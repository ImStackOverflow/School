from flask import Flask
import os
import socket

app = Flask(__name__)

tasks = [
    {
        'id' : ,
        'description' : u'Hello User!',
        'done' : False
    },
    {
        'id' : hello?name=John,
        'description' : u'Hello John!',
        'done' : False
    },
    {
        'id' : 3,
        'description' : u'This is a GET request',
        'done' : False
    },
    {
        'id' : 4,
        'description' : u'This is a POST request',
        'done' : False
    }
]


@app.route('/hello<string:task_id>', methods=['GET'])
def get_shit(task_id):
    task = [task for task in tasks if task['id'] == task_id]
    return task

@app.route('/check', methods=['GET'])
def getCheck:
    return tasks[2]

@app.route('/check', methods=['POST'])
def postCheck
    return tasks[3]

if __name__ == '__main__':
    app.run()
