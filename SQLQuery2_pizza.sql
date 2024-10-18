select top 5 * from pizza_db;

--calculating Total Revenue
select sum(total_price) as Total_Revenue from pizza_db;

--calculating average order value
select sum(total_price)/count(distinct(order_id)) as Average_Order_Value
from pizza_db;

--Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold from pizza_db 

--Total orders
select count(distinct(order_id)) as Total_Orders from pizza_db

--Number Of Pizzas Per Order
select order_id , sum(quantity) as pizzas_per_order from pizza_db
group by order_id
order by order_id

--Avg Number Of Pizzas Per Order
select sum(quantity)/count(distinct(order_id)) as Avg_Number_Pizzas_Per_Order from pizza_db

--Monthly Trend for Total orders
select Datename(month , order_date) as month_name , count(distinct(order_id)) as Total_Orders
from pizza_db
group by Datename(month , order_date)
order by Total_Orders

--Daily Trend for Total orders
select Datename(weekday , order_date) as day_name , count(distinct(order_id)) as Total_Orders
from pizza_db
group by Datename(weekday , order_date)
order by Total_Orders desc

--Hourly Trend for Total orders
select Datename(hour , order_time) as hour, count(distinct(order_id)) as Total_Orders
from pizza_db
group by Datename(hour , order_time)
order by Total_Orders desc

--Percentage of Sales by Pizza Category , you can make it for a specific month using where statement
select pizza_category , round(sum(total_price)*100/(select sum(total_price) from pizza_db where month(order_date) = 1) , 2) as Sales_Percentage
from pizza_db
where month(order_date) = 1
group by pizza_category
order by Sales_Percentage Desc

--Percentage of Sales by Pizza size in a quarter

SELECT 
    pizza_size, 
    round(SUM(total_price) * 100 / 
        (SELECT SUM(total_price) 
         FROM pizza_db 
         WHERE DATEPART(quarter, order_date) = 1)
    ,2) AS Sales_Percentage
FROM pizza_db
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Sales_Percentage DESC;

--top 5 best selling pizza , total quantity and total orders
select top 5 pizza_name , sum(quantity) as quantity  , count(distinct(order_id)) as num_of_orders ,round(sum(total_price),2) as sales from pizza_db
group by pizza_name
order by sales desc

--bottom 5 best selling pizza , total quantity and total orders
select top 5 pizza_name , sum(quantity) as quantity  , count(distinct(order_id)) as num_of_orders ,round(sum(total_price),2) as sales from pizza_db
group by pizza_name
order by sales asc