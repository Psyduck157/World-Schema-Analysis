/* =========================================================
   Advanced Logic and Strings
   ========================================================= */
   use world;
   
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