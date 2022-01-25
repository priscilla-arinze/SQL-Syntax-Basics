---Basic Inner Join Syntax
SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;


---Inner Joins with Aliases
SELECT c.code AS country_code, c.name, c.year, e.inflation_rate
FROM countries AS c
INNER JOIN economies as e
ON c.code = e.code;


---Inner Joins with 2 Tables & 2 ON conditions
SELECT c.code, name, region, e.year, p.fertility_rate, e.unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
on c.code = e.code
and e.year = p.year;


---Inner Join with Common Column Names ('using')
select c.name as country, c.continent, l.name as language, l.official
from countries as c
inner join languages as l
using(code)


---CASE WHEN, THEN (create a new column, aliased) & Inner Join
SELECT name, continent, code, surface_area,
CASE WHEN surface_area > 2000000 THEN 'large'
WHEN surface_area > 350000 THEN 'medium'
ELSE 'small' END
AS geosize_group
FROM countries;


---Self Joins (joining table with itself)
SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
FROM populations as p1
inner JOIN populations as p2
ON p1.country_code = p2.country_code and p1.year = p2.year - 5


--- Inner Join: Load CASE into new table
SELECT country_code, size,
CASE WHEN size > 50000000
THEN 'large'
WHEN size > 1000000
THEN 'medium'
ELSE 'small' END
AS popsize_group
INTO pop_plus       
FROM populations
WHERE year = 2015;

select name, c.continent, c.geosize_group, p.popsize_group
from countries_plus as c
inner join pop_plus as p
on c.code = p.country_code
order by geosize_group;
