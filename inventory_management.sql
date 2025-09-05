-- Inventory Management: Monitor stock levels and value

-- Total quantity of a product across all stores
SELECT total_stock.product_name, st.store_name, SUM(total_stock.quantity) AS grand_total
FROM 
    (SELECT s.store_id, p.product_name, s.quantity
     FROM stocks AS s
     INNER JOIN products AS p USING (product_id)) AS total_stock
INNER JOIN stores AS st USING (store_id)
GROUP BY total_stock.product_name, st.store_name;

-- Total value of each product in stock at each store
SELECT s.store_name, p.product_name, p.list_price, st.quantity, p.list_price * st.quantity AS total_value
FROM stocks AS st
INNER JOIN products AS p USING (product_id)
INNER JOIN stores AS s USING (store_id);

-- Total value of all products in stock at each store
SELECT s.store_name, SUM(p.list_price * COALESCE(st.quantity, 0)) AS total_value
FROM stocks AS st
INNER JOIN products AS p USING (product_id)
INNER JOIN stores AS s USING (store_id)
GROUP BY s.store_name;

-- Products with low stock (< 10)
SELECT s.store_name, p.product_name, st.quantity
FROM stocks AS st
INNER JOIN products AS p USING (product_id)
INNER JOIN stores AS s USING (store_id)
WHERE st.quantity < 10
ORDER BY s.store_name;