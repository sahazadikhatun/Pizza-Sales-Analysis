-- Purpose: understand customer ordering patterns.
-- Average pizzas per order.
select avg(c) as avg_pizzas_per_order from(
select order_id,count(*) as c from order_details
group by order_id) t1;

-- Average order value.
select avg(p) as AOV from(
select order_id,sum(price) as p from(
select t1.order_id,
	t2.order_details_id,
    t3.pizza_id,
    t3.price
from orders t1 join order_details t2
on t1.order_id=t2.order_id join pizzas t3
on t2.pizza_id=t3.pizza_id) t1
group by order_id) t2;

-- % revenue from top 3 pizzas.
with pizza_rev as(select pizza_type_id, sum(price) as rev from pizzas
group by pizza_type_id)
select pizza_type_id,round(100*rev/(select sum(rev) from pizza_rev),2) as percent_rev from pizza_rev
order by percent_rev desc
limit 3;

with pizza_rev as(select pizza_id, sum(price) as rev from pizzas
group by pizza_id)
select pizza_id,round(100*rev/(select sum(rev) from pizza_rev),2) as percent_rev from pizza_rev
order by percent_rev desc
limit 3;

-- Pizza category with highest average order value.
select category,sum(price)/count(distinct order_id) as aov_by_pizza_type from(
select t1.order_id,
	t2.order_details_id,
    t3.pizza_id,
    t3.pizza_type_id,
    t3.price,
    t4.category
from orders t1 join order_details t2
on t1.order_id=t2.order_id join pizzas t3
on t2.pizza_id=t3.pizza_id
join pizza_type t4
on t3.pizza_type_id=t4.pizza_type_id)p1
group by category
order by aov_by_pizza_type desc
limit 1;

-- Correlation between pizza size & order quantity.
select size,sum(quantity) as total_quantity_by_size from(
select 
	t2.*,
    t1.pizza_type_id,
    t1.size,
    t1.price
from pizzas t1 join order_details t2
on t1.pizza_id= t2.pizza_id) y
group by size
order by total_quantity_by_size desc;


