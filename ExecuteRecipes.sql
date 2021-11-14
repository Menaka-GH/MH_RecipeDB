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