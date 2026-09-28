#GRP1
-- 36. List all product descriptions ordered in orderno1 
SELECT productdesc 
FROM requests AS r, product AS p 
WHERE r.orderno=1 AND r.productno=p.productno; 

SELECT productdesc 
FROM product 
WHERE productno IN( 
    SELECT productno 
    FROM requests 
    WHERE orderno=1 
); 

SELECT productdesc
FROM product AS p INNER JOIN requests AS r 
ON p.productno=r.productno WHERE r.orderno=1;

SELECT productdesc
FROM product AS p
WHERE EXISTS(
    SELECT *
    FROM requests AS r
    WHERE r.productno=p.productno AND r.orderno=1
);
#Note: While using EXISTS, you need to explicitly set a relation,
#else EXISTS won't check the condition, and simply execute the
#entire outer query

-- 37. List every requests where quantity ordered is more than the average quantity ordered for the product 
SELECT * 
FROM requests AS r1 
WHERE quantity>( 
    SELECT AVG(quantity) 
    FROM requests AS r2 
    WHERE r1.productno=r2.productno
);

SELECT r1.productno,orderno,quantity
FROM requests AS r1 INNER JOIN(
    SELECT productno, AVG(quantity) AS avg_qty
    FROM requests
    GROUP BY productno
) AS temp
ON r1.productno=temp.productno
WHERE r1.quantity>avg_qty;

-- 38. List the names of all customers who have placed an order
SELECT c.customerid,customername
FROM customer AS c, orders AS o
WHERE c.customerid=o.customerid;

SELECT c.customerid, customername
FROM customer AS c INNER JOIN orders AS o
ON c.customerid=o.customerid;

SELECT customerid, customername
FROM customer
WHERE customerid IN(
    SELECT customerid
    FROM orders
);

#GRP2
-- 37. List the names of customers who have not placed an order
SELECT customername
FROM customer AS c LEFT JOIN orders AS o
ON c.customerid=o.customerid
WHERE o.customerid IS NULL;

SELECT customername
FROM customer
WHERE customerid NOT IN(
    SELECT customerid
    FROM orders
);

SELECT *
FROM customer AS c
WHERE NOT EXISTS(
    SELECT customerid
    FROM orders AS o
    WHERE o.customerid=c.customerid
);

-- 38. List all product descriptions ordered in orderno 1 and orderno 2
SELECT *
FROM product AS p
WHERE productno IN(
    SELECT productno
    FROM requests
    WHERE orderno IN(1,2)
);

SELECT productdesc
FROM product AS p
WHERE EXISTS(
    SELECT *
    FROM requests AS r
    WHERE r.orderno IN(1,2) AND r.productno=p.productno
);

SELECT productdesc
FROM product AS p INNER JOIN requests AS r
ON p.productno=r.productno
WHERE r.orderno IN(1,2);

SELECT productdesc
FROM product AS p, requests AS r
WHERE p.productno=r.productno AND orderno IN(1,2);