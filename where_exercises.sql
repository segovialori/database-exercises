#Create a file named where_exercises.sql. Make sure to use the employees database.

select *
from employees
where 
	(hire_date like '%12-17'
	or 
	birth_date like '12-17')
and not 
	(hire_date like '12-17' 
	and 
	birth_date like '12-17');
	
#In operator allows us to chain together a whole bunch of "ors"
#show me the employees that have the emp_no of 101010 or 202020 or 303030.  IN does the same thing as if you chained a bunch of "ors" together.  Allows us to search within a set.  Use in with numbers and strings.  

select *
from employees
where emp_no in (101010, 202020, 12345);

# select anybody who is in the this list of names:  [georgi, mary, jane, bob]

select *
from employees
where first_name in ('irena', 'vidya', 'maya');


#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

select *
from employees
where first_name in ('irena', 'vidya', 'maya');
#709

#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

select *
from employees
where first_name = 'irena' or first_name = 'vidya' or first_name = 'maya';

#709 rows come back with or.  It does match the number of rows from Q2.


#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.

select * 
from employees
where (first_name = 'irena' or first_name = 'vidya' or first_name = 'maya') and gender = 'm';
#441

#Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

select *
from employees
where last_name like 'e%';
#7330

#Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?

select *
from employees
where last_name like 'e%' or last_name like '%e';
#30723

select *
from employees
where last_name like '%e' and not last_name like 'e%';
#23393 ends with E but doesnt start with e

#Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
select *
from employees
where last_name like 'e%' and last_name like '%e';
#899

select *
from employees
where last_name like '%e';
#24292

#Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
select *
from employees
where hire_date like '199%';
#135214

#Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
select *
from employees
where birth_date like '%-12-25';
#842

#Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
select *
from employees
where hire_date like '199%' and birth_date like '%-12-25';
#362


#Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
select *
from employees
where last_name like '%q%';
#1873

#Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
select *
from employees
where last_name like '%q%' and not last_name like '%qu%';
#547