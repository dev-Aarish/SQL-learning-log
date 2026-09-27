-- 11. List all the distinct Bookcases
SELECT DISTINCT *
FROM product
WHERE productdesc LIKE '%Bookcase%';

-- 12. List the products if they are increased by 10%
SELECT productdesc, unitprice, unitprice*1.1 AS inc_unitprice
FROM product;

-- 13. How many products are there
SELECT COUNT(*) AS "total products"
FROM product;

-- 14. For every productfinish, find out the total quantity of products
SELECT productfinish, SUM(qtyonhand) AS "total quantity"
FROM product
GROUP BY productfinish;

-- 15. List every productfinish having unit price > 200 and whose average of qtyonhand greater than 3

SELECT productfinish
FROM product
WHERE unitprice>200.00
GROUP BY productfinish
HAVING AVG(qtyonhand)>3;
#the above query searches only among the query whose unitprice>200
#the query below looks over the entire productfinish and checks both
#the conditions for it
SELECT productfinish
FROM product
GROUP BY productfinish
HAVING AVG(qtyonhand)>3 AND MIN(unitprice)>200;

-- 16. List product names having maximum quantity on hand
SELECT productdesc
FROM product
GROUP BY productdesc
HAVING MAX(qtyonhand)
LIMIT 1;

SELECT *
FROM product
WHERE qtyonhand=(
    SELECT MAX(qtyonhand)
    FROM product
);

SELECT *
FROM product
ORDER BY qtyonhand DESC
LIMIT 1;

-- 17. Find out value of inventory for every productfinish
SELECT productfinish, SUM(qtyonhand*unitprice) AS inventory
FROM product
GROUP BY productfinish;
#Note: After group by the original rows are still intact,
#and data can be used from them. Also agg. func. works before displaying
#all the values

-- 18. List all products whose unitprice is same as some made of 'Oak'
SELECT *
FROM product
WHERE unitprice IN (
    SELECT unitprice
    FROM product
    WHERE productfinish='Oak'
);
#Note: We can't return more than 1 row from a subquery to the main query

SELECT *
FROM product
WHERE unitprice IN (
    SELECT unitprice
    FROM product
    WHERE productfinish='Oak'
)
AND productfinish<>'Oak';

-- 19. List product name(s) having qtyonhand more than the average qtyonhand of products
SELECT productdesc
FROM product
WHERE qtyonhand>(
    SELECT AVG(qtyonhand)
    FROM product
);

-- 20. List products whose unitprice is greater than every unitprice of different productfinish
SELECT *
FROM product AS p1
WHERE p1.unitprice> ALL(
    SELECT unitprice
    FROM product AS p2
    WHERE p1.productfinish<>p2.productfinish
);

SELECT *
FROM product AS p1
WHERE p1.unitprice> ALL(
    SELECT MAX(unitprice)
    FROM product AS p2
    WHERE p1.productfinish<>p2.productfinish
    GROUP BY p2.productfinish
);

SELECT *
FROM product;