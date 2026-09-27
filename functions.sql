#COUNT: counts the total rows, based on some certain conditions
SELECT COUNT(amount) AS "today's transactions"
FROM transactions;

#MAX: finds the maximum of a column, based on some certain cond
SELECT MAX(amount) as 'max amt'
FROM transactions;
#Similarly, there is minimum (MIN), average (AVG)

SELECT AVG(amount) as 'avg amt'
FROM transactions;

#SUM: adds up the numerical values present in a column
SELECT SUM(amount) as sum
FROM transactions;

SELECT *
FROM transactions;

SELECT CONCAT(first_name," ",last_name) AS full_name
FROM employees;

SELECT *
FROM employees;