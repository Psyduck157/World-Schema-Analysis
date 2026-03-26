/* =========================================================
   SQL MASTER DOCUMENT: THE WORLD SCHEMA STUDY GUIDE
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

#11. PATTERN MATCHING (LIKE)
#WHY: To find data when you only know part of the word (ex., search bars).
#HOW: '%' is a wildcard that stands for "anything"
select name from city
where name like 'san%';

#12. PATTERN MATCHING (UNDERSCORE)
#WHY: When you know the exact length of a word but are missing specific letters.
#HOW: Each '_' represents exactly one character.
select name 
from country 
where name like 'A_b%';

#13 REGULAR EXPRESSIONS (REGEXP)
#WHY: For complex text patterns that 'LIKE' cannot handle.
#HOW: '^' means "starts with", '$' means "ends with", and '|' means "OR".
select name 
from country 
where name regexp '^Un|ia$';

#13a REGULAR EXPRESSIONS (REGEXP) - Complex Text Filtering
#WHY: When you are looking for a specific range of characters (like any name starting with A, B, or C) without writing multiple OR statements.
#HOW: [ABC] looks for any one of those specific letters. .* stands for "any characters in between."
select name
from city
where name regexp '^[ABC].*s$';

#14. STRING COMBINATION (CONCAT)
#WHY: To combine data from different columns into a readable sentence.
#HOW: Separate columns and text (in quotes) with commas.
select concat(name, ' is in ', continent) as 'summary'
from country;

#15. BASIC CONDITIONAL (IF)
#HOW: IF(test, result_if_true, result_if_false).
select name, population,
if(population > 50000000, 'Large', 'Small') as 'Size'
from country;

#16. MULTI-CONDITION LOGIC (CASE)
#WHY: Like an "IF" statement, but allows for 3 or more categories.
#HOW: Uses WHEN, THEN, and ELSE logic. Always end with 'END'.
select name, 
case
	when gnp > 1000000 then 'High'
    when gnp between 100000 and 1000000 then 'medium'
    else 'low'
end as 'Economic_Status'
from country;

#17. CONNECTING TABLES (INNER JOIN)
#WHY: Relational databases split data into tables; Joins "glue" them back together
#HOW: Match the Primary Key of one table to the Foreign Key of another
select city.name as 'city',
 country.name as 'country'
from city
inner join country on city.countrycode = country.code;

#18. AGGREGATING DATA (SUM, AVG, COUNT)
#WHY: To perform math across many rows to get a single "big picture" number.
select sum(population), avg(lifeexpectancy), count(*)
from country;

#18a. AGGREGATING DATA (MIN & MAX)
#WHY: While AVG gives you the middle, MIN and MAX give you the extreme boundaries of your data.
#HOW: Wraps around the column to find the absolute highest or lowest value in the table.
select min(indepyear) as 'oldest indep', max(indepyear) as 'newest indep'
from country;

#19. GROUPING DATA (GROUP BY)
#WHY: To calculate totals for specific categories (ex. , total population per continent).
#HOW: Every column in SELECT that isn't an "aggregator" must be in the GROUP BY.
select continent, sum(population)
from country
group by continent;

#20. FILTERING GROUPS (HAVING)
#WHY: You cannot use 'WHERE' to filter grouped data like sums or averages.
#HOW: 'HAVING' works exactly like WHERE, but it runs after the grouping is done.
select continent, sum(gnp) as 'totalGNP'
from country
group by continent 
having totalGNP > 1000000;

#21. TOTALS & SUBTOTALS (ROLLUP)
#WHY: Adds a "Grand Total" or "Subtotal" row to the bottom of your results.
#HOW: Add 'WITH ROLLUP' at the very end of your GROUP BY line.
select continent, sum(population)
from country
group by continent with rollup;

#22. LISTING ITEMS IN A GROUP (GROUP_CONCAT)
#WHY: To see every individual item inside a group without creating hundreds of rows.
#HOW: Useful for making lists of countries within continents.
select continent, group_concat(name)
from country
group by continent;

#23 SUBQUERIES
#WHY: When you need to filter data based on a value you don't know yet (like the average).
#HOW: Place the inner query inside parentheses. It runs first.
select name, population
from city
where population > (select avg(population) from city);

-- you did it!