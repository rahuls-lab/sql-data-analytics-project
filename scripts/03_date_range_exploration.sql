/*
===============================================================================
Date Range Exploration 
===============================================================================

Purpose  : Determine the temporal boundaries of key data
--            points to understand the historical range of
--            sales activity and customer demographics.

===============================================================================

Tables Used:
--            gold.fact_sales
--            gold.dim_customers

==============================================================================

Functions Used:
--            MIN(), MAX(), AGE(), EXTRACT(), CURRENT_DATE
-- ==========================================================================

Sales Date Range
-- ------------------------------------------------------------
-- Finds the first and last order date in the sales data,
-- and calculates the total duration in month

=============================================================================

*/


SELECT
    MIN(order_date)  AS first_order_date,
    MAX(order_date)  AS last_order_date,
    (EXTRACT(YEAR  FROM AGE(MAX(order_date), MIN(order_date))) * 12
   + EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))))::INT AS order_range_months
FROM gold.fact_sales;


-- ============================================================
-- Customer Age Range

-- Identifies the oldest and youngest customers based on
-- birthdate, and calculates their current age in years.
-- ============================================================

SELECT
    MIN(birthdate)  AS oldest_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MIN(birthdate)))::INT AS oldest_age,
    MAX(birthdate)  AS youngest_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MAX(birthdate)))::INT AS youngest_age
FROM gold.dim_customers;
