CREATE TABLE customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO customers (first_name,last_name)
VALUES
("Fred","Fish"),
("Larry","Lobster"),
("Bubble","Bass");

DROP TABLE transactions;

CREATE TABLE transactions(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
#Main objective fo using a FOREIGN KEY constraint is to set up
#relationship or connection between two tables

#To drop a FOREIGN KEY
ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;

#To give a particular name to a FOREIGN KEY
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

ALTER TABLE transactions
AUTO_INCREMENT=1000;

INSERT INTO transactions (amount,customer_id)
VALUES
(4.99,3),
(2.89,2),
(3.38,3),
(4.99,1);

DELETE FROM customers
WHERE customer_id=3;
#MySQL Error (1451): Cannot delete or update a parent row: a foreign key constraint fails 
#(`mydb`.`transactions`, CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) 
#REFERENCES `customers` (`customer_id`))

SELECT *
FROM transactions;

SELECT *
FROM customers;