#UNION combines the results of two or more 
#SELECT statements

#Note: In order to make a UNION of SELECT statements,
#the number of coloumns need to be same. or you can
#select the same number of columns and perform UNION

SELECT first_name,last_name
FROM employees
UNION
SELECT first_name,last_name
FROM customers;

#Note: UNION doesn't show duplicates, but UNION ALL does

SELECT *
FROM employees;

SELECT *
FROM customers;