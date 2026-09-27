-- sub query is a query within another query
SELECT first_name, last_name, hourly_pay,
(SELECT AVG(hourly_pay)
FROM employees) AS average_hourly_pay
FROM employees;

-- every empployee having huorly_pay greater than average pay
SELECT first_name,last_name,hourly_pay
FROM employees
WHERE hourly_pay>(
    SELECT AVG(hourly_pay)
    FROM employees
);

SELECT *
FROM employees;

-- list all customer's name who has ever placed an order
SELECT first_name,last_name
FROM customers
WHERE customer_id IN(
    SELECT DISTINCT customer_id
    FROM transactions
    WHERE customer_id IS NOT NULL
);
SELECT DISTINCT first_name,last_name
FROM transactions INNER JOIN customers
ON transactions.customer_id=customers.customer_id;

SELECT *
FROM transactions;

SELECT *
FROM customers;