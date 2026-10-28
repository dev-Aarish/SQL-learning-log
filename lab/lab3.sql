-- 21. List all products which are made of 'Oak' or which has qtyonhand>2(without using OR/AND clause)
SELECT *
FROM product
WHERE productfinish='Oak'
UNION
SELECT *
FROM product
WHERE qtyonhand>2;

-- 22. List all the products which are not made of 'Oak' or 'Walnut'
SELECT *
FROM product
WHERE productfinish NOT IN ('Oak','Walnut');

SELECT *
FROM product
WHERE productfinish<>'Oak'
INTERSECT
SELECT *
FROM product
WHERE productfinish<>'Walnut';

-- 23. Find the product(s) with the second highest unitprice
SELECT *
FROM product
WHERE unitprice=(
    SELECT unitprice
    FROM product
    ORDER BY unitprice DESC
    LIMIT 1,1
);
#syntax for limit is LIMIT offset, rowcount

SELECT *
FROM product
WHERE unitprice=(
    SELECT MAX(unitprice)
    FROM product
    WHERE unitprice<(
        SELECT MAX(unitprice)
        FROM product
    )
);

-- 24. Find the most expensive products in each finish
SELECT *
FROM product
WHERE unitprice IN(
    SELECT MAX(unitprice)
    FROM product
    GROUP BY productfinish
);
#Mistake was: I was trying to check for unitprice(which can be duplicate),
#what I was not checking for was the productfinish

SELECT *
FROM product AS p1
WHERE p1.unitprice=(
    SELECT MAX(unitprice)
    FROM product AS p2
    WHERE p1.productfinish=p2.productfinish
);

-- 25. Find products having the same finish as the most expensive product
SELECT *
FROM product
WHERE productfinish=(
    SELECT productfinish
    FROM product
    WHERE unitprice=(
        SELECT MAX(unitprice)
        FROM product
    )
);

SELECT *
FROM product
WHERE productfinish=(
    SELECT productfinish
    FROM product
    ORDER BY unitprice DESC
    LIMIT 1
);

-- 26. Find the finish having the highest average unitprice

SELECT productfinish, AVG(unitprice) AS avg_price
FROM product
GROUP BY productfinish
ORDER BY avg_price DESC
LIMIT 1;

SELECT productfinish, AVG(unitprice) AS max_avg_price
FROM product
GROUP BY productfinish
HAVING AVG(unitprice) =(
    SELECT MAX(avg_price)
    FROM (
        SELECT AVG(unitprice) AS avg_price
        FROM product
        GROUP BY productfinish
    ) AS temp    
);

SELECT productfinish, AVG(unitprice) AS max_avg_price
FROM product
GROUP BY productfinish
HAVING AVG(unitprice)>=ALL(
    SELECT AVG(unitprice)
    FROM product
    GROUP BY productfinish
);

-- 27. Find the finish which has the maximum number of products
SELECT productfinish, COUNT(*) AS total_products
FROM product
GROUP BY productfinish
ORDER BY total_products DESC
LIMIT 1;

SELECT productfinish, COUNT(*) AS total_products
FROM product
GROUP BY productfinish
HAVING COUNT(*)>= ALL(
    SELECT COUNT(*)
    FROM product
    GROUP BY productfinish
);
#note: >=ALL == MAX

-- 28. Find the finish with the lowest total inventory value
SELECT productfinish, SUM(qtyonhand*unitprice) AS inventory_value
FROM product
GROUP BY productfinish
ORDER BY inventory_value
LIMIT 1;

SELECT productfinish, SUM(unitprice*qtyonhand) as inventory_value
FROM product
GROUP BY productfinish
HAVING inventory_value<=ALL(
    SELECT SUM(unitprice*qtyonhand)
    FROM product
    GROUP BY productfinish
);

-- 29. Find products whose finish has more than two products
SELECT *
FROM product
WHERE productfinish IN(
    SELECT productfinish
    FROM product
    GROUP BY productfinish
    HAVING COUNT(*)>2
);

-- 30. Find products whose price is above the average price of their finish
SELECT *
FROM product AS p1
WHERE p1.unitprice>(
    SELECT AVG(unitprice)
    FROM product AS p2
    WHERE p1.productfinish=p2.productfinish
);

-- 31. Find products that have the minimum price among products with quantity greater than zero
SELECT *
FROM product
WHERE unitprice=(
    SELECT MIN(unitprice)
    FROM product
    WHERE qtyonhand>0
);

SELECT *
FROM product
WHERE unitprice=(
  SELECT unitprice
  FROM product
  WHERE qtyonhand > 0
  ORDER BY unitprice
  LIMIT 1
);
#note: in the above query, you can't use IN instead of =