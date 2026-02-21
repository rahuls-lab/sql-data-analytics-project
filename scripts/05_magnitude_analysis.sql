/*
===============================================================================
Magnitude Analysis
===============================================================================

-- Purpose  : Quantify and group business data by key dimensions
--            to understand distribution patterns across
--            categories, customers, geography, and gender.

===============================================================================

Tables Used:
--            gold.fact_sales
--            gold.dim_customers
--            gold.dim_products

===============================================================================
-- Customer Distribution by Country
-- Shows how the customer base is spread across countries.
-- Helps identify dominant markets and underserved regions.
-- ============================================================

*/



-- Find total customers by countries
SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM  gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- ============================================================
-- Customer Distribution by Gender
-- ------------------------------------------------------------
-- Breaks down the customer base by gender.
-- Useful for targeted marketing and demographic analysis.
-- ============================================================

SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM  gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;


-- ============================================================
-- Product Count by Category
-- ------------------------------------------------------------
-- Shows the number of products available in each category.
-- Useful for understanding catalogue depth per category.
-- ============================================================

SELECT
    category,
    COUNT(product_key) AS total_products
FROM  gold.dim_products
GROUP BY category
ORDER BY total_products DESC;


-- ============================================================
-- Average Product Cost by Category
-- ------------------------------------------------------------
-- Calculates the average cost per product category.
-- Helps identify premium vs budget product segments.
-- ============================================================

SELECT
    category,
    ROUND(AVG(cost::NUMERIC), 2) AS avg_cost
FROM  gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;


-- ============================================================
-- Total Revenue by Product Category
-- ------------------------------------------------------------
-- Joins sales facts with product dimension to calculate
-- total revenue contribution from each product category.
-- LEFT JOIN ensures all sales are included even if a product
-- record is missing from the dimension table.
-- ============================================================

SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM    gold.fact_sales AS f
LEFT JOIN  gold.dim_products  AS p  
ON p.product_key = f.product_key
GROUP BY   p.category
ORDER BY   total_revenue DESC;


-- ============================================================
-- Total Revenue by Customer
-- ------------------------------------------------------------
-- Identifies the highest-value customers by total spend.
-- Useful for loyalty programs and customer tiering.
-- ============================================================

SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM       gold.fact_sales   AS  f
LEFT JOIN  gold.dim_customers  AS c  
ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;


-- ============================================================
-- Total Items Sold by Country
-- ------------------------------------------------------------
-- Shows the volume of products sold per country.
-- Reveals geographic demand patterns beyond just revenue.
-- ============================================================

SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM       gold.fact_sales   AS  f
LEFT JOIN  gold.dim_customers  AS c  
ON c.customer_key = f.customer_key
GROUP BY   c.country
ORDER BY   total_sold_items DESC;


