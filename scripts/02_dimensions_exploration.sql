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

SELECT DISTINCT country
FROM   gold.dim_customers
ORDER BY country;


-- ============================================================
-- Unique Product Categories, Subcategories & Product Names
-- ------------------------------------------------------------
-- Shows the full product hierarchy in one view.
-- Helps understand how products are structured before
-- writing category-level or subcategory-level aggregations.
-- ============================================================

SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM  gold.dim_products
ORDER BY category, subcategory, product_name;
