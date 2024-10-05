--  LAB 5 MULTIPLE TABLES
--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--  1 
-- A 
SELECT * FROM sales WHERE item=	'1014';

-- B 
FROM stock_items INNER JOIN sales ON stock_items.id=sales.item WHERE sales.item='1014';


--  2
-- A 
SELECT * FROM sales WHERE employee='111';
-- B
SELECT sales.date, employees.first_name, employees.last_name, sales.item FROM sales INNER JOIN employees
ON employees.id=sales.employee WHERE sales.employee='111';

--  3
-- A
SELECT sales.date,sales.item, employees.first_name FROM sales INNER JOIN employees
ON employees.id=sales.employee WHERE sales.date BETWEEN '2024-09-12' AND '2024-09-18';
-- B
SELECT employees.first_name, employees.last_name, COUNT(sales.item) FROM sales INNER JOIN employees
ON employees.id=sales.employee GROUP BY sales.employee ORDER BY COUNT(sales.item) DESC;

--  4
-- A
SELECT 
    sales.date, 
    stock_items.item, 
    stock_items.price, 
    stock_items.category,
    employees.first_name,
COUNT(sales.item) 
FROM 
    sales 
JOIN 
    employees 
ON 
    employees.id=sales.employee 
JOIN 
    stock_items 
ON 
    stock_items.id=sales.item 
GROUP BY sales.employee 
ORDER BY COUNT(sales.item) DESC;

-- B
SELECT 
    stock_items.id ,
    stock_items.item ,
    stock_items.price,
    stock_items.category,
    COUNT(sales.item) AS 'Times Sold'
FROM 
    stock_items
LEFT JOIN 
    sales ON stock_items.id = sales.item
GROUP BY 
    stock_items.item
ORDER BY 
    stock_items.id;

--  5
-- A <your question here>
Can you help me rank stock items by revenue, displaying the ID, item, and price, 
with the highest revenue listed first? I would like the revenue to be displayed with a $ symbol 
before the amount. The ranking should go from highest to lowest revenue.
-- B
SELECT 
    stock_items.id ,
    stock_items.item ,
    stock_items.category,
    stock_items.price,
COUNT(sales.item) AS 'Times Sold',
CONCAT("$",COUNT(sales.item)*stock_items.price) AS'Revenue'
FROM 
    stock_items
LEFT JOIN 
    sales ON stock_items.id = sales.item
GROUP BY 
    stock_items.item
ORDER BY 
    COUNT(sales.item)*stock_items.price DESC;