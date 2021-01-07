#Temporary tables
# Be sure to use your own database (based on your username)
use `easley_1257`;
CREATE TEMPORARY TABLE my_numbers(
    n INT UNSIGNED NOT NULL 
);
INSERT INTO my_numbers(n) VALUES (1), (2), (3), (4), (5);
select * 
from my_numbers;
update my_numbers
set n = n + 1;
select * from my_numbers;
update my_numbers
set n = 500
where n = 3; # using the where to isolate specific row(s)
select * from my_numbers;
# removes all records from 
delete from my_numbers;
select * from my_numbers;
delete from my_numbers where n = 3;
select * from my_numbers;

#When doing temp tables.  Start by using your own databse (so you can write/delete/whatever)
#start here
#use easley_1257
#lets make a temp table of current employees with their salary

use easley_1257;

create temporary table emp_salary as (
	select *
	from employees.employees #database_name.table_name
	join employees.salaries using(emp_no) #database_name.table_name
where to_date>curdate());

select *
from emp_salary;

#3 steps to success with temp tables
#1.  use your own database as a scratchpad
#2.  write the query you need to, using the database_name.table_name after your FROM or with your joins
#3.  wrap your query from above in create temporary table table_name as();

#stakeholder says:  what would our totoal salary spend be if everybody gets a 5% raise?
#technically we dont need a temp table to solve this, so this is a simple example.

update emp_salary
set salary = salary + salary * .05;

select *
from emp_salary;

select sum(salary) from emp_salary;

select *
from emp_salary
where first_name = 'Mary'
and salary > 60000


#Using the example from the lesson, re-create the employees_with_departments table.
use easley_1257;

#Using the example from the lesson, re-create the employees_with_departments table.

use easley_1257;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

select *
from employees_with_departments;

#A.  Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

alter table employees_with_departments 
add full_name VARCHAR(30);
#B.  Update the table so that full name column contains the correct data

update employees_with_departments 
set full_name = concat(first_name, " ", last_name);

select *
from employees_with_departments;

#C.  Remove the first_name and last_name columns from the table.

alter table employees_with_departments 
drop column first_name;

select *
from employees_with_departments;

alter table employees_with_departments 
drop column last_name;

select *
from employees_with_departments;

#D.  What is another way you could have ended up with this same table?

select emp_no, dept_no, dept_name, concat(first_name, " ", last_name) as "full_name"
from employees;

#2.  Create a temporary table based on the payment table from the sakila database.


#2A.   Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.








#Using the example from the lesson, re-create the employees_with_departments table.

use easley_1257;

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

select *
from employees_with_departments;

#A.  Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

alter table employees_with_departments 
add full_name VARCHAR(30);
#B.  Update the table so that full name column contains the correct data

update employees_with_departments 
set full_name = concat(first_name, " ", last_name);

select *
from employees_with_departments;

#C.  Remove the first_name and last_name columns from the table.

alter table employees_with_departments 
drop column first_name;

select *
from employees_with_departments;

alter table employees_with_departments 
drop column last_name;

select *
from employees_with_departments;

#D.  What is another way you could have ended up with this same table?

select emp_no, dept_no, dept_name, concat(first_name, " ", last_name) as "full_name"
from employees;

#2.  Create a temporary table based on the payment table from the sakila database.
use easley_1257;
create temporary table payments_amounts_revised as
select payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
from sakila.payment;

select *
from payments_amounts_revised;

#2A.   Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
select cast(amount as int)
from payments_amounts_revised);
select *
from payments_amounts_revised;


update payments_amounts_revised 
set amount = amount * 100;

select *
from payments_amounts_revised;

#3.  Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

use easley_1257;

create temporary table average_pay AS
select emp_no, salary, dept_no, dept_name, salaries.from_date, salaries.to_date
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no);

select *
from average_pay;


#test:historical avg salary for customer service is:  58770.3665
select dept_name, avg(salary)
from average_pay
where dept_name = 'customer service';

#test: current avg salary for customer service is:  66971.3536
select dept_name, avg(salary)
from average_pay
where to_date > curdate() and dept_name ='customer service';

#. created temporary table that has historical salary for each department and current salary for each department
create temporary table average_department_salary as
select dept_name as 'department', avg(salary) as 'historical average salary'
from average_pay
group by dept_name;

#temporary table for current salary for each department
create temporary table average_department_salary2
select dept_name as 'department', avg(salary) as 'current average salary'
from average_pay
where to_date > curdate()
group by dept_name;

alter table average_department_salary 
drop column current_average_salary;

select *
from average_department_salary;

select *
from average_department_salary2;

#join the tables
create temporary table all_salary as
select *
from average_department_salary
join easley_1257.average_department_salary2 using(department);

#historal average pay of all departments

select avg(`historical average salary`)
from all_salary;

select *
from all_salary;


#EXERCISE 3 APPROACHES

#. z = (x - population_mean)/ stddev(x)

#X, population_mean, std
#1,2 .816 (STD) (1-2) / .816
#2,2 .816 (2-2) / .816
#3,2 816 (3-2) / .816

#population mean = 2


##RYAN DEMO
#We can write a query that gets avg(salary) and std(salary)
# avg_salary is 63810
# std salary is 16904
# make this a temporary table
create temporary table historic_aggregates as (
select avg(salary) as avg_salary, std(salary) as std_salary
from employees.salaries);

#. Obtain the department name, the current average salary, and the departments current average salary.  
create temporary table current_info as (
select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > curdate()
and employees.salaries.to_date > curdate()
group by dept_name);

select * from current_info;

# Need to add a column to hold the historic average salary
# Need to add a column to hold the historic std salary
# then, ill add one more column to hold the zscore from that calculationm

alter table current_info
add average float(10,2);

alter table current_info add standard_deviation float(10,2);
alter table current_info add zscore float(10,2);

select * from current_info;

#how to update a column using a selct from another temp_table where had a single row of values
update current_info
set standard_deviation = (select std_salary from historic_aggregates);

update current_info
set average = (select avg_salary from historic_aggregates);

update current_info
set zscore = (department_current_average - average) / standard_deviation;

select * from current_info
order by zscore desc;

##zscore is the number of standard deviations away from the companies historic average salary across the entire company

select *, concat("$",department_current_average - average) as pay_change
from current_info
order by zscore desc;