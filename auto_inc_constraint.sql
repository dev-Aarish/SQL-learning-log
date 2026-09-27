DROP TABLE transactions;

CREATE TABLE transactions(
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5,2)
);
#AUTO_INCREMENT starts the first row value for that 
#particular column with 1, and it would increment 1 by 1

INSERT INTO transactions (amount)
VALUES(4.99);

INSERT INTO transactions (amount)
VALUES(2.89),(3.38),(4.99);

#We could set our primary key to begin at a particular 
#value.

ALTER TABLE transactions
AUTO_INCREMENT=1000;

DELETE FROM transactions;

INSERT INTO transactions (amount)
VALUES(2.89);

INSERT INTO transactions (amount)
VALUES(3.38),(4.99);

SELECT *
FROM transactions;