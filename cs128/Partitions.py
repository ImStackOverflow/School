#maintains lists of partions and nodes in the partitions

class PartitionBackups(object):

	ip_addrs = [] #list of ip addresses
	kluster = 0 # of nodes per cluster
	partitionId = 0 #my partition id
	PartitionNodes = {} #dickt of list of nodes in partitions, 
	#organized on partition ID, type <int> : <string> eg {0: ['10.0.0.22','10.0.0.23'], 1 : ['10.0.0.24','10.0.0.25']}
	
	#create inital partions from intial View
	#assumes all nodes inserted into hash ring with ip addresses
	def startPartitions(self, k, nodes, myIp):
		self.kluster = int(k)
		self.ip_addrs = nodes
		#establish a cosistent ordering of the addresses
		self.ip_addrs.sort()
		for i in range(0, len(self.ip_addrs), self.kluster):
			ID = int(i/self.kluster)
			section = self.ip_addrs[i:i+self.kluster] #break each partition
			if myIp in section:
				#set if its my partition
				self.partitionId = ID
			#add in paritions and record number of partitions
			self.PartitionNodes[ID] = section

	#insert new node 
	#if any partition has < K nodes, adds into partition
	#returns False and 0 if added into existing partition
	#returns True and partition id if created new partition
	#partition creation not monotonically increasing
	#ie if partitions [0,1,3], create partition 2
	def insertNode(self, ip_addr):
		if ip_addr not in self.ip_addrs:
			self.ip_addrs.append(ip_addr)
		#insert node in partition if its less then kluster size
		for section in self.PartitionNodes:
			nodes = self.PartitionNodes[section]
			if len(nodes) < self.kluster:
				nodes.append(ip_addr)
				return False, section

		#otherwise create a new partition
		#return missing partitions 
		#i.e if partition list is [0, 1, 3] return 2
		#if [0, 1, 2] return 3
		tits = list(self.PartitionNodes.keys())
		new = max(tits)+1
		self.PartitionNodes[new] = [ip_addr]
		return True, new


	#returns whether or not there is space in the partitions
	#true if every partition has kluster number of nodes
	#false if theres a partition with space open
	def partitionsFull(self, partition):
		print(partition)
		for section in self.PartitionNodes:
			nodes = self.PartitionNodes[section]
			if len(nodes) < self.kluster and section != partition:
				#print('deleting section fucker')
				#print(section)
				return False
		return True


	#reconisance phase
	#view change for a remove node
	#returns True, partition if only one node in partition or deleted last node in partition
		#ie need to remove partition from hash ring and shit
	#returns False, 0:
		#if more than 2 nodes left in partition
		#or if all other partitions have a node in them
		#ie shuffling the node would just have it end up in the same partition
		#means just dont fucking do anything nothing changes
	def removeNode(self, ip_addr):
		if ip_addr in self.ip_addrs:
			self.ip_addrs.remove(ip_addr)
			for partition in self.PartitionNodes:
				nodes = self.PartitionNodes[partition]
				if ip_addr in nodes:
					nodes.remove(ip_addr)
					print(nodes)
					#if only one node left in partition
					if len(nodes) < 2:
						#do I have space to put that node somewhere else?
						if (not self.partitionsFull(partition)) or len(nodes) == 0:						
							return True, partition
						#all the other partitions are full
						break
		return False, 0


	#remove partition and all its nodes from existence
	#use in conjunction with removeNode
	#removes shit
	def cleanShit(self, partition):
		for node in self.PartitionNodes[partition]:
			self.ip_addrs.remove(node)
		del self.PartitionNodes[partition]

	#function to update partition information
	#given lists of partition ids, nodes, myIP, and cluster size
	def updatePartitions(self, ids, nodes, myIp):
		#set ip address list
		self.ip_addrs = nodes
		for ID in ids:
			#set partition nodes info
			section = nodes[ids.index(ID)*self.kluster:ids.index(ID)*self.kluster+self.kluster]
			self.PartitionNodes[int(ID)] = section
			#get my own partition ID
			if myIp in section:
				self.partitionId = int(ID)

	#returns 2 lists
	#one is partition id's
	#second is nodes that belong in that partition id
	def returnPartitions(self):
		Ids = []
		nodes = []
		for ID in self.PartitionNodes:
			Ids.append(ID)
			nodes += self.PartitionNodes[ID]
		return Ids, nodes