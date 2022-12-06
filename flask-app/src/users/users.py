from flask import Blueprint, request, jsonify, make_response
import json
from src import db


users = Blueprint('users', __name__)

# Get user detail for user with particular username
@users.route('/user/<username>', methods=['GET'])
def get_user(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from user where username = {0}'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get pantry for user with particular username
@users.route('/<username>/pantry', methods=['GET'])
def get_pantry(username):
    cursor = db.get_db().cursor()
    cursor.execute('select name, quantity from ingredient where pantryNum = select pantryID from pantry where userNam = {0}'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

@users.route("/<username>/input_ingredients", methods = ['POST'])
def input_ingredients():
   cursor = db.get_db().cursor()
   ingredient = request.form['ingredient']
   quantity = request.form['quantity']
   query = f'INSERT INTO pantry(name, quantity) VALUES(\"{ingredient}\", \"{quantity}\")'
   cursor.execute(query)
   return f'<h1>{ingredient} added to pantry.</h1>'