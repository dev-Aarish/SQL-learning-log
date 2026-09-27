CREATE TABLE products(
    product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4,2)
);

#If needed to add a constraint after a table has been created,
#ALTER TABLE products
#ADD CONSTRAINT 
#UNIQUE(product_name);

INSERT INTO products
VALUES
(100,"Hamburger",3.99),
(101,"Fries",1.89),
(102,"Soda",1.00),
(103,"Ice Cream",1.49);
#Note: since we applied unique constraint on the product_name,
#if we try to add 2 or more products with same name, the following error will be thrown:
#Duplicate entry 'Fries' for key 'products.product_name'

SELECT *
FROM products;