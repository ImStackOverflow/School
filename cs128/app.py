#this file processes request routing and node finding
#finds appropriate node in ring to send request to


from flask import Flask,jsonify
from flask_restful import Resource, Api, reqparse
import os, sys, hashlib
from kvs import KVStore
from forwarding import ForwardHTTP
from hash import ConsistentHash
from ViewUpdate import ViewUpdate
from Partitions import PartitionBackups
import time
import json

# app setup
partition = PartitionBackups()
kvs = KVStore() 												# locally stores key-value object
forward = ForwardHTTP() 								# forwards http requests to main node
chash = ConsistentHash(1000)							# consistent hashing - give 50 replicas instead of 1000
parser = reqparse.RequestParser()
parser.add_argument('key', type=str, action='append') 		# recognizes query string "key=..." so you can retrieve the value of key "key"
parser.add_argument('value', type=str, action='append') 	# recognizes query string  "value=..." so you can retrieve the value of key "value"
parser.add_argument('nodes', action='append')
parser.add_argument('data', action='append')
parser.add_argument('ip_port', type=str) 			# gets ip port for forwarding request
parser.add_argument('type', type=str) 				# gets type for forwarding request. eithers None of 'foce'
parser.add_argument('partition_id', type=str)
parser.add_argument('broadcasted', type=str)
app = Flask(__name__)
api = Api(app)


#@app.teardown_request
#def teardown_request(exception=None):
#	print('this runs after request')
#	return jsonify(msg='accross')

# constants
MY_IP_PORT = os.environ['ip_port']

if('VIEW' in os.environ): # the list of ip:port of other nodes including this node's. if it doesn't exist, leave blank
	NODES = os.environ['VIEW']
else:
	NODES = os.environ['ip_port']

if('K' in os.environ):
	kluster = os.environ['K']
else:
	kluster = 2

class KVS(Resource):

	def get(self):
		# parser.parse_args() parses query string from url into json object.
		# /kvs?key=foo&value=bar --> {'key': 'foo', 'value': 'bar'}
		args = parser.parse_args()
		#ctx.push()
		print('penis')
		#ctx.pop()
		print('key is ')
		print(args['key'])
		if(args['key'][0] == 'printIPs'):
			message = chash.ip_addrs
			#print(message)
			return jsonify(message)
		elif(args['key'][0] == 'printKVS'):
			message = kvs.return_data()
			return jsonify(message)

		closest_node = chash.get_closest_node(args['key'][0])
		closest_node = int(closest_node)
		print('closest_node is '+ str(closest_node))
		print('key is '+str(args['key'][0]))
		#key is in some other partition
		if closest_node != partition.partitionId:
			#get nodes in other partition
			nodes = partition.PartitionNodes[closest_node]
			#get response from one of the nodes
			returnMsg, statusCode = forward.get(args, nodes)

		#otherwise return my key value pair
		else:
			key = args['key'][0]
			returnMsg, statusCode = kvs.get(key)
			returnMsg['timestamp'] = int(time.time())
			returnMsg['partition_id'] = partition.partitionId
			
			#if 'error' in returnMsg:
			
			#	index = partition.PartitionNodes[partition.partitionId].index(MY_IP_PORT)
			#	returnMsg = forward.get(args, partition.PartitionNodes[closest_node][index+1])	
		print(returnMsg)
		returnMsg = jsonify(returnMsg)
		returnMsg.status_code = statusCode
		return returnMsg

	def put(self):
		args = parser.parse_args()
		closest_node = chash.get_closest_node(args['key'][0])
		#key belongs to some other partition
		closest_node = int(closest_node)
		#get partition nodes
		nodes = partition.PartitionNodes[closest_node]
		if closest_node != partition.partitionId:
			#send put request to nodes in other partition
			returnMsg, statusCode = forward.put(args, nodes)
		else:
			#broadcast put request accross my replicas
			#print(args)
			#do this after sending the response
			@app.teardown_request
			def teardown_request(exception=None):
				forward.broadcast(args, nodes, MY_IP_PORT)
				#print('penis')
			key = args['key'][0]
			value = args['value'][0]
			returnMsg, statusCode = kvs.put(key, value)
			returnMsg['partition_id'] = partition.partitionId
			returnMsg['timestamp'] = int(time.time())
		returnMsg = jsonify(returnMsg)
		returnMsg.status_code = statusCode
		return returnMsg

	def delete(self):
		args = parser.parse_args()
		closest_node = chash.get_closest_node(args['key'][0])
		closest_node = int(closest_node)
		#get partition nodes
		nodes = partition.PartitionNodes[closest_node]
		if closest_node != partition.partitionId:
			returnMsg, statusCode = forward.delete(args, nodes)
		else:
			key = args['key'][0]
			returnMsg, statusCode = kvs.delete(key)
			returnMsg['timestamp'] = int(time.time())
			@app.teardown_request
			def teardown_request(exception=None):
				forward.broadcast(args, nodes, MY_IP_PORT)

		returnMsg = jsonify(returnMsg)
		returnMsg.status_code = statusCode
		return returnMsg

class NumberOfKeys(Resource):
	def get(self):
		returnMsg, statusCode = kvs.get_number_of_keys()
		returnMsg = jsonify(returnMsg)
		returnMsg.status_code = statusCode
		return returnMsg


class partition_id(Resource):
	def get(self):
		message = {
		'msg' : 'success',
		'partition_id' : partition.partitionId
		}
		message = jsonify(message)
		message.status_code = 200
		return message

class all_partitions(Resource):
	def get(self):
		penis = list(partition.PartitionNodes.keys())
		message = {
		'msg' : 'success',
		'partition_id_list' : penis
		}
		message = jsonify(message)
		message.status_code = 200
		return message

class get_partition_members(Resource):
	def get(self):
		args = parser.parse_args()
		ID = int(args['partition_id'])
		if partition is None:
			return jsonify("no partition arg given"), 400
		message = {
		'msg' : 'success',
		'partition_members' : partition.PartitionNodes[ID]
		}
		message = jsonify(message)
		message.status_code = 200
		return message

api.add_resource(KVS, '/kvs')
api.add_resource(ViewUpdate, '/kvs/view_update', 
	resource_class_kwargs={'kvs': kvs, 'chash': chash, 'ip_port': MY_IP_PORT, 'partitions' : partition, 'app' : app})
api.add_resource(NumberOfKeys, '/kvs/get_number_of_keys')
api.add_resource(partition_id, '/kvs/get_partition_id')
api.add_resource(all_partitions, '/kvs/get_all_partition_ids')
api.add_resource(get_partition_members, '/kvs/get_partition_members')



if __name__ == "__main__":
	print(NODES)
	nodes = NODES.split(',')
	print(nodes)
	#start partitions
	partition.startPartitions(kluster, nodes, MY_IP_PORT)

	#store tokens as hash of partition Id
	#i.e 0 
	tits = partition.PartitionNodes.keys()
	for ID in tits:
		chash.insert_node(ID)
		print('adding into hash ring: '+str(ID))

	app.run(host='0.0.0.0', port=8080, threaded = True)	