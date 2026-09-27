#Primary key constraint implies UNIQUE and NOT NULL on a
#particular column.
#Note: this can be only added to a single column or a
#group of columns in a table.

CREATE TABLE transactions(
    transaction_id INT PRIMARY KEY,
    amount DECIMAL(5,2)
);

#To add a PRIMARY KEY constraint to an existing table
#ALTER TABLE transactions
#ADD CONSTRAINT 
#PRIMARY KEY(transaction_id);

ALTER TABLE transactions
ADD CONSTRAINT 
PRIMARY KEY(amount);
#MySQL Error (1068): Multiple primary key defined

INSERT INTO transactions
VALUES
(1000,4.99);

INSERT INTO transactions
VALUES
(1001,2.89);

INSERT INTO transactions
VALUES
(1001,3.38);
#MySQL Error (1062): Duplicate entry '1001' for key 'transactions.PRIMARY'

INSERT INTO transactions
VALUES
(1002,3.38);

INSERT INTO transactions
VALUES
(NULL,3.89);
#MySQL Error (1048): Column 'transaction_id' cannot be null

INSERT INTO transactions
VALUES
(1003,3.89);

SELECT amount 
FROM transactions
WHERE transaction_id=1003;

SELECT *
FROM transactions;