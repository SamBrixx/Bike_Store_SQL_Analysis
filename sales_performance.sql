-- Sales Performance: Evaluate store and staff sales performance

-- Total revenue by store
SELECT s.store_name, SUM(oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0))) AS revenue
FROM orders AS o
INNER JOIN order_items AS oi USING (order_id)
INNER JOIN stores AS s USING (store_id)
GROUP BY s.store_name
ORDER BY revenue DESC;

-- Store with highest revenue in June 2017
SELECT total_revenue.store_name, ROUND(SUM(total_revenue.revenue), 2) AS revenue 
FROM
    (SELECT s.store_name, EXTRACT(MONTH FROM o.order_date) AS month, oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0)) AS revenue
     FROM order_items AS oi
     INNER JOIN orders AS o USING (order_id)
     INNER JOIN stores AS s USING (store_id)
     WHERE EXTRACT(MONTH FROM o.order_date) = 6
     AND EXTRACT(YEAR FROM o.order_date) = 2017
    ) AS total_revenue
GROUP BY total_revenue.store_name
ORDER BY revenue DESC
LIMIT 1;

-- Staff order count
SELECT s.first_name, s.last_name, COUNT(o.order_id) AS no_of_orders
FROM orders AS o
INNER JOIN staffs AS s USING (staff_id)
GROUP BY s.first_name, s.last_name
ORDER BY no_of_orders DESC;

-- Staff with highest sales
SELECT s.first_name, s.last_name, ROUND(SUM(oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0))), 2) AS total_sales
FROM order_items AS oi
INNER JOIN orders AS o USING (order_id)
INNER JOIN staffs AS s USING (staff_id)
GROUP BY s.first_name, s.last_name
ORDER BY total_sales DESC;