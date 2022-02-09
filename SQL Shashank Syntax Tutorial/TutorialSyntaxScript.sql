--- Simple SELECT statements
SELECT * FROM dataset_1;

SELECT destination, passanger FROM dataset_1;


--- LIMIT
SELECT * FROM dataset_1 LIMIT 10;


--- DISTINCT
SELECT DISTINCT passanger FROM dataset_1;


--- WHERE, AND, OR, ORDER BY
SELECT * FROM dataset_1 WHERE passanger = 'Alone';

SELECT * FROM dataset_1 WHERE passanger = 'Alone' 
AND weather = 'Sunny' OR time ='2PM';

SELECT * FROM dataset_1 WHERE passanger = 'Alone' 
AND weather = 'Sunny' OR time ='2PM'
ORDER BY time;


--- Aliasing
SELECT destination, passanger, time as 'The Time' 
FROM dataset_1 
WHERE passanger = 'Alone' AND weather = 'Sunny' OR time ='2PM'
ORDER BY time;


--- *AGGREGATIONS*: GROUP BY, AVG(), SUM(), COUNT(), COUNT(DISTINCT [])
SELECT destination, AVG(temperature), SUM(temperature), COUNT(temperature), COUNT(DISTINCT temperature) FROM dataset_1 d 
GROUP BY destination;

SELECT destination, time, AVG(temperature), SUM(temperature), COUNT(temperature), COUNT(DISTINCT temperature) FROM dataset_1 d 
GROUP BY destination, time;

SELECT destination, time, AVG(temperature), SUM(temperature), COUNT(temperature), COUNT(DISTINCT temperature) FROM dataset_1 d 
WHERE time <> '10PM'
GROUP BY destination, time;

SELECT destination, time, AVG(temperature), SUM(temperature), COUNT(temperature), COUNT(DISTINCT temperature) FROM dataset_1 d 
WHERE time <> '10PM'
GROUP BY destination, time
ORDER BY time;


--- HAVING
SELECT destination, time, AVG(temperature), SUM(temperature), COUNT(temperature), COUNT(DISTINCT temperature) FROM dataset_1 d 
WHERE time <> '10PM'
GROUP BY destination, time HAVING destination = 'No Urgent Place'
ORDER BY time;


--- UNION & Subquerying
SELECT * FROM dataset_1 d 
UNION 
SELECT * FROM table_to_union;

SELECT * FROM dataset_1 d 
UNION ALL
SELECT * FROM table_to_union;

SELECT DISTINCT destination FROM dataset_1 d;

SELECT DISTINCT destination FROM (
SELECT * FROM dataset_1 d 
UNION 
SELECT * FROM table_to_union);


--- JOIN
SELECT * FROM table_to_join ttj;

SELECT d.destination, d.time, ttj.part_of_day FROM dataset_1 d 
LEFT JOIN table_to_join ttj 
ON d.time = ttj.time;


-- Advanced Filtering
SELECT * FROM dataset_1 d 
WHERE weather LIKE 'Sun%';

SELECT * FROM dataset_1 d 
WHERE d.time LIKE '%P%';


--- BETWEEN
SELECT DISTINCT temperature FROM dataset_1 d
WHERE temperature BETWEEN 20 AND 75;


--- IN
SELECT occupation FROM dataset_1 d 
WHERE occupation IN ('Sales & Related', 'Management');

SELECT * FROM dataset_1 d 
WHERE time IN (SELECT time FROM dataset_1 d 
WHERE d.time LIKE '%P%');


--- *ADVANCED AGGREGATIONS*: Window Functions
--- OVER and PARTITION BY (similar to GROUP BY, but doesn't aggregate/combine, attaches aggregation result to each row)
SELECT destination, weather, 
AVG(temperature) OVER (PARTITION BY weather) as 'avg_temp_by_weather'
FROM dataset_1 d;


--- ROW_NUMBER(): gives a chronological number for every row based on order by statement
SELECT destination, weather, 
ROW_NUMBER() OVER (PARTITION BY weather ORDER BY destination)
FROM dataset_1 d;


--- RANK(): gives the first row number where the partition by & order by rows start; 
--- All rows w/ Home/Rainy has a rank of 1, then all rows w/ No Urgent/Rainy has a rank of 255, and so on
SELECT destination, weather, 
RANK() OVER (PARTITION BY weather ORDER BY destination)
FROM dataset_1 d;


--- DENSE_RANK(): instead of giving row number, each partition by & order by changes are incremented by 1 (1, 2, 3 ...)
SELECT destination, weather, 
DENSE_RANK() OVER (PARTITION BY weather ORDER BY destination)
FROM dataset_1 d;


--- LAG: to get previous record and start incrementing by 1; if no previous record (very first row), then put 99999
SELECT destination, time, LAG(row_count, 1, '99999') OVER (ORDER BY row_count) as 'LaggedCount'
FROM dataset_1 d;


--- LEAD: opposite of LAG; get next record and start with 2, very last row is 99999
SELECT destination, time, LEAD(row_count, 1, '99999') OVER (ORDER BY row_count) as 'LaggedCount'
FROM dataset_1 d;