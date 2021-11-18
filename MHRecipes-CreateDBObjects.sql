
IF EXISTS ( SELECT [name] FROM sys.databases WHERE [name] = 'MH_RECIPES' )
DROP DATABASE MH_RECIPES
GO

CREATE DATABASE MH_RECIPES;
GO

USE MH_RECIPES;

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

--Incredients	-ingredient_id(primary key)-ingredient_name	
IF OBJECT_ID('Incredients', 'U') IS NOT NULL
    DROP TABLE Incredients;
CREATE TABLE Incredients
( incredient_id INT NOT NULL IDENTITY PRIMARY KEY,
  incredient_name varchar(250) NOT NULL,
  );
  GO

--Users:user_id,user_email
IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;
CREATE TABLE Users
(userid INT NOT NULL IDENTITY PRIMARY KEY,
  user_email varchar(255) NOT NULL,
  );
  Go 


 ---indexes

CREATE NONCLUSTERED INDEX IX_RecipeName ON Recipes (recipe_name DESC)
GO


CREATE NONCLUSTERED INDEX IX_CategoryName ON Recipe_Category (category_name DESC)
GO


--stored procedure
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'CreateIncredients' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE CreateIncredients
GO
CREATE PROCEDURE CreateIncredients

(@Incredname varchar(255),
@IncredId int output)

AS
BEGIN
SET NOCOUNT ON;
INSERT INTO Incredients (incredient_name) VALUES (@Incredname)
SELECT @IncredId= SCOPE_IDENTITY()
END;
GO
--stored procedure: ReadRecipeCategories
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'ReadRecipeCategories' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE ReadRecipeCategories
GO

CREATE PROCEDURE ReadRecipeCategories(@rname as varchar(255))
AS 
BEGIN
SET NOCOUNT ON;
SELECT R.recipe_name,RC.category_name 
FROM Recipes AS R
INNER JOIN Recipe_Category RC ON R.recipe_category_id = RC.recipe_category_id
where R.recipe_name like '%'+ @rname
END;

GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'DeleteRecipe' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE DeleteRecipe
GO

--delete stored procedure
CREATE PROCEDURE DeleteRecipe @RecipeName NVARCHAR(255) AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @RecipeId INT = (SELECT Recipes.recipe_id FROM Recipes WHERE recipe_name = @RecipeName)
    DELETE FROM Recipe_Incredients WHERE Recipe_Incredients.recipe_id = @RecipeId;
    DELETE FROM Recipes WHERE Recipes.recipe_id = @RecipeId;
	DELETE FROM Recipe_steps WHERE Recipe_steps.recipe_id = @RecipeId;
	DELETE FROM Comments WHERE Comments.recipe_id = @RecipeId;


END
GO

---updaterecipe
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'UpdateRecipe' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE UpdateRecipe
GO

CREATE PROCEDURE UpdateRecipe @OldRecipeName NVARCHAR(255), @NewRecipeName NVARCHAR(255) AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Recipes SET Recipes.recipe_name = @NewRecipeName WHERE Recipes.recipe_name = @OldRecipeName
END
GO
---Functions
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'NumberOfCategories' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE NumberOfCategories
GO
CREATE OR ALTER PROCEDURE NumberOfCategories AS
BEGIN
	SELECT	distinct(rc.category_name),
	count(rc.category_name) Number_of_Categories
FROM
	Recipes r
left JOIN Recipe_Category rc ON r.recipe_category_id = rc.recipe_category_id
group by rc.category_name
ORDER BY
	rc.category_name
END;
GO

IF object_id('NumberOfUsers', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[NumberOfUsers]
END
GO
---NumberOfUser function
CREATE FUNCTION NumberOfUsers(@RecipeID INT)
RETURNS INT
AS 
BEGIN
    RETURN (SELECT COUNT(userid) FROM Comments 
	WHERE recipe_id = @RecipeID);
END;
GO
--Table valued function

IF object_id('CommentsOnPDate', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[CommentsOnPDate]
END
GO

CREATE FUNCTION CommentsOnPDate (
    @PostedDate Date) 
RETURNS TABLE
AS
RETURN
    SELECT 
        c.userid,
		r.recipe_name,
        c.comment        
    FROM
        Comments c join Recipes r
    ON c.recipe_id=r.recipE_id  
	WHERE posted_date = @PostedDate;
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'ReadRecipes' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE ReadRecipes
GO
CREATE PROCEDURE ReadRecipes
AS
BEGIN
	SELECT	*
FROM
	Recipes 
END;
GO
---Lists recipes by category
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'ListRecipeCategory' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE ListRecipeCategory
GO
CREATE OR ALTER PROCEDURE ListRecipeCategory AS
BEGIN
	SELECT	r.recipe_name,
	rc.category_name
FROM
	Recipes r
INNER JOIN Recipe_Category rc ON r.recipe_category_id = rc.recipe_category_id

ORDER BY
	r.recipe_name
END;
GO

SELECT r.recipe_name,rc.category_name,i.incredient_name,ri.amount_required
FROM Recipe_Category rc
INNER JOIN Recipes r ON rc.recipe_category_id = r.recipe_category_id
INNER JOIN Recipe_Incredients ri ON r.recipe_id = ri.recipe_id
INNER JOIN Incredients i ON ri.incredient_id = i.incredient_id;
		