-- Instructions
/* In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.
Create a table rentals_may to store the data from rental table with information for the month of May.
Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
Create a table rentals_june to store the data from rental table with information for the month of June.
Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
Check the number of rentals for each customer for May.
Check the number of rentals for each customer for June.
Create a Python connection with SQL database and retrieve the results of the last two queries (also mentioned below) as dataframes:
Check the number of rentals for each customer for May
Check the number of rentals for each customer for June
Hint: You can store the results from the two queries in two separate dataframes.
Write a function that checks if customer borrowed more or less books in the month of June as compared to May.
Hint: For this part, you can create a join between the two dataframes created before, using the merge function available for pandas dataframes. Here is a link to the documentation for the merge function.*/

-- 1
Use sakila;
CREATE TABLE rentals_may (
    rental_id int,
    rental_date datetime,
    inventory_id int,
    customer_id int,
    return_date datetime,
    staff_id int,
    last_update datetime
);

-- 2
select*from sakila.rental
where rental_date like '2005-05%';
INSERT INTO rentals_may (rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
SELECT rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update
FROM rental 
where rental_date like '2005-05%';

-- 3
CREATE TABLE rentals_june (
    rental_id int,
    rental_date datetime,
    inventory_id int,
    customer_id int,
    return_date datetime,
    staff_id int,
    last_update datetime
);

-- 4
INSERT INTO rentals_june (rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
SELECT rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update
FROM rental 
where rental_date like '2005-06%';

select*from sakila.rentals_june;
-- 5
select customer_id, count(rental_id) from sakila.rentals_may
group by customer_id
order by count(rental_id) asc;
-- 6
select customer_id, count(rental_id) from sakila.rentals_june
group by customer_id
order by count(rental_id) asc;

-- LAST PART
/*select 
rj.customer_id, 
count(rj.rental_id) over (group by rj.cutomer_id), 
count(rm.rental_id) over (group by rm.cutomer_id) 
from sakila.rentals_june as rj
join sakila.rentals_may as rm
on rm.customer_id = rj.customer_id;*/

select l.customer_id, 
	count(l.rental_id) as sum_rentals_may, 
    count(r.rental_id) as sum_rentals_june  
from sakila.rentals_may as l
join sakila.rentals_june as r
on l.customer_id=r.customer_id
group by l.customer_id, r.customer_id
order by l.customer_id asc;

select *
from sakila.rentals_may as l
inner join sakila.rentals_june as r
on l.customer_id=r.customer_id
order by l.customer_id asc;

select customer_id, count(rental_id) from rentals_june
group by customer_id;

select customer_id, count(rental_id) from rentals_may
group by customer_id;