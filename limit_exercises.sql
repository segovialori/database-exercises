## LIMIT EXERCISES AND NOTES
select *
from employees limit 10;

#show salaries between the range
#order by salary
#show the first 100

select *
from salaries
where salary between 67000 and 71000
order by salary asc
limit 100;

#take the above query and show the last 100
#reverse our order by
#add the limit

select * 
from salaries
where salary between 6700 and 71000
order by salary desc
limit 100;

#lets take a look at the first 10 employees (ordered by emp_no)
#off is where you are starting.  "Offset 0" is the default.
#if we show 10 employess per page, this is the first page of the results.
#this shows emp_no 10001 through 10010
select *
from employees
limit 10 offset 0;

#lets get the same results, but the second page
#where the results are the next ten rows
#this shows emp_no 10011 through 10020

select *
from employees
limit 10 offset 10;

#page 3 of the results of what we did above
select *
from employees
limit 10 offset 20;


#Create a new SQL script named limit_exercises.sql.

#MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

#SELECT DISTINCT title FROM titles;
#List the first 10 distinct last name sorted in descending order.

select distinct last_name from employees order by last_name desc limit 10;
#Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker

#Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
order by hire_date
limit 5;
# alselm, utz, bouchung,baocai, petter 

#Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
limit 5 offset 0;

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
limit 5 offset 20;

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
limit 5 offset 45;

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

#Limit limits the number of results returned to a number or page specified.  Limit and offset are used for creating pages of data.  The relationship between LIMIT & OFFSET can be viewed as a function: OFFSET = LIMIT*p-LIMIT. offeset_number = (page_number - 1) * limit_number  
