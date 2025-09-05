-- Customer Insights: Analyze customer demographics and order behavior

-- Customers from NY state
SELECT first_name, last_name, email, state
FROM customers
WHERE state = 'NY';

-- Customers with phone numbers
SELECT *
FROM customers
WHERE phone IS NOT NULL;

-- Customer names and order dates
SELECT c.first_name, c.last_name, o.order_date
FROM orders AS o
INNER JOIN customers AS c
USING (customer_id);

-- Customers who placed orders in a specific year
SELECT c.first_name, c.last_name, EXTRACT(YEAR FROM o.order_date) AS year
FROM orders AS o
INNER JOIN customers AS c
USING (customer_id);