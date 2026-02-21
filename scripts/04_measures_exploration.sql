/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================

Purpose  : Calculate core business metrics using aggregate
--            functions to get a high-level snapshot of sales
--            performance, customer activity, and product range.

==============================================================================

Tables Used:
--            gold.fact_sales
--            gold.dim_products
--            gold.dim_customers

==============================================================================

 Functions Used:
--            COUNT(), SUM(), AVG()
=============================================================================

*/


 ============================================================
-- Individual Key Metrics
-- ============================================================


- Total revenue generated from all sales
   
   SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;


-- Total number of items sold across all orders

SELECT SUM(quantity) AS total_quantity
FROM gold.fact_sales;



-- Average selling price per transaction

SELECT AVG(price) AS avg_price
FROM gold.fact_sales;


-- Total number of orders 

SELECT COUNT(order_number) AS total_orders
FROM gold.fact_sales;


-- Total number of unique orders placed

SELECT COUNT(DISTINCT order_number) AS total_unique_orders
FROM gold.fact_sales;


-- Total number of products in the catalogue

SELECT COUNT(DISTINCT product_name) AS total_products
FROM gold.dim_products;


-- Total number of registered customers

SELECT COUNT(customer_key) AS total_customers
FROM gold.dim_customers;


-- Total number of customers who have placed at least one order

SELECT COUNT(DISTINCT customer_key) AS total_active_customers
FROM gold.fact_sales;


-- ============================================================
-- Business Key Metrics Summary Report
-- ------------------------------------------------------------
-- Consolidates all key metrics into a single result set
-- using UNION ALL for a clean executive-level overview.
-- Useful for dashboards or quick business health checks.
-- ============================================================

SELECT 
'Total Sales'  AS measure_name, 
SUM(sales_amount) AS measure_value 
FROM gold.fact_sales
  
UNION ALL
  
SELECT 
'Total Quantity',                        
SUM(quantity)                                
FROM gold.fact_sales
  
UNION ALL
  
SELECT 
'Average Price',                        
ROUND(AVG(price::NUMERIC), 2)                
FROM gold.fact_sales
  
UNION ALL
  
SELECT 
'Total Orders',                          
COUNT(DISTINCT order_number)                 
FROM gold.fact_sales
  
UNION ALL
  
SELECT
'Total Products',                       
COUNT(DISTINCT product_name)                 
FROM gold.dim_products
  
UNION ALL
  
SELECT 
'Total Customers',                     
COUNT(customer_key)                          
FROM gold.dim_customers
  
UNION ALL
  
SELECT 
'Total Active Customers',         
COUNT(DISTINCT customer_key)               
FROM gold.fact_sales;
