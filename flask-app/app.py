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
   query = f'INSERT INTO help_requests(user_username, user_phoneNum, user_email, help_needed) VALUES(\"{username}\", \"{phoneNum}\", \"{email}\", \"{description}\")'
   cursor.execute(query)
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
   
if __name__ == '__main__':
   # we want to run in debug mode (for hot reloading)
   # this app will be bound to port 4000.
   # Take a look at the docker-compose.yml to see
   # what port this might be mapped to...
   app.run(debug = True, host = '0.0.0.0', port = 4000)

