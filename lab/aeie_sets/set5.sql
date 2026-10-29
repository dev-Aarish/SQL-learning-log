-- 1. Create Flight table
CREATE TABLE Flight (
    flight_no VARCHAR(10) PRIMARY KEY,
    flight_name VARCHAR(50),
    start_airport VARCHAR(50)
);

-- 2. Create Seat table
CREATE TABLE Seat (
    seat_no VARCHAR(10),
    flight_no VARCHAR(10),
    type VARCHAR(20),
    price DECIMAL(10, 2),
    PRIMARY KEY (seat_no, flight_no),
    FOREIGN KEY (flight_no) REFERENCES Flight(flight_no)
);

-- 3. Create Schedule table
CREATE TABLE Schedule (
    flight_no VARCHAR(10),
    day_of_week VARCHAR(15),
    type VARCHAR(20),
    PRIMARY KEY (flight_no, day_of_week),
    FOREIGN KEY (flight_no) REFERENCES Flight(flight_no)
);

-- 4. Insert values into Flight
INSERT INTO Flight VALUES
('F101', 'ABC', 'ABC'),
('F102', 'PQR', 'PQR'),
('F103', 'Global Air', 'ABC'),
('F104', 'Sky Connect', 'XYZ'),
('F105', 'Business Flyer', 'PQR');

-- 5. Insert values into Seat
INSERT INTO Seat VALUES
('S01', 'F101', 'economy', 3500),
('S02', 'F101', 'business', 5500),
('S03', 'F102', 'economy', 4000),
('S04', 'F102', 'business', 6500),
('S05', 'F102', 'first', 9000),
('S06', 'F103', 'business', 5800),
('S07', 'F104', 'economy', 3000),
('S08', 'F104', 'business', 5200),
('S09', 'F105', 'business', 7000);

-- 6. Insert values into Schedule
INSERT INTO Schedule VALUES
('F101', 'Monday', 'Regular'),
('F101', 'Saturday', 'Regular'),
('F101', 'Sunday', 'Regular'),
('F102', 'Tuesday', 'Regular'),
('F103', 'Saturday', 'Regular'),
('F103', 'Sunday', 'Regular'),
('F104', 'Saturday', 'Regular'),
('F105', 'Sunday', 'Regular');

-- (i) Find all the flight names starting from station “ABC”

SELECT flight_name
FROM flight
WHERE start_airport='ABC';

-- (ii) List the price and type of all seats of “PQR” flight

SELECT price, type
FROM seat s JOIN flight f
ON s.flight_no=f.flight_no
WHERE f.flight_name='PQR';

-- (iii) List the flight number and price of all “business” 
-- (type) seats with price below Rs 6000

SELECT flight_no, price
FROM seat
WHERE type='business'
AND price<6000;

-- (iv) Find all those flight names which are scheduled to run on 
-- Saturdays and Sundays.

SELECT flight_name
FROM flight f JOIN schedule s
ON f.flight_no=s.flight_no
WHERE day_of_week IN ('Saturday','Sunday')
GROUP BY f.flight_no, f.flight_name
HAVING COUNT(DISTINCT s.day_of_week)=2;