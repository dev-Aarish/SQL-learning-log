CREATE TABLE CUSTOMER (
customerid INT PRIMARY KEY,
customername VARCHAR(150) NOT NULL,
ccity VARCHAR(100),
cstate VARCHAR(50),
caddress VARCHAR(255),
czip VARCHAR(20)
);
ALTER TABLE CUSTOMER
ADD CONSTRAINT chk_customer_czip_range
CHECK (czip BETWEEN 100000 AND 999999);

INSERT INTO CUSTOMER (customerid, customername, caddress, ccity, cstate,
czip)
VALUES (1, 'Contemporary Casuals', '1355 S. Avenue', 'Kolkata', 'WB',
'700019');
INSERT INTO CUSTOMER (customerid, customername, caddress, ccity, cstate,czip)
VALUES 
(2, 'Value furniture', '151 Lake Terrace', 'Cuttack', 'OR','560002'),
(3, 'Home Furnishings', '1900 Ashram Road', 'Ahmedabad', 'GU','380015'),
(4, 'Eastern Furniture', '1925 Belview Road', 'Bangalore', 'KA','600207'),
(5, 'Impressions', '5585 M. G. Road', 'Chennai', 'CH', '300016'),
(6, 'Furniture Gallery', '325 Marine Dr.', 'Mumbai', 'MU','400004');

CREATE TABLE ORDERS (
    orderid INT PRIMARY KEY,
    orderdate DATE,
    customerid INT,
    FOREIGN KEY (customerid) REFERENCES CUSTOMER(customerid)
);

INSERT INTO orders (orderid, orderdate, customerid) 
VALUES 
(1,STR_TO_DATE('29-10-2021', '%d-%m-%Y'), 2),
(2,STR_TO_DATE('11-01-2021', '%d-%m-%Y'), 3),
(3,STR_TO_DATE('15-10-2021', '%d-%m-%Y'), 1),
(4,STR_TO_DATE('04-10-2021', '%d-%m-%Y'), 6),
(5,STR_TO_DATE('02-11-2021', '%d-%m-%Y'), 4);

CREATE TABLE requests (
    productno INT,
    orderno INT,
    quantity INT,
    PRIMARY KEY (productno, orderno),
    FOREIGN KEY (productno) REFERENCES PRODUCT(productno),
    FOREIGN KEY (orderno) REFERENCES ORDERS(orderid)
);

INSERT INTO requests (orderno, productno, quantity)
VALUES
(1, 4, 1),
(1, 5, 10),
(1, 10, 2),
(2, 3, 1),
(2, 8, 2),
(2, 14, 1),
(3, 1, 5),
(3, 5, 10),
(3, 6, 2),
(4, 3, 1),
(4, 8, 3),
(5, 6, 2),
(5, 10, 1);

SELECT *
FROM requests;