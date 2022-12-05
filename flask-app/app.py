###
# Main application interface
###
 
# import the create app function
# that lives in src/__init__.py
from src import create_app
from flask import request
from src import db
 
# create the app object
app = create_app()
 
@app.route('/')
def homepage():
   return f'<h1>Welcome to Egg-cellent Recipes!</h1>'

@app.route("/input_ingredients", methods = ['POST'])
def input_ingredients():
   ingredient = request.form['ingredient']
   return f'<h1>{ingredient} added to pantry.</h1>'

@app.route('/recipes_based_on_ingred')
def recipes_ingred():
    return f'<h1>these are the recipes based on your available ingredients</h1'
 
@app.route('/suggested_recipes')
def suggested_recipes():
    return f'<h1>these are the top ten suggested recipes</h1>'
 
@app.route('/customer_service_form', methods = ['POST'])
def cus_service_form():
   cursor = db.get_db().cursor()
   username = request.form['username']
   email = request.form['email']
   phoneNum = request.form['phone']
   description = request.form['description']
   return f'<h1>{username}, your request has been submitted.</h1>' 

@app.route('/signup', methods = ['POST'])
def signup():
   cursor = db.get_db().cursor()
   first_name = request.form['first']
   last_name = request.form['last']
   username = request.form['username']
   email = request.form['email']
   phoneNum = request.form['phone']
   query = f'INSERT INTO user(username, email, employeeNum, firstName, lastName, phoneNum) VALUES(\"{username}\", \"{email}\", 3, \"{first_name}\", \"{last_name}\", \"{phoneNum}\")'
   cursor.execute(query)
   db.get_db().commit()
   return f'<h1>You have successfully signed up for Egg-cellent Recipes!</h1>'
 
@app.route('emp_profile')
def emp_profile():
    return f'<h1> this is employee profile page<h/1>'
 
@app.route('/chef_profile')
def chef_profile():
    return f'<h1> this is chef profile page</h1>'
 
@app.route('/user')
def user_profile():
    return f'<h1> this is user profile page</h1>'
 
@app.route('/add_recipes')
def add_recipes():
    return f'<h1> add recipes to the system</h1>'
   
if __name__ == '__main__':
   # we want to run in debug mode (for hot reloading)
   # this app will be bound to port 4000.
   # Take a look at the docker-compose.yml to see
   # what port this might be mapped to...
   app.run(debug = True, host = '0.0.0.0', port = 4000)

