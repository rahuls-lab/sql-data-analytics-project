/*
===============================================================================
Dimensions Exploration
===============================================================================

Purpose  : Explore the content of dimension tables to
--            understand the unique values available for
--            filtering and grouping in analytical queries.

===============================================================================

-- Tables Used:
--            gold.dim_customers
--            gold.dim_products

==============================================================================

Functions Used:
--            DISTINCT, ORDER BY

=============================================================================

 Unique Customer Countries:
-- Identifies all countries where customers are located.
-- Useful for geographic segmentation analysis.
==============================================================================

*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
