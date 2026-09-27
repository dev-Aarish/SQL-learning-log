#LIMIT clause is used to limit the number of records.
#Useful if you're working with a lot of data.
#Can be used to display a large data on pages(pagination).

SELECT *
FROM customers;

SELECT *
FROM customers
ORDER BY first_name
LIMIT 2;

#We can add offset to the limit clause as well
SELECT *
FROM customers
LIMIT 2,1;
#2 is the offset here