/*
===============================================================================
Ranking Analysis
===============================================================================

- Purpose  : Rank products and customers based on revenue
--            and order performance to identify top performers
--            and laggards across the business.
================================================================================

-- Tables Used:
--            gold.fact_sales
--            gold.dim_products
--            gold.dim_customers

=================================================================================

Functions Used:
--            RANK(), DENSE_RANK(), ROW_NUMBER()
--            GROUP BY, ORDER BY, LIMIT

================================================================================

*/

- Top 5 Products by Revenue  |  Simple Ranking
-- ------------------------------------------------------------
-- A straightforward approach using LIMIT to retrieve the
-- top 5 revenue-generating products.
-- Best used when you need a quick, fixed-size result.
-- ============================================================

SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM       gold.fact_sales    f
LEFT JOIN  gold.dim_products  p  ON p.product_key = f.product_key
GROUP BY   p.product_name
ORDER BY   total_revenue DESC
LIMIT 5;


-- ============================================================
-- Top 5 Products by Revenue  |  Window Function Ranking
-- ------------------------------------------------------------
-- A more flexible approach using RANK() as a window function.
-- Allows filtering by rank threshold and handles ties
-- gracefully — tied products share the same rank position.
-- Preferred when ranking logic needs to be reused or extended.
-- ============================================================

SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount)                                  AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC)     AS rank_products
    FROM       gold.fact_sales    f
    LEFT JOIN  gold.dim_products  p  ON p.product_key = f.product_key
    GROUP BY   p.product_name
) AS ranked_products
WHERE rank_products <= 5;


-- ============================================================
-- Bottom 5 Products by Revenue  |  Worst Performers
-- ------------------------------------------------------------
-- Identifies the lowest revenue-generating products.
-- Useful for discontinuation decisions or promotional focus.
-- ============================================================

SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM       gold.fact_sales    f
LEFT JOIN  gold.dim_products  p  ON p.product_key = f.product_key
GROUP BY   p.product_name
ORDER BY   total_revenue ASC
LIMIT 5;


-- ============================================================
-- Top 10 Customers by Revenue  |  Highest Value Customers
-- ------------------------------------------------------------
-- Ranks customers by their total spend.
-- Key input for VIP segmentation and loyalty programmes.
-- ============================================================

SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM       gold.fact_sales     f
LEFT JOIN  gold.dim_customers  c  ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- Bottom 3 Customers by Order Frequency  |  Least Engaged
-- ------------------------------------------------------------
-- Finds customers who have placed the fewest unique orders.
-- Useful for re-engagement campaigns targeting low-activity
-- customers before they churn completely.
-- ============================================================

SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM       gold.fact_sales     f
LEFT JOIN  gold.dim_customers  c  ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC
LIMIT 3;
