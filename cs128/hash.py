# code inspired from http://techspot.zzzeek.org/2012/07/07/the-absolutely-simplest-consistent-hashing-example/
import bisect, hashlib, sys

class ConsistentHash(object):

	nodes = {} # key-value pair of key and node ip address. both are type string. example: {'031edd7d4': '10.0.0.22'}
	keys = [] # array of all keys of all node ip. used to find the closest node ip address. example: ['031edd7d41651593c5fe5c006fa57', '7bc45a8fc544c03f52dc550cd6e1']
	replicas = 0 # number of node 'replicas'. example: if replicas is 3, then there will be 3 copies of every node
	ip_addrs = [] # set that holds unique ip addresses.

	def __init__(self, default_replicas=1):
		self.replicas = default_replicas

	# the hash function.
	# returns hash value of where the key's value stored.
	def hash_func(self, key):
		return hashlib.sha256(key.encode('utf-8')).hexdigest()


	# given ip_addr, find the hash values of node's replicas and
	# insert it into self.nodes. insert hash values into self.keys in order
	# TODO: need to notify existing nodes that the new one is being added.
	def insert_node(self, ip_addr):
		self.ip_addrs.append(ip_addr)
		ip_addr = str(ip_addr)
		for i in range(0, self.replicas):
			# give the ip_addr a unique key since hash_func will give us the same hash value for same key every time
			key = ip_addr + ':' + str(i) 
			hash_val = self.hash_func(key)

			# raise error if we are adding the same
			# ip address. probably don't need this...
			if(hash_val in self.nodes):
				return
				#raise ValueError("ip address %r already exists" % ip_addr)

			self.nodes[hash_val] = ip_addr
			bisect.insort(self.keys, hash_val)

	# loop through self.nodes and delete all
	# key-val pairs that matches ip_addr and
	# ip_addr's keys in self.keys.
	# TODO: need to notify exisiting nodes that
	# the selected ip_addr is being deleted.
	def delete_node(self, ip_addr):
		if(ip_addr in self.ip_addrs):
			self.ip_addrs.remove(ip_addr)
			for key in list(self.nodes.keys()):
				if self.nodes[key] == str(ip_addr):
					del self.nodes[key]
					self.keys.remove(key)
		
	# given a key, it computes hash value and
	# finds the next biggest hash value,
	# which is the key for a certain ip address
	#returns the partition responsible for that key
	#return = <int> eg 1 
	def get_closest_node(self, key):
		hash_val = self.hash_func(key)
		index = bisect.bisect(self.keys, hash_val) # gets the insertion index of hash_val in self.keys
		if index == len(self.keys): # if it's inserted into the end of self.keys, then we know it's the biggest hash_val, so we return ip address of the smallest hash value
			index = 0
		return self.nodes[self.keys[index]]
					