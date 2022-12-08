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
    (1, 'step 1: boil potato with skin on for ten minutes', 1), 
    (2, 'step 2: cut potatoe in half', 1), 
    (3, 'step 3: spread butter on potato', 1), 
    (4, 'step 4: add salt and pepper', 1), 
    (5,  'step 1: boil pasta for ten minutes', 2), 
    (6, 'step 2: drain pasta', 2),
    (7, 'step 3: add sauce to pot', 2), 
    (8, 'step 4: add salt, pepper, and pasta to pot', 2), 
    (9, 'step 1: get yougrt, granola, berries', 3), 
    (10, 'step 2: put granola and berries on top of yogurt', 3),
    (11, 'step 1: In a shallow bowl, combine butter, Worcestershire sauce and mustard', 4), 
    (12, 'step 2: Place onions in another shallow bowl', 4), 
    (13, 'step 3: Dip chicken in butter mixture, then coat with onions', 4), 
    (14, 'step 4: Place in a greased 11x7-in. baking dish; drizzle with remaining butter mixture.', 4), 
    (15, 'step 5: Bake, uncovered, at 400° for 20-25 minutes or until a thermometer reads 165°', 4),
    (16, 'step 1: In a Dutch oven, combine milk, water and macaroni; bring to a boil over medium heat', 5), 
    (17, 'step 2: Reduce heat and simmer until macaroni is tender and almost all the cooking liquid has been absorbed, 12-15 minutes, stirring frequently', 5), 
    (18, 'step 3: Reduce heat to low; stir in cheeses until melted and season with salt and pepper', 5), 
    (19, 'step 1: In a Dutch oven, cook pasta according to package directions, adding peas during the last 3 minutes of cooking; drain and return to pan', 6), 
    (20, 'step 2: Stir in shrimp and sauce; heat through over medium heat, stirring occasionally and sprinkle with cheese', 6), 
    (21, 'step 1: Bring a large pot of salted water to a boil. Add the plantains and boil until fork-tender, about 25 minutes. Drain the plantains, reserving ½ cup (125 mL) of the cooking water', 7), 
    (22, 'step 2: Meanwhile, place the red onion in a small bowl and cover with the vinegar', 7), 
    (23, 'step 3: Transfer the plantains to a medium bowl and add the reserved cooking water, 1 tablespoon (15 mL) of the olive oil, salt, and pepper. Mash the plantains to the consistency of mashed potatoes', 7), 
    (24, 'step 4: In a medium frying pan, heat the vegetable oil over medium heat. Drain the red onions and discard the vinegar. Add the onions to the pan and cook, stirring often, until soft and translucent, about 5 minutes. Transfer to a plate', 7), 
    (25, 'step 5: In the same pan (no need to wipe clean), heat the remaining 1 tablespoon (15 mL) olive oil over medium heat. Carefully crack the eggs into the pan, leaving space between each egg. Cook for 3 to 4 minutes, or until the whites are cooked and no longer translucent and the yolks are still runny. (I prefer the eggs over easy for this dish.)', 7), 
    (26, 'step 6: To serve, divide the mashed plantain between plates and top with a fried egg, cooked onions, and a few slices of avocado. Season with salt and pepper to taste', 7), 
    (27, 'step 1: Whisk together the flour, baking powder, and salt in a small bowl', 8), 
    (28, 'step 2: In a medium bowl, whisk the egg and milk. Add the flour mixture and mix until just blended. The batter should be quite thin. Add the chopped vegetables to the batter and mix well', 8),
    (29, 'step 3: Heat 1 tablespoon of the oil in a medium non- stick skillet over medium-high heat. Pour ¼ cup (60 ml) of the batter to make a 6-inch (15 cm) pancake. Cook until medium brown, about 1 minute. Place ¼ of the meat on top of the pancake and then flip the meat side down. Turn heat to low and cook until the bottom of the pancake is browned, the meat is thoroughly cooked, and the vegetables are tender—about 10 minutes. Repeat until the batter is used up', 8), 
    (30, 'step 4: To serve, brush the pancake with mayonnaise and tonkatsu sauce, or soy sauce. Sprinkle with the bonito flakes and crumbled nori. Eat while piping hot', 8),
    (31, 'step 1: Preheat the oven to 400°F. Set racks in the upper and lower thirds of the oven. Line two 13x18-inch baking sheets with parchment paper. In a small bowl, beat the egg with 1 tablespoon water. Prep the ingredients for the filling and set aside', 9), 
    (31, 'step 2: If using a 17-ounce puff pastry package, roll each sheet to a 9x12-inch rectangle. Cut each piece lengthwise into eight 1 1/2-inch wide strips. Cut each strip crosswise into two pieces, about 4 1/2 inches long. You should have 32 pieces of pastry', 9), 
    (32, 'step 3: Spread the center of each piece of pastry with 1/2 teaspoon mustard and top with 1/2 teaspoon sauerkraut. Brush one narrow end of the pastry with egg wash, add one piece of sausage, and roll to enclose. Return to parchment-lined baking sheets. Brush the top of each pastry with egg wash and sprinkle with caraway seeds, seam-side down. Chill in refrigerator for 15 minutes. Bake until golden brown and puffed, 23 to 27 minutes', 9), 
    (33, 'step 1: In a 4-quart saucepan, combine the rice, chicken stock, and water. Cover and let sit overnight at cool room temperature (around or below 60°F) or in the refrigerator', 10),
    (34, 'step 2: The next morning, add the ginger and the white parts of the green onions to the pot. Partially cover (a small gap is perfect to minimize evaporation and avoid a boil over) and bring to vigorous simmer over high heat. Lower the heat and gently simmer, partially covered, for 15 minutes, stirring occasionally and adjusting the heat as needed. When done, most of the liquid will have been absorbed (you’ll see little separation between the rice and liquid). Discard the ginger and green onions. Stir the pot, cover tightly, turn off the heat, and let rest for 10 minutes to finish thickening. The desired thickness of the porridge can vary according to taste; it can be rustic and thick, or elegant and thin, or somewhere in between. If needed, add a splash of water to thin or cook a little longer to thicken. Taste and season with the salt', 10), 
    (35, 'step 3: When ready to serve, reheat the porridge to a simmer, then ladle into individual bowls. Garnish with sliced green onions and pepper', 10), 
    (36, 'step 1: Combine sake, mirin, and soy sauce in a small bowl; set teriyaki sauce aside', 11), 
    (37, 'step 2: Heat oil in a large skillet over medium-high. Season salmon lightly with salt. Cook, skin side down, until skin is brown and crisp, about 4 minutes. Turn and cook until other side is just beginning to brown, about 2 minutes. Transfer to a plate', 11), 
    (38, 'step 3: Pour off fat in skillet. Bring teriyaki sauce to a boil in skillet over medium heat. Cook until reduced by two-thirds, about 4 minutes. Add salmon, skin side up, and cook, spooning sauce over, until sauce is syrupy and salmon is just cooked through, about 2 minutes', 11), 
    (39, 'step 4: Serve sprinkled with sansho powder, if desired', 11), 
    (40, 'step 1: Put a tablespoon of oil into a large lidded frying pan over medium heat and, when hot, add the cubes of paneer. Fry for a couple of minutes until golden on all sides, turning regularly, then remove to a plate', 12), 
    (41, 'step 2: Put the butter into the same pan over medium heat. When hot, add the onion and fry for around 10 minutes, until translucent and turning golden. Add the ginger and garlic, stir-fry for 2 to 3 minutes, then add the crushed tomatoes. Cover with the lid and cook for 12 to 15 minutes, until reduced to a lovely thick sauce', 12), 
    (42, 'step 3: Add the fenugreek leaves, cinnamon, cloves, ground red chile, honey, and salt to the pan. Stir, then add the fried paneer, cover with a lid, and cook for 5 minutes, or until cooked through. Add the peas and cream and cook for a further 5 minute', 12), 
    (43, 'step 4: To serve, scatter with the almonds and drizzle with a little extra cream. This curry is perfect with steamed basmati rice', 12), 
    (44, 'step 1: Using your hands, mix pork, scallion, soy paste, sesame oil, grapeseed oil, ginger, wine, salt, and pepper (if using) in a large bowl until thoroughly combined. Crack egg into center of mixture and stir vigorously in one direction with a wooden spoon or rubber spatula until mixture is shaggy and lightened in color, about 4 minutes. Cover and chill at least 15 minutes and up to 12 hours', 13), 
    (45, 'step 2: Fill a small bowl with cold water. Take a wonton wrapper and lay it in your palm. Using a small offset spatula or butter knife, press about 1 tsp. pork mixture into the center of wrapper. Dip a finger into water and run it around edges. Fold wrapper in half on a diagonal and press edges tightly together to seal. Dip your finger into water again and dampen 2 bottom corners of wonton. Bring corners together and pinch to seal. Place on a parchment-paper-lined baking sheet. Repeat with remaining wonton wrappers and filling. Cover and chill until ready to cook', 13),
    (46, 'step 3: Wontons can be assembled 1 day ahead. Keep chilled, or freeze up to 1 month. Freeze in a single layer on baking sheet until frozen, then transfer to an airtight container. Cook from frozen, about 4 minutes', 13),
    (47, 'step 4: Whisk oil, sesame paste, soy sauce, vinegar, and sugar in a small bowl to combine, then whisk in water, 1-tablespoonful at a time, until you can drizzle sauce easily but it’s not watery. If using chili crisp, stir in 1–3 Tbsp., depending on how spicy you want your sauce; set aside', 13),
    (48, 'step 5: Bring a large pot of water to a boil. Working in batches of up to 10 at a time, boil wontons until wrappers are puckered and tightly wrapped around filling (filling should be cooked through; slice one open to double-check if unsure), about 3 minutes. Using a spider or slotted spoon, transfer to a plate; let cool slightly', 13),
    (49, 'step 6: Divide wontons among bowls and spoon reserved sauce over; top with scallions and more chili crisp if desired', 13), 
    (50, 'step 1: Char, peel, and prep the ginger and onion: Use medium heat on a gas or electric coil burner, medium-hot heat on an outdoor grill or barbecue, or the broil setting in an oven (have the rack in the top or second position). Regardless, let the skin get a little splotchy with black; use tongs to occasionally rotate the ginger and onion (or shallot) and to grab and discard any flyaway skin. When working indoors, turn on the exhaust fan and open a window. To steady the aromatics on the stove, use a small grilling rack, heavy-duty broiling rack, or oven-safe cooling rack', 14), 
    (51, 'step 2: Monitor the aromatics because they char at different rates due to their uneven size and shape. After 10 to 15 minutes, they’ll have softened slightly and become sweetly fragrant. Bubbling at the root or stem ends may happen. You do not have to blacken the entire surface. Remove from the heat and let cool for about 10 minutes', 14), 
    (52, 'step 3: Remove the charred skin from the cooled onions or shallots, and as needed, rinse under running water to dislodge stubborn dark bits. Trim off and discard the blackened root and stem ends; halve or quarter each and set aside', 14), 
    (53, 'step 4: Use a vegetable peeler or the edge of a teaspoon to remove the ginger skin. Rinse under warm water to remove blackened bits. Halve the ginger lengthwise, cut into chunks, then bruise lightly (use the broad side of a knife or a meat mallet). Set aside to add to the stockpot', 14),
    (54, 'step 5: When shopping, select firm, solid onions or shallots. If using shallots, big ones endure the charring best. Choose ginger that’s relatively straight; side knobs and little branches make it harder to char and peel. To avoid feeling rushed, char and peel the aromatics a day in advance and refrigerate; cut and bruise before using. Set aside', 14), 
    (55, 'step 6: Wield a heavy cleaver or knife suitable for chopping bones to whack the bones and parts: Break them partway or all the way through to expose the marrow, making the cuts at 1 1/2-inch (3.75 cm) intervals. Work efficiently, with the flatter side of each part facing down. Direct the action from your wrist (not elbow). Imagine vanquishing a foe', 14), 
    (56, 'step 7: Switch attention to the whole chicken. Look in the body cavity for the neck, heart, gizzard, and liver. If included, add the neck (first give it a few whacks), heart, and gizzard to the parts bowl; the liver may dirty and impart an off flavor, so save it for something else', 14), 
    (57, 'step 8: Since wings tend to fall off during cooking, detach each one: bend it back (like a long arm stretch) and cut off at the shoulder/armpit joint. Whack each wing a few times and add to the parts bowl. Set the wingless bird aside', 14), 
    (58, 'step 9: To achieve a clear broth, parboil and rinse the chicken parts; use a medium stockpot, about 12-quart (12 l) capacity. After rinsing off the impurities, quickly scrub the pot, and return the parts to it. Add the wingless chicken, breast side up. Pour in the water and make sure the chicken is submerged. Partially cover and bring to a boil over high heat. Uncover and lower the heat to gently simmer', 14), 
    (59, 'step 10: Use a ladle or skimmer to remove scum that rises to the top. Add the ginger and onions, plus the coriander seeds, cloves, cilantro, rock sugar, and salt. Readjust the heat to gently simmer uncovered', 14),
    (60, 'step 11: After 25 minutes, the wingless chicken should be cooked; its flesh should feel firm yet still yield a bit to the touch. Use tongs to grab and transfer the chicken to a large bowl. Flush it with cold water, drain well, then set aside for 15 to 20 minutes to cool. Meanwhile, keep the broth simmering', 14), 
    (61, 'step 12: When the chicken can be handled, use a knife to remove each breast half and the whole legs (thigh and drumstick). Don’t cut these pieces further, or they’ll lose their succulence. Set on a plate to cool completely, then cover, and refrigerate for up to 3 days or freeze for up to 3 months; bring to room temperature for bowl assembly', 14), 
    (62, 'step 13: Return the leftover carcass and remaining bony bits to the stockpot. Adjust the heat to gently simmer for 1 1/2 hours longer. Total simmering time is roughly 2 1/4 hours, depending on the chicken’s cooling time', 14),
    (63, 'step 14: When done, let rest for 20 minutes to settle the impurities and further concentrate the flavor. Skim some fat from the broth, then use a slotted spoon to remove most of the bony parts, dumping them into a bowl for refuse. Strain the broth through a muslin-lined mesh strainer positioned over a large pot. Discard the solids. You should yield about 4 quarts (4 l)', 14), 
    (64, 'step 15: If using the broth right away, season it with the fish sauce and extra salt. When making the broth ahead, partially cover the unseasoned broth, let cool, then refrigerate for up to 3 days or freeze for up to 3 months; reheat and season before using', 14),
    (65, 'step 16: About 30 minutes before serving, ready ingredients for the bowls. Soak dried noodles in hot water until pliable and opaque; drain, rinse, then let drain well. If using fresh noodles, untangle or separate them, and snip as needed. Divide them among 8 soup bowls', 14), 
    (66, 'step 17: Prep the chicken, discarding the skin, if you want. Set aside. Place the onion, green onion, and cilantro in separate bowls and line them up with the noodles and pepper for a pho assembly line', 14), 
    (67, 'step 18: Bring the broth to a simmer over medium heat. At the same time, fill a pot with water and bring to a rolling boil for the noodles', 14), 
    (68, 'step 19: For each bowl, place a portion of the noodles in a noodle strainer or mesh sieve and dunk in the boiling water. When the noodles are soft, 5 to 60 seconds, pull the strainer from the water, shaking it to let water drain back into the pot. Empty the noodles into a bowl. Top with chicken, then add the onion, green onion, and cilantro. Finish with pepper', 14),
    (69, 'step 20: Taste and check the broth flavor again, adjust if desired, then raise the heat and bring it to boil. Ladle about 2 cups (480 ml) of broth into each bowl. Serve immediately with extras at the table', 14),
    (70, 'step 1: Remove any pin bones from fish fillets (using tweezers makes this easy). Cut each fillet in half lengthwise. Cut each half on a diagonal into 1" strips. (Work with the natural shape of the fish as you cut; this will help the pieces stay together instead of falling apart when frying', 15),
    (71, 'step 2: Whisk all-purpose flour, rice flour, and salt in a medium bowl. Gradually whisk in club soda until no lumps remain; adjust with more club soda or rice flour as needed to make it the consistency of thin pancake batter—it should be pourable, but thick enough to coat the fish', 15),
    (72, 'step 3: Fit a large pot with a deep-fry thermometer and pour in oil to measure 2". Heat over medium-high heat until thermometer registers 350°', 15), 
    (73, 'step 4: Working in batches of 5–7 pieces at a time, coat fish in batter, letting excess drip off, then carefully place in oil (to avoid splattering, lower fish into oil pointing away from you). Don’t overcrowd the pot: The oil temperature will drop dramatically and fish may stick together', 15), 
    (74, 'step 5: Fry fish, turning occasionally with a fish spatula or slotted spoon and maintaining oil temperature at 350°, until crust is puffed, crisp, and golden brown, about 5 minutes', 15), 
    (75, 'step 6: Transfer to a wire rack set inside a rimmed baking sheet; season immediately with salt', 15), 
    (76, 'step 7: While fish is frying, use tongs to heat tortillas one at a time directly over a gas burner, moving them often, until lightly charred and puffed in spots, about 1 minute per side', 15),
    (77, 'step 8: Transfer to a plate; cover with a clean kitchen towel to keep warm. (If you don’t have a gas stove, wrap up a stack of tortillas in a sheet of foil and heat in a 350° oven until warmed through', 15),
    (78, 'step 9: Top tortillas (we like two per taco) with fish, slaw, hot sauce, avocado, cilantro, and pickled jalapeños. Serve with lime wedges', 15), 
    (79, 'step 1: Place chickpeas in a medium pot and cover with water by 1". Bring to a boil over high heat, then reduce heat to medium-low and simmer, undisturbed, until chickpeas start falling apart, about 20 minutes. Reserve 1 cup cooking liquid, then drain chickpeas', 16),
    (80, 'step 2: Transfer chickpeas to a food processor. Add garlic, lemon juice, tahini, salt, and 2 Tbsp. reserved cooking liquid and process for a full 5 minutes (set a timer for this) until creamy and smooth. If at any point the hummus appears dry or very thick, add cooking liquid 1 Tbsp. at a time. With the motor running, stream in oil and process just until combined. Transfer to a medium bowl and drizzle with more oil', 16),
    (81, 'step 3: Do Ahead: Hummus can be made 5 days ahead. Let cool, then cover and chill', 16), 
    (82, 'step 1: Put the palm sugar in a medium heavy-bottomed saucepan over medium-low heat. Cook until the sugar melts, about 8 to 10 minutes, stirring frequently so the sugar doesn’t scorch. When the sugar is smooth and completely melted, remove the pan from the heat and slowly stir in the fish sauce. The mixture may seize; if it does, return it to low heat and continue stirring until smooth', 17),
    (83, 'step 2: Preheat the oven to 300°F. In a large Dutch oven over high heat, heat the canola oil. Season the pork pieces on all sides with salt and pepper. When the oil is hot, add some of the pieces of pork and sear until well browned on all sides, about 8 minutes. Transfer to a rimmed baking sheet and repeat with the remaining pork. When all the pork has been browned, reduce the heat to medium and add the shallots. Cook, stirring, until the shallots are softened, about 2 minutes, then add the ginger, garlic, and chilies and cook 1 minute more. Return the pork and any accumulated juices to the pot and add the caramel sauce and coconut water. The pieces of meat should poke up above the level of the liquid; if they’re completely submerged, transfer the meat and liquid to a different pot. Bring to a boil, then reduce the heat so the liquid is simmering. Cover the pot and transfer to the oven', 17),
    (84, 'step 3: After 15 minutes of cooking, uncover the pot; the liquid should be simmering gently. If it’s bubbling too vigorously, reduce the oven temperature to 275°F. Cook for 70 minutes—the meat should be tender but not falling apart. Uncover the pot and continue cooking for 30 minutes more, until the exposed bits of pork are caramelized and the meat is tender. Remove from the oven and serve with steamed rice', 17),
    (85, 'step 1: Gently heat the oil in a saucepan and fry the paneer until it’s golden brown on all sides. Remove from the pan and set aside for later', 18),
    (86, 'step 2: Throw the curry leaves (if using) into the pan to crisp up. Take them out and reserve for sprinkling over at the end', 18),
    (87, 'step 3: Add a little more oil to the pan if you need to and toss in the mustard and cumin seeds. Once they start sizzling, stir in the turmeric and onion. Allow to soften for a few minutes before stirring in the garlic, ginger and chiles. After a further minute, stir in the tomato paste, garam masala and coriander', 18),
    (88, 'step 4: Add a splash of water to the pan and pour in the coconut milk. Bring to a simmer and toss in the broccoli and fried paneer. Stir through the tamarind and simmer for 5 minutes. Taste and adjust the seasoning with salt and sugar. Garnish with the crispy curry leaves and the fresh cilantro before serving with some steamed basmati to mop up the sauce', 18), 
    (89, 'step 1: Wash the rice in several changes of water until the water runs clear. Soak the rice in water, generously covered, for at least 30 minutes. (This is optional but results in softer, more evenly cooked rice.) Drain thoroughly using a fine-mesh sieve', 19),
    (90, 'step 2: In a soup pot, dry-roast and stir the lentils continuously over medium heat until they are golden brown and have a nutty aroma, 2 to 3 minutes. (This step is optional but reduces the stickiness of the dal.) Thoroughly wash the lentils using a fine mesh colander. Return them to the pot, together with the rice, and add 3 1⁄2 cups of water. Bring to a boil. Skim the foam off the top. Add the turmeric powder, 2 tablespoons of the ghee, and the ginger to the boiling mixture', 19), 
    (91, 'step 3: While the rice and lentils are cooking, put 1⁄2 teaspoon of the ghee in a tempering pot or small pan over medium heat. Add the cashews, stirring them until they are fragrant and turn golden brown, a few minutes. Set the cashews aside to cool in a bowl lined with a paper towel. If using cumin seeds and peppercorns, roughly crush them in a mortar with a pestle. Set aside', 19), 
    (92, 'step 4: When the rice and lentil mixture is cooked, mix in the salt, coconut, and fried cashews, reserving some cashews for garnish', 19),
    (93, 'step 5: Put the remaining 2 tablespoons of ghee in the tempering pot or small pan over medium heat. When melted, add the crushed black peppercorns and cumin seeds and the asafetida. Fry for a few seconds until fragrant. Turn off the heat', 19), 
    (94, 'step 6: Immediately pour the spiced ghee over the rice. To get all of the spiced ghee out of the pot, put a spoonful of the rice mixture into the pot, stir, and spoon it back into the rest of the dish. Taste for salt and adjust as needed. Garnish with the reserved cashews. Serve hot', 19), 
    (95, 'step 1: In a large pot of boiling water, cook the sōmen noodles as directed on the package. Drain the noodles and place them in a large bowl filled with ice and water to serve. Your sōmen noodles will be the highlight of the table, so serve them up in a gorgeous bowl', 20),
    (96, 'step 2: Serve family-style in the middle of your table. Using tongs or chopsticks, place the noodles into individual bowls, shaking off any residual water before serving', 20),
    (97, 'step 3: Add your choice of sauces and toppings. I usually top with a touch of shōyu and rice vinegar, and offer a variety of toppings— negi, katsuobushi, arugula, tofu, avocado slices, etc', 20), 
    (98, 'step 1: Working one at a time, place pork chops on a cutting board and use the back of a cleaver or heavy chef’s knife to pound meat, moving knife back and forth across the surface, to ⅛"–¼" thick. The surface will be jagged and textured', 21), 
    (99, 'step 2: Whisk together soy sauce, vinegar, soy paste, sugar, black pepper, white pepper (if using), cinnamon, Five-Spice Powder, and ⅓ cup water in a large bowl. Add pork chops and turn to coat well. Cover and chill at least 2 hours and up to 6 hours', 21),
    (100, 'step 3: Remove pork from marinade and pat dry. Place sweet potato starch in a large shallow dish. Working one at a time, dredge pork in starch to coat well on both sides; shake off excess and transfer to a plate', 21),
    (101, 'step 4: Clip thermometer to the side of a large skillet or pot and pour in oil to come ½" up sides. Heat over medium-high until thermometer registers 350°F. Working in batches, fry pork until just golden, about 30 seconds per side. Transfer to a wire rack set inside a rimmed baking sheet and let drain', 21),
    (102, 'step 5: Repeat process, frying pork a second time until deep golden brown, about 30 seconds per side. Return to rack and let cool slightly', 21), 
    (103, 'step 6: Transfer pork to a cutting board; slice into strips. Arrange in a single layer on a platter; sprinkle with gochugaru if using', 21), 
    (104, 'step 1: In a large bowl, combine the chicken pieces with the fish sauce, lemon juice and pepper; toss to combine. Cover with plastic wrap and refrigerate for at least an hour. Drain the chicken and discard the marinade', 22), 
    (105, 'step 2: Heat the oil in a Dutch oven or heavy-bottomed pan over medium-high heat. Add the garlic and onion, and sauté until the onion begins to soften, about 2 minutes', 22), 
    (106, 'step 3: Add the chicken and sauté until no longer pink, about 5 minutes', 22), 
    (107, 'step 4: Add the pineapple juice, sugar and soy sauce. Bring to a boil, reduce the heat to medium and simmer covered until the chicken is almost tender, about 20 minutes', 22),
    (108, 'step 5: Add the pineapple chunks with juice and continue to simmer until the sauce has reduced and the chicken is tender, about 20 minutes. Season to taste with salt', 22),
    (109, 'step 6: Serve with steamed rice', 22)
    (110, 'step 1: Pat tofu dry with paper towels, then wrap in fresh paper towels and put in a microwave-safe dish. Microwave at high power 30 seconds. Pour off any liquid and wrap tofu in fresh paper towels. Microwave 1 or 2 more times for 30 seconds each time, pouring off any liquid, until tofu feels firmer', 23),
    (111, 'step 2: Preheat broiler', 23),
    (112, 'step 3: Stir together miso, sugar, and sake in a small saucepan. (If miso mixture is very thick, stir in 1 tablespoon water.) Cook over medium-high heat, stirring, until bubbling, glossy, and the consistency of ketchup, 1 to 3 minutes', 23),
    (113, 'step 4: Cut tofu in half horizontally and arrange, cut sides up, on a cutting board. Cut each half into 6 squares (pieces might not be perfectly square)', 23),
    (114, 'step 5: Arrange tofu on a foil-lined broiler pan, cut sides up, and broil about 2 inches from heat until a crust just forms, 1 to 2 minutes. Remove from oven and spread crusted side of each square with about 3/4 teaspoon miso mixture. Broil until tops are just bubbling and starting to color, 1 to 2 minutes. Transfer to a plate. Skewer each square with 1 two-pronged pick or 2 parallel straight picks. Sprinkle with seeds', 23), 
    (115, 'step 1: Heat oil in a large skillet over mediumlow. Cook guanciale, stirring often, until it starts to brown and crisp, 10–15 minutes; it will shrink dramatically as the fat renders. Transfer to a small bowl with a slotted spoon; reserve skillet (do not wipe out)', 24), 
    (116, 'step 2: Meanwhile, cook pasta in a large pot of boiling lightly salted water, stirring occasionally, until pasta is about halfway cooked (not quite al dente); drain, reserving 1 1/2 cups pasta cooking liquid', 24),
    (117, 'step 3: Add 3/4 cup pasta cooking liquid to reserved skillet and bring to a gentle boil over medium heat, swirling often to encourage drippings and liquid to emulsify, about 1 minute. Add pasta and cook, tossing often and adding more pasta cooking liquid as needed, until pasta is al dente and a thick, glossy sauce forms, 5–7 minutes (this second cooking is why you undercook the pasta initially)', 24), 
    (118, 'step 4: Increase heat to medium-high. Add guanciale, pepper, and two-thirds of Pecorino; toss well to combine and melt cheese. Serve pasta topped with remaining Pecorino', 24), 
    (119, 'step 1: Heat oil in a large skillet, preferably cast iron, over medium. Cook onion and garlic, stirring occasionally, until very soft and golden, 10–12 minutes; season with salt. Transfer to a small bowl and wipe skillet clean', 25), 
    (120, 'step 2: Toast a tortilla in the same skillet over medium-high until golden brown but not crunchy on one side, about 1 minute. Turn tortilla over and scatter one-quarter of cheese over one half of toasted side. Arrange 2 squash blossoms and one-quarter of onion mixture on top of cheese and fold tortilla in half to create a half-moon. Press down on it lightly to help tortilla adhere. Continue cooking, turning once or twice and pressing occasionally, until cheese is melted and tortilla begins to brown and crisp in spots (turn down the heat if needed), about 3 minutes. Transfer quesadilla to a plate. Repeat with remaining tortillas, cheese, squash blossoms, and onion mixture to make 3 more quesadillas', 25), 
    (121, 'step 1: Beat eggs with 1/2 teaspoon salt until smooth but not frothy', 26), 
    (122, 'step 2: Heat 1 tablespoon oil in a 12-inch nonstick skillet over medium-high heat until hot. Add eggs and cook, undisturbed, just until a thin film of cooked egg forms on bottom of skillet but most of eggs are still runny, 5 to 10 seconds. Immediately scrape eggs into a bowl. Wipe out skillet', 26), 
    (123, 'step 3: Heat remaining tablespoon oil in skillet over medium-high heat until hot. Add scallions and stir-fry until just softened, about 30 seconds. Add tomatoes and cook, stirring and turning occasionally, until juices are released and tomatoes are slightly wilted but still intact, 4 to 6 minutes. Sprinkle sugar and 1/4 teaspoon salt over tomatoes and stir to combine. Return eggs to skillet and cook, stirring occasionally, until eggs are just cooked through. Serve sprinkled with reserved scallion greens', 26), 
    (124, 'step 1: Dice cabbage finely and sprinkle with 1 teaspoon salt. Give it a bit of a massage. Leave for 10–15 minutes and then squeeze with your hands to remove any moisture', 27), 
    (125, 'step 2: With your hands thoroughly mix together cabbage, ground meat, chives, mushrooms, ginger, soy sauce, sesame oil, and pinch of salt', 27), 
    (126, 'step 3: Dry your hands completely (or wrappers will stick). Place a gyoza wrapper on one hand and put 1 teaspoon filling in center of wrapper', 27), 
    (127, 'step 4: Brush edge of half the wrapper with cold water. Make a semi-circle by folding the wrapper in half. Pinch open sides of wrapper together with your fingers and seal the top', 27),
    (128, 'step 5: Place a large frying pan over medium-high heat, add 2 teaspoons sesame oil and arrange 20–25 gyoza in pan. Add 200ml water to cover bottom of pan, cover with lid and cook on medium-high heat for 6–7 minutes or until translucent, cooked and no liquid is left in pan. Take off lid and cook for another 30–60 seconds for the bottoms to go crunchy. Cook remaining gyoza or freeze them', 27), 
    (129, 'step 6: Mix together soy sauce, vinegar and chili oil, if using. Serve gyoza hot with dipping sauce', 27), 
    (130, 'step 1: Cook farfalle in a large pot of boiling salted water, stirring occasionally, until al dente; drain, reserving 2 Tbsp. pasta cooking liquid', 28), 
    (131, 'step 2: Meanwhile, heat oil in a medium skillet over medium-high. Add shallots and 1/2 tsp. salt; cook, stirring occasionally, until tender, about 5 minutes (do not brown). Add ham, peas, and cream. Bring to a simmer and cook, stirring occasionally, until sauce is slightly thickened, about 5 minutes. Remove from heat; stir in lemon zest, 2 Tbsp. parsley, and 1/2 tsp. pepper', 28),
    (132, 'step 3: Return pasta to pot. Toss with sauce and reserved pasta cooking liquid; season with salt and pepper. Divide among plates, then top with parsley and Parmesan and season with more pepper', 28),
    (133, 'step 1: Heat 1 Tbsp. oil in a large nonstick or cast-iron skillet or wok over high. Reserve about 2 Tbsp. sliced scallion greens; add remaining scallions to oil and cook, tossing occasionally, about 1 minute. Add chicken, 1 tsp. salt, and pepper and cook, stirring, about 2 minutes. Stir in garlic and ginger, then add broccolini and toss until incorporated. Cover and cook until chicken is cooked through and broccolini is tender, 2–3 minutes more. Transfer to a large bowl', 29), 
    (134, 'step 2: Heat remaining 3 Tbsp. oil in skillet over high. Add rice and remaining 1/4 tsp. salt, toss to coat, then press rice into a single layer, and cook, undisturbed, until crisped on the bottom, about 2 minutes. Move rice to one-half of skillet and add eggs to other half. Cook, stirring gently to form curds, until soft set and just cooked through, about 1 minute, then fold into rice', 29), 
    (135, 'step 3: Fold in snow peas, edamame, soy sauce, and orange juice. Cook, tossing, until warmed through, about 1 minute. Add chicken mixture and toss to combine. Divide among plates, then top with reserved 2 Tbsp. scallions. Drizzle with chili or sesame oil, if using', 29), 
    (136, 'step 1: Preheat oven 425°F. Using kitchen scissors, trim the tips from the wings and discard. Cut the wings in half at the joint and place in a plastic bag with the cornstarch. Shake to coat, dusting off any excess cornstarch', 30), 
    (137, 'step 2: Place the oil, salt, five-spice and dried chili flakes in a large bowl. Add the wings and toss to coat. Place on a baking sheet lined with non-stick parchment paper and roast for 25–30 minutes or until crisp. Serve with chili sauce, chilies and chili mayonnaise', 30);
 


    
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
    (81, 'chickpeas'),
    (82, 'lemon juice'),
    (83, 'tahini'),
    (84, 'olive oil'),
    (85, 'pork shoulder'),
    (86, 'shallots'),
    (87, 'thai chilies'),
    (88, 'coconut water'),
    (89, 'curry leaves'),
    (90, 'cumin seeds'),
    (91, 'ground turmeric'),
    (92, 'tomato paste'),
    (93, 'coconut milk'),
    (94, 'broccoli'),
    (95, 'tamarind paste'),
    (96, 'moong dal'),
    (97, 'cashews'),
    (98, 'coconut'),
    (99, 'asafetida powder'),
    (100, 'somen noodles'),
    (101, 'sriracha sauce'),
    (102, 'katsuobushi'),
    (103, 'furikake'),
    (104, 'arugula'),
    (105, 'kaiware sprouts'),
    (106, 'gomashio'),
    (107, 'tofu'),
    (108, 'boneless pork loin chops'),
    (109, 'white pepper'),
    (110, 'five-spice powder'),
    (111, 'chinese sweet potato starch'),
    (112, 'gochugaru'),
    (113, 'chicken breast'),
    (114, 'lemon juice'),
    (115, 'pineapple juice'),
    (116, 'pineapple'),
    (117, 'red miso'),
    (118, 'sesame seeds'),
    (119, 'pilpelchuma'),
    (120, 'tomatoes'),
    (121, 'labneh'),
    (122, 'lemon zest'),
    (123, 'ricotta'),
    (124, 'tostadas'),
    (125, 'serrano chiles'),
    (126, 'capers'),
    (127, 'greek yogurt'),
    (128, 'peanut oil'),
    (129, 'ground cardamom'),
    (130, 'ground nutmeg'),
    (131, 'paprika'),
    (132, 'cayenne'),
    (133, 'naan'),
    (134, 'quinoa grains'),
    (135, 'queso fresco'),
    (136, 'corn'),
    (137, 'fava beans'),
    (138, 'rocoto chile'),
    (139, 'yellow chile'),
    (140, 'parsley'),
    (141, 'huacatay leaves'),
    (142, 'black olives'),
    (143, 'white wine vinegar'),
    (144, 'oregano'),
    (145, 'chicken thighs'),
    (146, 'anise'),
    (147, 'peanut butter'),
    (148, 'english hothouse cucumber'),
    (149, 'pork shoulder'),
    (150, 'pork belly'),
    (151, 'cabbage')
    (152, 'guanciale'),
    (153, 'rigatoni'),
    (154, 'pecorino romano')
    (155, 'mozzarella cheese'),
    (156, 'squash blossoms'),
    (157, 'shiitake mushrooms'),
    (158, 'la-yu'),
    (159, 'farfalle'),
    (160, 'ham'),
    (161, 'parmesan cheese')
    (162, 'chicken cutlets'),
    (163, 'broccolini'),
    (164, 'snow peas'),
    (165, 'orange juice'),
    (166, 'chicken wings'),
    (167, 'cornstarch'),
    (168, 'dried chili flakes'),
    (169, 'pickled chili'),
    (170, 'chili maynonnaise'),