SELECT *
FROM employees
ORDER BY last_name;
#Note: by default, order by works in ascending order

SELECT *
FROM employees
ORDER BY last_name DESC;

SELECT *
FROM employees;

SELECT *
FROM transactions
ORDER BY amount;

SELECT *
FROM transactions
ORDER BY amount, customer_id;
#When there are 2 equal amounts, then the ordering will be 
#done between them based on customer_id

SELECT *
FROM transactions;