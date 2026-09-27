ALTER TABLE products
MODIFY price DECIMAL(4,2) NOT NULL;

DESCRIBE products;

#INSERT INTO products
#VALUES(104,"Cookie",NULL);
#Error: Column 'price' cannot be null

SELECT *
FROM products;