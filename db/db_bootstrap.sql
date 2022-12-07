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
    employeeID Integer auto_increment PRIMARY KEY, 
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
    recipeId Integer auto_increment PRIMARY KEY,
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
    pantryID Integer auto_increment PRIMARY KEY,
    userNam VARCHAR(255) NOT NULL, 
    FOREIGN KEY (userNam) REFERENCES user(username) 
);

CREATE TABLE ingredient (
    ingredientID Integer auto_increment PRIMARY KEY, 
    name VARCHAR(255) NOT NULL
);

-- updated pantry and ingredient to be many to many relationship
CREATE TABLE pantry_ingred (
    pantryNum Integer UNIQUE,
    ingredientNum Integer UNIQUE,
    FOREIGN KEY (pantryNum) REFERENCES pantry(pantryID),
    FOREIGN KEY (ingredientNum) REFERENCES ingredient(ingredientID)
);

CREATE TABLE instructions (
    instruID Integer auto_increment PRIMARY KEY, 
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
    (5, 'Emily', 'Flower', 'customer service representative', 214, 'emilyflower@gmail.com')
    (6, 'Shuai', 'Ge', 'customer service representative', 215, 'shuaige@gmail.com')
    (7, 'Billy', 'Bob', 'customer service representative', 216, 'billybob@gmail.com'),
    (8, 'Amanda', 'Liu', 'customer service representative', 217, 'amandaliu@gmail.com'),
    (9, 'Lily', 'Zhu', 'customer service representative', 218, 'lilyzhu@gmail.com'),
    (10, 'Jeff', 'Anderson', 'customer service representative', 219, 'jeffanderson@gmail.com'),
    (11, 'Cory', 'White', 'customer service representative', 220, 'corywhite@gmail.com')
    (12, 'Lucy', 'Armstrong', 'customer service representative', 221, 'lucyarmstrong@gmail.com')
    (13, 'Harris', 'Batman', 'customer service representative', 222, 'harrisbatman@gmail.com'),
    (14, 'Molly', 'Bear', 'customer service representative', 223, 'mollybear@gmail.com'),
    (15, 'Peppa', 'Ping', 'customer service representative', 224, 'peppaping@gmail.com'),
    (16, 'Ryan', 'Null', 'customer service representative', 225, 'ryannull@gmail.com'),
    (17, 'Casey', 'Plant', 'customer service representative', 226, 'caseyplant@gmail.com')
    (18, 'Henry', 'Young', 'customer service representative', 227, 'henryyoung@gmail.com')
    (19, 'Harry', 'Old', 'customer service representative', 228, 'harryold@gmail.com'),
    (20, 'Paul', 'Liu', 'customer service representative', 229, 'paulliu@gmail.com'),
    (21, 'Vincent', 'Zhu', 'customer service representative', 230, 'vincentzhu@gmail.com'),
    (22, 'Andrea', 'Lol', 'customer service representative', 231, 'andrealol@gmail.com'),
    (23, 'Daniel', 'Xu', 'customer service representative', 232, 'danielxu@gmail.com')
    (24, 'Brianna', 'Yolo', 'customer service representative', 233, 'briannayolo@gmail.com')
    (25, 'Alice', 'Chu', 'customer service representative', 234, 'alicechu@gmail.com'),
    (26, 'Frank', 'Darcy', 'customer service representative', 235, 'frankdarcy@gmail.com'),
    (27, 'George', 'Mouse', 'customer service representative', 236, 'georgemousegmail.com'),
    (28, 'Theo', 'Door', 'customer service representative', 237, 'theodoor@gmail.com'),
    (29, 'Will', 'Bread', 'customer service representative', 238, 'willbread@gmail.com')
    (30, 'John', 'Winterjacket', 'customer service representative', 239, 'johnwinterjacket@gmail.com');


INSERT INTO user
    (username, email, employeeNum, firstName, lastName, phoneNum) 
VALUES 
    ('estack0','estack0@marriott.com',1,'Edgard','Stack', 9175023045),
    ('awellstead1','awellstead1@dion.ne.jp',2, 'Adamo','Wellstead',9175021235),
    ('bsollars2','bsollars2@123-reg.co.uk',3,'Blaire', 'Sollars', 9175023923), 
    ('rpickaver3','rpickaver3@arizona.edu',4,'Raviv', 'Pickaver', 9175021092),
    ('rbernaldez4','rbernaldez4@wsj.com',5,'Riva','Bernaldez', 9175021274),
    ('joejoeymulligan','joejoeymulligan@wsj.com',6,'Joe','Mulligan', 9175021937)
    ('fandadadayo','fzoom@gmail.com',7,'Fan','Zoom', 8603128888),
    ('luvfoodz','yumfood8@yahoo.com',8, 'Jamie','Moon',9175021234),
    ('pickleseater23','kelseyjo@gmail.com',9,'Kelsey', 'Jo', 3211409123), 
    ('randomperson11','randyliu3@gmail.com',10,'Randy', 'Liu', 3459871023),
    ('lizqueen','elizabethstraw99@gmail.com',11,'Elizabeth','Straw', 9175021774),
    ('johnathon342','john342@wsj.com',12,'Johnathon','Miller', 9175022894)
    ('emily88','iamemily88@marriott.com',13,'Emily','Stocks', 8609089123),
    ('howardtower','howardeatsfood@gmail.com',14, 'Howard','Toward', 8609489123),
    ('bennypenny','bpsoccer@gmail.com',15,'Ben', 'Peng', 9175023323), 
    ('ketchup912','calebzhu@arizona.edu',16,'Caleb', 'Zhu', 6782349876),
    ('kellywillis34','kwillis@wsj.com',17,'Kelly','Willis', 3409124738),
    ('differentjoe','joesunny@wsj.com',18,'Joe','Sunny', 1327896712),
    ('iloverain3','ibelieveinfate@gmail.com',19,'Winnie','Wheel', 9176023045),
    ('iwanttocook13','cookandbakeguru@gmail.com',20, 'Sam','Wellington',9175025235),
    ('badmintonpro34','iplaysports78@yahoo.com',21,'Jake', 'Spring', 9175223323), 
    ('isleepandeat','enjoylife4@gmail.com',22,'Tim', 'Zhou', 6782349886),
    ('cupcakes2023','youngkid49@gmail,com',23,'Lucy','Tree', 6782449886),
    ('kruskalalgo99','ilovecs@yahoo.com',24,'Doug','Brow', 8607859993)
    ('pollytriangle2','pollyyes@gmail.com',25,'Polly','Triangle', 5679760912),
    ('itakenaps42','susanli3@gmail.com',26, 'Susan','Li',5679352789),
    ('icanswim2','b.mondo@northeastern.edu',27,'Blaire', 'Mondo', 8574371354), 
    ('holidayseasonyay','hollyku@northeastern.edu',28,'Holly', 'Ku', 6745986435),
    ('user234','basicname45@yahoo.com',29,'Kevin','Lin', 9453781208),
    ('user123456','iloveramennoodles@gmail.com',30,'Tiffany','Mulligan', 3854670834);

INSERT INTO chef 
    (userName, firstName, lastName, email, employeeNum, phoneNum) 
VALUES 
    ('chef12pas', 'Chris', 'Patterson', 'christpatterson@gmail.com', 1, 9175022093),
    ('ilovecheesechef', 'Mandy', 'Kipling', 'mandykipling@gmail.com', 2, 9175021298),
    ('souflecheface', 'Paige', 'Loveman', 'paigeloveman@gmail.com', 3, 9175021293),
    ('chocconswe', 'Brian', 'Mul', 'brianmul@gmail.com', 4, 9175021209),
    ('clongmore0', 'Connie', 'Longmore', 'clongmore0@alexa.com', 5, 7254942881),
    ('rbeernaert1', 'Rina', 'Beernaert', 'rbeernaert1@com.com', 6, 8844062563),
    ('kdemangeot2', 'Kerwin', 'Demangeot', 'kdemangeot2@lycos.com', 7, 6745732806),
    ('pandriessen3', 'Pen', 'Andriessen', 'pandriessen3@stanford.edu', 8, 4963987363),
    ('wbertram4', 'Wilt', 'Bertram', 'wbertram4@auda.org.au', 9, 1398843933),
    ('jcharlwood5', 'Jemmie', 'Charlwood', 'jcharlwood5@dyndns.org', 10, 3445635799),
    ('ehollerin6', 'Edmund', 'Hollerin', 'ehollerin6@miitbeian.gov.cn', 11, 6491037410),
    ('msimanenko7', 'Morty', 'Simanenko', 'msimanenko7@columbia.edu', 12, 2318006518),
    ('bmcclelland8', 'Binni', 'McClelland', 'bmcclelland8@xing.com', 13, 2957568861),
    ('vkhidr9', 'Vilma', 'Khidr', 'vkhidr9@soup.io', 14, 4237208397),
    ('dmassiea', 'Deidre', 'Massie', 'dmassiea@loc.gov', 15, 1039888490),
    ('ichavezb', 'Isadore', 'Chavez', 'ichavezb@senate.gov', 16, 3905899009),
    ('ewiganc', 'Evan', 'Wigan', 'ewiganc@goo.gl', 17, 2372310517),
    ('srycroftd', 'Stanleigh', 'Rycroft', 'srycroftd@list-manage.com', 18, 6324420701),
    ('tdodse', 'Thurston', 'Dods', 'tdodse@slashdot.org', 19, 1122927758),
    ('iambroschf', 'Isobel', 'Ambrosch', 'iambroschf@constantcontact.com', 20, 2838938681),
    ('kfedorskig', 'Kelci', 'Fedorski', 'kfedorskig@blog.com', 21, 6988624499),
    ('glotonh', 'Gaile', 'Loton', 'glotonh@sbwire.com', 22, 1509771275),
    ('bfarnalli', 'Benson', 'Farnall', 'bfarnalli@ifeng.com', 23, 8423271140),
    ('kgrishaevj', 'Kaela', 'Grishaev', 'kgrishaevj@google.co.uk', 24, 7368404116),
    ('drosek', 'Dasha', 'Rose', 'drosek@umich.edu', 25, 1213449540),
    ('sburletonl', 'Spense', 'Burleton', 'sburletonl@deliciousdays.com', 26, 1892222861),
    ('wsikoram', 'Wilow', 'Sikora', 'wsikoram@google.nl', 27, 6609200575),
    ('qjerattn', 'Quill', 'Jeratt', 'qjerattn@ted.com', 28, 6692259316),
    ('sbogo', 'Shamus', 'Bog', 'sbogo@list-manage.com', 29, 9983509000),
    ('kcarlop', 'Kim', 'Carlo', 'kcarlop@opensource.org', 30, 1466920655);

INSERT INTO recipe
    (recipeId, name, numViews, numLikes, cuisineNum, servings, prepTime, cookTime, chefNam)
VALUES 
    (1, 'baked potato', 0, 0, 103, 1, '2 minutes', '5 minutes', 'chef12pas'),
    (2, 'spaghetti', 6, 6, 132, 5, '5 minutes', '15 minutes', 'ilovecheesechef'),
    (3, 'yogurt parfait', 100, 0, 103, 1, '5 minutes', '0 minutes','souflecheface'),
    (4, 'tasty onion chicken', 12, 6, 103, 4, '10 minutes', '25 minutes','vkhidr9'), 
    (5, 'one pot mac and cheese', 1000, 5, 1, 10, '5 minutes', '30 minutes', 'kcarlop'),
    (6, 'shrimp pasta alfredo', 4929, 2109, 132, 4, '10 minutes', '15 minutes', 'sbogo'), 
    (7, 'mashed plantains with fried eggs', 28991, 2124, 239, 2, '15 minutes', '15 minutes', 'sburletonl'),
    (8, 'okonomiyaki pancakes with bonito flakes', 219, 133, 213, 1, '15 minutes', '15 minutes','vkhidr9'),
    (9, 'pigs in a blanket with sauerkraut and mustard', 281, 29, 217, 4, '20 minutes', '25 minutes', 'glotonh'), 
    (10, 'super simple overnight porridge', 3298, 3001, 215, 1, '10 minutes', '5 minutes', 'ichavezb'), 
    (11, 'salmon teriyaki', 199, 129, 213, 2, '10 minutes', '15 minutes', 'dmassiea'),
    (12, 'paneer butter masala', 208, 100, 218, 4, '10 minutes', '15 minutes', 'bmcclelland8'),
    (13, 'pork wontons with sesame sauce', 1938, 199, 212, 4, '15 minutes', '20 minutes', 'clongmore0'), 
    (14, 'classic chicken pho', 113988, 2891, 215, 5, '20 minutes', '30 minutes', 'qjerattn'),
    (15, 'perfect fish tacos', 827, 283, 103, 2, '12 minutes', '15 minutes', 'kfedorskig'), 
    (16, 'easy canned chickpea hummus', 10, 0, 103, 3, '5 minutes', '5 minutes', 'sburletonl'), 
    (17, 'candy pork', 100, 10, 215, 5, '20 minutes', '20 minutes', 'jcharlwood5'),
    (18, 'paneer and broccolo masala', 500, 234, 218, 5,'15 minutes', '25 minutes', 'msimanenko7'), 
    (19, 'pongal', 134, 22, 218, 6, '20 minutes', '25 minutes', 'chef12pas'),
    (20, 'summertime somen noodles', 10, 9, 213, 10, '25 minutes', '5 minutes','bmcclelland8'), 
    (21, 'crispy taiwanese pork cutlets', 130, 67, 239, 'glotonh'), 
    (22, 'chicken hamonado', 199, 20, 103, 5, '10 minutes', '15 minutes', 'iambroschf'),
    (23, 'broiled tofu with miso', 93, 14, 212, 1, '10 minutes', '5 minutes', 'wsikoram'), 
    (24, 'pasta alla gricia', 200, 30, 132, 4, '10 minutes', '15 minutes', 'kgrishaevj'), 
    (25, 'quesadilla', 2847, 299, 234, 1, '10 minutes', '5 minutes', 'bmcclelland8'), 
    (26, 'stir-fried egg and tomato', 29, 23, 103, 1, '5 minutes', '5 minutes', 'luvfoodz'),
    (27, 'gyoza', 3298, 2983, 212, 2, '25 minutes', '25 minutes', 'ewiganc'), 
    (28, 'pasta with ham, pea, and cream sauce', 14, 0, 132, 5, '15 minutes', '15 minutes'), 
    (29, 'fried rice w/ chicken and broccolini', 56, 0, 212, 4, '15 minutes', '15 minutes', 'bfarnalli'), 
    (30, 'cripsy chicken wings', 1990, 1800, 103, 5, '10 minutes', '15 minutes', 'sbogo');

INSERT INTO pantry 
    (pantryID, userNam)
VALUES 
    (123, 'estack0'),
    (345, 'rbernaldez4'),
    (567, 'joeJoeyMulligan');

INSERT INTO instructions 
    (instruID, steps, recipeNum)
VALUES 
    (1, 'boil potato with skin on for ten minutes', 1), 
    (2, 'cut potatoe in half', 1), 
    (3, 'spread butter on potato', 1), 
    (4, 'add salt and pepper', 1), 
    (5,  'boil pasta for ten minutes', 2), 
    (6, 'drain pasta', 2),
    (7, 'add sauce to pot', 2), 
    (8, 'add salt, pepper, and pasta to pot', 2);
    
INSERT INTO ingredient
    (ingredientID, name, quantity)
VALUES 
    (1, 'onion'),
    (2, 'bell pepper'),
    (3, 'pasta'),
    (4, 'butter'),
    (5, 'chocolate'), 
    (6, 'worcestershire sauce'),
    (7, 'ground mustard'),
    (8, 'french-fried onions'),
    (9, 'boneless skinless chicken breast halves'),
    (10, 'milk'),
    (11, 'water'),
    (12, 'elbow macaroni'),
    (13, 'velveeta'),
    (14, 'sharp cheddar cheese'),
    (15, 'salt'),
    (16, 'ground pepper'),
    (17, 'bow tie pasta'),
    (18, 'frozen peas'),
    (19, 'shrimp'),
    (20, 'alfredo sauce'),
    (21, 'parmesan cheese'),
    (22, 'plantains'),
    (23, 'red onion'),
    (24, 'white vinegar'),
    (25, 'vegetable oil'),
    (26, 'eggs'),
    (27, 'avocado'),
    (28, 'all-purpose flour'),
    (29, 'baking powder'),
    (30, 'cabbage'),
    (31, 'scallions'),
    (32, 'bell pepper'),
    (34, 'mayonnaise'),
    (35, 'tonkatsu sauce'),
    (36, 'bonito flakes'),
    (37, 'crumbled nori'),
    (38, 'puff pastry'),
    (39, 'sausage'),
    (40, 'sauerkraut'),
    (41, 'caraway seeds'),
    (42, 'white rice'),
    (43, 'chicken stock'),
    (44, 'ginger'),
    (45, 'sake'),
    (46, 'mirin'),
    (47, 'soy sauce'),
    (48, 'boneless salmon fillets'),
    (49, 'sansho powder'),
    (50, 'paneer'),
    (51, 'yellow onion'),
    (52, 'garlic'),
    (53, 'cans of crushed tomatoes'),
    (54, 'kasoori methi'),
    (55, 'cinnamon'),
    (56, 'cloves'),
    (57, 'red chili'),
    (58, 'honey'),
    (59, 'heavy cream'),
    (60, 'almonds'),
    (61, 'ground pork'),
    (62, 'soy paste'),
    (63, 'sesame oil'),
    (64, 'rice wine'),
    (65, 'wonton wrapper'),
    (66, 'rice vinegar'),
    (67, 'sugar'),
    (68, 'chili crisp'),
    (69, 'coriander'),
    (70, 'cilantro'),
    (71, 'yellow rock sugar'),
    (72, 'fish sauce'),
    (73, 'flat rice noodles'),
    (74, 'yellow rock sugar'),
    (75, 'white fish fillet'),
    (76, 'white rice flour'),
    (77, 'club soda'),
    (78, 'corn tortillas'),
    (79, 'cabbage and jicama slaw'),
    (80, 'fresno chile hot sauce'),