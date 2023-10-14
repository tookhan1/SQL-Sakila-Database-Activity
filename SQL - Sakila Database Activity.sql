
-- Sakila Database - Context

-- We are going to run through a series of queries from the Sakila sample database in MySQL Workbench. Results will be shown below queries. 
-- Added Active Notes to certain questions to show my logic and process. 

-- Q1 - Which actors have the first name "Scarlett"?

Select * from actor
where first_name = 'scarlett';

-- actor_id, first_name, last_name
-- '81', 'SCARLETT', 'DAMON'
-- '124', 'SCARLETT', 'BENING'


-- Q2 - Which actors have last names that contain the word "son"?

Select * from actor
where last_name like '%son%'
order by first_name asc;

-- # actor_id, first_name, last_name
-- '146', 'ALBERT', 'JOHANSSON'
-- '65', 'ANGELA', 'HUDSON'
-- '6', 'BETTE', 'NICHOLSON'
-- '61', 'CHRISTIAN', 'NEESON'
-- '62', 'JAYNE', 'NEESON'
-- '8', 'MATTHEW', 'JOHANSSON'
-- '154', 'MERYL', 'GIBSON'
-- '64', 'RAY', 'JOHANSSON'
-- '168', 'WILL', 'WILSON'


-- Q3 - Return the full names (first and last) of actors with "son" in their last name, ordered by the first name?

Select first_name,last_name, concat(first_name,' ',last_name) as fullname
from actor
where last_name like '%son%'
order by first_name;

--  first_name, last_name, fullname
-- 'ALBERT', 'JOHANSSON', 'ALBERT JOHANSSON'
-- 'ANGELA', 'HUDSON', 'ANGELA HUDSON'
-- 'BETTE', 'NICHOLSON', 'BETTE NICHOLSON'
-- 'CHRISTIAN', 'NEESON', 'CHRISTIAN NEESON'
-- 'JAYNE', 'NEESON', 'JAYNE NEESON'
-- 'MATTHEW', 'JOHANSSON', 'MATTHEW JOHANSSON'
-- 'MERYL', 'GIBSON', 'MERYL GIBSON'
-- 'RAY', 'JOHANSSON', 'RAY JOHANSSON'
-- 'WILL', 'WILSON', 'WILL WILSON'


-- Q4 - In total, how many last names occur in the "actor" table?

Select count(last_name) from actor;

-- count(last_name)
-- '200'

-- Q5 - How many distinct last names occur in the "actor" table?

Select count(distinct last_name) from actor;

-- count(distinct last_name)
-- '121'

-- Q6 - How many distinct country names are there?

Select count(distinct country) from country;

-- count(distinct country)
-- '109'


-- Q7 - What are the names of all the languages in the language table, sorted alphabetically?

Select * from language
order by name asc;

-- language_id, name
-- '1', 'English'
-- '5', 'French'
-- '6', 'German'
-- '2', 'Italian'
-- '3', 'Japanese'
-- '4', 'Mandarin'


-- Q8 - What is the sum of all payment amounts and the average payment amount per customer?

-- Active Notes Below:

-- Since the customers info is separate from their payment info, I'll need to join the two tables. 
-- My first step is to write queuries to see what columns are similar for table payment and table customer.

Select * from payment;

Select * from customer;

-- customer_id is the common column, so I'll write a query that connects both customer_id columns into one query. 

-- Select first and last names to identify all unique names, as well as the requried information of the sum of the amounts and average of the amounts.
-- The only additional information we need to join is just customer_id so I chose an inner join query to just take the neccessary information from the customer table.
-- Once a connected payment's customer_id and customer's customer_id, I finished the query by grouping and ordering by alphabetical order. 
-- Limited it to 10 rows for brevity sake

Select c.first_name, c.last_name, sum(p.amount), avg(p.amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by 1,2
order by c.first_name, c.last_name
limit 10;

-- first_name, last_name, sum(p.amount), avg(p.amount)
-- 'AARON', 'SELBY', '110.76', '4.615000'
-- 'ADAM', 'GOOCH', '101.78', '4.626364'
-- 'ADRIAN', 'CLARY', '74.81', '3.937368'
-- 'AGNES', 'BISHOP', '98.77', '4.294348'
-- 'ALAN', 'KAHN', '124.74', '4.797692'
-- 'ALBERT', 'CROUSE', '99.77', '4.337826'
-- 'ALBERTO', 'HENNING', '66.79', '3.180476'
-- 'ALEX', 'GRESHAM', '151.67', '4.596061'
-- 'ALEXANDER', 'FENNELL', '151.64', '4.212222'
-- 'ALFRED', 'CASILLAS', '120.74', '4.643846'


-- Q9 - List the 5 customers who have paid the highest amounts?

Select c.first_name, c.last_name, sum(p.amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
group by 1,2
order by sum(p.amount) desc
limit 5;


-- first_name, last_name, sum(p.amount)
-- 'KARL', 'SEAL', '221.55'
-- 'ELEANOR', 'HUNT', '216.54'
-- 'CLARA', 'SHAW', '195.58'
-- 'MARION', 'SNYDER', '194.61'
-- 'RHONDA', 'KENNEDY', '194.61'

