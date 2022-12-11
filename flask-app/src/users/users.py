from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


users = Blueprint('users', __name__)

# Get user profile for user with particular username
@users.route('/<username>', methods=['GET'])
def get_user(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from user where username = "{0}"'.format(username))
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
    cursor.execute('SELECT i.name' + 
    ' FROM ingredient i JOIN pantry_ingred pi ON i.ingredientID = pi.ingredientNum' +
    ' WHERE pi.pantryNum = (SELECT p.pantryID FROM pantry_ingred pi JOIN pantry p ON pi.pantryNum = p.pantryID' + 
    ' WHERE p.userNam = "{0}"'.format(username) + 
    ' LIMIT 1)')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Suggested recipes based on what user has in pantry
@users.route('/<username>/recipes_based_on_ingred', methods = ['GET'])
def recipes_ingred(username):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT DISTINCT r.name' +
        ' FROM recipe r JOIN ingredient_rec ir on r.recipeId = ir.recipeNum' +
        ' JOIN ingredient i on ir.ingredientNum = i.ingredientId' +
        ' JOIN pantry_ingred pi on i.ingredientID = pi.ingredientNum' +
        ' JOIN pantry p on pi.pantryNum = p.pantryID' +
        ' WHERE pi.ingredientNum = ir.ingredientNum AND p.userNam = "{0}"'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
 
 # customer service form
@users.route('/customer_service_form', methods = ['POST'])
def cus_service_form():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    username = request.form['username']
    phoneNum = request.form['phone']
    email = request.form['email']
    description = request.form['description']
    query = f'INSERT INTO help_requests(user_username, user_phoneNum, user_email, help_needed) VALUES(\"{username}\", \"{phoneNum}\", \"{email}\", \"{description}\")'
    cursor.execute(query)
    db.get_db().commit()
    return f'<h1>Request submitted</h1>' 

# Get the entire list of ingredients we have in our database
@users.route('/get_ingredients', methods = ['GET'])
def get_ingredients_list(): 
    cursor = db.get_db().cursor()
    cursor.execute('select ingredientID as value, name as label from ingredient')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get recipe info for fish tacos
@users.route('/get_fish_taco_recipe', methods = ['GET'])
def get_fish_taco(): 
    cursor = db.get_db().cursor()
    cursor.execute('select * from recipe' + 
    ' Where name = "perfect fish tacos"')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the list of ingredients needed for fish tacos
@users.route('/get_fish_taco_ingredients', methods = ['GET'])
def get_fish_taco_ingr(): 
    cursor = db.get_db().cursor()
    cursor.execute('select i.name from ingredient i JOIN ingredient_rec ir on i.ingredientId = ir.ingredientNum' + 
    ' JOIN recipe r on ir.recipeNum = r.recipeId' +
    ' Where r.name = "perfect fish tacos"')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the list of steps to follow for fish tacos
@users.route('/get_fish_taco_steps', methods = ['GET'])
def get_fish_taco_steps(): 
    cursor = db.get_db().cursor()
    cursor.execute('select steps from instructions i ' + 
    ' JOIN recipe r on i.recipeNum = r.recipeId' +  
    ' Where r.name = "perfect fish tacos"')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response