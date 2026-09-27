ALTER TABLE employees
ADD COLUMN job VARCHAR(25) AFTER hourly_pay;

UPDATE employees
SET job='manager'
WHERE employee_id=1;

UPDATE employees
SET employee_id=6
WHERE first_name="Sheldon";

INSERT INTO employees (first_name,last_name,hourly_pay,job,hire_date)
VALUES("Sheldon","Plankton",10.00,"janitor",'2023-01-07');

SELECT *
FROM employees
WHERE job="cook" AND hire_date<'2023-01-05';

SELECT *
FROM employees
WHERE job='cook' OR job='cashier';

SELECT *
FROM employees
WHERE job IN ('cook','cashier');

SELECT *
FROM employees
WHERE NOT job='manager';

SELECT *
FROM employees
WHERE NOT job='manager' AND NOT job='asst. manager';

SELECT *
FROM employees
WHERE NOT job IN ('manager','asst. manager');

SELECT *
FROM employees
WHERE hire_date BETWEEN '2023-01-04' AND '2023-01-07';

SELECT *
FROM employees;