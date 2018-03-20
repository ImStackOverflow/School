import unittest
import subprocess
import requests
import sys
import random
import time
import hashlib 

hostname = 'localhost' #Windows and Mac users can change this to the docker vm ip
contname = 'hw3' #Set your container name here
sudo = '' #Make the value of this variable sudo if you need sudo to start containers 
replicas = 3

def hash_func(key):
	return hashlib.sha256(key.encode('utf-8')).hexdigest()

class TestKvs(unittest.TestCase):

    '''
    Creating a subnet:
        sudo docker network create --subnet=10.0.0.0/16 mynet
    '''
    ip_addresses = [] #virtual ip addresses of nodes
    host_ports = [] #physical tcp ports
    view = [] #nodes in intial cluster view
    node_ids = [] #docker node ids

    nodes_address = []
    has_been_run_once = False
    all_tests_done = False

    def generate_ip_ports(self):
    	for i in range(0, replicas):
    		ip ='10.0.0.' + str(20+i)
	    	self.__class__.ip_addresses.append(ip)
	    	self.__class__.host_ports.append(str(8081 + i))
	    	self.__class__.view.append(ip+':8080')

    def spin_up_nodes(self):
    	print('spinning up nodes')
    	self.generate_ip_ports()
    	ports = self.__class__.host_ports
    	ipaddresses = self.__class__.ip_addresses
    	view = str(self.__class__.view).strip(']').strip('[').replace("'","")
    	for port, ip in zip(ports, ipaddresses): 
        	exec_string_main = (sudo +' docker run -p {0}:8080 --net=mynet --ip={1} -e '
        	'VIEW="{2}" -e "ip_port"="{1}:8080" -d {3}'''.format(port, ip, view, contname))
        	print exec_string_main
        	self.__class__.node_ids.append(subprocess.check_output(exec_string_main, shell=True).strip('\n'))

        self.__class__.nodes_address = ['http://' + hostname + ":" + x for x in ports]
        print(self.__class__.nodes_address)

    def setUp(self):
    	print 'setting shit up'
        if not self.__class__.has_been_run_once:
            print 'fuckein'
            self.__class__.has_been_run_once = True   
            self.spin_up_nodes()
            print "Sleeping for 10 seconds to let servers bootup"
            time.sleep(10)

    def test_a_put_nonexistent_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
    		#send data to nodes using node ip as key
    		#should store on respective node
    		res = requests.put(node+'/kvs',data = {'value':'bart', 'key': key})
        	d = res.json()
        	self.assertEqual(res.status_code,201)
        	self.assertEqual(int(d['replaced']),0)
        	self.assertEqual(d['msg'],'success')
        	self.assertEqual(d['owner'], key)

    def test_c_get_nonexistent_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
	        res = requests.get(node+'/kvs?key=faa')
	        d = res.json()
	        self.assertEqual(res.status_code,404)
	        self.assertEqual(d['msg'],'error')
	        self.assertEqual(d['error'],'key does not exist')

    def test_e_del_nonexistent_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
	        res = requests.delete(node+'/kvs?key=faa')
	        d = res.json()  
	        self.assertEqual(res.status_code,404)
	        self.assertEqual(d['msg'],'error')
	        self.assertEqual(d['error'],'key does not exist')

    def test_f_del_existing_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
	        res = requests.delete(node+'/kvs?key='+key)
	        d = res.json()
	        self.assertEqual(d['msg'],'success')

    def test_j_put_existing_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
	        res = requests.put(node+'/kvs',data = {'value':'ass', 'key':key})
	        d = res.json()
	        self.assertEqual(d['replaced'],1)
	        self.assertEqual(d['msg'],'success')
	        self.assertEqual(d['owner'], key)

    def test_l_get_existing_key(self):
    	endpoint = self.__class__.nodes_address
    	view = self.__class__.view
    	for node, key in zip(endpoint, view):
	        res = requests.get(node+'/kvs?key='+key)
	        d = res.json()
	        self.assertEqual(d['msg'],'success')
	        self.assertIsNotNone(d['value'])
	        self.assertEqual(d['owner'], key)

    	self.__class__.all_tests_done = True

    def tearDown(self):
        if self.__class__.all_tests_done:
            print("\nKilling all alive nodes.")
            shell_command = 'docker container ls'
            print(subprocess.check_output(shell_command, shell=True))
            shell_command = "docker stop $(docker ps -q)"
            subprocess.check_output(shell_command, shell=True)

if __name__ == '__main__':
	suite = unittest.TestLoader().loadTestsFromTestCase(TestKvs)
	unittest.TextTestRunner(verbosity=2).run(suite)