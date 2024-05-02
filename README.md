# PIZZA-SALES-ANALYSIS-USING-SQL

From total revenue generated from pizza sales to top 3 most ordered pizza types based on revenue for each pizza category, there are 20 different queries are executed to Analyze the Sales data of Pizza Company. 

Key Highlights:

I have used 4 different tables and from basic to advanced queries to retrieve these all queries -->

1. pizzas table(containing 4 columns)-->pizza_id, pizza_type_id, size and price.
2. pizza_types table(containing 4 columns)--> pizza_type_id,name,category and ingredients.
3. orders table(containing 3 columns)-->order_id,order_date and order_time.
4.order_details table(containing 4 columns)-->order_details_id,order_id,pizza_id and quantity.

I have used COUNT(),SUM(),RANK(),OVER(),GROUP BY(),ORDER BY(),LIMIT and others clauses in these 20 questions. 

The 20 different queries are:
SQL PROJECT QUESTIONS:
1.	Retrieve the total number of orders placed
2.	Retrieve distinct pizza type ordered
3.	Retrieve number of pizza ordered where pizza_size='xxl' and it's pizza_id
4.	Calculate the total revenue generated from pizza sales--> Rounded upto 2 decimal places
5.	Wants to know the pizza types where special ingredients-->'Mushrooms' and 'Pepperoni' used
6.	Need to find the number of pizzas in different categroies
7.	Identify the highest-priced pizza
8.	Identify the highest-priced pizza and Revenue generated from it
9.	Identify the most common pizza size ordered
10.	List the top 5 most ordered pizza types along with their quantities.
11.	Join the necessary tables to find the total quantity of each pizza category ordered
12.	Determine the distribution of orders by hour of the day.
13.	Determine the top 5 distribution of orders by hour of the day
14.	Group the orders by date and calculate the average number of pizzas ordered per day
15.	Group the orders by date and calculate the top 10 day when maximum pizza ordered
16.	Find the total pizza ordered and revenue generated month wise and revenue earned >70000
17.	Determine the top 5 most ordered pizza types based on revenue
18.	Calculate the percentage contribution of each pizza type to total revenue
19.	Analyze the cumulative revenue generated over time
20.	Determine the top 3 most ordered pizza types based on revenue for each pizza category
