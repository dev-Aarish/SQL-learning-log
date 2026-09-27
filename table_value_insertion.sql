SELECT *
FROM employees;

INSERT INTO employees
VALUES(1,"Eugene","Krabs",25.50,"2023-01-02");

#Inserting multiple rows into a table
INSERT INTO employees
VALUES
(2,"Squidword","Tentacles",15.00,"2023-01-03"),
(3,"Spongebob","Squarepants",12.50,"2023-01-04"),
(4,"Patrick","Star",12.50,"2023-01-05"),
(5,"Sandy","Cheeks",17.25,"2023-01-06");

#We'll try to insert a row with missing data
INSERT INTO employees
VALUES(6,"Sheldon","Plankton");
#The above gives an error of Column count doesn't match value count at row 1

#But if we mention the names of the column, and the others(which we are not entering values for)
#don't have NOT NULL in it, it would be okay, and the values would be inserted for those columns only
#and the others would remain empty(NULL).
INSERT INTO employees (employee_id,first_name,last_name)
VALUES(6,"Sheldon","Plankton");