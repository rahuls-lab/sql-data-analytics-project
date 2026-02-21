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

 STEP 1 | List All Tables in the Database
-- ------------------------------------------------------------
-- Queries the information_schema to retrieve all tables
-- available in the current database.
-- Filter by table_schema = 'gold' to focus only on our
-- curated analytics layer and exclude system schemas.
-- ============================================================

SELECT
    table_catalog,       -- database name
    table_schema,        -- schema name  (e.g. gold, public)
    table_name,          -- table name
    table_type           -- BASE TABLE or VIEW
FROM information_schema.tables
WHERE table_schema NOT IN ('information_schema', 'pg_catalog')  -- exclude system schemas
ORDER BY table_schema, table_name;


-- ============================================================
-- STEP 2 | Inspect Columns of a Specific Table
-- ------------------------------------------------------------
-- Returns column-level metadata for 'dim_customers'.
-- Useful for understanding data types, nullability, and
-- field length constraints before building queries.
-- ============================================================

SELECT
    column_name,               -- name of the column
    data_type,                 -- PostgreSQL data type
    is_nullable,               -- YES / NO
    character_maximum_length   -- max length for VARCHAR fields
FROM information_schema.columns
WHERE table_schema = 'gold'
  AND table_name   = 'dim_customers'
ORDER BY ordinal_position;     -- preserves original column order


-- ============================================================
-- STEP 3 | Inspect Columns of All Tables (Gold Schema)
-- ------------------------------------------------------------
-- A broader view — shows columns across all tables in the
-- gold schema at once. Helpful for a full schema overview.
-- ============================================================

SELECT
    table_name,
    column_name,
    data_type,
    is_nullable,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'gold'
ORDER BY table_name, ordinal_position;
