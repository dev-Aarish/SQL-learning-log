ALTER TABLE customers
ADD referral_id INT;

UPDATE customers
SET referral_id=2
WHERE customer_id=4;

SELECT *
FROM customers AS a INNER JOIN customers AS b
ON a.referral_id=b.customer_id;

SELECT a.customer_id, a.first_name, a.last_name, CONCAT(b.first_name," ",b.last_name) AS referred_by
FROM customers AS a LEFT JOIN  customers AS b
ON a.referral_id=b.customer_id;

SELECT *
FROM customers;

ALTER TABLE employees
ADD supervisor_id INT;

UPDATE employees
SET supervisor_id=5
WHERE job NOT IN ('manager','asst. manager');

UPDATE employees
SET supervisor_id=1
WHERE first_name="Sandy";

SELECT e1.employee_id, e1.first_name,e1.last_name,CONCAT(e2.first_name," ",e2.last_name) AS "reports to"
FROM employees AS e1 LEFT JOIN employees e2
ON e1.supervisor_id=e2.employee_id
ORDER BY employee_id;

SELECT *
FROM employees AS a INNER JOIN employees AS b
ON a.supervisor_id=b.employee_id;



SELECT *
FROM employees;