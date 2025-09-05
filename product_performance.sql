-- Product Performance: Analyze product and brand sales

-- Products from a specific brand (Trek)
SELECT product_name, brand_name
FROM products
INNER JOIN brands USING (brand_id)
WHERE brand_name = 'Trek';

-- Products from a specific category (Mountain Bikes)
SELECT product_name, category_name
FROM products
INNER JOIN categories USING (category_id)
WHERE category_name = 'Mountain Bikes';

-- Products with list price > $2,000
SELECT product_name, list_price
FROM products
WHERE list_price > 2000
ORDER BY list_price DESC;

-- Category revenue
SELECT c.category_name, ROUND(SUM(total_revenue.revenue), 2) AS revenue_totals
FROM 
    (SELECT p.category_id, p.product_name, oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0)) AS revenue
     FROM order_items AS oi
     INNER JOIN products AS p USING (product_id)) AS total_revenue
INNER JOIN categories AS c USING (category_id)
GROUP BY c.category_name
ORDER BY c.category_name;

-- Brand revenue
SELECT b.brand_name, ROUND(SUM(oi.quantity * oi.list_price * (1 - COALESCE(oi.discount, 0))), 2) AS revenue
FROM order_items AS oi
INNER JOIN products AS p USING (product_id)
INNER JOIN brands AS b USING (brand_id)
GROUP BY b.brand_name
ORDER BY revenue DESC;

-- Staff who sold a specific brand
SELECT s.first_name, s.last_name, b.brand_name, p.product_name, o.order_date
FROM order_items AS oi
INNER JOIN orders AS o USING (order_id)
INNER JOIN staffs AS s USING (staff_id)
INNER JOIN products AS p USING (product_id)
INNER JOIN brands AS b USING (brand_id)
ORDER BY o.order_date;