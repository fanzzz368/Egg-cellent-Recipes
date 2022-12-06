CREATE DATABASE egg_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'eggrecipes'; 
GRANT ALL PRIVILEGES ON egg_db.* TO 'webapp'@'%'; 
FLUSH PRIVILEGES; 

USE egg_db; 

CREATE TABLE cuisine (
    name VARCHAR(255) NOT NULL, 
    cuisineID Integer PRIMARY KEY
);

CREATE TABLE employee (
    employeeID Integer PRIMARY KEY, 
    firstName VARCHAR(255) NOT NULL, 
    lastName VARCHAR(255) NOT NULL, 
    title VARCHAR(255) NOT NULL, 
    cuisineNum Integer NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    FOREIGN KEY (cuisineNum) REFERENCES cuisine(cuisineID)
);

CREATE TABLE employee_cuisine (
    employeeNum Integer, 
    cusineNum Integer, 
    FOREIGN KEY (employeeNum) REFERENCES employee(employeeID),
    FOREIGN KEY (cusineNum) REFERENCES cuisine(cuisineID)
);

CREATE TABLE user (
    recipeId Integer,
    username VARCHAR(255) PRIMARY KEY, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    employeeNum Integer NOT NULL,
    firstName VARCHAR(255) NOT NULL, 
    lastName VARCHAR(255) NOT NULL, 
    phoneNum BIGINT UNIQUE, 
    FOREIGN KEY (employeeNum) REFERENCES employee(employeeID)
); 

CREATE TABLE chef (
    username VARCHAR(255) PRIMARY KEY, 
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    employeeNum Integer UNIQUE, 
    phoneNum BIGINT UNIQUE, 
    FOREIGN KEY (employeeNum) REFERENCES employee(employeeID)
);

CREATE TABLE recipe (
    recipeId Integer PRIMARY KEY,
    name TEXT NOT NULL, 
    numViews Integer, 
    numLikes Integer, 
    cuisineNum Integer NOT NULL,
    servings Integer, 
    prepTime VARCHAR(255) NOT NULL, 
    cookTime VARCHAR(255) NOT NULL, 
    chefNam VARCHAR(255) NOT NULL, 
    FOREIGN KEY (cuisineNum) REFERENCES cuisine(cuisineID),
    FOREIGN KEY (chefNam) REFERENCES chef(username)
); 

CREATE TABLE pantry (
    pantryID Integer PRIMARY KEY,
    userNam VARCHAR(255) NOT NULL, 
    FOREIGN KEY (userNam) REFERENCES user(username) 
);

CREATE TABLE ingredient (
    ingredientID Integer PRIMARY KEY, 
    name VARCHAR(255) NOT NULL, 
    quantity Integer, 
    pantryNum Integer, 
    FOREIGN KEY (pantryNum) REFERENCES pantry(pantryID)
);

CREATE TABLE instructions (
    instruID Integer PRIMARY KEY, 
    steps VARCHAR(255) NOT NULL, 
    recipeNum Integer NOT NULL, 
    FOREIGN KEY (recipeNum) REFERENCES recipe(recipeId)
);

CREATE TABLE recipe_user (
    userNam VARCHAR(255) UNIQUE, 
    recipeNum Integer UNIQUE, 
    FOREIGN KEY (userNam) REFERENCES user(username),
    FOREIGN KEY (recipeNum) REFERENCES recipe(recipeId)
);

CREATE TABLE employee_rec (
    employeeNum Integer UNIQUE, 
    recipeNum Integer UNIQUE, 
    FOREIGN KEY (employeeNum) REFERENCES employee(employeeID),
    FOREIGN KEY (recipeNum) REFERENCES recipe(recipeId)
);

CREATE TABLE ingredient_rec (
    ingredientNum Integer, 
    recipeNum Integer UNIQUE, 
    FOREIGN KEY (ingredientNum) REFERENCES ingredient(ingredientID),
    FOREIGN KEY (recipeNum) REFERENCES recipe(recipeId)
); 

CREATE TABLE recipe_instru (
    instruNum Integer, 
    recipeNum Integer UNIQUE, 
    FOREIGN KEY (instruNum) REFERENCES instructions(instruID),
    FOREIGN KEY (recipeNum) REFERENCES recipe(recipeId)
);

CREATE TABLE help_requests (
    ticketID Integer auto_increment PRIMARY KEY,
    employeeNum Integer UNIQUE,
    user_username VARCHAR(255) UNIQUE,
    user_phoneNum VARCHAR(255) UNIQUE,
    user_email VARCHAR(255) UNIQUE,
    help_needed VARCHAR(255) UNIQUE
    FOREIGN KEY (employeeNum) REFERENCES employee(employeeID)
);


INSERT INTO cuisine 
    (name, cuisineID)
VALUES 
    ('American', 103),
    ('Italian', 132),        
    ('Chinese', 212),
    ('Japanese', 213)
    ('Caribbean', 214)
    ('Vietnamese', 215)
    ('Korean', 216)
    ('German', 217)
    ('Indian', 218)
    ('Greek', 219)
    ('French', 220)
    ('Moroccan', 221)
    ('Turkish', 222)
    ('Thai', 223)
    ('Lebanese', 224)
    ('Nigerian', 225)
    ('Malaysian', 226)
    ('Filipino', 227)
    ('Pakistani', 228)
    ('Egyptian', 229)
    ('Zimbian', 230)
    ('Spanish', 231)
    ('Australian', 232)
    ('Scottish', 233)
    ('Mexican', 234)
    ('Indonesian', 235)
    ('Brazilian', 236)
    ('Russian', 237)
    ('Peruvian', 238)
    ('Others', 239);

INSERT INTO employee 
    (employeeID, firstName, lastName, title, cuisineNum, email)
VALUES 
    (1, 'Chris', 'Patterson', 'customer service representative', 103, 'christpatterson@gmail.com'),
    (2, 'Mandy', 'Kipling', 'customer service representative', 132, 'mandykipling@gmail.com'),
    (3, 'Paige', 'Loveman', 'customer service representative', 212, 'paigeloveman@gmail.com'),
    (4, 'Brian', 'Mul', 'customer service representative', 213, 'brianmul@gmail.com'),
    (5, 'Emily', 'Flower', 'customer service representative', 212, 'emilyflower@gmail.com');

INSERT INTO user
    (username, email, employeeNum, firstName, lastName, phoneNum) 
VALUES 
    ('estack0','estack0@marriott.com',2,'Edgard','Stack', 9175023045),
    ('awellstead1','awellstead1@dion.ne.jp',1, 'Adamo','Wellstead',9175021235),
    ('bsollars2','bsollars2@123-reg.co.uk',1,'Blaire', 'Sollars', 9175023923), 
    ('rpickaver3','rpickaver3@arizona.edu',4,'Raviv', 'Pickaver', 9175021092),
    ('rbernaldez4','rbernaldez4@wsj.com',3,'Riva','Bernaldez', 9175021274),
    ('joeJoeyMulligan','joeJoeyMulligan@wsj.com',4,'Joe','Mulligan', 9175021937);

INSERT INTO chef 
    (userName, firstName, lastName, email, employeeNum, phoneNum) 
VALUES 
    ('chef12pas', 'Chris', 'Patterson', 'christpatterson@gmail.com', 1, 9175022093),
    ('ilovecheesechef', 'Mandy', 'Kipling', 'mandykipling@gmail.com', 2, 9175021298),
    ('souflecheface', 'Paige', 'Loveman', 'paigeloveman@gmail.com', 3, 9175021293),
    ('chocconswe', 'Brian', 'Mul', 'brianmul@gmail.com', 4, 9175021209);

INSERT INTO recipe
    (recipeId, name, numViews, numLikes, cuisineNum, servings, prepTime, cookTime, chefNam)
VALUES 
    (1, 'cheeseburger', 0, 0, 103, 1, '2 minutes', '5 minutes', 'chef12pas'),
    (2, 'spaghetti', 6, 6, 132, 5, '5 minutes', '15 minutes', 'ilovecheesechef'),
    (3, 'yogurt parfait', 100, 0, 103, 1, '5 minutes', '0 minutes','souflecheface');

INSERT INTO pantry 
    (pantryID, userNam)
VALUES 
    (123, 'estack0'),
    (345, 'rbernaldez4'),
    (567, 'joeJoeyMulligan');

INSERT INTO instructions 
    (instruID, steps, recipeNum)
VALUES 
    (687, 'boil potato with skin on for ten minutes', 1), 
    (803, 'cut potatoe in half', 1), 
    (483, 'spread butter on potato', 1), 
    (586, 'add salt and pepper', 1), 
    (209,  'boil pasta for ten minutes', 2), 
    (301, 'drain pasta', 2),
    (320, 'add sauce to pot', 2), 
    (182, 'add salt, pepper, and pasta to pot', 2);
    
INSERT INTO ingredient
    (ingredientID, name, quantity, pantryNum)
VALUES 
    (3421, 'onion', 2, 123),
    (4234, 'bell pepper', 6,123),
    (7546, 'pasta', 4,345),
    (2342, 'butter stick', 2, 345),
    (8586, 'chocolate', 2, 567); 