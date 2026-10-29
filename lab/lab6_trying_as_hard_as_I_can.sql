-- 47. Find customers who ordered all products of Oak finish.

SELECT c.customerid, c.customername
FROM customer c
WHERE NOT EXISTS(
    SELECT productno
    FROM product
    WHERE productfinish='Oak'
    EXCEPT
    SELECT r.productno
    FROM requests r, orders o
    WHERE r.orderno=o.orderno
    AND o.customerid=c.customerid
);

-- RANDOM AHH QUESTION. Find orders whose total ordered quantity is greater 
-- than the average quantity ordered per product

SELECT o.orderno, SUM(r.quantity) AS total_qty_ordered
FROM orders o NATURAL JOIN requests r
GROUP BY o.orderno
HAVING total_qty_ordered>=ALL(
    SELECT AVG(product_qty)
    FROM (
        SELECT SUM(r.quantity) AS product_qty
        FROM requests r
        GROUP BY productno
    ) AS temp
);

-- 48. Find products whose total ordered quantity is greater than the 
-- average quantity ordered per product

SELECT p.productno, p.productdesc, SUM(r.quantity) AS total_ordered_qty
FROM product p, requests r
WHERE p.productno=r.productno
GROUP BY p.productno, p.productdesc
HAVING total_ordered_qty>ALL(
    SELECT AVG(product_qty)
    FROM (
        SELECT SUM(r2.quantity) AS product_qty
        FROM requests r2
        GROUP BY r2.productno
    ) AS temp
);

-- 49. Find the customer who has ordered the largest total quantity

SELECT c.customerid, c.customername, SUM(r.quantity) AS total_ordered_qty
FROM orders o 
JOIN requests r
    ON o.orderno=r.orderno
JOIN customer c
    ON o.customerid=c.customerid
GROUP BY c.customerid, c.customername
HAVING total_ordered_qty>=ALL(
    SELECT SUM(r2.quantity)
    FROM orders o2 JOIN requests r2
    ON o2.orderno=r2.orderno
    GROUP BY o2.customerid
);

SELECT temp.customerid, temp.customername
FROM (
    SELECT c.customerid, c.customername, SUM(r.quantity) AS total_qty
    FROM customer c
    JOIN orders o
        ON c.customerid=o.customerid
    JOIN requests r
        ON r.orderno=o.orderno
    GROUP BY c.customerid, c.customername
    ORDER BY total_qty DESC
) AS temp
LIMIT 1;

SELECT c.customerid, customername
FROM customer c 
JOIN orders o ON c.customerid=o.customerid
JOIN requests r ON o.orderno=r.orderno
GROUP BY c.customerid, c.customername
ORDER BY SUM(r.quantity) DESC
LIMIT 1;

-- 50. Find products that were ordered by more than one customer

SELECT p.productno, p.productdesc
FROM product p
JOIN requests r ON r.productno=p.productno
JOIN orders o ON o.orderno=r.orderno
GROUP by p.productno, p.productdesc
HAVING COUNT(DISTINCT o.customerid)>1;

-- 51. Find customers who ordered more than two different products

SELECT c.customerid, c.customername
FROM customer c
JOIN orders o ON c.customerid=o.customerid
JOIN requests r ON r.orderno=o.orderno
GROUP BY c.customerid, c.customername
HAVING COUNT(DISTINCT r.productno)>2;

-- 52. Find product(s) with highest total order quantity

SELECT p.productno, productdesc, SUM(r.quantity) AS total_product_ordered
FROM product p
JOIN requests r ON p.productno=r.productno
GROUP BY r.productno, productdesc
HAVING total_product_ordered>=ALL(
    SELECT SUM(r2.quantity)
    FROM requests r2
    GROUP BY r2.productno
);

-- 53. Find customers who ordered more quantity than the average 
-- customer ordered

SELECT c.customerid, c.customername
FROM customer c
JOIN orders o ON o.customerid=c.customerid
JOIN requests r ON r.orderno=o.orderno
GROUP BY c.customerid, c.customername
HAVING SUM(r.quantity)>(
    SELECT AVG(total_ordered_per_cust)
    FROM (
        SELECT SUM(r2.quantity) AS total_ordered_per_cust
        FROM requests r2
        JOIN orders o2 ON r2.orderno=o2.orderno
        GROUP BY o2.customerid
    ) AS temp
);

-- 54. Find products that has been ordered in every order

SELECT p.productno, p.productdesc
FROM product p
JOIN requests r ON p.productno=r.productno
GROUP BY p.productno, p.productdesc
HAVING COUNT(DISTINCT r.orderno)=(
    SELECT COUNT(*)
    FROM orders
);

-- 55. Find customers who ordered exactly the same products as 
-- Contemporary Casuals

SELECT c1.customerid, c1.customername
FROM customer c1
WHERE NOT EXISTS(
    SELECT DISTINCT r2.productno
    FROM requests r2 JOIN orders o2
    ON r2.orderno=o2.orderno
    WHERE o2.customerid=(
        SELECT customerid
        FROM customer
        WHERE customername='Contemporary Casuals'
    )
    EXCEPT
    SELECT DISTINCT r3.productno
    FROM requests r3 JOIN orders o3
    ON o3.orderno=r3.orderno
    WHERE o3.customerid=c1.customerid
)
AND NOT EXISTS(
    SELECT DISTINCT r3.productno
    FROM requests r3 JOIN orders o3
    ON o3.orderno=r3.orderno
    WHERE o3.customerid=c1.customerid
    EXCEPT
    SELECT DISTINCT r2.productno
    FROM requests r2 JOIN orders o2
    ON r2.orderno=o2.orderno
    WHERE o2.customerid=(
        SELECT customerid
        FROM customer
        WHERE customername='Contemporary Casuals'
    )
)
AND c1.customername<>'Contemporary Casuals';

-- 56. Find customers who ordered both oak and birch products

SELECT c.customerid, c.customername
FROM customer c
JOIN orders o ON o.customerid=c.customerid
JOIN requests r ON o.orderno=r.orderno
JOIN product p ON p.productno=r.productno
WHERE p.productfinish IN ('Oak','Birch')
GROUP BY c.customerid, c.customername
HAVING COUNT(DISTINCT p.productfinish)=2;