-- 1. Create Suppliers table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50),
    address VARCHAR(50)
);

-- 2. Create Parts table
CREATE TABLE Parts (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(50),
    color VARCHAR(20)
);

-- 3. Create Catalog table
CREATE TABLE Catalog (
    supplier_id INT,
    part_id INT,
    cost DECIMAL(10, 2),
    PRIMARY KEY (supplier_id, part_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (part_id) REFERENCES Parts(part_id)
);

-- 4. Insert values into Suppliers
INSERT INTO Suppliers VALUES
(1, 'Pipe Supplier', 'Mumbai'),
(2, 'ABC Suppliers', 'Delhi'),
(3, 'XYZ Industries', 'Kolkata'),
(4, 'Global Parts', 'Chennai'),
(5, 'Metal Works', 'Pune');

-- 5. Insert values into Parts
INSERT INTO Parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Pipe', 'Red'),
(104, 'Screw', 'Green'),
(105, 'Valve', 'Red');

-- 6. Insert values into Catalog
INSERT INTO Catalog VALUES
(1, 101, 500),
(1, 102, 300),
(1, 103, 1200),
(1, 104, 400),
(1, 105, 1500),
(2, 101, 550),
(2, 103, 1100),
(2, 105, 1400),
(3, 101, 450),
(3, 102, 350),
(3, 104, 500),
(4, 102, 320),
(4, 103, 1250),
(5, 101, 480),
(5, 102, 310),
(5, 103, 1150),
(5, 104, 450),
(5, 105, 1450);


-- (i) Find the names of suppliers who supply some red part.

SELECT DISTINCT s.supplier_name
FROM suppliers s
JOIN catalog c ON c.supplier_id=s.supplier_id
JOIN parts p ON p.part_id=c.part_id
WHERE p.color='Red';

-- (ii) Find the supplier_ids of suppliers who supply every part.

SELECT supplier_id
FROM catalog c
WHERE NOT EXISTS(
    SELECT part_id
    FROM parts
    EXCEPT
    SELECT c2.part_id
    FROM catalog c2
    WHERE c2.supplier_id=c.supplier_id
)
GROUP BY supplier_id;

SELECT c.supplier_id
FROM catalog c
GROUP BY c.supplier_id
HAVING COUNT(DISTINCT c.part_id)=(
    SELECT COUNT(*)
    FROM parts
);

-- (iii) Find the part_ids of the most expensive parts supplied by 
-- suppliers named “Pipe Supplier”.

SELECT c.part_id
FROM catalog c
WHERE c.supplier_id=(
    SELECT supplier_id
    FROM suppliers
    WHERE supplier_name='Pipe Supplier'
)
AND cost=(
    SELECT MAX(cost)
    FROM catalog
    WHERE supplier_id=(
        SELECT supplier_id
        FROM suppliers
        WHERE supplier_name='Pipe Supplier'
    )
);

SELECT c.part_id
FROM catalog c
JOIN suppliers s ON s.supplier_id=c.supplier_id
WHERE s.supplier_name='Pipe Supplier'
ORDER BY c.cost DESC
LIMIT 1;