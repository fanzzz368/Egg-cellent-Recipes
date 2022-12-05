from flask import Blueprint, request, jsonify, make_response
import json
from src import db

chefs = Blueprint('chefs', __name__)
#login, sign-in

@chefs.route('chefs/chef_profile/<userName>', methods=['GET'])
def chef_profile(userName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from chef where username = {0}'.format(userName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@chefs.route('chefs/add_recipes', methods=['POST'])
def chef_add_recipe():
    current_app.logger.info(request.form)
    return "Hello"

    # copied and pasted from the slides idk what it means


