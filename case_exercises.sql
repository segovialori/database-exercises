##CASE STATEMENTS

#Select case column a.  hey sql look at this column, when then is looking for a true.  If condition A is true, then it will return the new value.  Else is the catch all if first two conditions are not met.  Works like if-else.  end the case statement with the alias as the new column name.  

#When the case is research then we replace it with development.  When its marketing then replace it with sales.  End and alias result as department group.  

#if n is 3 then add 100
# if n is 5 thrn multiply by 100
#otherwise, return j

select n, 
case
	when n = 3 then n + 100
	when n = 5 then n * 100
	else n
	end as "output"
from numbers;

#USING IF FUNCTION
# if the department name matches research, return true, otherwise return false
# only producing a true or false
#If is useful if you task was just to find if something is true or false.  
#If we have trues or falses, then we can say "count or sum" the trues once you make a true column using if.  

#If i made a temporary table out of this 

create temporary table example as (
	select dept_name,
			if(dept_name = 'research', true, false) as is_research)


#1.  Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

#First join the correct table

select emp_no, dept_no, hire_date, to_date, 
case 
	when to_date = '9999-01-01' 
	then 1
	else 0
	end as is_current_employee
from employees
join dept_emp using(emp_no);

#Matthew's way
select emp_no, dept_no, hire_date, to_date, 
case	
	when to_date > curdate() then 1
	else 0
	end as is_current_employee
from employees
join dept_emp using(emp_no);

#2.  Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

select first_name, last_name, 
case
	when last_name < 'I' then 'A-H'
	when last_name < 'R' then 'I-Q'
	when last_name > 'Q' then 'R-Z'	
	else null
	end as alpha_group	
from employees;
############ matthews way
select first_name, last_name,
case 	
	when last_name REGEXP '^(A|B|C|D|E|F|G|H)' then 'A-H'
	when last_name REGEXP '^(I|J|K|L|M|N|O|P|Q)' then 'I-Q'
	else 'R-Z'
	end as alpha_group
from employees;
	
#########amandas way
CASE 
		WHEN last_name LIKE 'A%' 
			OR 
			last_name LIKE 'B%'
			OR 
			last_name LIKE 'C%' 
			OR 
			last_name LIKE 'D%' 
			OR 
			last_name LIKE 'E%' 
			OR 
			last_name LIKE 'F%' 
			OR 
			last_name LIKE 'G%' 
			OR 
			last_name LIKE 'H%'  
		THEN 'A-H'
		ELSE last_name
		END AS alpha_group


#3.  How many employees (current or previous) were born in each decade?

select count(birth_date)
from employees
where birth_date like '195%';

select count(birth_date)
from employees
where birth_date like '196%';
#employees only born in 1950 and 1960

select count(
case
	when birth_date like '195%' then '1950s' else null end) as decade_1950,
	   count(
case 
	when birth_date like '196%' then '1960s' else null end) as decade_1960
from employees;











#4.  What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select *
from salaries
join dept_emp using(emp_no)
join departments using(dept_no);

##REVIEW

#1.  emp_no, first_name, dept_no, dept_name
select emp_no, dept_no, from_date, to_date,
	if(to_date = '9999-01-01', 1, 0) as is_current_employee
from dept_emp;
#2.
select *,
case
	when left(last_name, 1) in ('a','b','c','d','e','f','g','h') then 'A-H'
	when left(last_name, 1) in ('i','j','k','l','m','n','o','p','q') then 'I-Q'
	else 'R-Z'
	end as alpha_group
from employees;

#3.  
select *
from employees
order by birth_date
limit 5;

select
case
	when birth_date like '195%' then '50s'
	when birth_date like '196%' then '60s'
	else 'young'
end as decade,
count(*) as number_of_employees
from employees
group by decade;

#bonus:  What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

select dept_name
from departments
group by dept_name;

select
case
	When dept_name in('Research', 'Development') then 'R&D'
	when dept_name in('Sales', 'Marketing') then 'Sales & Marketing'
	when dept_name in('Production', 'Quality Management') then 'Prod & QM'
	when dept_name in('Finance', 'Human Resources') then 'Finance & HR'
	else 'Customer Service'
end as department_group,
avg(salary) as average_salary
from employees_with_departments as ewd
join salaries as s on s.emp_no = ewd.emp_no
as s.to_date > curdate()
group by department_group;


