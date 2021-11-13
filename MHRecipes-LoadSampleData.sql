INSERT INTO Recipe_Category(category_name) VALUES('Dinner Recipes')
INSERT INTO Recipe_Category(category_name) VALUES('Breakfast Recipes');
INSERT INTO Recipe_Category(category_name) VALUES('Rice Recipes');
INSERT INTO Recipe_Category(category_name) VALUES('Snack Recipes');
INSERT INTO Recipe_Category(category_name) VALUES('Sweet Recipes');
INSERT INTO Recipe_Category(category_name) VALUES('Chutney Recipes');
INSERT INTO Recipe_Category(category_name) VALUES('Curry Recipes');


---Inserting values for the table Recipes
INSERT INTO Recipes values('Sakkarai Pongal','Sweet recipe made with Rice,Moong dal and Jaggery',5);
INSERT INTO Recipes values('Sambar','Curry recipe mixed with Toor dal,veggies and spices',7);
INSERT INTO Recipes values('Panneer Masala','Panneer mixed with tomato, cashew gravy and spices',7);
INSERT INTO Recipes values('Vegetables Curry','Veggies mixed with spices and coconut gravy',7);
INSERT INTO Recipes values('Mysore Pak','Sweet recipe made with Besan, sugar and ghee',5);
INSERT INTO Recipes values('Peanut Laddoo','Crushed peanuts mixed with Jaggery syrup and nuts',5);
INSERT INTO Recipes values('Tamarind Rice','Rice mixed with tamarind juice and spices',3);
INSERT INTO Recipes values('Green Rice','Rice mixed with coriander leaves, Palak and lemon juice',3);
INSERT INTO Recipes values('Lemon Rice','Rice mixed with lemon juice,peanuts and spices',3);
INSERT INTO Recipes values('Urad Dal Vada','Fritters made with urad dal, onion,ginger and chillies',4);
INSERT INTO Recipes values('Kara Vada','Fritters made with channa dal, onion,ginger and chillies',4);
INSERT INTO Recipes values('Bajji','Besan flour fritters mixed with onions, chillies',4);
INSERT INTO Recipes values('Idli Recipe','Idli made with Rice,urad dal and fenugreek seeds grinded together and fermented',2);
INSERT INTO Recipes values('Dosa Recipe','Idli made with Rice,urad dal,channa dal and fenugreek seeds grinded together and fermented',2);
INSERT INTO Recipes values('Upma Recipe','Upma recipe is made with wheat rawa, veggies, spices and onion',2);
INSERT INTO Recipes values('Pudina Chutney','Pudina chutney made with pudina leaves, garlic, chillies, tomatoes and grind together',6);
INSERT INTO Recipes values('Coconut Chutney','Coconut chutney made with coconuts, ginger, garlic, putna dal and grind together',6);
INSERT INTO Recipes values('Tomato Chutney','Tomatoes and onions, galic, curry leaves',6);


---sample data for Recipe_steps
INSERT INTO Recipe_steps values(1,'Method: 1.wash the rice and moong dal three times and add the water in the ratio of 1:3.
											2. cook them in the pressure cooker for 3 to 4 whistles.
											3. Once whistle releases, mash the rice and dal.
											4. Prepare the jaggery syrup with water and strain them
											5. mix jaggery syrup and mashed rice,dal.
											6. Fry cashews and dry nuts in the ghee and add to the rice.
											7. add Elaichi powder and mix with ladle and serve them.',60,30);
INSERT INTO Recipe_steps values(2,'Method: 1.wash the toor dal three times and add the water in the ratio of 1:2.
											2. cook them in the pressure cooker for 3 to 4 whistles.
											3. Once whistle releases, mash the dal.
										    4. Cut the veggies by 1 inch shape.
											5. In a pan, add oil,mustard,uraddal and add onions, fry them.
											6. Add tomatoes and fry until cooked, then add the veggies.
											7. Add the masala and salt, water.
											8. Let them cook until the veggies cook, add tamarind juice and dal
											9. add chopped coriander leaves.',45,30);

INSERT INTO Incredients values('Mustard');
INSERT INTO Incredients values('Jeera');
INSERT INTO Incredients values('Urad dal');
INSERT INTO Incredients values('Jeera powder');
INSERT INTO Incredients values('Coriander powder');

INSERT INTO Incredients values('Sambar powder');
INSERT INTO Incredients values('Fenugreek seeds');

---inserting data for the table Recipe_Incredients
INSERT INTO Recipe_Incredients values(1,2, '1 teaspoon');
INSERT INTO Recipe_Incredients values(7,2, '1/2 teaspoon');
INSERT INTO Recipe_Incredients values(6,2, '1 tablespoon');
---Users table
INSERT INTO Users values('joe456@gmail.com');
INSERT INTO Users values('a34gh@gmail.com');
INSERT INTO Users values('kkss222@gmail.com');
---Comments table

INSERT INTO Comments values(1,2, 'Nice','2/2/2020');
INSERT INTO Comments values(2,2, 'Very good','12/20/2020');
INSERT INTO Comments values(3,1, 'Nice','6/20/2021');