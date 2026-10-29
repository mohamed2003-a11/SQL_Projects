SELECT * 
FROM parks_and_recreation.employee_demographics; # The ; is used to define the end of query 
SELECT first_name,
last_name,
birth_date,
age,
age + 10
FROM parks_and_recreation.employee_demographics;
#########################################

select  * 
FROM employee_salary
where salary >= 5000 or salary = 4600 ;
#####################################################

-- LIKE statment
-- (%er%) this sign mean anything include er in it's context like jerry or tery or dwyer 
-- anything include er in the name or also birth_data like '1989%'  
select *
from employee_demographics
where birth_date like '1989%' ;
######################################

 -- Group by and AVG statment 
select gender,avg(age),max(age),min(age),count(age) # using this query result for avarge age for both gender male and female  
from employee_demographics
group by gender ;
######################################

-- order by 1 or 2 
-- In SQL, writing ORDER BY 1 or ORDER BY 2 is a shortcut that tells MySQL to sort your results 
-- by the positional number of the column as it appears in your SELECT statement, reading from left to right.
select *
from employee_demographics
order by gender,age  asc ;
######################################

-- Having statment 
select occupation , avg(salary)
from employee_salary
where occupation like "%manager%"
group by occupation
having avg(salary) > 75000
; 
-- Aliasing 
select gender ,avg(age) as avg_age
from employee_demographics
group by gender 
having avg_age > 40; 
######################################


