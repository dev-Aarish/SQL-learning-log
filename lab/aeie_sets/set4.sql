-- 1. Create DEPT table
CREATE TABLE DEPT (
    DCODE VARCHAR(10) PRIMARY KEY,
    DNAME VARCHAR(50)
);

-- 2. Create EMP table
CREATE TABLE EMP (
    ECODE VARCHAR(10) PRIMARY KEY,
    ENAME VARCHAR(50),
    BASIC DECIMAL(10, 2),
    DCODE VARCHAR(10),
    DT_JN DATE,
    FOREIGN KEY (DCODE) REFERENCES DEPT(DCODE)
);

-- 3. Insert values into DEPT
INSERT INTO DEPT VALUES
('D01', 'ABC'),
('D02', 'PQR'),
('D03', 'XYZ'),
('D04', 'LMN');

-- 4. Insert values into EMP
INSERT INTO EMP VALUES
('E101', 'Amit', 12000, 'D01', '1998-05-10'),
('E102', 'Riya', 15000, 'D02', '2001-03-15'),
('E103', 'Rahul', 10000, 'D01', '1999-07-20'),
('E104', 'Sneha', 18000, 'D02', '2003-02-12'),
('E105', 'Karan', 14000, 'D03', '2005-08-01'),
('E106', 'Priya', 11000, 'D02', '1997-01-05'),
('E107', 'Arjun', 20000, 'D03', '2002-11-11');

-- (i) For each department, show DNAME and total basic 
-- of the employees in the department.

SELECT dname, COALESCE(SUM(basic),0) AS total_basic
FROM dept d LEFT JOIN emp e
ON d.dcode=e.dcode
GROUP BY d.dcode,d.dname;

-- (ii) Find out the name of the departments where no 
-- person is working.

SELECT dname
FROM dept d LEFT JOIN emp e
ON d.dcode=e.dcode
WHERE e.ecode IS NULL;

-- (iii) Find out the name of the employees who are working in the 
-- department named as “PQR”.

SELECT ename
FROM emp 
WHERE dcode=(
    SELECT dcode
    FROM dept
    WHERE dname='PQR'
);

-- (iv) Find out the maximum basic among the employees who has joined 
-- after the year2000.

SELECT MAX(basic)
FROM emp
WHERE YEAR(dt_jn)>2000;
#or alternative: EXTRACT(YEAR FROM dt_jn)>2000
