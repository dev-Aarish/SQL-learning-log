#Wild card characters: %, _
#These are used to substitute one or more characters in a string

#'%' represents any number of random characters
SELECT *
FROM employees
WHERE first_name LIKE 's%';
#LIKE searches for patterns 

SELECT *
FROM employees
WHERE hire_date LIKE '2023%';

SELECT *
FROM employees
WHERE last_name LIKE '%r';

#'_' represents one random letter
SELECT *
FROM employees
WHERE job LIKE '_ook';

SELECT *
FROM employees
WHERE hire_date LIKE '____-01-__';
#Note: the table date is in MM/DD/YYYY format, but
#the input we give in is of YYYY-MM-DD

#list the employees with the second char being a in their job title
SELECT *
FROM employees
WHERE job LIKE '_a%';

SELECT *
FROM employees;