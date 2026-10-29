-- join statment
#An INNER JOIN is used to combine rows from two or more tables, but only when there is a matching value in both tables.
select *
from employee_demographics;

select *
from employee_salary;

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id =sal.employee_id;
    
select dem.employee_id,age,sal.occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id =sal.employee_id;
#################################################

-- outer joins 
#An OUTER JOIN is used when you want to combine rows from two or more tables, but unlike an INNER JOIN, you don't want to lose data just because there isn't a perfect match between them.
#There are three types of Outer Joins: LEFT, RIGHT, SELF JOIN and FULL.

#RIGHT (OUTER) JOIN:"Give me every single salary record from the right table. If a salary doesn't connect to an employee's profile in the left table, show the salary anyway and fill the employee details with NULL."
#left (outer) join :"Give me every single employee from the left table, and if they happen to have a salary in the right table, show that too. If they don't, just leave the salary blank (NULL)."

select *
from employee_demographics as dem 
left join employee_salary as sal
	on dem.employee_id = sal.employee_id;

select *
from employee_demographics as dem 
right join employee_salary as sal
	on dem.employee_id = sal.employee_id;

select *
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id+1 = emp2.employee_id ;

-- joining multiple table together 
select *
from employee_demographics dem
inner join employee_salary sal
	on dem.employee_id = sal.employee_id
inner join parks_departments pd
	on sal.dept_id = pd.department_id ;
#################################################
-- DISTINCt :The DISTINCT command is used inside a SELECT statement to remove all duplicate rows and return only unique values.
-- uniona statment :The UNION operator is used to combine the result sets of two or more SELECT statements into a single, continuous result set.
select gender ,age 
from employee_demographics
union
select first_name ,last_name
from employee_salary;

select first_name ,last_name , 'Old Man' as Label 
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name ,last_name, 'Old Lady' as Label
from employee_demographics 
where age > 40 and gender = 'Female'
union
select first_name ,last_name , 'Highly Paid Salary' as Label
from employee_salary
where salary >70000
order by first_name ,last_name;

#################################################
-- string function :

select length('skyfull');

select first_name, length(first_name)
from employee_demographics
order by 2; -- order by 2 means from shortest to longest name 

select upper('sky');
select first_name, upper(first_name)
from employee_demographics;

select trim ('     sky       '); -- there is also Ltrim and Rtrim 

select first_name ,left(first_name , 4),
right(first_name , 4),
substring(first_name ,3,2) ##this mean we start from third character and move only 2 indicies 
birth_date ,substring(birth_date ,6,2) as birth_month
from employee_demographics;

#################################################
-- REPLACE ;
-- CONCA: combine two name together 
select first_name ,replace(first_name ,'a','z')
from employee_demographics;

select locate('x','Alexander');

select first_name ,locate('an',first_name )
from employee_demographics;

select first_name ,last_name ,
CONCAT(first_name,last_name)
FROM employee_demographics;
#################################################
-- CASE STATMENT 
select first_name ,age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'Old'
    when age >=50 then 'On death door'
end as Age_Bracketf
from employee_demographics;

-- pay increase  and bounes
-- < 50000 = 5%
-- > 50000 = 7% 
-- Finance  = 10% bounes 

select first_name ,last_name, salary,
case
	when salary < 50000 then salary * 1.05
	when salary > 50000 then salary * 1.07
end as New_Salary,
case 
	when dept_id = 6 then salary * .10
end as Bounes 
from  employee_salary;

#################################################
-- subqueries 

select * 
from employee_demographics;

select AVG(max_age)
from
(select gender ,
avg(age) as avg_age,
max(age) as max_age,
min(age) as min_age,
count(age) 
from employee_demographics
group by gender 
) as Agg_table;

 -- Window Functions 
 
 select gender ,avg(salary)
 from employee_demographics as dm
 join employee_salary as sal
	on dm.employee_id = sal.employee_id
group by gender;

-- Over() / ROW_NUMBER() / Dense_Rank()
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


