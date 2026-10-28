-- 47. Find customers who ordered all products of Oak finish.

SELECT customername
FROM customer c, orders o, requests r
WHERE c.customerid=o.customerid AND r.orderno=o.orderno
EXCEPT
SELECT DISTINCT customername
FROM customer c, orders o, requests r, product p
WHERE c.customerid=o.customerid AND r.orderno=o.orderno AND r.productno=p.productno AND p.productfinish<>'Oak';
#This is not soln of the above ques, this finds a customer who have ordered all products made of oak
#not all oak products

SELECT c.customerid, c.customername
FROM customer c
WHERE NOT EXISTS(
    SELECT p.productno
    FROM product p
    WHERE p.productfinish='Oak'
    EXCEPT
    SELECT r.productno
    FROM orders o, requests r
    WHERE o.orderno=r.orderno AND o.customerid=c.customerid
);

-- 48.Find products whose total ordered quantity is greater than the
-- average quantity ordered per product.

SELECT p.productno, productdesc, SUM(r.quantity) AS total_qty_ordered, AVG(r.quantity) AS avg_qty_ordered
FROM product p JOIN requests r
ON p.productno=r.productno
GROUP BY p.productno, productdesc
HAVING total_qty_ordered>AVG(r.quantity);

SELECT p.productno, productdesc, SUM(r.quantity) AS total_qty_ordered, AVG(r.quantity) AS avg_qty_ordered
FROM product p, requests r
WHERE p.productno=r.productno
GROUP BY p.productno, productdesc
HAVING total_qty_ordered>AVG(r.quantity);

-- SELECT productno
-- FROM requests
-- GROUP BY productno
-- HAVING SUM(quantity)>(
--     SELECT SUM(AVG(quantity))
--     FROM requests
--     GROUP BY productno
-- );

-- 49.Find the customer who has ordered the largest total quantity.

-- SELECT customername
-- FROM customer
-- WHERE customerid=(
--     SELECT customerid
--     FROM orders
--     WHERE orderno=(
--         SELECT orderno
--         FROM (
--             SELECT orderno, SUM(quantity) AS total_qty_per_order
--             FROM requests
--             GROUP BY orderno
--             ORDER BY total_qty_per_order DESC
--             LIMIT 1
--         ) AS temp
--     )
-- );

SELECT c.customername
FROM customer c 
INNER JOIN orders as o
    ON o.customerid=c.customerid
INNER JOIN requests AS r
    ON r.orderno=o.orderno
GROUP BY c.customername
HAVING SUM(r.quantity)>=ALL(
    SELECT SUM(r2.quantity)
    FROM requests as r2
    GROUP BY r.orderno
);


#do 49

-- 50.Find products that were ordered by more than one customer.