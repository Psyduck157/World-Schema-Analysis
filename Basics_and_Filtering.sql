/* =========================================================
   Basics And Filtering
   ========================================================= */
   -- this does not include making databases, just analyzing--
   
#1. DATABASE SELECTION & INSPECTION
#Why: You must tell MySQL which "folder" to open before running commands
#How: 'USE' sets the active schema. 'DESCRIBE' shows column names and data types
use world;
describe country; 
describe city; 
   
#2. BASIC DATA EXTRACTION
#Why: The foundation of all SQL. It pulls raw data from a table
#How: SELECT identifies the "what" (columns), FROM identifies the "where" (table)
select Name, Continent, Population 
from country; 

#3 RENAMING COLUMNS
#Why: Makes report headers readable for people who don't know the database
#How: Use 'AS' followed by a name in single quotes if it contains spaces
Select name as 'country name', LifeExpectancy as 'life'
from country; 

#4. BASIC SORTING
#Why: Data is stored randomly; you usually need it ranked (e.g., biggest to smallest)
#How: 'ORDER BY' followed by 'DESC' for descending or 'ASC' for ascending
select name, gnp 
from country
order by gnp desc;

#5. LIMITING RESULTS
#HOW: 'LIMIT' must always be the very last line of your query.
select name, gnp 
from country
order by gnp desc
limit 10; 

#6. RELATIONAL OPERATORS
#How: Use symbols like > (greater), < (less), or <> (not equal to).
select name, SurfaceArea
from country 
where SurfaceArea > 5000000;

#7. LOGICAL OPERATORS
#Why: To narrow down results using multiple "filters" at once
#How: 'AND' requires both to be true; 'OR' requires at least one to be true
select name, continent, population 
from country
where continent = 'Asia' and population > 100000000; 

#8. THE 'BETWEEN' OPERATOR
select name, indepyear
from country 
where indepyear between 1900 and 1950;

#9. THE 'IN' OPERATOR
#Why: To check if a value exists within a specific list of strings or numbers.
#How: Put the list inside parentheses, separated by commas.
SELECT Name, Continent 
FROM country 
WHERE Continent in ('North America', 'South America', 'Oceania');

#10. NULL HANDLING
select name, LifeExpectancy 
from country 
where LifeExpectancy is null;