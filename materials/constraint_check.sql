ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay>=10.00);

INSERT INTO employees
VALUES(6,"Sheldon","Plankton",5.00,"2023-01-07");
#MySQL Error (3819): Check constraint 'chk_hourly_pay' is violated.

#To drop a check
ALTER TABLE employees
DROP CHECK chk_hourly_pay;

SELECT * 
FROM employees;