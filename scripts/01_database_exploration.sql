/*
===============================================================================
Database Exploration
===============================================================================

-- Purpose  : Explore the structure of the DataWarehouse
--            database — list available tables, inspect column
--            metadata, and understand schema layout before
--            writing analytical queries
===============================================================================


-- Tables Used:
--            information_schema.tables
--            information_schema.columns
-- =======================================================================

*/

-- Retrieve a list of all tables in the database

SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve all columns for a specific table (dim_customers)

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

