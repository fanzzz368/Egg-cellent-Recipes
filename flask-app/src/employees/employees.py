from flask import Blueprint, jsonify, make_response
import json
from src import db

employees = Blueprint('employees', __name__)

# get all info about an employee -- it works
@employees.route('/<employeeID>', methods=['GET'])
def get_employee(employeeID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from employee where employeeID = {0}'.format(employeeID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get the help requests from customers -- it works
@employees.route('/view_help_request', methods=['GET'])
def get_help_request():
    cursor = db.get_db().cursor()
    cursor.execute('select * from help_requests')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# @app.route('/')
# def homepage():
#    return f'<h1>Welcome to Egg-cellent Recipes!</h1>'

@employees.route('/db_test')
def db_testing():
   cur = db.get_db().cursor()
   cur.execute('select * from employee')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)