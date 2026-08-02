use e_commerce;
-- ==========================================================
-- 01_Basic_SQL.sql
-- AI-Assisted E-commerce Sales & Customer Analytics
-- Basic SQL Queries
-- ==========================================================


-- ==========================================================
-- Query 1: Display All Customers
-- Purpose:
-- Retrieve all customer records.
-- ==========================================================

SELECT *
FROM olist_customers_dataset;


-- ==========================================================
-- Query 2: Display Unique Customer States
-- Purpose:
-- Retrieve all unique customer states.
-- ==========================================================

SELECT DISTINCT customer_state
FROM olist_customers_dataset
ORDER BY customer_state;


-- ==========================================================
-- Query 3: Display Delivered Orders
-- Purpose:
-- Retrieve all orders that have been successfully delivered.
-- ==========================================================

SELECT *
FROM olist_orders_dataset
WHERE order_status = 'delivered';


-- ==========================================================
-- Query 4: Display Top 10 Most Expensive Products Sold
-- Purpose:
-- Retrieve the order items with the highest product prices.
-- ==========================================================

SELECT *
FROM olist_order_items_dataset
ORDER BY price DESC
LIMIT 10;


-- ==========================================================
-- Query 5: Count Total Customers
-- Purpose:
-- Calculate the total number of customers.
-- ==========================================================

SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;


-- ==========================================================
-- Query 6: Calculate Total Revenue
-- Purpose:
-- Calculate the total payment received from all orders.
-- ==========================================================

SELECT
    ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 7: Calculate Average Payment Value
-- Purpose:
-- Calculate the average payment amount per transaction.
-- ==========================================================

SELECT
    ROUND(AVG(payment_value),2) AS average_payment
FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 8: Find Minimum and Maximum Product Price
-- Purpose:
-- Display the lowest and highest product prices.
-- ==========================================================

SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM olist_order_items_dataset;


-- ==========================================================
-- Query 9: Count Orders by Status
-- Purpose:
-- Display the number of orders for each order status.
-- ==========================================================

SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;


-- ==========================================================
-- Query 10: Display Top 10 Highest Payment Transactions
-- Purpose:
-- Retrieve the highest payment transactions.
-- ==========================================================

SELECT
    order_id,
    payment_type,
    payment_value
FROM olist_order_payments_dataset
ORDER BY payment_value DESC
LIMIT 10;