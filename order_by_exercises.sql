#ORDER BY EXERCISES AND NOTES

use employees;

select *
from employees
order by hire_date desc;

select *
from employees
order by first_name ASC, last_name ASC, hire_date ASC;

select * 
from employees
order by first_name DESC, birth_date ASC;

#This is the default order by, SQL orders by the primary kdy by default
select *
from employees
order by first_name ASC;


#1 Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.


#2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select *
from employees
where first_name in ('irena', 'vidya', 'maya')
order by first_name;
#Irena Reutenauer

#3 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
select *
from employees
where first_name in ('irena', 'vidya', 'maya')
order by first_name, last_name;
#Vidya Zweizig

#4 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
select *
from employees
where first_name in ('irena', 'vidya', 'maya')
order by last_name, first_name;
#Maya zyda

#5 Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
select *
from employees
where last_name like 'e%' and last_name like '%e'
order by emp_no;
#7330 emloyees returned, first:  10021/Ramzi/Erde, last:  499648/Tadahiro/Erde

#6 Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

select *
from employees
where last_name like 'e%' and last_name like '%e'
order by hire_date DESC;
#899 employees returned, newest employee:  Teiji Eldridge, Sergi Erde

#7 Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
order by hire_date ASC;
#362 employees returned

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
order by birth_date asc, hire_date desc;
#oldest employee who was hired last was Khun Bernini

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
order by birth_date desc, hire_date asc;
#youngest employee who was hired first was Douadi Pettis