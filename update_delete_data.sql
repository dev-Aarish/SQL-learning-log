#Updating a row in the present table
UPDATE employees
SET hourly_pay = 10.25
WHERE employee_id=6;
#Note: Don't forget to put the WHERE clause, else all the values would be
#set to 10.25 in the hourly_pay column.

#We can update mroe than 1 column in the present table
UPDATE employees
SET hourly_pay=10.50,
    hire_date="2023-01-07"
WHERE first_name="Sheldon";

#Note: to delete an entire table, you can simply run:
#DELETE FROM employees; 
#All the rows will be deleted, cuz no where clause or any other specifications
#are mentioned.

DELETE FROM employees
WHERE employee_id=6;

SELECT *
FROM employees;