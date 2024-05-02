/*1. Retrieve the total number of orders placed.*/
use pizza_db;
select * from orders;

select count(order_id) as TOTAL_ORDERS from orders;

/*2 Retrieve distinct pizza type ordered*/
select count(distinct(pizza_id)) TYPE_OF_PIZZA from order_details;

/*3. Retrieve number of pizza ordered where pizza_size='xxl' and it's pizza_id*/
select pizza_id,count(pizza_id) as PIZZA_COUNT 
from order_details
where pizza_id like '%_xxl'
group by pizza_id
order by PIZZA_COUNT desc;

/*4. Calculate the total revenue generated from pizza sales--> Rounded upto 2 decimal places*/

select 
round(sum(od.quantity*pz.price),2) as TOTAL_REVENUE_GENERATED
from order_details od 
join pizzas pz
on pz.pizza_id=od.pizza_id;

/*5. to know the pizza types where special ingredients-->'Mushrooms' and 'Pepperoni' used*/
select pizza_type_id,name,ingredients from pizza_types
where ingredients like '%Mushrooms%' 
and ingredients like'%Pepperoni%';

/*6. find the number of pizzas in different categroies*/

select category,count(pizza_type_id) as PIZZA_COUNT
from pizza_types
group by category
order by PIZZA_COUNT desc;

/*7 .Identify the highest-priced pizza.*/
select pt.name, pz.price
from pizza_types pt
join pizzas pz
on pt.pizza_type_id=pz.pizza_type_id
order by pz.price desc
limit 1;

/*8. Identify the highest-priced pizza and Revenue generated from it */
select pt.name, pz.price,round(sum(odd.quantity*pz.price),2) as REVENUE_GENERATED
from pizza_types pt
join pizzas pz
on pt.pizza_type_id=pz.pizza_type_id
join order_details odd
on pz.pizza_id=odd.pizza_id
group by pt.name,pz.price
order by pz.price desc
limit 1;

/*9. Identify the most common pizza size ordered.*/
select pz.size,count(od.order_details_id) as NO_OF_ORDERS
from pizzas pz
join order_details od
on pz.pizza_id=od.pizza_id
group by pz.size
order by NO_OF_ORDERS desc
limit 1;

/*10. List the top 5 most ordered pizza types along with their quantities.*/
select pt.name,sum(od.quantity) as COUNT_PIZZA
from pizza_types pt
join pizzas pz
on pt.pizza_type_id=pz.pizza_type_id
join order_details od
on od.pizza_id=pz.pizza_id
group by pt.name 
order by COUNT_PIZZA desc
limit 5;

/*11. Join the necessary tables to find the total quantity of each pizza category ordered.*/
select pt.category,sum(od.quantity) as NO_OF_PIZZAS
from pizza_types pt
join pizzas pz
on pt.pizza_type_id=pz.pizza_type_id
join order_details od
on od.pizza_id=pz.pizza_id
group by pt.category
order by NO_OF_PIZZAS desc;

/*12. Determine the distribution of orders by hour of the day.*/
select hour(order_time) as HOUR_OF_DAY,count(order_id) as NO_OF_ORDERS 
from orders
group by HOUR_OF_DAY
order by HOUR_OF_DAY;
 
/*13. Determine the top 5 distribution of orders by hour of the day.*/
select hour(order_time) as HOUR_OF_DAY,count(order_id) as NO_OF_ORDERS 
from orders
group by HOUR_OF_DAY
order by NO_OF_ORDERS desc
limit 5;


/*14. Group the orders by date and calculate the average number of pizzas ordered per day.*/
select round(avg(COUNT_QUANTITY),0) as AVG_QT_PER_DAY from
(select od.order_date,sum(odd.quantity) as COUNT_QUANTITY
from orders od
join order_details odd
on od.Order_id=odd.order_id
group by od.order_date) as odr_quantity;


/*15. Group the orders by date and calculate the top 10 day when maximum pizza ordered.*/

select od.order_date,sum(odd.quantity) as COUNT_QUANTITY
from orders od
join order_details odd
on od.Order_id=odd.order_id
group by od.order_date
order by COUNT_QUANTITY desc limit 10;

/*16. Find the total pizza ordered and revenue generated month wise and revenue earned >70000*/
select monthname(od.order_date) as MONTH,sum(odd.quantity) as NO_OF_PIZZA,
round(sum(odd.quantity*pz.price),2) as REVENUE_EARNED
from orders od
join order_details odd
on od.Order_id=odd.order_id 
join pizzas pz
on pz.pizza_id=odd.pizza_id
group by MONTH
having REVENUE_EARNED>70000
order by REVENUE_EARNED desc;


/*17. Determine the top 5 most ordered pizza types based on revenue*/
select pt.name,
sum(odd.quantity*pz.price) as REVENUE
from pizza_types pt
join pizzas pz
on pz.pizza_type_id=pt.pizza_type_id
join order_details odd
on odd.pizza_id=pz.pizza_id
group by pt.name
order by REVENUE desc
limit 5;

/*18.Calculate the percentage contribution of each pizza type to total revenue*/
select pt.category,
round((sum(odd.quantity*pz.price)
/(select round(sum(odd.quantity*pz.price),2) as total_sales
from order_details odd 
join pizzas pz
on pz.pizza_id=odd.pizza_id))*100,2) as REVENUE_PERCENTAGE
from pizza_types pt
join pizzas pz
on pz.pizza_type_id=pt.pizza_type_id
join order_details odd
on odd.pizza_id=pz.pizza_id
group by pt.category
order by REVENUE_PERCENTAGE desc;

commit;

/*19. Analyze the cumulative revenue generated over time.*/
select order_date,
sum(REVENUE) over(order by order_date) as CUMULATIVE_REV
from
(select od.order_date,
sum(odd.quantity*pz.price) as REVENUE
from order_details odd
join pizzas pz
on odd.pizza_id=pz.pizza_id
join orders od
on od.order_id=odd.order_id
group by od.order_date) as sales_table ;

/*20.Determine the top 3 most ordered pizza types based on revenue for each pizza category.*/

select category,name,REVENUE,RNK
from 
(select category,name,REVENUE,
rank() over(partition by category order by REVENUE desc) as RNK
from
(select pt.category,pt.name,
round(sum(odd.quantity*pz.price),2) as REVENUE
from pizza_types pt
join pizzas pz
on pt.pizza_type_id=pz.pizza_type_id
join order_details odd
on odd.pizza_id=pz.pizza_id
group by pt.category,pt.name) as a) as b
where RNK<=3;

commit;

