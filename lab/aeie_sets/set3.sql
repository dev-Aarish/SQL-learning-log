-- 1. Create Department table
CREATE TABLE Department (
    Dept_Code VARCHAR(10) PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);

-- 2. Create Employee table
CREATE TABLE Employee (
    Emp_Code VARCHAR(10) PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Desig VARCHAR(30),
    Manager VARCHAR(10),
    Date_of_Joining DATE,
    Salary DECIMAL(10, 2),
    Dept_Code VARCHAR(10),
    FOREIGN KEY (Dept_Code) REFERENCES Department(Dept_Code)
);

-- 3. Insert values into Department
INSERT INTO Department VALUES
('D01', 'IT', 'Kolkata'),
('D02', 'HR', 'Delhi'),
('D03', 'Finance', 'Mumbai');

-- 4. Insert values into Employee
INSERT INTO Employee VALUES
('E101', 'Amit', 'Manager', 'E101', '2018-01-10', 8000, 'D01'),
('E102', 'Riya', 'Developer', 'E101', '2019-03-15', 6000, 'D01'),
('E103', 'Rahul', 'Tester', 'E101', '2020-06-20', 5000, 'D01'),
('E104', 'Sneha', 'Manager', 'E104', '2017-02-12', 9000, 'D02'),
('E105', 'Karan', 'Developer', 'E104', '2019-08-01', 7000, 'D02'),
('E106', 'Priya', 'Clerk', 'E104', '2021-01-05', 4000, 'D02'),
('E107', 'Arjun', 'Analyst', 'E107', '2018-11-11', 10000, 'D03'),
('E108', 'Neha', 'Developer', 'E107', '2020-04-10', 8000, 'D03');

-- (i) List the average salary and number of employees working 
-- in each department.

SELECT dept_code, AVG(salary) AS avg_salary, COUNT(*) AS no_of_employees
FROM employee
GROUP BY dept_code;

-- (ii) List the names of those departments where the total 
-- salary is greater than 15000.

SELECT dept_name
FROM department d 
JOIN employee e ON d.dept_code=e.dept_code
GROUP BY e.dept_code,d.dept_name
HAVING SUM(salary)>15000;

-- (iii) List the names of the employees and the names of their managers 
-- under whom they are working.

SELECT e1.emp_name AS employee, e2.emp_name AS manager
FROM employee e1 JOIN employee e2
ON e1.manager=e2.emp_code;

-- (iv)List the details of those employees who are getting salary 
-- greater than the average salary of their department.

SELECT e.*
FROM employee e
WHERE e.salary>(
    SELECT AVG(salary)
    FROM employee e2
    WHERE e2.dept_code=e.dept_code
);
