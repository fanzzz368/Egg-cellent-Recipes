from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


users = Blueprint('users', __name__)

# Get user profile for user with particular username -- it works
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

# Get pantry for user with particular username -- it works
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

# Input ingredients into pantry
@users.route("/<username>/input_ingredients", methods = ['POST'])
def input_ingredients():
   cursor = db.get_db().cursor()
   ingredient = request.form['ingredient']
   query = f'INSERT INTO pantry(name, quantity) VALUES(\"{ingredient}\")'
   cursor.execute(query)
   return f'<h1>{ingredient} added to pantry.</h1>'

# Suggested recipes based on what user has in pantry
#match the ingredients that the user has entered with the ingredients in each recipe--> if same, return the recipe
@users.route('/<username>/recipes_based_on_ingred', methods = ['GET'])
def recipes_ingred():
    cursor = db.get_db().cursor()
    query = '''
    SELECT r.name
    FROM recipe r JOIN ingredient_rec ir on r.recipeId = ir.recipeNum
    WHERE (SELECT COUNT(i.ingredientId) as numMatches
            FROM ingredient_rec ir JOIN ingredient i on ir.ingredientNum = i.ingredientId
            JOIN pantry_ingred pi on i.pantryNum = pi.pantryNum
            JOIN pantry p on pi.pantryNum = p.pantryID
            WHERE i.ingredientId = ir.ingredientNum)
    ORDER BY numMatches DESC
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

@users.route('/suggested_recipes')
def suggested_recipes():
    return f'<h1>these are the top ten suggested recipes</h1>'
 
 # customer service form -- it works
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