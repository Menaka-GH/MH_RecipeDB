--To update the recipes

EXECUTE UpdateRecipe "Sakkarai Pongal","SakkaraiPongal";

---input for the stored procedure CreateIncredients

--To know the incredientid of the inserted row

DECLARE @IncredId INT
EXEC CreateIncredients 'Garammasala powder', @IncredId OUTPUT
SELECT @IncredId Incredients_Id

select *from Incredients;

--to list the users

select *from Users;

---To get the count of users commented for the recipe

SELECT dbo.NumberOfUsers(1); 

---TO GET THE NUMBER OF CATEGORIES

EXEC NumberOfCategories;

--To list the comments for the recipes

select *from Comments;

--To get the comments on recipes by date

select * from CommentsOnPDate('2020-12-20');

--To list the recipes

EXECUTE ReadRecipes;

--to delete the recipe

EXECUTE DeleteRecipe 'Bajji';

--To list the recipes and category

EXEC ListRecipeCategory;

--To list the recipe categories orderly
select *from Recipe_Category order by category_name;

--To list the recipes
select *from Recipes;

SELECT r.recipe_name,rc.category_name,i.incredient_name,ri.amount_required
FROM Recipe_Category rc
INNER JOIN Recipes r ON rc.recipe_category_id = r.recipe_category_id
INNER JOIN Recipe_Incredients ri ON r.recipe_id = ri.recipe_id
INNER JOIN Incredients i ON ri.incredient_id = i.incredient_id
ORDER BY r.recipe_name;