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
#Sir's way of doing it apparently