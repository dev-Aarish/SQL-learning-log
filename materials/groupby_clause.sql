#GROUP BY-> Aggregate all rows by a specific column often used
#with aggregate functions ex. SUM(), MAX(), MIN(), AVG(), COUNT()

ALTER TABLE transactions
ADD order_date DATE;

SELECT order_date, SUM(amount) AS earnings
FROM transactions
GROUP BY order_date;

SELECT order_date, COUNT(amount) AS orders
FROM transactions
GROUP BY order_date;

#how much each customer spent on total
SELECT customer_id, SUM(amount) AS "money spent"
FROM transactions
GROUP BY customer_id;

#let's do the above one but showing customer names with it
SELECT t.customer_id, CONCAT(c.first_name," ",c.last_name) AS customer, SUM(amount) AS "money spent"
FROM transactions AS t LEFT JOIN customers AS c
ON t.customer_id=c.customer_id
GROUP BY t.customer_id;

#Note: We can't use WHERE clause while using GROUP BY.
#Instead we can use HAVING

SELECT COUNT(amount),customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount)>1 and customer_id IS NOT NULL;

SELECT *
FROM transactions;

SELECT *
FROM customers;