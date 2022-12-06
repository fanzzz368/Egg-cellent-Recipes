from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

chefs = Blueprint('chefs', __name__)
#login, sign-in

@chefs.route('/chefs/<username>', methods=['GET'])
def chef_profile(username):
    cursor = db.get_db().cursor()
    cursor.execute('select * from chef where username = {0}'.format(username))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#    recipeId Integer PRIMARY KEY,
#     name TEXT NOT NULL, 
#     numViews Integer, 
#     numLikes Integer, 
#     cuisineNum Integer NOT NULL,
#     servings Integer, 
#     prepTime VARCHAR(255) NOT NULL, 
#     cookTime VARCHAR(255) NOT NULL, 
#     chefNam VARCHAR(255) NOT NULL, 
#     FOREIGN KEY (cuisineNum) REFERENCES cuisine(cuisineID),
#     FOREIGN KEY (chefNam) REFERENCES chef(username)

@chefs.route('/add_recipe', methods=['POST'])
def chef_add_recipe():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    name = request.form['nuid']
    # numViews = 0
    # numLikes = 0
    cuisineNum = request.form['cusineNum']
    servings = request.form['servings']
    prepTime = request.form['prepTime']
    cookTime = request.form['cookTime']
    chefNam = request.form['chefNam']
    query = f'INSERT INTO chef(name, numViews, numLikes, cuisineNum, servings, prepTime, cookTime, chefNam) VALUES(\"{name}\", 0, 0, \"{cuisineNum}\", \"{servings}\", \"{prepTime}\", \"{cookTime}\", \"{chefNam}\")'
    cursor.execute(query)
    db.get_db().commit()
    return "success"




