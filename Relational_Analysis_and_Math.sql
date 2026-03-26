/* =========================================================
   Relational Analysis and Math
   ========================================================= */
   -- this does not include making databases, just analyzing--
use world;
   
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