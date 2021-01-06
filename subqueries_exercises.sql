#SUBQUERIES

select *
from employees
where emp_no = 101010
or emp_no = 202020
or emp_no = 212121;

#if we have a list of specific numbers, we can use IN ()

select *
from employees
where emp_no in (101010, 202020, 212121);

#select *
#from table A
#where column_a in (
#		select column_a
#		from Table_B
#Joins allowed us to stitch together tables based on keys...
#column on the where needs to be the same column we are selecting
#joins are pretty darn fast
#subqueries using IN == pretty darn fast
select * 
from employees
where emp_no in (
	   select emp_no
	   from dept_manager
	   where to_date > curdate()
	   )
and gender = 'F';
 
 
#1.  Find all the current employees with the same hire date as employee 101010 using a sub-query.
#First find employee 101010, then find hire date of that employee, then use subquery with that hireday to find all employees with that hire date
select first_name, last_name, hire_date, emp_no
from employees
where hire_date in (
	  select hire_date
	  from employees
	  where emp_no = '101010');
	  
#2.  Find all the titles ever held by all current employees with the first name Aamod.
#first find all aamod employees, then find all the titles aamod's have held using distinct.
#join tables employees with the emp no to the titles table

select title, emp_no
from titles
where emp_no in (
	  select emp_no
	  from employees
	  where first_name = 'aamod');

#3.  How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

select count(emp_no)
from employees
where emp_no not in (
	  select emp_no
	  from dept_emp
	  where to_date > curdate());

#4.  Find all the current department managers that are female. List their names in a comment in your code.
#find all department manangers, then find all that are female.  join employees to department manager using empno

select * 
from employees
where emp_no in (
	   select emp_no
	   from dept_manager
	   where to_date > curdate()
	   )
and gender = 'F';

# isamu, karsten, leon, Hilary

#5.  Find all the employees who currently have a higher salary than the companies overall, historical average salary.
#find all salaries of all employees
#then get greater than average overall

select first_name, last_name, salary
from salaries
join employees on employees.emp_no = salaries.emp_no
where salary > (
	   select avg(salary)
	   from salaries)
	   and to_date > curdate();
	   
	   
#6.  How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?



