-- =============================================================
-- Create Database and Schemas
-- =============================================================
-- Script Purpose:
--   This script creates a new database named 'datawarehouseanalytics'
--   and a schema called 'gold' with dimension and fact tables.
--   Data is loaded from CSV files using PostgreSQL's COPY command.
--
-- WARNING:
--   Running this script will DROP the entire 'datawarehouseanalytics'
--   database if it exists. All data will be permanently deleted.
--   Ensure you have proper backups before running this script.
--
-- Tool: pgAdmin 4 (Docker)
-- Author: Data Analyst
-- =============================================================


-- =============================================================
-- STEP 1: Drop & Recreate Database
-- -------------------------------------------------------------
-- NOTE: In PostgreSQL, you cannot drop a database you are
-- currently connected to. Run this block from the default
-- 'postgres' database in pgAdmin.
-- =============================================================

-- First, terminate all active connections to the target database
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'datawarehouseanalytics'
  AND pid <> pg_backend_pid();

-- Drop the database if it already exists
DROP DATABASE IF EXISTS datawarehouseanalytics;

-- Create a fresh database
CREATE DATABASE datawarehouseanalytics;


-- =============================================================
-- STEP 2: Connect to the New Database
-- -------------------------------------------------------------
-- In pgAdmin: right-click 'datawarehouseanalytics' → Query Tool
-- Then run everything below from STEP 2 onwards.
-- =============================================================


-- =============================================================
-- STEP 3: Create Schema
-- =============================================================

CREATE SCHEMA IF NOT EXISTS gold;


-- =============================================================
-- STEP 4: Create Tables
-- =============================================================

-- Customers Dimension Table
CREATE TABLE gold.dim_customers (
    customer_key      INT,
    customer_id       INT,
    customer_number   VARCHAR(50),
    first_name        VARCHAR(50),
    last_name         VARCHAR(50),
    country           VARCHAR(50),
    marital_status    VARCHAR(50),
    gender            VARCHAR(50),
    birthdate         DATE,
    create_date       DATE
);

-- Products Dimension Table
CREATE TABLE gold.dim_products (
    product_key       INT,
    product_id        INT,
    product_number    VARCHAR(50),
    product_name      VARCHAR(50),
    category_id       VARCHAR(50),
    category          VARCHAR(50),
    subcategory       VARCHAR(50),
    maintenance       VARCHAR(50),
    cost              INT,
    product_line      VARCHAR(50),
    start_date        DATE
);

-- Sales Fact Table
CREATE TABLE gold.fact_sales (
    order_number      VARCHAR(50),
    product_key       INT,
    customer_key      INT,
    order_date        DATE,
    shipping_date     DATE,
    due_date          DATE,
    sales_amount      INT,
    quantity          SMALLINT,      
    price             INT
);


-- =============================================================
-- STEP 5: Load Data from CSV Files
-- -------------------------------------------------------------
-- PostgreSQL uses the COPY command instead of BULK INSERT.
-- The file paths below are INSIDE your Docker container.
--
-- If your CSV files are on your LOCAL machine, use \copy
-- in psql terminal instead, OR use pgAdmin's Import Tool:
--   Right-click table → Import/Export Data → choose your CSV
-- =============================================================

-- Load Customers
TRUNCATE TABLE gold.dim_customers;

COPY gold.dim_customers
FROM '/Users/rahuls/Documents/sql-data-analytics-project/datasets/flat-files/dim_customers.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,          
    DELIMITER ','
);

-- Load Products
TRUNCATE TABLE gold.dim_products;

COPY gold.dim_products
FROM '/Users/rahuls/Documents/sql-data-analytics-project/datasets/flat-files/dim_products.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

-- Load Sales
TRUNCATE TABLE gold.fact_sales;

COPY gold.fact_sales
FROM '/Users/rahuls/Documents/sql-data-analytics-project/datasets/flat-files/fact_sales.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);


-- =============================================================
-- STEP 6: Verify Data Load ✅
-- =============================================================

SELECT 'dim_customers' AS table_name, COUNT(*) AS total_rows FROM gold.dim_customers
UNION ALL
SELECT 'dim_products',                COUNT(*)                FROM gold.dim_products
UNION ALL
SELECT 'fact_sales',                  COUNT(*)                FROM gold.fact_sales;
