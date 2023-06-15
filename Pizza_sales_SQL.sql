select * from pizza_sales;

/*KPI Measures*/
/*Total Revenue*/
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;

/*Average Order Value*/
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS avg_order_value
FROM pizza_sales;

/*Total Pizza Sold */
SELECT SUM(quantity) as total_pizzas_sold
FROM pizza_sales;

/*Total Orders */
SELECT COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales;

/*Avg Pizzas per Order*/
SELECT CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS avg_pizza_per_order
FROM pizza_sales;



/*DAILY TREND FOR TOTAL ORDERS*/
SELECT DATENAME(weekday,order_date) AS weekday_ordered, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(weekday,order_date)
ORDER BY total_orders DESC;

--Hourly Trend
Select DATEPART(HOUR,order_time) as order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY order_hours;

--% of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS pct_sales
FROM pizza_sales
GROUP by pizza_category;

--% of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS pct_sales
FROM pizza_sales
GROUP BY pizza_size;

--Total Pizzas Sold by Category
SELECT pizza_category, SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category;

--Top 5 Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
OFFSET 0 ROWS FETCH FIRST 5 ROWS ONLY;

--Bottom 5 Sellers by Total Pizza Sold
SELECT TOP 5 pizza_name, SUM(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
