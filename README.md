Recipe Database

Introduction
	
	This repository is an example project for the Code Louisville Fall 2021 SQL course. The purpose of this code is to demonstrate the use of SQL and Git.

Project Description

	This is a recipe database for the tracking the recipe names, categories, steps to prepare the recipes and so on.  
Stored procedures are included to insert, update, and delete the recipes which are in the database.  

Features

1. Maintain lists of recipes, recipe description and categories.
2. Add new recipes to the recipe collection
3. Updating the recipes which are in the database.
4. Tracking the users with their name and email.

User Instructions
					
List all recipes - EXEC ListRecipes	
	
List all recipes by category - EXEC ListRecipeCategory		

List recipes by ingredient	

Add recipes to the collection	

Remove recipe from collection		

Delete recipe from collection	


Technical Instructions

•	Requires MS SQL Server.

•	Execute the MHRecipes-CreateDBObjects.sql script to create the database objects.

•	Execute the MHRecipes-LoadSampleData.sqlscript to load the sample data.

•	The ExecuteRecipes.sql file has example commands showing how to use the stored procedures.

Project Requirements

Group 1: Reading Data from a Database

•	Write a SELECT query that uses a WHERE clause.
•	Write a SELECT query that uses an OR and an AND operator.
•	Write a SELECT query that filters NULL rows using IS NOT NULL.
•	Write a SELECT query that utilizes a JOIN.
•	Write a SELECT query that utilizes a JOIN with 3 or more tables.
•	Write a SELECT query that utilizes a LEFT JOIN.
•	Write a SELECT query that utilizes a variable in the WHERE clause.

Group 2: Updating/Deleting Data from a Database

•	Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.
•	Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable.

Group 3: Optimizing a Database

•	Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries.

