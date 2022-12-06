from flask import Blueprint, request, jsonify, make_response
import json
from src import db


users = Blueprint('users', __name__)

# Get user profile for user with particular username
@users.route('/users/<username>', methods=['GET'])
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
    cursor.execute('SELECT name, quantity FROM ingredient i JOIN pantry p ON i.pantryNum = p.pantryID where pantryNum = select pantryID from pantry where userNam = {0}'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Input ingredients into pantry
@users.route("/<username>/input_ingredients", methods = ['POST'])
def input_ingredients():
   cursor = db.get_db().cursor()
   ingredient = request.form['ingredient']
   quantity = request.form['quantity']
   query = f'INSERT INTO pantry(name, quantity) VALUES(\"{ingredient}\", \"{quantity}\")'
   cursor.execute(query)
   return f'<h1>{ingredient} added to pantry.</h1>'

# Suggested recipes based on what user has in pantry
@users.route('/<username>/recipes_based_on_ingred', methods = ['GET'])
def recipes_ingred():
    cursor = db.get_db().cursor()
    query = '''
    SELECT *
    FROM recipe r JOIN ingredient_rec ir on r.recipeId = ir.recipeNum
    WHERE (SELECT COUNT(i.ingredientId)
            FROM ingredient_rec ir JOIN ingredient i on ir.ingredientNum = i.ingredientId
            JOIN pantry p on i.pantryNum = p.pantryID
            WHERE i.ingredientId = ir.ingredientNum)
    '''
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response