from flask import Flask
from flask import request

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def get_shit():
    username = request.args.get('name')
    if not username :
       username = 'User'
    return username

app.route('/check', methods = ['GET', 'POST'])
def method(): 
	
	if request.method == 'POST':
	    return 'This is a POST request', 200
	elif request.method == 'GET':
	    return 'This is a GET request', 200
	else: 
	    return 405

if __name__ == '__main__':
    app.run(host = '0.0.0.0', port=81)
