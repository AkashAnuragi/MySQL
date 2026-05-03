--  ___________________________PROJECT 3: E-Commerce System____________________________

-- Scenario: Build a scalable retail system with categories, orders, and payments.
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

 
CREATE DATABASE ecommerce_db; 
USE ecommerce_db; 

-- ___________________________Schema___________________________________________

CREATE TABLE users ( 
user_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100), 
email VARCHAR(100) UNIQUE 
); 
CREATE TABLE categories ( 
category_id INT PRIMARY KEY AUTO_INCREMENT, 
category_name VARCHAR(100) 
); 
CREATE TABLE products ( 
product_id INT PRIMARY KEY AUTO_INCREMENT, 
name VARCHAR(100), 
category_id INT, 
price DECIMAL(10,2), 
stock INT, 
FOREIGN KEY (category_id) REFERENCES categories(category_id) 
); 
CREATE TABLE orders ( 
order_id INT PRIMARY KEY AUTO_INCREMENT, 
user_id INT, 
order_date DATE, 
status VARCHAR(20), 
FOREIGN KEY (user_id) REFERENCES users(user_id) 
); 
CREATE TABLE order_items ( 
order_item_id INT PRIMARY KEY AUTO_INCREMENT, 
order_id INT, 
product_id INT, 
quantity INT, 
FOREIGN KEY (order_id) REFERENCES orders(order_id), 
FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 
CREATE TABLE payments ( 
payment_id INT PRIMARY KEY AUTO_INCREMENT, 
order_id INT, 
amount DECIMAL(10,2), 
payment_status VARCHAR(20), 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
); 

-- _________________________________________ Sample Data_____________________________________
INSERT INTO users (name, email) VALUES
    ('Akash Anuragi',  'akash@shop.com'),
    ('Priyanka Verma',   'priyanka@shop.com'),
    ('Rahul Ojha',   'rahul@shop.com'),
    ('Ayushi Garg',    'ayushi@shop.com'),
    ('Sagar Singh', 'Sagar@shop.com');
    -- user_id 5 (Sagar) places NO orders → used in Q7
 
INSERT INTO categories (category_name) VALUES
    ('Electronics'), ('Clothing'), ('Books'), ('Home & Kitchen');
 
INSERT INTO products (name, category_id, price, stock) VALUES
    ('Smartphone X',        1, 15000.00,  8),
    ('Wireless Earbuds',    1,  2500.00,  5),
    ('Cotton Kurta',        2,   799.00, 25),
    ('Denim Jeans',         2,  1299.00, 12),
    ('Clean Code (Book)',   3,   499.00,  3),  -- stock < 10
    ('Pressure Cooker',     4,  1800.00, 15),
    ('Bluetooth Speaker',   1,  3500.00,  9);
 
INSERT INTO orders (user_id, order_date, status) VALUES
    (1, '2025-06-01', 'Delivered'),
    (2, '2025-06-03', 'Delivered'),
    (3, '2025-06-05', 'Shipped'),
    (1, '2025-06-10', 'Delivered'),
    (4, '2025-06-12', 'Pending');
 
INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 1),   -- Akash: Smartphone
    (1, 2, 2),   -- Akash: Earbuds x2
    (2, 3, 3),   -- Priyanka: Kurta x3
    (2, 1, 1),   -- Priyanka: Smartphone
    (3, 5, 1),   -- Rahul: Book
    (3, 7, 1),   -- Rahul: Speaker
    (4, 6, 2),   -- Akash: Cooker x2
    (5, 4, 1);   -- Ayushi: Jeans
 
INSERT INTO payments (order_id, amount, payment_status) VALUES
    (1, 20000.00, 'Paid'),
    (2, 17397.00, 'Paid'),
    (3,  3999.00, 'Paid'),
    (4,  3600.00, 'Paid'),
    (5,  1299.00, 'Pending');

-- Basic 1. List all products  
SELECT * FROM products;

-- OR with category Name

SELECT p.*, c.category_name FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER by product_id;

-- 2. Show products with stock < 10  
SELECT * FROM products 
WHERE stock < 10;

-- Intermediate: 3. Show order details with product names  
SELECT  o.order_id, u.name AS customer_name, p.name AS product_name,oi.quantity,o.status
FROM orders o
JOIN users       u  ON o.user_id     = u.user_id
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id;

-- 4. Calculate total order value 
SELECT o.order_id, u.name AS customer_name, SUM(oi.quantity*p.price) AS total_order_value, o.status 
FROM orders o 
JOIN users u ON u.user_id = o.user_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id,u.name,o.status; 

-- Advanced 5. Find best-selling product  
SELECT p.name AS product_name, SUM(oi.quantity) AS total_sold, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 1;
-- 6. Find category-wise revenue  
SELECT c.category_name, SUM(oi.quantity * p.price) AS category_revenue, SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products    p  ON oi.product_id   = p.product_id
JOIN categories  c  ON p.category_id   = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY category_revenue DESC;

-- 7. Identify inactive users 
SELECT u.*
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;



SHOW TABLES;


SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;

