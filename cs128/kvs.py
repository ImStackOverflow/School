'''just a key value store table object
returns all messages in json format
simple interface to deal with kvs, no RESTful shit inside
'''
import ast, copy

def makeEntry(value):
	entry = {
		'replaced' : 0,
		'value' : value,
		'causal_payload' : '0',
		'deleted' : False
	}
	return entry

class KVStore:

	def __init__(self):
		self.hashmap = {} # dictionary, store k-v pairs.

	def get(self, key):
		if key in self.hashmap.keys() and not self.hashmap[key]['deleted']:
			returnMsg = {
				'msg' : 'success',
				'value' : self.hashmap[key]['value'],
				'causal_payload' : self.hashmap[key]['causal_payload']
				}
			returnCode = 200
		else:
			returnMsg = {
				'msg' : 'error',
				'error' : 'key does not exist',
			}
			returnCode = 404
		return returnMsg, returnCode

	def put(self, key, value):
		if len(key) > 250 or len(key) < 1:
			returnMsg = {
				'msg' : 'error', 
				'error' : 'invalid key length',
			}
			returnCode = 400
		elif value == None:
			returnMsg = {
				'msg' : 'error', 
				'error' : 'missing value',
			}
			returnCode = 400
		else:
			if key in self.hashmap.keys():
				self.hashmap[key]['replaced'] += 1
				self.hashmap[key]['value'] = value
				returnCode = 200
			else:
				self.hashmap[key] = makeEntry(value)
				returnCode = 201
			returnMsg = {
				'replaced' : self.hashmap[key]['replaced'],
				'msg' : 'success',
				'causal_payload' : self.hashmap[key]['causal_payload']
				}
		return returnMsg, returnCode
	
	def update_data(self, data):
		#print("in update fucking data the type is: "+str(type(data)))
		#print(data)
		#the data gets sent as a string
		#need to evalute value and turn into dict
		#eg item = 'fyoatmudew'
		#data[item] = "{'replaced': 0, 'value': '1', 'owner': '10.0.0.3:8080'}" <str>
		for item in data:
			#print(item)
			#print(data[item])
			self.hashmap[item] = ast.literal_eval(data[item])
		returnMsg = { 'msg' : 'successfully (bulk) updated' }
		return returnMsg

	#implement tombstones 
	#doesnt actually delte key
	#changes delted value to true
	def delete(self, key):
		if key not in self.hashmap.keys():
			returnMsg = {
				'msg' : 'error', 
				'error' : 'key does not exist',
			}
			returnCode = 404
		else:
			self.hashmap[key]['deleted'] = True
			returnMsg = {
				'msg' : "success",
				'causal_payload' : self.hashmap[key]['causal_payload']
			}
			returnCode = 200
		return returnMsg, returnCode


	#actually remove key, only for when sure key needs to be deleted
	#ie during view update requests
	def remove(self, key):
		del self.hashmap[key]
	
	def get_number_of_keys(self):
		returnMsg = {
			'count' : len(self.hashmap.keys()),
		}
		returnCode = 200
		return returnMsg, returnCode


	#returns a deep copy of kvs ommiting deleted keys
	def return_data(self):
		shit = copy.deepcopy(self.hashmap)
		for tits in list(shit.keys()):
			if shit[tits]['deleted']: 
				del shit[tits]
		return shit

	def populate_data(self):
		for i in range(0,10):
			self.hashmap[str(i)] = str(random.random())

	def sortedKeys(self):
		return sorted(self.hashmap.keys()), 200


#example code on how its used
#uncomment and run python kvs.py to check output

# if __name__ == '__main__':
# 	d = KVStore() #create an instance of object
# 	output = d.put('penis','hore') #put key and value in
# 	print('put command does: ')
# 	print(output)
# 	output = d.put('penis', 'dick') #change value for key
# 	print('put command (replace value): ')
# 	print(output)
# 	output = d.get('penis') #get value associated with key
# 	print('get command: ')
# 	print(output)
# 	output = d.delete('penis') #delete key
# 	print('delete: ')
# 	print(output)
