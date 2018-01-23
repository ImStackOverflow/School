from flask import Flask
from flask import request

app = Flask(__name__)

@app.route('/hello', methods=['GET'])
def get_shit():
    #username = request.args.get('name')
    #if not username :
    #    username = 'User'
    return 'Hello john !'

"""@app.route('/check', methods=['GET'])
def getCheck:
    task = task[
    return tasks['description'], status.HTTP_200_OK

@app.route('/check', methods=['POST'])
def postCheck
    return tasks[3]
"""
if __name__ == '__main__':
    app.run(host = '0.0.0.0', port=81)
