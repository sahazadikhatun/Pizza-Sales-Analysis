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
DROP DATABASE IF EXISTS pizza_sales;
create database pizza_sales;
use pizza_sales;
