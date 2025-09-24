-- Step 1: Create Database
DROP DATABASE IF EXISTS retail_sales;
CREATE DATABASE retail_sales;
USE retail_sales;

-- Step 2: Create Tables

-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Sales table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 3: Insert Data

-- Customers
INSERT INTO customers (customer_name, region) VALUES
('Amit Kumar', 'North'),
('Priya Singh', 'South'),
('Rahul Sharma', 'East'),
('Neha Verma', 'West');

-- Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 55000),
('Smartphone', 'Electronics', 20000),
('Shoes', 'Fashion', 2500),
('Washing Machine', 'Home Appliances', 30000);

-- Sales
INSERT INTO sales (customer_id, product_id, sale_date, quantity) VALUES
(1, 1, '2025-09-01', 2),
(2, 2, '2025-09-05', 3),
(3, 3, '2025-09-07', 5),
(4, 4, '2025-09-09', 1),
(1, 2, '2025-09-10', 1);
-- Total Revenue

SELECT SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- Customer Segmentation (by total spend)

SELECT c.customer_name,
       SUM(s.quantity * p.price) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- Monthly Sales Growth

SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
       SUM(s.quantity * p.price) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Ranking Products by Revenue (Window Function)

SELECT p.product_name,
       SUM(s.quantity * p.price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(s.quantity * p.price) DESC) AS rank_by_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id;





