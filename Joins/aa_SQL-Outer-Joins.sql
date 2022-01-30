--- Inner Join review
SELECT c1.name AS city, c2.code, c2.name AS country,
c2.region, c1.city_proper_pop
FROM cities AS c1
INNER JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code desc;

--- Left Join of above
SELECT c1.name AS city, c2.code, c2.name AS country,
c2.region, c1.city_proper_pop
FROM cities AS c1
left JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code DESC;

--- Left Join with group by
select c.region, avg(e.gdp_percapita) as avg_gdp
from countries as c
left join economies as e
on c.code = e.code
where year = 2010
group by region;

--- Arrange this data on average GDP per capita for each region in 2010 
--- from highest to lowest average GDP per capita.
select c.region, avg(e.gdp_percapita) as avg_gdp
from countries as c
left join economies as e
on c.code = e.code
where year = 2010
group by region
order by avg_gdp desc;

--- Left Join to Right Join conversion
-- convert this code to use RIGHT JOINs instead of LEFT JOINs
/*
SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM cities
  LEFT JOIN countries
    ON cities.country_code = countries.code
  LEFT JOIN languages
    ON countries.code = languages.code
ORDER BY city, language;
*/

select cities.name as city, urbanarea_pop, countries.name as country, indep_year, languages.name as language, percent
from languages
right join countries
on languages.code = countries.code
right join cities
on countries.code = cities.country_code
order by city, language


--- Full Join: Choose records in which region corresponds to North America or is NULL.
SELECT name AS country, code, region, basic_unit
FROM countries
FULL JOIN currencies
USING (code)
WHERE region = 'North America' OR region IS null
ORDER BY region;

-- Full Join (cont)
select c1.name as country, c1.region, l.name as language, c2.basic_unit, c2.frac_unit
from countries as c1
full join languages as l
using(code)
full join currencies as c2
using(code)
where c1.region like 'M%esia'


--- Cross Join
select c.name as city, l.name as language
from cities as c
cross join languages as l
where c.name like 'Hyder%';

