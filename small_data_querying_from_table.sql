SELECT last_name, first_name
FROM employees;

SELECT *
FROM employees
WHERE employee_id=3;

SELECT *
FROM employees
WHERE first_name="Spongebob";

SELECT *
FROM employees
WHERE hourly_pay>=15.00;

SELECT *
FROM employees
WHERE hire_date<="2023-01-03";

SELECT *
FROM employees
WHERE employee_id<>1;
#Note: Not equal to can also be written as '!='

SELECT *
FROM employees
WHERE hire_date IS NULL;
#Note we can't use '= NULL'

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

SELECT *
FROM employees;