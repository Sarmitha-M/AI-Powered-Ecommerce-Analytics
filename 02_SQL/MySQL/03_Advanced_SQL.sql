use e_commerce;

-- ==========================================================
-- 03_Advanced_SQL.sql
-- AI-Assisted E-commerce Sales & Customer Analytics
-- Advanced SQL Queries
-- ==========================================================


-- ==========================================================
-- Query 1: Rank Customers by Total Spending
-- Purpose:
-- Rank customers based on the total amount spent.
-- ==========================================================

WITH CustomerSpending AS
(
    SELECT
        c.customer_unique_id,
        ROUND(SUM(p.payment_value),2) AS total_spent

    FROM olist_customers_dataset c

    INNER JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id

    INNER JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id

    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    total_spent,
    RANK() OVER(ORDER BY total_spent DESC) AS spending_rank
FROM CustomerSpending;


-- ==========================================================
-- Query 2: Assign Row Number to Orders
-- Purpose:
-- Number each order based on purchase timestamp.
-- ==========================================================

SELECT

    order_id,
    customer_id,
    order_purchase_timestamp,

    ROW_NUMBER() OVER
    (
        ORDER BY order_purchase_timestamp
    ) AS row_number

FROM olist_orders_dataset;


-- ==========================================================
-- Query 3: Dense Rank Orders by Payment Value
-- Purpose:
-- Rank payment values without gaps.
-- ==========================================================

SELECT

    order_id,
    payment_value,

    DENSE_RANK() OVER
    (
        ORDER BY payment_value DESC
    ) AS payment_rank

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 4: Compare Current Payment with Previous Payment
-- Purpose:
-- Display previous payment value using LAG().
-- ==========================================================

SELECT

    order_id,

    payment_value,

    LAG(payment_value,1)
    OVER
    (
        ORDER BY payment_value
    ) AS previous_payment

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 5: Compare Current Payment with Next Payment
-- Purpose:
-- Display next payment value using LEAD().
-- ==========================================================

SELECT

    order_id,

    payment_value,

    LEAD(payment_value,1)
    OVER
    (
        ORDER BY payment_value
    ) AS next_payment

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 6: Running Total Revenue
-- Purpose:
-- Calculate cumulative revenue generated.
-- ==========================================================

SELECT

    order_id,

    payment_value,

    SUM(payment_value)
    OVER
    (
        ORDER BY order_id
    ) AS running_total

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 7: Overall Average Payment
-- Purpose:
-- Display each payment together with the overall average.
-- ==========================================================

SELECT

    order_id,

    payment_value,

    ROUND
    (
        AVG(payment_value)
        OVER(),
        2
    ) AS overall_average

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 8: Top 5 Highest Spending Customers
-- Purpose:
-- Retrieve the five customers with the highest spending.
-- ==========================================================

WITH CustomerRevenue AS
(
    SELECT

        c.customer_unique_id,

        SUM(p.payment_value) AS total_spent

    FROM olist_customers_dataset c

    INNER JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id

    INNER JOIN olist_order_payments_dataset p
        ON o.order_id = p.order_id

    GROUP BY c.customer_unique_id
)

SELECT *

FROM CustomerRevenue

ORDER BY total_spent DESC

LIMIT 5;


-- ==========================================================
-- Query 9: Revenue Contribution Percentage
-- Purpose:
-- Calculate each payment's percentage contribution
-- to total revenue.
-- ==========================================================

SELECT

    order_id,

    payment_value,

    ROUND
    (
        payment_value /
        SUM(payment_value) OVER() * 100,
        2
    ) AS revenue_percentage

FROM olist_order_payments_dataset;


-- ==========================================================
-- Query 10: Monthly Revenue Trend
-- Purpose:
-- Calculate monthly revenue using CTE.
-- ==========================================================

WITH MonthlyRevenue AS
(
    SELECT

        DATE_FORMAT(o.order_purchase_timestamp,'%Y-%m') AS order_month,

        SUM(p.payment_value) AS revenue

    FROM olist_orders_dataset o

    INNER JOIN olist_order_payments_dataset p

    ON o.order_id = p.order_id

    GROUP BY order_month
)

SELECT *

FROM MonthlyRevenue

ORDER BY order_month;