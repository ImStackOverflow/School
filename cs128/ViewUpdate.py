#this file proccesses view changes
#send view change request
#takes in instances of kvs, hash ring, and parser
#extension of app.py
#interfaces with kvs

from kvs import KVStore 
import copy
from hash import ConsistentHash
from flask_restful import reqparse, Resource
from forwarding import ForwardHTTP
from flask import jsonify
import time
import sys

forward = ForwardHTTP()
parser = reqparse.RequestParser()
parser.add_argument('ip_port', type=str) 			# gets ip port for forwarding request
parser.add_argument('type', type=str) 				# gets type for forwarding request. eithers None of 'foce'
parser.add_argument('keys', action='append')  #values to be updated
parser.add_argument('values', action='append')  #values to be updated
parser.add_argument('nodes', action='append') #partition node members
parser.add_argument('ids', action='append') #partition id


class ViewUpdate(Resource):

	#returns list of partition ip's responsible for hashed key
	def __getClosestIpaddresses(self, key):
			closest_partition = int(self.chash.get_closest_node(key))
			return self.partitions.PartitionNodes[closest_partition]


	def __init__(self, kvs, chash, ip_port, partitions, app):
		self.kvs = kvs
		self.chash = chash
		self.MY_IP_PORT = ip_port
		self.partitions = partitions
		self.app = app


	#send view change to all nodes
	#assumes the node being added is blank and new
	#gets everyone to send thier rehased data to them
	def __add(self, ip_port):
		#if i already added the new node, ignore the message
		if (ip_port in self.partitions.ip_addrs): 
			msg = 'already added node dumb fuck'
			print(msg)
			return msg

		# otherwise add in new node
		add, partition = self.partitions.insertNode(ip_port)
		print("addind a node to new partition: " + str(add) + str(partition))

		# broadcast to all other nodes that a new node is being added
		data = {'type':'add', 'ip_port':ip_port}
		for node in self.partitions.ip_addrs:
			if(node == self.MY_IP_PORT): 
			# avoid forwarding to myself or new node, causes weird timed out error
				continue
			try:
				forward.notify_view_change(data, node)
			except Exception as err:
				print('error in forwaring view change (add) : ')
				print(err)

		#added node into existing partition
		if not add:
			#if added into my partition send my data to sync up
			#otherwise just do nothing ie not in my partition just 
			#log a new node into partitions
			if partition == self.partitions.partitionId:
				#send all my data
				data = self.kvs.return_data()
				print(data)
				key = []
				value = []
				for pair in data.items():
					#print(pair)
					key.append(pair[0])
					value.append(pair[1])
				#keys are list of type sting 
				#values are list of dictionaries but gets converted to string upon sending
				ids, nodes = self.partitions.returnPartitions()
				data = {
					'type':'add_data',
					'ids' : ids,
					'nodes': nodes,
					'keys': key,
					'values' : value
				}
				print(data)
				# notify the new node the list of current nodes.
				forward.bulk_put(data, ip_port)
		
		#created new partition
		else:
			#insert node into hash ring
			self.__addIntoHash(partition, ip_port)

		returnMsg = {
			'msg' : 'success',
			'partition_id' : partition,
			'number_of_partitions' : len(self.partitions.PartitionNodes.keys()),
			'ip_port' :self.MY_IP_PORT
		}
		return returnMsg


	#add new partition into hash ring
	#scan own kvs
	#send values to new node
	def __addIntoHash(self, partition, ip_port):

		self.chash.insert_node(partition)
		# since a new node is added to the cluster, send some of
		# my data that's closest to the new node
		key = []
		value = []
		items = self.kvs.return_data()
		#check to make sure theres even fucking values
		if items != None:
			print(items)
			for pair in items.items():
				closest_nodes = self.__getClosestIpaddresses(pair[0])
				if(ip_port in closest_nodes):
					#print(pair)
					key.append(pair[0])
					value.append(pair[1])
					self.kvs.remove(pair[0])
		
		#keys are list of type sting 
		#values are list of dictionaries but gets converted to string upon sending
		ids, nodes = self.partitions.returnPartitions()
		data = {
			'type':'add_data',
			'ids' : ids,
			'nodes': nodes,
			'keys': key,
			'values' : value,
			'ip_port' : self.MY_IP_PORT
		}
		print(data)
		# notify the new node the list of current nodes.
		forward.bulk_put(data, ip_port)
		return

	
	#on recieveing side of nodes
	#function is called for both delete and adding node
	#since both actions send data
	def __addData(self, ids, nodes, keys, values):
		print('in add data: ')
		print(nodes)
		#update my partitions if im getting nodes 
		#if im getting nodes it means im the added node
		if nodes: 
			self.partitions.updatePartitions(ids, nodes, self.MY_IP_PORT)
			#generate my hash table
			for ID in ids:
				#if I got a new ID add it into chash
				ID = int(ID)
				print('fuck!!!!')
				print(self.chash.ip_addrs)
				print(ID)
				print(type(self.chash.ip_addrs[0]))
				print(type(ID))
				if ID not in self.chash.ip_addrs:
					self.chash.insert_node(ID)
		#keys and values come in as lists
		#put keys and values together to make dict
		#value is a string eg 'fyoatmudew': "{'replaced': 0, 'value': '1', 'owner': '10.0.0.3:8080'}"
		if keys:
			data = {}
			for i in range(0,len(keys)):
				data.update({keys[i]:values[i]})
			self.kvs.update_data(data)


	#delete node from partition and shit
	#the deleted node doesnt know shit about whether its getting deleted
	#everyone else just deletes them and stops talking to him
	#if the there ends up a partition with only one node in it
	#reshuffle the partitions
	#ie delete the solo partition and re-add its node into the system
	def __delete(self, ip_port):
		print('in detele')
		penis = 0
		# check if already deleted node
		if (ip_port not in self.partitions.ip_addrs):
			print('already deleted node')
			return

		# delete ip address from my list
		#have to do this litteraly right after message is recieved
		#otherwise bound for terminating reliable broadcast fucks up because computers are fast and threads fuck shit up
		delete, partition = self.partitions.removeNode(ip_port)

		#then broadcase to delete that shit
		data = {'type':'remove', 'ip_port':ip_port}
		#send the delete request to the deleted node too
		if self.MY_IP_PORT != ip_port: forward.notify_view_change(data, ip_port)
		for ip_addr in self.partitions.ip_addrs:
				if(ip_addr == self.MY_IP_PORT): # avoid forwarding to myself, causes weird timed out error
					continue
				# print("notifying %s of view change (delete)" % ip_addr ,file=sys.stderr)
				try:
					forward.notify_view_change(data, ip_addr) # forward notify view change to ip address
				except Exception as err:
					print('exception forwarding node: ')
					print(err)

		#if the partition was deleted, gotta do some extra work
		#send out data from remaining node
		#add remaining node back into partitions
		if delete:
			#delete partition from hash ring
			print('deteleing this partition: '+str(partition))
			self.partitions.cleanShit(partition)
			self.chash.delete_node(partition)

			#I am the last node in my partition
			#send out all my data and reshuffle partitions
			if partition == self.partitions.partitionId:
				penis = 1
				print("IM COMMITING SUICIDE MOTHER FUCKER!!!!!!")
				self.__sendOutData(self.MY_IP_PORT)
				#reset my kvs
				self.kvs = KVStore()
				#send message to add me back in as a NEW PERSON
				node = self.partitions.ip_addrs[0]
				if node == self.MY_IP_PORT: node = self.partitions.ip_addrs[1]
				data = {'type' : 'add', 'ip_port' : self.MY_IP_PORT}
				print('telling '+str(node)+' about my suicide')
				#forward.notify_view_change(data, node)

		returnMsg = {
			'msg' : 'success',
			'number_of_partitions' : len(self.partitions.PartitionNodes)+penis
		}
		return returnMsg


	#send my data to the appropriate nodes
	#rehashes my kvs and calculates which nodes are responsible for my new data
	#sends that data to them
	def __sendOutData(self, ip_port):

		data = {}
		#make dict using partitions as key
		#each entry has 2 lists, 0 = key from kvs, 1 = values
		tits = list(self.partitions.PartitionNodes.keys())
		for partition in tits:
			key = []
			value = []
			data[int(partition)] = [key, value]

		#rehash all my data and send to appropriate nodes
		#fills data dict with more dictionaries
		#each node entry holds list with more dictionaries
		#eg{ 0: [[key1, key2, key3], [{value1}, {value2}, {value3}]}
		items = self.kvs.return_data()
		for pair in items.items():
			print(pair)
			#pair[0] = <str> key, pair[1] = <dict> value
			#return partition responsible for key
			closest_node = int(self.chash.get_closest_node(pair[0]))
			print(closest_node)
			print(self.chash.ip_addrs)
			#add key
			data[closest_node][0].append(pair[0])
			#add value
			data[closest_node][1].append(pair[1])
		#print("in delete mofo data to send is: ")
		#print(data)

		#send data to respective nodes
		for partition in data:
			#print("in delete motherfucker value type is: "+str(type(data[partition])))
			#print(data[partition])
			#print(data[partition][1])
			
			sendData = {
				'type':'add_data',
				'keys': data[partition][0],
				'values' : data[partition][1]
			}
			print(sendData)
			#send to all nodes in that partition
			for node in self.partitions.PartitionNodes[partition]:
				print('sending data to: '+str(node))
				forward.bulk_put(sendData, node)



	def put(self):
		args = parser.parse_args()
		action = args['type']
		ip_port = args['ip_port']

		# a client request to add a new node
		if(action == 'add'):
			print('in adding')
			print(args)
			message = self.__add(ip_port)
			message = jsonify(message)
			message.status_code = 200
			return message

		#add values
		#on recieveing node side
		elif(action == 'add_data'):
			print(args)
			#data is sent in json pairs bc http is fucking shitty that way
			#keys and values in lists with matching indicies
			#values are dictionaries
			ids = args['ids']
			nodes = args['nodes']
			keys = args['keys']
			values = args['values']
			self.__addData(ids, nodes, keys, values)
			return jsonify(msg='succes')

		elif(action == 'remove'):
			message = self.__delete(ip_port)
			message = jsonify(message)
			message.status_code = 200
			return message