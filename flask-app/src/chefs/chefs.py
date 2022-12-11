from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

chefs = Blueprint('chefs', __name__)

# get profile info for a chef with a particular username
@chefs.route('/<username>', methods=['GET'])
def chef_profile(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from chef where username = "{0}"'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# post a recipe
@chefs.route('/add_recipe', methods = ['POST'])
def chef_add_recipe():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    name = request.form['name']
    cuisineNum = request.form['cuisineNum']
    servings = request.form['servings']
    prepTime = request.form['prepTime']
    cookTime = request.form['cookTime']
    chefNam = request.form['chefNam']
    query = f'INSERT INTO recipe(name, cuisineNum, servings, prepTime, cookTime, chefNam) VALUES(\"{name}\", \"{cuisineNum}\", \"{servings}\", \"{prepTime}\", \"{cookTime}\", \"{chefNam}\")'
    cursor.execute(query)
    db.get_db().commit()
    return "success"

# View all the recipes we have in our database
@chefs.route('/view_recipes', methods=['GET'])
def view_rec(): 
    cursor = db.get_db().cursor()
    cursor.execute('SELECT *' + 
    ' FROM recipe')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# View all the cuisines we have in our database
@chefs.route('/get_cuisines', methods=['GET'])
def get_cusines(): 
    cursor = db.get_db().cursor()
    cursor.execute('select cuisineID as value, name as label from cuisine')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response







