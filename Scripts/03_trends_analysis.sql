-- Purpose: analyze orders over time.
-- Daily order trends (orders per day).
select day_name, sum(quantity) as quantity_of_pizza_per_day from(
select 
	t1.order_id,
    date,
    time,
	Upper(left(dayname(date),3)) as day_name,
    pizza_id,quantity
from orders t1 join order_details t2
on t1.order_id=t2.order_id) p
group by day_name;

-- Monthly revenue trends.
select month_name, sum(quantity) as quantity_of_pizza_per_month from(
select 
	t1.order_id,
    date,
    time,
	Upper(left(monthname(date),3)) as month_name,
    pizza_id,quantity
from orders t1 join order_details t2
on t1.order_id=t2.order_id) p
group by month_name
order by quantity_of_pizza_per_month desc;
-- limit 1;

-- Day of week analysis (which day has max sales).
select day_name, sum(quantity) as quantity_of_pizza_per_day from(
select 
	t1.order_id,
    date,
    time,
	Upper(left(weekday(date),3)) as day_name,
    pizza_id,quantity
from orders t1 join order_details t2
on t1.order_id=t2.order_id) p
group by day_name
order by quantity_of_pizza_per_day desc
limit 1;

-- Hourly trends (peak order times).
select hour_, 
	sum(quantity)/count(distinct order_id) as avg_quantity_of_pizza_per_hour ,
	sum(quantity) as total_quantity_of_pizza_per_hour from(
select 
	t1.order_id,
    date,
    time,
	hour(time) as hour_,
    pizza_id,quantity
from orders t1 join order_details t2
on t1.order_id=t2.order_id) p
group by hour_
order by quantity_of_pizza_per_hour desc;

-- Analyze the cumulative revenue generated over time.

select 
	t1.order_id,
    date,
    time,
	Upper(left(monthname(date),3)) as month_name,
    t2.pizza_id,quantity,
    t3.price
from orders t1 join order_details t2
on t1.order_id=t2.order_id
join pizzas t3 
on t2.pizza_id= t3.pizza_id
