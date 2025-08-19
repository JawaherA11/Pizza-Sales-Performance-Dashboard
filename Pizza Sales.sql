-- Create the pizza table
CREATE TABLE pizza (
    pizza_id INT PRIMARY KEY,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(5,2),
    total_price DECIMAL(5,2),
    pizza_size CHAR(5),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

Select * from pizza;

--The dataset will be loaded into the 'pizza' table using the Import/Export feature

--QUESTIONS 
                         --KPI--

						 
--1. Total Revenue:
Select sum (total_price) As Total_Revenue
 from pizza;

--2. Average Order Value
Select (sum (total_price) / count (Distinct order_id)) As Avg_order_value
 from pizza;

--3. Total Pizzas Sold
Select sum (quantity) As Total_Pizza_Sold
 from pizza;

--4. Total Orders
Select  count (Distinct order_id) As Total_Orders
 from pizza;

--5. Average Pizzas Per Order
Select Cast(Cast(Sum(quantity) As DECIMAL(10,2)) / 
Cast (Count(Distinct order_id) As DECIMAL(10,2)) As DECIMAL(10,2))
AS Avg_Pizzas_per_order
From pizza;

                     --Charts--


--6.Daily Trend for Total Orders
Select TO_CHAR(order_date, 'FMDay') as ORDER_DAY ,
count (Distinct order_id) as TOTAL_ORDERS 
From pizza
Where order_date Is Not Null
group by TO_CHAR(order_date, 'FMDay');

					 
--7.Monthly Trend for Orders
Select TO_CHAR(order_date, 'Month') as ORDER_DAY ,
count (Distinct order_id) as TOTAL_ORDERS 
From pizza
Where order_date Is Not Null
group by TO_CHAR(order_date, 'Month');

--8.% of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) 
AS DECIMAL(10,2)) AS PCT
FROM pizza
GROUP BY pizza_category;

--9.% of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) 
AS DECIMAL(10,2)) AS PCT
FROM pizza
GROUP BY pizza_size;

--10.Top 5 Pizzas by Revenue
select pizza_name ,sum(total_price) as total_revenue
FROM Pizza
GROUP BY pizza_name
ORDER BY total_revenue DESC
limit 5;

--11.Bottom 5 Pizzas by Revenue
select pizza_name ,sum(total_price) as total_revenue
FROM Pizza
GROUP BY pizza_name
ORDER BY total_revenue ASC
limit 5;

--12.Top 5 Pizzas by Quantity
select pizza_name ,sum(quantity) as Total_Pizza_Sold
FROM Pizza
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5;

--13.Bottom 5 Pizzas by Quantity
select pizza_name ,sum(quantity) as Total_Pizza_Sold
FROM Pizza
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
limit 5;

--14.Top 5 Pizzas by Total Orders
select pizza_name ,count (Distinct order_id) as Total_orders
FROM Pizza
GROUP BY pizza_name
ORDER BY Total_orders DESC
limit 5;

--15.Borrom 5 Pizzas by Total Orders
select pizza_name ,count (Distinct order_id) as Total_orders
FROM Pizza
GROUP BY pizza_name
ORDER BY Total_orders ASC
limit 5;
