#2.  Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department
select dept_name, CONCAT(employees.first_name, " ", employees.last_name) as Dept_Manager
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on dept_emp.emp_no = dept_manager.emp_no
where dept_manager.to_date> curdate()
order by dept_name;

#3.  Find the name of all departments currently managed by women.
select dept_name, CONCAT(employees.first_name, " ", employees.last_name) as Dept_Manager
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on dept_emp.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate() and gender = 'f'
order by dept_name;

#4.  Find the current titles of employees currently working in the Customer Service department.
#how many titles has each employee had?


select title as Titles, count(*) as Count
from titles
join dept_emp on dept_emp.emp_no = titles.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where dept_name = "customer service" and titles.to_date > curdate() and dept_emp.to_date > curdate()
group by title;

#5 Find the current salary of all current managers.
select departments.dept_name as "department", CONCAT(employees.first_name, " ", employees.last_name) as "name", salary
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on dept_emp.emp_no = dept_manager.emp_no
join salaries on salaries.emp_no = employees.emp_no
where salaries.to_date > curdate() and dept_manager.to_date > curdate()
order by dept_name;

#6 Find the number of current employees in each department.
select departments.dept_no, departments.dept_name, count(*)
from dept_emp
join departments on dept_emp.dept_no = departments.dept_no
where dept_emp.to_date > curdate()
group by departments.dept_no
order by departments.dept_no;

#7.  
SELECT dept_no, avg(salary)
 from salaries
 join dept_emp using (emp_no)
 group by dept_no
 order by avg(salary) desc;
 
 #8s Who is the highest paid employee in the Marketing department?
 SELECT e.first_name, e.last_name
 FROM salaries AS s
 	JOIN employees AS e
 		ON s.emp_no = e.emp_no
 	JOIN dept_emp AS de
 		ON s.emp_no = de.emp_no
 WHERE s.to_date > curdate()
 AND de.dept_no = 'd001'
 ORDER BY s.salary DESC
 LIMIT 1;
 
 #9. which current department manager has the highest salary?
 SELECT e.first_name, e.last_name, s.salary, d.dept_name
 FROM employees AS e
 	JOIN dept_manager AS dm
 		ON dm.emp_no = e.emp_no
 	JOIN departments AS d
 		ON d.dept_no = dm.dept_no
 	JOIN salaries AS s
 		ON s.emp_no = dm.emp_no

 WHERE dm.to_date > curdate()
 AND s.to_date > curdate()
 ORDER BY s.salary DESC
 LIMIT 1;
 
 
 #10.  Bonus Find the names of all current employees, their department name, and their current manager's name.
 
#manifrelst of tables we will touch.  
#employees table to get employees names
#departments table to get department names
#dep_emp table to join employees with departments
#managers table
#dept_manager to get the empno of a manger and the dept no for the departments they manage
#but wheres the managers table with managers names?
#employee_name, department name, managers name
#get joins togehter first
#if you have the same columns with the same name then you can use "using"
#joined the table a second time using an alias (employees as managers)

select concat(employees.first_name, " ", employees.last_name) as "employee_name", dept_name, dept_manager.emp_no, concat(managers.first_name, " ", managers.last_name) as "manager_name"
from employees
join dept_emp using(emp_no)
join departments using(dept_no)
join dept_manager using(dept_no)
join employees as managers on managers.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate();

 #11.  Bonus Who is the highest paid employee within each department.
 #does the querie have to be one query or can it be several?
 #What we do is a function of teh context in which that work is needed
 #Does teh query need to run 1000 a day, every day for 20 years?
 #Does sally your manager need that info before her lunch meeting?
 #list out the tables we need:
 #employees to get names and salary to get compensation and department to get departmenet name and dept_emp to associate department and employees
 select first_name, last_name, salary
 from employees
 join salaries on salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
 join departments on departments.dept_no = dept_emp.dept_no
 where salary in (
 select max(salary)
 from employees
 join salaries on salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
 join departments on departments.dept_no = dept_emp.dept_no
 and salaries.to_date > curdate()
 and dept_emp.to_date > curdate()
 group by dept_name);
 
 select max(salary), dept_name
 from employees
 join salaries on salaries.emp_no = employees.emp_no
 join dept_emp on dept_emp.emp_no = employees.emp_no
 join departments on departments.dept_no = dept_emp.dept_no
 group by dept_name;