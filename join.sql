#JOIN is used to combine rows from 2 or more table
#on a column such as FOREIGN KEY    
INSERT INTO transactions(amount,customer_id)
VALUES(1.00,NULL);

INSERT INTO customers(first_name,last_name)
VALUES("Poppy","Puff");

#JOIN type: 1. INNER JOIN 2. LEFT JOIN 3. RIGHT JOIN

#Making a simple inner join of the tables transactions and customers
SELECT *
FROM transactions INNER JOIN customers
ON transactions.customer_id=customers.customer_id;
#Note: the sequence you write the join statement, the output will be
#of the same sequence(tables) and,
#the rows of the second column would change according to the FOREIGN KEY
#values present in the left table(may repeat as well)

SELECT transaction_id,amount,first_name,last_name
FROM transactions INNER JOIN customers
ON transactions.customer_id=customers.customer_id;

#In LEFT and RIGHT JOIN, the table(left or right) would be shown
#entirely, doesn't matter the opposite column can show data based 
#on the FOREIGN KEY.

SELECT *
FROM transactions LEFT JOIN customers
ON transactions.customer_id=customers.customer_id;
#shows the entire left table(transactions in this case)

SELECT *
FROM transactions RIGHT JOIN customers
ON transactions.customer_id=customers.customer_id;
#shows the missing Poppy in the very last row, after the joined 
#rows are gone.

SELECT *
FROM transactions;

SELECT *
FROM customers;