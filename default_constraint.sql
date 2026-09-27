INSERT INTO products
VALUES
(104,"Straw",0.00),
(105,"Napkin",0.00),
(106,"Fork",0.00),
(107,"Spoon",0.00);

DELETE FROM products
WHERE price=0.00;

#To add a deafult constraint while making a new TABLE
#   price DECIMAL(4,2) DEFAULT 0

#To modify an existing table, we can use
ALTER TABLE products
ALTER price SET DEFAULT 0;

INSERT INTO products (product_id, product_name)
VALUES
(104,"Straw"),
(105,"Napkin"),
(106,"Fork"),
(107,"Spoon");
#Note: even through we have defined price as default, we still
#need to mention the column names while inserting rows, else
#error of less columns would appear.

SELECT *
FROM products;

CREATE TABLE transactions(
    transaction_id INT,
    amount DECIMAL(5,2),
    transaction_date DATETIME DEFAULT NOW()
);

ALTER TABLE transactions
RENAME COLUMN transaction_date TO transaction_datetime;

INSERT INTO transactions(transaction_id, amount)
VALUES(1,4.99);

DROP TABLE transactions;

SELECT *
FROM transactions;