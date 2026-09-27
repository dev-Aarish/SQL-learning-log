-- 1. List all products
SELECT *
FROM product;

-- 2. List all product names and prices(unitprice)
SELECT productdesc,unitprice
FROM product;

-- 3. List all product names whose product prices > Rs.200
SELECT productdesc
FROM product
WHERE unitprice>200.00;

-- 4. List all product names whose product prices > Rs.200 and qty_on_hand >5
SELECT productdesc
FROM product
WHERE unitprice>200.00 AND qtyonhand>5;

-- 5. List all product names whose product prices > Rs.200 and qty_on_hand between 1 and 5
SELECT *
FROM product
WHERE unitprice>200.00 AND qtyonhand BETWEEN 1 AND 5;

-- 6. List all products with finish='Oak'
SELECT *
FROM product
WHERE productfinish='Oak';

-- 7. List all products with finish='Oak' or 'Walnut'
SELECT *
FROM product 
WHERE productfinish IN ('Oak','Walnut');

-- 8. List all products with finish='Oak' or unitprice>=300
SELECT *
FROM product
WHERE productfinish='Oak' OR unitprice>=300;

-- 9. List all product names and prices arranged by prices
SELECT productdesc, unitprice
FROM product
ORDER BY unitprice;

-- 10. List product names and prices whose finish is 'Oak' arranged by names in reverse order
SELECT productdesc
FROM product
WHERE productfinish='Oak'
ORDER BY productdesc DESC;