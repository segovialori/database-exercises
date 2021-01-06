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
SELECT COUNT(*), (COUNT(*)/(SELECT COUNT(*) FROM salaries AS s WHERE s.to_date>NOW()) * 100) AS Percent
FROM salaries AS s
WHERE s.to_date='9999-01-01' AND s.salary >

				(SELECT MAX(s.salary) - STD(s.salary)
				FROM salaries AS s);

#7.  Find all the department names that currently have female managers.
SELECT d.dept_name
FROM departments AS d
JOIN dept_manager AS dm 
ON d.dept_no=dm.dept_no
JOIN employees AS e
ON e.emp_no=dm.emp_no
WHERE e.gender='F' AND dm.emp_no IN (SELECT dm.emp_no
FROM dept_manager AS dm
WHERE dm.to_date='9999-01-01');
#8.  Find the first and last name of the employee with the highest salary.
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN salaries AS s ON e.emp_no=s.emp_no
WHERE s.salary =
(SELECT MAX(s.salary)
FROM salaries AS s);
#9.  Find the department name that the employee with the highest salary works in.
SELECT d.dept_name
FROM departments AS d
JOIN dept_emp AS de
ON d.dept_no=de.dept_no
JOIN salaries AS s
ON de.emp_no=s.emp_no
WHERE s.salary=
		(SELECT MAX(s.salary)
		FROM salaries AS s);