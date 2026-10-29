-- 1. Create Train table
CREATE TABLE Train (
    train_no INT PRIMARY KEY,
    train_name VARCHAR(50),
    start_station VARCHAR(50),
    destination VARCHAR(50)
);

-- 2. Create Berth_Seat table
CREATE TABLE Berth_Seat (
    SeatNo INT PRIMARY KEY,
    train_no INT,
    coach_type VARCHAR(10),
    price_perKm DECIMAL(5, 2),
    FOREIGN KEY (train_no) REFERENCES Train(train_no)
);

-- 3. Insert values into Train
INSERT INTO Train VALUES
(101, 'Kolkata Express', 'Kolkata', 'Delhi'),
(102, 'Howrah Rajdhani', 'Howrah', 'Delhi'),
(103, 'Howrah Duronto', 'Howrah', 'Mumbai'),
(104, 'Kolkata Delhi Mail', 'Kolkata', 'Delhi'),
(105, 'Mumbai Express', 'Mumbai', 'Delhi');

-- 4. Insert values into Berth_Seat
INSERT INTO Berth_Seat VALUES
(1, 101, 'SL', 0.80),
(2, 101, '3AC', 1.20),
(3, 102, 'SL', 0.90),
(4, 102, '3AC', 1.50),
(5, 102, '2AC', 2.00),
(6, 103, 'SL', 0.85),
(7, 103, '3AC', 1.70),
(8, 104, 'SL', 0.95),
(9, 104, '3AC', 1.30),
(10, 105, '3AC', 1.60);

-- i) List all the train names starting from source station “Kolkata.

SELECT train_name
FROM train
WHERE start_station='Kolkata';

-- ii) List the train number and price of a seat under “SL” type 
-- of coach for those train originating from “Howrah” Station 
-- and terminating at “Delhi”.

SELECT b.train_no, price_perKm
FROM berth_seat b
JOIN train t ON b.train_no=t.train_no
WHERE t.start_station='Howrah' 
AND destination='Delhi'
AND b.coach_type='SL';

-- iii) Display the train name whose price/km under “3AC” type of 
-- coach is maximum.

SELECT train_name
FROM train t 
JOIN berth_seat b ON t.train_no=b.train_no
WHERE b.price_perKm=(
    SELECT MAX(price_perKm)
    FROM berth_seat
    WHERE coach_type='3AC'
);
