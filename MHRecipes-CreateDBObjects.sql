
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

 ---indexes

CREATE NONCLUSTERED INDEX IX_RecipeName ON Recipes (recipe_name DESC)
GO


CREATE NONCLUSTERED INDEX IX_CategoryName ON Recipe_Category (category_name DESC)
GO
--stored procedure
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'ReadRecipeCategories' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE ReadRecipeCategories
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'DeleteRecipe' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE DeleteRecipe
GO
IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'UpdateRecipe' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE UpdateRecipe
GO
--stored procedure: ReadRecipeCategories
CREATE PROCEDURE ReadRecipeCategories(@rname as varchar(255))
AS 
BEGIN
SET NOCOUNT ON;
SELECT R.recipe_name,RC.category_name 
FROM Recipes AS R
INNER JOIN Recipe_Category RC ON R.recipe_category_id = RC.recipe_category_id
where R.recipe_name like '%'+ @rname
END;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'CreateRecipeCategory' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE CreateRecipeCategory
GO
CREATE PROCEDURE CreateRecipeCategory @RecipeName VARCHAR(255), @CategoryName VARCHAR(255),
@RecipeDescription varchar(255) = NULL 
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    IF((@RecipeName IS NULL OR @CategoryName IS NULL) OR (@RecipeName = '' OR @CategoryName = ''))
    BEGIN
        RAISERROR('@RecipeName and @CategoryName cannot be null or empty',18,0)
    END
    ELSE
    BEGIN
        DECLARE @RecipeCount INT = (SELECT COUNT(1) FROM Recipes WHERE recipe_name = @RecipeName)
        DECLARE @RecipeId INT
        IF(@RecipeCount = 0)
        BEGIN
            INSERT INTO Recipes VALUES (@RecipeName)
            SET @RecipeId = (SELECT scope_identity())
        END
        ELSE
        BEGIN
           SET @RecipeId = (SELECT Recipes.recipe_id FROM Recipes WHERE Recipes.recipe_name = @RecipeName)
        END
        INSERT INTO Recipe_Category VALUES (@RecipeId, @CategoryName)
    END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState );
    END CATCH

END
GO
------------------------------------------------
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
CREATE PROCEDURE UpdateRecipe @OldRecipeName NVARCHAR(255), @NewRecipeName NVARCHAR(255) AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Recipes SET Recipes.recipe_name = @NewRecipeName WHERE Recipes.recipe_name = @OldRecipeName
END
GO
