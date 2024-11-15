/* Q.1 . Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints.
*/
create database assignment;
use  assignment;
create table employees
(emp_id int not null primary key,
emp_name varchar(60) not null,
age int check(age>=18),
email varchar(100) unique ,
salary decimal(10,2) default 30000.00
);

/* Q.2  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
Ans.
Purpose of constraints:-
•	Data integrity
•	Data validity
•	Consistency of data
Integrity refers to consistency and accuracy of data. constraints ensure that data adheres to specific rules, preventing the entry of invalid, incorrect or inconsistent data. so this is how constraints help maintain data integrity in a database.
Types of constraints:-
•	Primary key constraint:-
It ensure that each record in a table is unique and not null. a table can  only have one primary key.
Example- */
             create table employees
             (emp_id int  primary key);

/* •	Foreign key constraints:-
It enforces  referential integrity by ensuring that a column in one table matches a value in another table. establishing relationship between two.
Example- */
Create table department
(dept_id int not null,
Dept_name varchar(80));

Create table employee
(dept_id int not null,
emp_name varchar(80),
foreign key  (dept_id)  references  department(dept_id));
/* •	Unique constraints:-
It ensure that  all non null values in a column are unique. but it can allow null values.

Example:- */
            create table employees
            (email varchar(100) unique);
/* •	Not null constraints:-
It ensures that each value in column is not null.
Example:-
*/
Create table employee
(emp_name varchar(60) not null);

/* •	Check constraints:-
It allows to defines condition that must be met for the values to be valid.
Example:- */
Create table employee
(age int check(age>=18));
/* •	Default constraints:-
It provide a default value for a column  when no value is specified during an insert operation.
Example:- */
Create table employee
(salary decimal(10,2) default 30000.00);

/* Q.3 Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
Ans.
If we apply Not null constraints    it means that specific column can not contain any null values.but it does not enforce uniqueness.
No,a primary key does not contain null values.
Because primary key constraint must have unique , not null values to ensure data integrity.
I can justify my answer with the help of examples
Suppose I created a table in which emp_id column has primary key constraint .so emp_id column can only contain those values which are unique and not null. And in reality emp_id ofeach person is unique.
And other column which I had created that is emp_name which has not null constraint.so emp_name can not contain any null value but it can contain duplicate values. It is possible that two persons have same name.
 
 Q.4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
Ans.
Steps and sql commands to add constraint on an existing table:-
Use the “alter table” statement with the “add constraint” clause .
Syntax
Alter table table_name
Add constraint constraint_name constraint_definition;
Example-1 add primary key constraints */
Alter table employees
Add constraint pk_emp_id primary key (employee_id);
/* Example-2 add a foreign key constraint
If we have two tables (orders and customers) */
Alter table orders
Add constraint fk_cus_id foreign key (customer_id) references customers(customer_id);
/* Example-3 add check constraint */
Alter table voters
Add constraint check_age check (age>=18);
## Example-4 add unique constraint 
Alter table details
Add constraint unique_sub  unique (sub) ;
/* Steps and sql commands to remove constraint on an existing table:-
use “alter table” statement with the “drop constraint” clause.
Syntax:-
Alter table table_name
Drop constraint_name;
Example-1 removing a primary key constraint */
Alter table employees
Drop constraint pk_emp_id;
/* Example-2 removing a foreign key constraint */
Alter table orders 
Drop constraint fk_cus_id;
##  Example-3 removing a check constraint
Alter table voters
Drop constraint check_age;                           
## Example-4 removing a  unique constraint
Alter table details
Drop constraint unique_name;

/* Q.5  Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
Ans.
Violating constraints results in an error message that details the violation.
Consequences of violating constraints:-
•	Data integrity violation
•	Transaction failure
•	Error message
•	Impact on application
Examples of constraints and violation:-
•	Primary key constraint violation */
insert into employees
values(1,"jai",23,"jai123@gmail.com",20000.00),
(1,"shiv",25,"shiv123@gmail.com",50000.00);

## Error:- Error Code: 1062. Duplicate entry '1' for key 'employees.PRIMARY'

update employees
set emp_id=2 where emp_name="kali";

## Error:- Error Code: 1062. Duplicate entry '2' for key 'employees.PRIMARY'

## 	Foreign key constraint violation
Insert INTO Orders (OrderID, CustomerID) 
values (1001, 999); -- Assuming 999 does not exist in the Customers table
## Error:- insert or update on table "Orders" violates foreign key constraint "fk_cus_id"

## •	Not null constraint violation
insert into employees values
(4,null,22,"khali908@gmail.com",39000.00);
## Error:- Error Code: 1048. Column 'emp_name' cannot be null

## •	unique constraint violation
insert into employees values
(6,"ram",30,"khali908@gmail.com",39000.00);
## Error:- Error Code: 1062. Duplicate entry 'khali908@gmail.com' for key 'employees.email'

## •	check constraint violation
set sql_safe_updates=0;
update employees
set age=17 where emp_name="raj";
## Error:- Error Code: 3819. Check constraint 'employees_chk_1' is violated.

/* Q.6 . You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));  
 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00
Ans.
Sql query for making product_id a primary key:- */
ALTER TABLE PRODUCTS
ADD CONSTRAINT PRODUCT_ID PRIMARY KEY(PRODUCT_ID);
## Sql query for the price should have a default value of 50.00:-
alter table products
alter column price set default 50.00;

/* Q.7 You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
Ans.
Sql query to fetch the student_name and class_name for each student using an INNER JOIN.*/
select student_name,class_name from 
students s inner join classes c
on s.class_id=c.class_id;

/* Q.8 Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order Hint: (use INNER JOIN and LEFT JOIN)
Ans */
SELECT o.order_id, c.customer_name, p.product_name
FROM orders o
 left JOIN customers c ON o.customer_id = c.customer_id
left JOIN products p ON o.order_id = p.order_id;
/* Q.9 Given the following tables:
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
Ans.
Sql  query to find the total sales amount for each product using an INNER JOIN and the SUM() function. */
select product_name,sum(amount) total_sales_amount
from products p inner join sales s
on p.product_id=s.product_id
group by p.product_id,product_name;
/* Q.10 You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.
Ans. */
select od.order_id,customer_name,count(product_id),sum(quantity)
from order_details od join orders o 
on od.order_id=o.order_id join
customers c on o.customer_id=c.customer_id
group by od.order_id,c.customer_name;

## SQL COMMANDS
/* Q.1 Identify the primary keys and foreign keys in maven movies db. Discuss the differences
Ans.
•	Primary Key: Ensures the uniqueness and identification of each record within a table.
•	Foreign Key: Establishes a connection between two tables and enforces referential integrity by ensuring that a column's values correspond to valid primary keys in related tables.
In a Maven Movies DB, the primary keys ensure that records in each table (e.g., movies, actors, directors) are unique, while foreign keys create meaningful relationships between entities like movies and their respective directors or actor */
## Q.2 List all details of actors
Select * from actor;

## Q.3 List all customer information from DB.	
Select * from customers;	

## Q.4 List different countries.
select country from country;

## Q.5 Display all active customers.
select customer_id,first_name,last_name from customer
where active=1;

## Q6 -List of all rental IDs for customer with ID 1.
select rental_id from rental
where customer_id=1;

## Q7 - Display all the films whose rental duration is greater than 5 .
select film_id,title from film
where rental_duration>5 ;

## Q. 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
select count(film_id) from film
where replacement_cost >15 and replacement_cost<20 ;

## Q. 9 - Display the count of unique first names of actors.
select first_name,count(actor_id) count from actor group by first_name ;

## Q.10- Display the first 10 records from the customer table .
select * from customer
limit 10;

## Q.11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name like "b%"
limit 3;

## Q.12 -Display the names of the first 5 movies which are rated as ‘G’.
select film_id,title from film
where rating="G"
limit 5;

## Q.13-Find all customers whose first name starts with "a".
select customer_id,first_name from customer
where first_name like "a%";

## Q.14- Find all customers whose first name ends with "a".
select customer_id,first_name from customer
where first_name like "%a";

## Q.15- Display the list of first 4 cities which start and end with ‘a’ .
select city_id,city from city
where city like "%a" and city like "a%"
limit 4;

## Q.16- Find all customers whose first name have "NI" in any position.
select first_name,last_name from customer
where first_name like "%NI%";

## Q.17- Find all customers whose first name have "r" in the second position .
select first_name,last_name from customer
where first_name like "_r%";

## Q.18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select first_name,last_name from customer
where first_name like "a%" and length(first_name)>=5;

## Q.19- Find all customers whose first name starts with "a" and ends with "o".
select first_name,last_name from customer
where first_name like "a%o";

## Q.20 - Get the films with pg and pg-13 rating using IN operator.
select film_id,title from film 
where rating in ("pg","pg-13");

## Q.21 - Get the films with length between 50 to 100 using between operator.
select * from film 
where length between 50 and 100;

## Q.22 - Get the top 50 actors using limit operator.
select * from actor
limit 50;

## Q.23 - Get the distinct film ids from inventory table.
select count(distinct film_id) distinct_film_ids from inventory;

 /*                                       FUNCTIONS
Basic Aggregate Functions:
Question 1:
 Retrieve the total number of rentals made in the Sakila database.
 Hint: Use the COUNT() function.
*/
select count(rental_id) total_no_of_rentals from rental;

 /*Question 2:
 Find the average rental duration (in days) of movies rented from the Sakila database.
 Hint: Utilize the AVG() function.
*/
select avg(datediff(return_date,rental_date)) as avg_rental_duration  from rental;

/* String Functions:
 Question 3:
 Display the first name and last name of customers in uppercase.
 Hint: Use the UPPER () function.
*/
select upper(first_name) first_name_in_upper_case,upper(last_name) last_name_in_upper_case from customer;
 
 /*Question 4:
 Extract the month from the rental date and display it alongside the rental ID.
 Hint: Employ the MONTH() function.
*/
select rental_id,month(rental_date) rental_month from rental;
 
 
## GROUP BY:
/* Question 5:
 Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 Hint: Use COUNT () in conjunction with GROUP BY.
*/
select customer_id,count(rental_id) count_of_rentals from rental
group by customer_id;
/* Question 6:
 Find the total revenue generated by each store.
 Hint: Combine SUM() and GROUP BY.
*/
select store_id,sum(amount) total_revenue_generated
from payment p join staff s
on p.staff_id=s.staff_id group by store_id;
/* Question 7:
 Determine the total number of rentals for each category of movies.
 Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
*/
select c.name category_name,count(rental_id) total_rentals
from category c join film_category fc on 
c.category_id=fc.category_id join film f on
fc.film_id=f.film_id join inventory i
on f.film_id=i.film_id join rental r
on i.inventory_id=r.inventory_id group by category_name;

/* Question 8:
 Find the average rental rate of movies in each language.
 Hint: JOIN film and language tables, then use AVG () and GROUP BY.
*/
select f.language_id,avg(rental_rate),name
from film f join language l
on f.language_id=l.language_id
group by language_id;

## Joins

/* Questions 9 -
 Display the title of the movie, customer s first name, and last name who rented it.
 Hint: Use JOIN between the film, inventory, rental, and customer tables.
*/
select ff.film_id,title,first_name as customer_first_name,last_name as customer_last_name
from film ff join inventory i on  ff.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
join customer c on r.customer_id=c.customer_id;

/* Question 10:
 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 Hint: Use JOIN between the film actor, film, and actor tables.
*/
select a.actor_id,first_name,last_name 
from film_actor fa join film f on fa.film_id=f.film_id
join actor a on  fa.actor_id=a.actor_id where f.title="Gone with the Wind";
/* Question 11:
 Retrieve the customer names along with the total amount they've spent on rentals.
 Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
*/
select a.actor_id,first_name,last_name 
from film_actor fa join film f
on fa.film_id=f.film_id
 join actor a on  fa.actor_id=a.actor_id
where f.title="Gone with the Wind";
/* Question 12:
 List the titles of movies rented by each customer in a particular city (e.g., 'London').
 Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
*/
select c.customer_id, ci.city,c.first_name,c.last_name,group_concat(f.title order by f.title) rented_movies   from customer c join address a
on c.address_id=a.address_id join city ci
on a.city_id=ci.city_id join rental r
on c.customer_id=r.customer_id join inventory i
on r.inventory_id=i.inventory_id join  film f
on i.film_id=f.film_id
where ci.city="london"
group by c.customer_id;




## Advanced Joins and GROUP BY:
 /* Question 13:
 Display the top 5 rented movies along with the number of times they've been rented.
 Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
*/
select f.film_id,f.title,count(rental_id) rented_movies from film f join inventory i
on f.film_id=i.film_id join rental r
on i.inventory_id=r.inventory_id 
group by film_id
order by rented_movies desc
limit 5;
 /* Question 14:
 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
 Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
*/
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
WHERE 
    i.store_id IN (1, 2)
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT i.store_id) = 2;


## Windows Function:
## 1.	Rank the customers based on the total amount they've spent on rentals.

select r.customer_id,sum(amount) as total_spent,
rank() over(order by sum(amount)  desc) as rank_ from
rental r join payment p	
on r.customer_id=p.customer_id
group by customer_id;

## 2.	Calculate the cumulative revenue generated by each film over time.	

select f.film_id,f.title,r.rental_date,sum(amount) revenue,
sum(amount) over(partition by film_id order by rental_date)  cummulative_sum
from film f join inventory i on f.film_id=i.film_id join rental r
on i.inventory_id=r.inventory_id join payment p 
on r.rental_id=p.payment_id
group by  f.film_id,r.rental_id
order by f.film_id,r.rental_date;

## 3.	Determine the average rental duration for each film, considering films with similar lengths.

select length film_length,
avg(rental_duration) over(partition by length) avg_rental_duration
 from film;
 
## 4.	Identify the top 3 films in each category based on their rental counts.

select
   film_id,title,category_name,rental_counts
from
   (
     select f.film_id,f.title,c.name category_name,count(rental_id) rental_counts,

     row_number() over(partition by c.name  order by count(rental_id) desc) as rental_rank
     
     from film_category fc join category c on
     fc.category_id=c.category_id join film f
	 on fc.film_id=f.film_id join inventory i
     on f.film_id=i.film_id join rental r
     on i.inventory_id=r.inventory_id
     
     group by f.film_id,f.title,c.name
) as filmRentalCounts

where
rental_rank<=3
order by
category_name,rental_rank;    


## 5.	Calculate the difference in rental counts between each customer's total rentals and the average rentals  across all customers.

with customerRentals as(
     select c.customer_id,first_name,last_name,count(rental_id) as
     total_rents from customer c join rental r
     on c.customer_id=r.customer_id
     group by c.customer_id,c.first_name,c.last_name)
     ,AverageRentals as (
     select avg(total_rents) avg_rentals from customerRentals)
select cr.customer_id,cr.first_name,cr.last_name
,cr.total_rents,ar.avg_rentals,abs((cr.total_rents-ar.avg_rentals)) rental_differences
from
customerRentals cr,
averagerentals ar
order by
rental_differences desc;


## 6.	Find the monthly revenue trend for the entire rental store over time.

select date_format(payment_date,'%Y-%M') as month,
sum(amount) from payment   group by month
order by month ;


## 7.Identify the customers whose total spending on rentals falls within the top 20% of all customers.

with customerspending as(
   select c.customer_id,sum(amount) total_spendings
   from customer c join payment p on c.customer_id=p.customer_id
   group by c.customer_id)
,rankedcustomer as(
   select customer_id,total_spendings,
   ntile(5) over(order by total_spendings desc) spending_rank from customerspending)
select r.customer_id,total_spendings
from rankedcustomer r
where spending_rank=1;  ##top 20% total_spendings
                      
                      
## 8.	Calculate the running total of rentals per category, ordered by rental count.

with rentalcount as
(
        select c.name category_name,count(rental_id) as rental_count
        from category c join film_category fc on c.category_id=fc.category_id
         join inventory i on fc.film_id=i.film_id join rental r
        on r.inventory_id=i.inventory_id
        group by category_name
)
select category_name,rental_count,
sum(rental_count) over(order by rental_count desc) running_total
from rentalcount
order by 
rental_count desc;


 ## 9. Find the films that have been rented less than the average rental count for their respective categories.

with rentedfilm as(
    select c.name category_name,f.film_id,title,count(rental_id) rental_count from 
    category c join film_category fc on c.category_id=fc.category_id
   join film f on fc.film_id=f.film_id join inventory i
    on i.film_id=f.film_id join rental r 
    on i.inventory_id=r.inventory_id
    group by category_name,f.film_id,title
    ),
avgrentalcount as(
    select avg(rental_count) avg_rental_count from rentedfilm
    )
select category_name,film_id,title,rental_count
from rentedfilm,avgrentalcount
where rental_count<avg_rental_count
order by category_name,rental_count;


## 10.	Identify the top 5 months with the highest revenue and display the revenue generated in each month.

select date_format(payment_date,"%Y-%M") month_year,
sum(amount)
as total_revenue_generated
from payment
group by month_year
order by total_revenue_generated desc
limit 5;

##                           Normalisation & CTE
/*1. First Normal Form (1NF):
               a. Identify a table in the Sakila database that violates 1NF. Explain how you
               would normalize it to achieve 1NF.
Ans.	

In the Sakila database, the table customer could potentially violate 1NF if it contains non-atomic data types such as repeating groups or multi-valued attributes.
To normalize the customer table to 1NF, you would need to eliminate the repeating groups or multi-valued attributes, and ensure that each column holds a single value.

 2. Second Normal Form (2NF):
               a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
            If it violates 2NF, explain the steps to normalize it.
Ans.
If we determine that there are no partial or transitive dependencies, the table is in 2NF.
For example:
•	The Rental table has a single-column primary key (rental_id).
•	All non-key attributes (like rental_date, customer_id, staff_id, etc.) depend entirely on rental_id.
•	film_title depends on film_id, not on rental_id, which is a transitive dependency.

If the table were not in 2NF, the steps to normalize it would be:
•	Remove any partial dependencies by breaking the table into two (or more) tables. For example, if film_title depended on film_id, we would move film_id and film_title to a separate Film table.
•	Ensure that all non-key attributes are fully functionally dependent on the primary key, with no transitive dependencies.

 3. Third Normal Form (3NF):
               a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
               present and outline the steps to normalize the table to 3NF.
Ans.
Actor table in sakila violates 3nf.because in this table transitive dependencies is present.
Which means non key attributes depend on another non key attributes for ex. Address_id depend upon address_line,city_id, city_id depends upon country_id , country_id depends upon country_name, actor_id depends upon address_id.

Step 1: Split the Table into Multiple Tables
Step 2: Reorganize the Actor Table
       The actor table now only contains the necessary attributes related to the actor itself and            links to the other tables via foreign keys.
actor_id	first_name	last_name
1	John	Doe
2	Jane	Smith
         Normalized Actor Table (3NF): 




Step 3: Reorganize the Other Tables
•	The Address table contains address details with a link to the city.
•	The City table contains city-related details with a link to the country.
•	The Country table contains country-related information.
By separating the Actor, Address, City, and Country tables, we have eliminated the transitive dependencies. Each non-key attribute in the tables now directly depends on the primary key of its respective table, which satisfies 3NF. This normalization reduces redundancy, improves data integrity, and makes the schema easier to maintain.

 4. Normalization Process:
               a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  unnormalized form up to at least 2NF.
Ans.
Let’s take rental table.
1 nf   >>    it means a table is in 1nf when Each row is atomic, and each column now holds only a single piece of information.
So rental table is already in 1nf
But it is not in 2nf
So we covert this into 2nf
To move from 1NF to 2NF, we need to:
1.	Ensure that the table is in 1NF (which we already have).
2.	Eliminate partial dependencies: Non-key attributes must depend on the whole primary key, not just part of it.
Steps to achieve 2NF:
•	Separate out customer and staff information into their own tables to avoid repeating these details for each rental transaction.
•	Move address details into a separate Address table, linking it by a foreign key
Key changes:-
•	The Rental table now only contains the rental_id, rental_date, rental_fee, and return_date. It no longer includes customer or staff information directly.
•	The Customer table stores customer_name and links to an address_id.
•	The Staff table stores staff_name.
•	The Address table stores the address.
•	The Movie Title Table stores the movie_title for each rental transaction.*/

/* 5. CTE Basics:
                a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
*/

with distinctactor as(
select concat(first_name,' ',last_name) actor_name
,count(film_id) number_of_films
from actor a join film_actor fc on
a.actor_id=fc.actor_id
group by actor_name)
select actor_name,number_of_films
from distinctactor
order by number_of_films desc;


 /* 6. CTE with Joins:
                a. Create a CTE that combines information from the film and language tables to display the film title,  language name, and rental rate.
*/ 

with displayinfo as(
    select title,name language_name,rental_rate
    from film f
    join language l on f.language_id=l.language_id)
select * from displayinfo;


/* 7.  CTE for Aggregation:
               a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)  from the customer and payment tables.
*/

with totalrevenue as (
    select trim(concat(first_name,' ',last_name))  customer_name,
    sum(amount) total_revenue from customer c
    join payment p on c.customer_id=p.customer_id
    group by customer_name)
select * from totalrevenue 
order by total_revenue desc;


/* 8. CTE with Window Functions:
               a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
*/

with rankedfilm as(
 select film_id,trim(title),rental_duration,
rank() over(order by rental_duration desc)
 rank_based_on_rental_duration from film)
 select * from rankedfilm
 order by rental_duration desc;
 
 
/* 9.  CTE and Filtering:
               a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
*/

with custfilteration as(
  select c.customer_id,trim(concat(first_name,' ',last_name)) customer_name,
  count(rental_id) as rental_count from customer c join rental r
  on c.customer_id=r.customer_id
  group by customer_id
  having rental_count>2)
select c.customer_id,
cu.customer_name,cu.rental_count,c.email,c.address_id
 from
customer c join custfilteration cu on
c.customer_id=cu.customer_id;

/* 10. CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
*/

with rentaldata as(
  select date_format(rental_date,"%Y-%M") month_year,
  count(rental_id) total_rentals
  from rental 
  group by month_year)
select * from rentaldata
order by month_year;


 /* 11. CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
*/
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor fa1
    JOIN 
        film_actor fa2 
    ON 
        fa1.film_id = fa2.film_id
    WHERE 
        fa1.actor_id < fa2.actor_id -- ensures unique pairs (actor1_id, actor2_id)
)

SELECT 
    a1.first_name  AS actor1_name,
    a2.first_name AS actor2_name,
    COUNT(*) AS times_together
FROM 
    ActorPairs ap
JOIN 
    actor a1 ON ap.actor1_id = a1.actor_id
JOIN 
    actor a2 ON ap.actor2_id = a2.actor_id
GROUP BY 
    a1.first_name, a1.last_name, a2.first_name, a2.last_name
ORDER BY 
    times_together DESC;
    
/* 12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
*/
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Start with the specific manager (from store table)
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.store_id
    FROM 
        staff s
    JOIN 
        store st ON s.staff_id = st.manager_staff_id  -- Join with store to find the manager
    WHERE 
        s.staff_id = 1  -- Replace with the specific manager's staff_id you are interested in
    
    UNION ALL
    
    -- Recursive case: Find all employees who work at the same store as the manager
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.store_id
    FROM 
        staff s
    INNER JOIN 
        EmployeeHierarchy eh ON s.store_id = eh.store_id  -- Employees who work at the same store
)
-- Final selection: Get the full list of employees (including the manager and all employees reporting to them)
SELECT 
    staff_id, 
    first_name, 
    last_name, 
    store_id
FROM 
    EmployeeHierarchy;
