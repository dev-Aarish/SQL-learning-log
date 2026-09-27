CREATE TABLE employees(
    employee_id INT,
    first_name varchar(50),
    last_name varchar(50),
    hourly_pay DECIMAL(5,2),
    hire_date DATE
);

SELECT *
FROM employees;

#To rename a table, you can use the following command:
#RENAME TABLE employees TO workers;

ALTER TABLE employees
ADD phone_number VARCHAR(15);

ALTER TABLE employees
RENAME COLUMN phone_number TO email;

#The following command changes the datatype of email from it's previous one to the specified one
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100);

#Moves the email column from the last to after last_name
ALTER TABLE employees
MODIFY email VARCHAR(100)
AFTER last_name;

ALTER TABLE employees
DROP COLUMN email;