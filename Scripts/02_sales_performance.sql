-- Purpose: performance of products, categories, and sizes.
-- Total revenue generated.
select sum(price) as total_revenue from (
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id)t;

-- Top 5 pizzas by quantity ordered.
select pizza_id,sum(quantity) as total_quantity from order_details
group by pizza_id
order by total_quantity desc
limit 5;

-- Top 5 pizzas by revenue.
select pizza_id,sum(price) as total_revenue_by_pizza_id from (
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id)t
group by pizza_id
order by total_revenue_by_pizza_id desc
limit 5;

-- Revenue contribution by pizza size.
select size,sum(price) as total_revenue_by_pizza_size from (
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id)t
group by size
order by total_revenue_by_pizza_size desc;

-- Revenue contribution by pizza category.
select category,sum(price) as total_revenue_by_category from(
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price,
	t3.name,
    t3.category,
    t3.ingredients
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id 
join pizza_type t3
on t2.pizza_type_id=t3.pizza_type_id) t
group by category
order by total_revenue_by_category desc;

-- Most profitable pizza type.

select pizza_type_id,sum(price) as total_revenue_by_pizza_type from (
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id)t
group by pizza_type_id
order by total_revenue_by_pizza_type desc
limit 1;

-- Identify the pizza that contributes the most revenue in each category.
select category,pizza_id,rev_by_category_pizza
 from(
select *, rank() over (partition by category order by rev_by_category_pizza desc) as rn from(
select category,pizza_id, sum(price) as rev_by_category_pizza from(
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
on t3.pizza_type_id=t4.pizza_type_id) u1
group by category,pizza_id
) u2) u3
where rn = 1;

-- Identify the most common pizza size ordered.
select size,count(order_details_id) as total_revenue_by_pizza_size from (
select
	t1.order_details_id,
    t1.order_id,
    t2.pizza_id,
    t2.pizza_type_id,
    t2.size,
    t2.price
from order_details t1
join pizzas t2
on t1.pizza_id=t2.pizza_id)t
group by size
order by total_revenue_by_pizza_size desc
limit 1;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,pizza_type_id,rev_by_category_pizza from(
select *, rank() over (partition by category order by rev_by_category_pizza desc) as rn from(
select category,pizza_type_id, sum(price) as rev_by_category_pizza from(
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
on t3.pizza_type_id=t4.pizza_type_id) u1
group by category,pizza_type_id
) u2) u3
where rn in (1,2,3);
