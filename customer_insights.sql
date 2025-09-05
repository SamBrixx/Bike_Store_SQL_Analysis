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

-- Top customer and the number of orders placed
SELECT c.first_name, c.last_name, ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),2) AS order_total
FROM order_items AS oi
INNER JOIN orders AS o
USING (order_id)
INNER JOIN customers AS c
USING (customer_id)
GROUP BY c.first_name, c.last_name
ORDER BY order_total DESC;

-- Using RANK function to rank the customer based on the order total
WITH customer_revenue AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0))) AS order_total
    FROM order_items AS oi
    INNER JOIN orders AS o USING (order_id)
    INNER JOIN customers AS c USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    first_name, 
    last_name, 
    ROUND(order_total, 2) AS order_total,
    RANK() OVER (ORDER BY order_total DESC) AS revenue_rank
FROM customer_revenue
ORDER BY order_total DESC;