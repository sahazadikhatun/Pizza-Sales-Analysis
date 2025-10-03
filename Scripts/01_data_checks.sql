-- Purpose: sanity checks & quick exploration.
-- Count rows in each table.
use Pizza_Sales_DB_1;
select count(*) from order_details;
select count(*) from orders;
select count(*) from pizza_type;
select count(*) from pizzas;

-- Find earliest & latest order date.
select max(date) as latest_order_date from orders;
select min(date) as earliest_order_date from orders;

-- Count distinct pizza types & sizes.
select 
	pizza_id,
	count(*) as ordered_pizza_count_by_id from order_details
group by pizza_id;
select 
	pizza_type_id, 
	count(*) as pizza_count_in_each_category from pizzas
group by pizza_type_id;

select count(distinct pizza_id) as total_pizza_variety from order_details;

-- Check total number of orders & order details.
select count(distinct order_id) from orders;
select order_id,count(order_details_id) ordered_pizza_count from order_details
group by order_id;

-- List all unique pizza categories available.
select distinct category from pizza_type;
-- Find the most expensive pizza and the least expensive pizza.
select * from pizzas
order by price desc limit 1;
-- 
select * from pizzas
order by price limit 1;
-- Count the number of distinct pizza types.
select count(distinct pizza_type_id) as pizza_type_count from pizzas;

