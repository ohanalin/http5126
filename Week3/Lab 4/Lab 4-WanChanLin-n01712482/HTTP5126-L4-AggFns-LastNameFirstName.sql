-- YOUR NAME HERE	LAB 4 AGGREGATE FUNCTIONS
-- Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
-- 1 
-- A
SELECT MIN(price) FROM stock_items;
-- B
SELECT MAX(inventory) FROM stock_items;
-- C
SELECT AVG(price) FROM stock_items;
-- D
SELECT AVG(inventory) FROM stock_items;

-- 2
-- A
SELECT COUNT(role), role FROM employees GROUP BY role;
-- B
SELECT COUNT(inventory), category AS Mammals FROM stock_items GROUP BY category HAVING NOT category = 'Piscine';
-- C(Question why do we need to use WHERE NOT instead of HAVING NOT)
SELECT AVG(price), category FROM stock_items WHERE NOT inventory = 0 GROUP BY category ;


-- 3
-- A
SELECT SUM(inventory), category FROM stock_items GROUP BY category ORDER BY inventory DESC;

-- B
SELECT SUM(inventory) , AVG(price) AS 'average price', category FROM stock_items GROUP BY category HAVING AVG(price)<100
AND  SUM(inventory) < 100;

-- 4
SELECT CONCAT("$", price *inventory)  AS 'Potential Earnings', item AS Product , price AS Price ,inventory AS'Stock Remaining' ,category AS Species FROM stock_items ORDER BY price *inventory DESC;