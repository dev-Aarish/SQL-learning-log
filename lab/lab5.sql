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