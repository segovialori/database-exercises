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

select employees.emp_no, count(*)
from employees
join titles ON titles.emp_no = employees.emp_no
group by emp_no;

select titles, employees.emp_no, count(*) 
from employees
join titles on titles.emp_no = employees.emp_no
join dept_emp on dept_emp.emp_no = 
group by dept_no;

#5 Find the current salary of all current managers.
select departments.dept_name as "department", CONCAT(employees.first_name, " ", employees.last_name) as "name", salary
from employees
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on dept_emp.emp_no = dept_manager.emp_no
join salaries on salaries.emp_no = employees.emp_no
where salaries.to_date > curdate() and dept_manager.to_date > curdate()
order by dept_name;