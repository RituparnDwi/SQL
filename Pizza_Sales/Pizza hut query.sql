USE [pizzahut]
GO


select * from [dbo].[order_details]

select * from [dbo].[orders]

---------------------------------------------------------------------------------------------------
------------------------------------------#   Basic   #--------------------------------------------
---------------------------------------------------------------------------------------------------


----Q1. Retrive total number of orders placed.

select count(order_id) as total_orders from [dbo].[orders]

---Q2. Calculate the total revenue generated from pizza sales.

select * from [dbo].[pizzas]

select
sum(cast(order_details.quantity as float) * pizzas.price) as Total_Revenue
from order_details 
inner join pizzas on pizzas.pizza_id = order_details.pizza_id

---Q3. Identify the highest-priced pizza.

select * from pizza_types

select * from [dbo].[pizzas]
where price = (select max(price) from [dbo].[pizzas])

select pizza_types.name, pizzas.price
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
where price = (select max(price) from [dbo].[pizzas])
order by pizzas.price desc

-----Q4. Identify the most common pizza size ordered.

select * from order_details

select count(quantity) from [dbo].[order_details]

select pizzas.size,
count(order_details.order_details_id) as order_count
from pizzas
inner join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc

----Q5. List the top 5 most ordered pizza types along with their quantities.

select top 5 
convert(nvarchar(50), pizza_types.name) as Name,
sum(cast(order_details.quantity as decimal(10,2))) as quantity_order
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join order_details
on order_details.pizza_id = pizzas.pizza_id
group by convert(nvarchar(50), pizza_types.name)
order by quantity_order desc


--------------------------------------------------------------------------------------------------
------------------------------------------#   Intermediate   #------------------------------------
--------------------------------------------------------------------------------------------------


-----Q1. Join the necessary tables to find the total quantity of each pizza category ordered.
 
select convert(nvarchar(50), pizza_types.category) as category, 
sum(cast(order_details.quantity as decimal(10,2))) as quantity
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by convert(nvarchar(50), pizza_types.category)
order by quantity desc

-------Determine the distribution of orders by hour of the day.
   
select 
datepart(hour, time) as hour, 
COUNT(order_id) as order_distribution from orders
group by datepart(hour, time)
order by order_distribution desc

select orders.date, orders.time,
SUM(cast(order_details.quantity as decimal(10,2))) as Quantity_order
from order_details
inner join orders on order_details.order_id = orders.order_id
group by date, time
order by date desc 

------Join relevant tables to find the category-wise distribution of pizzas.

select convert(nvarchar(50), category) as category,
count(convert(nvarchar(50), name)) as count from pizza_types
group by convert(nvarchar(50), category)

--Group the orders by date and calculate the average number of pizzas ordered per day.

select avg(order_count) from 
(select orders.date, sum(cast(order_details.quantity as decimal(10,2))) as order_count
from orders
inner join order_details on orders.order_id = order_details.order_id
group by orders.date) as order_quantity

--Determine the top 3 most ordered pizza types based on revenue.

select top 3
convert(nvarchar(50), pizza_types.name) as name, 
sum(cast(order_details.quantity as decimal(10,2)) * pizzas.price) as total_revenue
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join order_details on order_details.pizza_id = pizzas.pizza_id
group by convert(nvarchar(50), pizza_types.name)
order by total_revenue desc


--------------------------------------------------------------------------------------------------
---------------------------------------------#   Advanced   #--------------------------------------
--------------------------------------------------------------------------------------------------

-----Calculate the percentage contribution of each pizza type to total revenue.

select 
convert(nvarchar(50), pizza_types.category) as category, 
(sum(cast(order_details.quantity as decimal(10,2)) * pizzas.price) / (select
sum(cast(order_details.quantity as decimal(10,2)) * pizzas.price) as total_sales
from order_details
inner join pizzas on order_details.pizza_id = pizzas.pizza_id))*100 as revenue 
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join order_details on order_details.pizza_id = pizzas.pizza_id
group by convert(nvarchar(50), pizza_types.category)
order by revenue desc

--Analyze the cumulative revenue generated over time.

select date,
sum(revenue) over(order by date) as cum_revenue
from
(select orders.date,
SUM(cast(order_details.quantity as decimal(10,2))* pizzas.price) as revenue
from order_details
inner join pizzas on order_details.pizza_id = pizzas.pizza_id
inner join orders on orders.order_id = order_details.order_id
group by orders.date) as sales

-----Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select
convert(nvarchar(50), pizza_types.category) as category,
convert(nvarchar(50), pizza_types.name) as name,
SUM(cast(order_details.quantity as decimal(10,2)) * pizzas.price) as revenue
from pizzas
inner join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
inner join order_details on order_details.pizza_id = pizzas.pizza_id
group by convert(nvarchar(50), category), convert(nvarchar(50), pizza_types.name)) as a) as b
where rn <= 3
