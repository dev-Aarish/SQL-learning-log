-- 57. Products which has not been ordered

SELECT p.*
FROM product p LEFT JOIN requests r
ON p.productno=r.productno
WHERE orderno IS NULL;

-- 58. Customers who have not ordered

SELECT c.*
FROM customer c LEFT JOIN orders o
ON c.customerid=o.customerid
WHERE orderno IS NULL;

-- 59. Product whose price is more than the price of any other product

SELECT p1.*
FROM product p1 LEFT JOIN product p2
ON p1.unitprice<p2.unitprice
WHERE p2.productno IS NULL;

-- 60. Product whose price is less than the price of any other product 
-- with different productfinish

SELECT p1.*
FROM product p1 LEFT JOIN product p2
ON p1.unitprice>p2.unitprice AND p1.productfinish<>p2.productfinish
WHERE p2.productfinish IS NULL;

-- 61. Customers who live in the same city as some other customer

SELECT *
FROM customer c1 LEFT JOIN customer c2
ON c1.ccity=c2.ccity
WHERE c1.customerid<>c2.customerid;