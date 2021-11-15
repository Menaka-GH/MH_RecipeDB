--To update the recipes
EXECUTE UpdateRecipe "Urad Dal Vada","Urad dal Fritters";
---input for the stored procedure CreateIncredients
--To know the incredientid of the inserted row
DECLARE @IncredId INT


EXEC CreateIncredients 'salt', @IncredId OUTPUT

SELECT @IncredId Incredients_Id

---To get the count of users for the recipe
SELECT dbo.NumberOfUsers(1); 
---TO GET THE NUMBER OF CATEGORIES
EXEC NumberOfCategories;

--To get the comments on recipes by date
select * from CommentsOnPDate('11/10/2020');
--To list the recipes
EXECUTE ReadRecipes;
--To list the recipes and category
EXEC ListRecipeCategory