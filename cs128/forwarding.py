import os, requests, sys
import json


#request timeout varriable
retry = 1

class ForwardHTTP:
	# forward GET request to ip_addr with data
	def get(self, params, nodes, endpoint = ''):
		print('in get bitch')
		for ip_addr in nodes:
			try:
				res = requests.get(
					'http://' + ip_addr + '/kvs' + endpoint,
					data=params,
					timeout=retry
				)
				d = res.json()
				print(d)
				#return value of first node that responds
				if 'error' not in d:
					returnMsg = d
					returnCode = 200
					return returnMsg, returnCode
				else:
					returnMsg = {
						'msg' : d['msg'],
						'error' : d['error']
					}
					returnCode = 404

			except requests.exceptions.ConnectionError:
				returnMsg = {
					'msg' : 'error',
					'error' : 'service is not available',
					'contactedNode' : ip_addr
				}
				returnCode = 405
			print(returnMsg)
			returnMsg['error'] = returnMsg['error']+' or key does not exist'
		return returnMsg, returnCode
	
	def put(self, params, nodes, endpoint = ''):
		for ip_addr in nodes:
			try:
				res = requests.put(
					'http://' + ip_addr + '/kvs' + endpoint,
					data=params,
					timeout=retry
				)
				d = res.json()
				if 'error' not in d:
					#just send to one node in partition, let it take care of broadcasting
					returnMsg = d
					returnCode = 201
					return returnMsg, returnCode
				else:
					returnMsg = {
						'msg' : 'error', 
						'error' : 'invalid key length'
					}
					returnCode = 400
			except requests.exceptions.ConnectionError:
				returnMsg = {
					'msg' : 'error',
					'error' : 'pee is not available',
					'contactedNode' : ip_addr
				}
				returnCode = 404

			#if it reaches this point record a loss and try sending it later
		return returnMsg, returnCode
		
	def delete(self, params, nodes, endpoint = ''):
		for ip_addr in nodes:
			try:
				res = requests.delete(
					'http://' + ip_addr + '/kvs' + endpoint,
					data=params,
					timeout=retry
				)
				d = res.json()
				if 'error' not in d:
					#just send to one node in partition, let it take care of broadcasting
					returnMsg = d
					returnCode = 201
					return returnMsg, returnCode
				else:
					returnMsg = {
						'msg' : 'error', 
						'error' : 'invalid key length'
					}
					returnCode = 400
			except requests.exceptions.ConnectionError:
				returnMsg = {
					'msg' : 'error',
					'error' : 'service is not available',
					'contactedNode' : ip_addr
				}
				returnCode = 404

			#if it reaches this point record a loss and try sending it later
		return returnMsg, returnCode
	
	def notify_view_change(self, params, ip_addr):
		try:
			res = requests.put(
				'http://' + ip_addr + '/kvs/view_update',
				data=params,
				timeout=retry
			)
		except requests.exceptions.ConnectionError as err:
			print(err)
		message = {'message' : 'sent'}

		return message, 200

	def bulk_put(self, params, ip_addr):
		try:
			data = json.dumps(params)
			headers = {'Content-Type': 'application/json'}
			res = requests.put(
				'http://' + ip_addr + '/kvs/view_update',
				data = data,
				headers = headers,
				timeout = retry
			)
			
			returnMsg = {
				'msg' : 'success',
				'owner' : ip_addr
			}
			returnCode = 201
		except Exception as err:
			print('error in bulk_put: ')
			print(err)
			returnMsg = {
				'msg' : 'fail',
				'owner' : ip_addr
			}
			returnCode = 400
		return returnMsg, returnCode

		
	#broadcast put request to all ip addresses in nodes
	#skip own ip address
	def broadcast(self, args, nodes, skip):
		#avoid broadcasting a broadcast message
		if args['broadcasted'] == 'penis' : 
			return
		args['broadcasted'] = 'penis'
		for node in nodes:
			if node != skip:
				try:
					requests.put(
						'http://' + node + '/kvs',
						data = args
					)
				except Exception as err:
					print('couldnt broadcast to all nodes')
					print(err)
