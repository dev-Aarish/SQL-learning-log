-- 39. List the products which are ordered by customer named "Contemporary Casuals"
SELECT *
FROM product
WHERE productno IN(
    SELECT productno
    FROM requests
    WHERE orderno=(
        SELECT orderno
        FROM orders
        WHERE customerid=(
            SELECT customerid
            FROM customer
            WHERE customername="Contemporary Casuals"
        )
    )
);

SELECT p.productno, productdesc, productfinish, unitprice, qtyonhand
FROM product AS p, orders AS o, requests AS r, customer AS c
WHERE c.customername='Contemporary Casuals' AND o.customerid=c.customerid AND r.orderno=o.orderno AND p.productno=r.productno;

SELECT p.*
FROM customer AS c
JOIN orders AS o
    ON o.customerid=c.customerid
JOIN requests AS r
    ON r.orderno=o.orderno
JOIN product AS p
    ON p.productno=r.productno
WHERE c.customername='Contemporary Casuals';
#Note: By default JOIN means INNER JOIN

-- 40. List order dates for every order made by Customer "Value Furniture"
SELECT orderdate
FROM orders AS o, customer AS c
WHERE c.customername='Value Furniture' AND o.customerid=c.customerid;

SELECT orderdate
FROM orders AS o JOIN customer AS c
ON o.customerid=c.customerid
WHERE c.customername='Value Furniture';

SELECT orderdate
FROM orders AS o
WHERE customerid=(
    SELECT customerid
    FROM customer
    WHERE customername='Value Furniture'
);

SELECT orderdate
FROM orders AS o
WHERE EXISTS(
    SELECT *
    FROM customer AS c
    WHERE c.customerid=o.customerid AND c.customername='Value Furniture'
);

-- 41. List every order which includes a request for a product made of "Oak"
SELECT o.*
FROM orders AS o
WHERE o.orderno IN(
    SELECT r.orderno
    FROM requests AS r
    WHERE r.productno IN (
        SELECT productno
        FROM product
        WHERE productfinish='Oak'
    )
);

SELECT DISTINCT o.*
FROM orders AS o, requests AS r, product AS p
WHERE p.productfinish='Oak' AND r.productno=p.productno AND o.orderno=r.orderno;

SELECT *
FROM orders AS o
WHERE EXISTS(
    SELECT *
    FROM requests AS r
    WHERE r.orderno=o.orderno AND r.productno IN(
        SELECT productno
        FROM product
        WHERE productfinish='Oak'
    )
);

SELECT DISTINCT o.*
FROM orders AS o
JOIN requests AS r
    ON r.orderno=o.orderno
JOIN product AS p
    ON p.productno=r.productno
WHERE productfinish='Oak';
#DISTINCT is needed because an order can contain multiple products of Oak
#which would lead to satisfying the condition that many times.

-- 42. List every order which includes request only for products made of "Oak"

SELECT orderno
FROM requests
EXCEPT
SELECT DISTINCT orderno
FROM requests AS r, product AS p
WHERE r.productno=p.productno AND p.productfinish<>'Oak';

SELECT DISTINCT o.*
FROM orders AS o, requests AS r1
WHERE o.orderno=r1.orderno
AND NOT EXISTS(
    SELECT *
    FROM requests AS r2, product AS p
    WHERE r2.orderno=o.orderno
    AND r2.productno=p.productno
    AND p.productfinish<>'Oak'
);
#Sir's way of doing it

-- 43. List the total quantity ordered for every product finish

SELECT productfinish, SUM(r.quantity) AS total_qty_ordered
FROM product p, requests r
WHERE p.productno=r.productno
GROUP BY productfinish
UNION
SELECT DISTINCT productfinish, 0 AS total_qty_ordered
FROM product
WHERE productfinish NOT IN(
    SELECT DISTINCT p2.productfinish
    FROM product p2, requests r2
    WHERE p2.productno=r2.productno
);

SELECT productfinish, COALESCE(SUM(r.quantity),0) as total_qty_ordered
FROM product as p LEFT JOIN requests as r
ON r.productno=p.productno
GROUP BY productfinish;

-- 44. List quantity on hand and quantity ordered for every product
SELECT p.productno, productdesc, qtyonhand, COALESCE(SUM(r.quantity),0) AS qty_ordered
FROM product p
LEFT JOIN requests r
ON p.productno=r.productno
GROUP BY p.productno, productdesc, qtyonhand;

SELECT p.productno,productdesc, qtyonhand, SUM(r.quantity) AS qty_ordered
FROM product p, requests r
WHERE p.productno=r.productno
GROUP BY p.productno, p.productdesc, p.qtyonhand
UNION
SELECT p1.productno, productdesc, qtyonhand, 0 AS qty_ordered
FROM product p1, requests
WHERE p1.productno NOT IN(
    SELECT DISTINCT productno
    FROM requests
);

-- 45. List the product nos along with total ordered quantity for those products whose 
-- total ordered quantity is more than qty on hand.

SELECT p.productno, productdesc, qtyonhand, SUM(r.quantity) AS total_qty_ordered
FROM product p INNER JOIN requests r
ON p.productno=r.productno
GROUP BY p.productno, productdesc, qtyonhand
HAVING total_qty_ordered>qtyonhand;

SELECT p.productno, qtyonhand, SUM(r.quantity) AS total_qty_ordered
FROM product p, requests r
WHERE p.productno=r.productno
GROUP BY p.productno, qtyonhand
HAVING total_qty_ordered>qtyonhand;

-- 46. List the product nos along with total ordered quantity and qty on
-- hand for those products whose total ordered quantity is more than qty on hand.

#same as above(I've actually included qtyonhand as well)