-- CTEs : CTE stands for Common Table Expression.

with CTE_example (Gender , AVG_SAL,MAX_SAL,MIN_SAL,COUNT_SAL)as
(
select gender ,avg(salary) avg_sal,max(salary) max_sal ,min(salary) min_sal ,count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_example;


-- Subquery

select avg(avg_sal)
from(
select gender ,avg(salary) avg_sal,max(salary) max_sal ,min(salary) min_sal ,count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)  subqueiry_ex ;

-- Nested CTEs  
with CTE_example as
(
select employee_id , gender ,birth_date
from employee_demographics
where birth_date > '1985-01-01'
),
CTE_example2 as
(
select employee_id ,salary
from employee_salary
where salary > 5000
)
select *
from CTE_example
join CTE_example2
	on CTE_example.employee_id = CTE_example2.employee_id
;

-- Temporary Tabels
create temporary table temp_table
(
first_name varchar(50),
last_name varchar(50),
favourt_name varchar(100)
);

SHOW TABLES; -- to show all tables 
DROP TEMPORARY TABLE IF EXISTS SALARY_OVER_50k; -- to delete  table from system use drop 

create temporary table SALARY_OVER_50k 
select * 
from employee_salary
where salary > 50000;

######################################################################
-- stored procedures 

select * 
from employee_salary
where salary >= 50000;

create procedure large_salaries()
select *
from employee_salary
where salary > 50000;

call large_salaries();