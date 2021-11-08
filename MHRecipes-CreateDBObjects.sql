
CREATE DATABASE MH_RECIPES;
USE MH_RECIPES;
IF OBJECT_ID('Recipes', 'U') IS NOT NULL
    DROP TABLE Recipes;
CREATE TABLE Recipes
( recipe_id INT NOT NULL IDENTITY PRIMARY KEY,
  recipe_name VARCHAR(255) NOT NULL,
  recipe_description VARCHAR(255),
  recipe_category_id INT NOT NULL
  FOREIGN KEY(recipe_category_id) REFERENCES Recipe_Category(recipe_category_id));
  GO
  IF OBJECT_ID('Recipe_Category', 'U') IS NOT NULL
    DROP TABLE Recipe_Category;
CREATE TABLE Recipe_Category
( recipe_category_id INT NOT NULL IDENTITY PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  );
  GO
--  Recipe_steps-steps_id-recipe_id-instructions-prep_time-cook_time
IF OBJECT_ID('Recipe_steps', 'U') IS NOT NULL
    DROP TABLE Recipe_steps;
CREATE TABLE Recipe_steps
( steps_id INT NOT NULL IDENTITY PRIMARY KEY,
  recipe_id INT NOT NULL,
  instructions TEXT,
  prep_time INT,
  cook_time INT,
  FOREIGN KEY(recipe_id) REFERENCES Recipes(recipe_id));
  GO
--Incredients	-ingredient_id(primary key)-ingredient_name	
IF OBJECT_ID('Incredients', 'U') IS NOT NULL
    DROP TABLE Incredients;
CREATE TABLE Incredients
( incredient_id INT NOT NULL IDENTITY PRIMARY KEY,
  incredient_name varchar(250) NOT NULL,
  );
  GO
---Recipe_incredients:id,incredient_id,recipe_id,amount_required
IF OBJECT_ID('Recipe_Incredients', 'U') IS NOT NULL
    DROP TABLE Recipe_Incredients;
CREATE TABLE Recipe_Incredients
(recipe_incredient_id INT NOT NULL IDENTITY PRIMARY KEY,
  incredient_id INT NOT NULL,
  recipe_id INT NOT NULL,
  amount_required varchar(50),
  FOREIGN KEY(incredient_id) REFERENCES Incredients(incredient_id),
  FOREIGN KEY(recipe_id) REFERENCES Recipes(recipe_id));
   
  GO
  --Users:user_id,user_email
  IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;
CREATE TABLE Users
(userid INT NOT NULL IDENTITY PRIMARY KEY,
  user_email varchar(255) NOT NULL,
  );
  Go 
 --comments:user_id, recipe_id, comment,posted_date
   IF OBJECT_ID('Comments', 'U') IS NOT NULL
    DROP TABLE Comments;
CREATE TABLE Comments
(comments_id INT NOT NULL IDENTITY PRIMARY KEY,
  userid INT NOT NULL,
  recipe_id INT NOT NULL,
  comment text,
  posted_date date,
  FOREIGN KEY(userid) REFERENCES Users(userid),
  FOREIGN KEY(recipe_id) REFERENCES Recipes(recipe_id));
   
  GO

 
