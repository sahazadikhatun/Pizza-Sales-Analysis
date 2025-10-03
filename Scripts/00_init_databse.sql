/*
=============================================================
Create Database
=============================================================
Script Purpose:
    This script creates a new database named 'pizza_sales' after checking if it already exists. 
    If the database exists, it is dropped and recreated.
	
WARNING:
    Running this script will drop the entire 'pizza_sales' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/
-- Create Database "MuSQL_Project_Pizza_Sales_Analysis"
DROP DATABASE IF EXISTS  Database Pizza_Sales_DB_1;
Create Database Pizza_Sales_DB_1;
use Pizza_Sales_DB_1;

-- ===============================
-- DROP TABLES IF THEY ALREADY EXIST
-- ===============================
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS pizza_type;

-- ===============================
-- CREATE TABLES
-- ===============================

-- ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
);

-- ORDER DETAILS TABLE
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL
);

-- PIZZA TYPE TABLE
CREATE TABLE pizza_type (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL
);

-- PIZZAS TABLE
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(5) NOT NULL,
    price DECIMAL(5,2) NOT NULL
);

