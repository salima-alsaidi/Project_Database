create database AirLine_System
--AIRPORT TABLE
create table airport(
IATA INT primary key not null,
name varchar(100) not null,
city varchar(100) not null, 
country varchar(100) not null
);


--FLIGHT TABLE 
create table flight(
 FNo INT PRIMARY KEY,
  ArrivalDateTime DATETIME NOT NULL,
  CONSTRAINT CK_Flight_DateTime
  CHECK (ArrivalDateTime > DepartureDateTime),
 DepartureDateTime DATETIME NOT NULL,
 duration CHAR(20),
 Status CHAR(10) NOT NULL DEFAULT 'Scheduled',
 CONSTRAINT CK_Flight_Status
 CHECK (Status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),
 IATA INT,
 Registration_No int,
 FOREIGN KEY (IATA) REFERENCES airport(IATA)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 FOREIGN KEY (Registration_No) REFERENCES Aircraft(Registration_No)
 ON DELETE CASCADE
 ON UPDATE CASCADE
);


--BOOKING TABLE
CREATE TABLE Booking(
Bid INT PRIMARY KEY NOT NULL,
SNo INT,
Class CHAR(25),
CONSTRAINT Booking_Class
CHECK (class IN ('Economy', 'Business', 'First')),
Price DECIMAL(10,2),
CONSTRAINT CK_Booking_Price
CHECK (Price > 0),
Bdate DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
ID INT,
FNo INT,
FOREIGN KEY (ID) REFERENCES Passenger(ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (FNo) REFERENCES flight(FNo)
ON DELETE CASCADE
 ON UPDATE CASCADE
);

--PASSENGER TABLE 
create table Passenger(
ID INT PRIMARY KEY not null,
Full_name VARCHAR(30) not null,
email VARCHAR(100),
Phone INT,
Nationality VARCHAR(50) NOT NULL 
);

--Aircraft table 
create table Aircraft(
Registration_No INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
model VARCHAR(20), 
Manufactuer VARCHAR(50),
Total_Seat INT,
M_year CHAR(6),
);

--Crew table
create table Crew(
Lincense_NO int primary key not null,
Full_name varchar(50),
Role varchar(50),
FNo int, 
CONSTRAINT CK_Crew_Role
CHECK (Role IN ('Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer')),
FOREIGN KEY (FNo) REFERENCES flight(FNo)
ON DELETE CASCADE
ON UPDATE CASCADE
);

--inser data into airport 
INSERT INTO airport (IATA, name, city, country) VALUES
(1, 'Muscat International Airport', 'Muscat', 'Oman'),
(2, 'Dubai International Airport', 'Dubai', 'UAE'),
(3, 'Doha Hamad International Airport', 'Doha', 'Qatar'),
(4, 'Abu Dhabi International Airport', 'Abu Dhabi', 'UAE'),
(5, 'King Khalid International Airport', 'Riyadh', 'Saudi Arabia');

select * from airport;

ALTER TABLE airport
ALTER COLUMN name VARCHAR(100) NOT NULL;

--inser data into flight
INSERT INTO Flight(FNo,DepartureDateTime,ArrivalDateTime,Duration, Status,IATA, Registration_No)VALUES
(1, '2026-09-23 08:00:00', '2026-09-23 09:30:00',
 '1 hour 30 min', 'Scheduled', 1,  101),

(2, '2026-09-23 10:00:00', '2026-09-23 11:30:00',
 '1 hour 30 min', 'Delayed', 2,  102),

(3, '2026-09-23 12:00:00', '2026-09-23 14:00:00',
 '2 hours', 'Scheduled', 3,  103),

(4, '2026-09-23 15:00:00', '2026-09-23 16:30:00',
 '1 hour 30 min', 'Completed', 4,  104),

(5, '2026-09-23 18:00:00', '2026-09-23 20:00:00',
 '2 hours', 'Cancelled', 5,  105);

SELECT * FROM flight;

ALTER TABLE flight
ADD Registration_No INT;

ALTER TABLE Flight
ALTER COLUMN ArrivalDateTime DATETIME NOT NULL;

--insert data into booking table 
INSERT INTO Booking(Bid, SNo, Class, Price, Bdate, ID, FNo)VALUES
(1, 101, 'Economy', 120.00, '2026-09-23', 1, 1),

(2, 102, 'Business', 350.00, '2026-09-23', 2, 2),

(3, 103, 'First', 750.00, '2026-09-23', 3, 3),

(4, 104, 'Economy', 150.00, '2026-09-23', 4, 4),

(5, 105, 'Business', 400.00, '2026-09-23', 5, 5);

select * from booking;

--create passenger table 
INSERT INTO Passenger(ID, Full_name, email, Phone, Nationality )VALUES
(1, 'Ahmed Ali', 'ahmed@gmail.com', 91234567, 'Omani'),
(2, 'Sara Mohammed', 'sara@gmail.com', 92345678, 'Omani'),
(3, 'Khalid Said', 'khalid@gmail.com', 93456789, 'Qatari'),
(4, 'Mariam Hassan', 'mariam@gmail.com', 94567890, 'UAE'),
(5, 'Omar Salim', 'omar@gmail.com', 95678901, 'Omani');

select * from Passenger;

--- insert data aircraft table
INSERT INTO Aircraft(model, Manufactuer, Total_Seat, M_year)VALUES
('A320', 'Airbus', 180, '2020'),
('B737-800', 'Boeing', 189, '2019'),
('A350', 'Airbus', 325, '2021'),
('B787-9', 'Boeing', 296, '2022'),
('A330-300', 'Airbus', 277, '2018');

select * from Aircraft;
ALTER TABLE Aircraft
ALTER COLUMN Manufactuer VARCHAR(50);


ALTER TABLE Aircraft
ALTER COLUMN M_year VARCHAR(4);

ALTER TABLE Aircraft
drop table Aircraft;

--insert into crew table 
INSERT INTO Crew(Lincense_NO, Full_name, Role, FNo)VALUES
(1001, 'Ahmed Al Balushi', 'Pilot', 1),
(1002, 'Khalid Al Harthy', 'Co-Pilot', 1),
(1003, 'Sara Al Said', 'Cabin Crew', 2),
(1004, 'Mariam Al Lawati', 'Pilot', 3),
(1005, 'Omar Al Hinai', 'Co-Pilot', 3),
(1006, 'Fatma Al Rashdi', 'Cabin Crew', 4),
(1007, 'Salim Al Amri', 'Pilot', 5),
(1008, 'Noor Al Shamsi', 'Cabin Crew', 5);

select * from Crew;

--updating 
update flight set Status='Completed' where FNo = 1
  AND Status = 'Scheduled';

  select * from flight;

  update flight set Status='Cancelled' where FNo =2
  AND Status = 'Delayed';
    select * from flight;

UPDATE Booking
SET Price = Price * 1.10
WHERE Class = 'Economy';

select * from Booking;

UPDATE Passenger
SET Phone = 96891234
WHERE ID = 1;

SELECT * FROM Passenger


UPDATE Crew
SET Role = 'Co-Pilot'
WHERE Lincense_NO = 1001;

select * from Crew;



--insert Query 

SELECT FNo, DepartureDateTime, Status
FROM Flight
ORDER BY DepartureDateTime ASC;

SELECT *
FROM Passenger
ORDER BY Full_name ASC

SELECT Registration_No, model, Total_Seat
FROM Aircraft
ORDER BY Total_Seat DESC;


SELECT DISTINCT Class
FROM Booking;

SELECT *
FROM Flight
WHERE Status IN ('Delayed', 'Cancelled');

SELECT *
FROM Passenger
WHERE Nationality = 'Omani';

ALTER TABLE Passenger
ADD Nationality VARCHAR(50);

SELECT *
FROM Passenger;

UPDATE Passenger
SET Nationality = 'Omani'
WHERE ID IN (1, 2, 5);

UPDATE Passenger
SET Nationality = 'UAE'
WHERE ID IN (4);

UPDATE Passenger
SET Nationality = 'Qatari'
WHERE ID IN (3);

select * from Passenger;


SELECT *
FROM Airport
ORDER BY Country ASC;


-----------------------
SELECT 
    F.FNo,
    O.Name AS OriginAirpor
FROM Flight F
INNER JOIN Airport O
    ON F.IATA = O.IATA


 SELECT
    B.Bid,
    P.Full_name,
    B.FNo
FROM Booking B
INNER JOIN Passenger P
    ON B.ID = P.ID;

    SELECT
    C.Full_name,
    C.Role
FROM Crew C
INNER JOIN Flight F
    ON C.FNo = F.FNo
WHERE F.FNo = '1';


SELECT
    C.Full_name,
    C.Role
FROM Crew C
WHERE C.FNo = 2;

SELECT
    F.FNo,
    A.model
FROM Flight F
INNER JOIN Aircraft A
    ON F.Registration_No = A.Registration_No
WHERE F.Status = 'Completed';

SELECT
    P.Full_name,
    COUNT(B.Bid) AS BookingCount
FROM Passenger P
LEFT JOIN Booking B
    ON P.ID = B.ID
GROUP BY P.ID, P.Full_name
ORDER BY BookingCount DESC;


SELECT
    Class,
    SUM(Price) AS TotalRevenue
FROM Booking
GROUP BY Class;

SELECT
    A.Registration_No,
    A.model,
    COUNT(F.FNo) AS FlightCount
FROM Aircraft A
LEFT JOIN Flight F
    ON A.Registration_No = F.Registration_No
GROUP BY A.Registration_No, A.model;



SELECT
    FNo,
    COUNT(Bid) AS BookingCount
FROM Booking
GROUP BY FNo
HAVING COUNT(Bid) > 1;


SELECT
    P.Full_name,
    F.FNo,
    O.Name AS OriginAirport,
    B.Class,
    B.Price
FROM Booking B
INNER JOIN Passenger P
    ON B.ID = P.ID
INNER JOIN Flight F
    ON B.FNo = F.FNo
INNER JOIN Airport O
    ON F.IATA = O.IATA
-------------------------
SELECT
    F.FNo,
    O.name AS OriginAirport,
    A.model AS AircraftModel,
    COUNT(B.Bid) AS TotalPassengers
FROM Flight F
INNER JOIN Airport O
    ON F.IATA = O.IATA
INNER JOIN Aircraft A
    ON F.Registration_No = A.Registration_No
LEFT JOIN Booking B
    ON F.FNo = B.FNo
GROUP BY
    F.FNo,
    O.Name,
    A.model;


SELECT P.ID,  P.Full_name
FROM Passenger P
LEFT JOIN Booking B
    ON P.ID = B.ID
WHERE B.Bid IS NULL;


SELECT
    F.FNo,
    SUM(B.Price) AS TotalRevenue
FROM Flight F
INNER JOIN Booking B
    ON F.FNo = B.FNo
GROUP BY F.FNo
HAVING SUM(B.Price) > 500
ORDER BY TotalRevenue DESC;

SELECT
    Full_name,
    COUNT(FNo) AS TotalFlights
FROM Crew
GROUP BY Lincense_NO, Full_name
HAVING COUNT(FNo) > 1;


SELECT
    FNo,
    AVG(Price) AS AveragePrice
FROM Booking
GROUP BY FNo
HAVING AVG(Price) > (
    SELECT AVG(Price)
    FROM Booking
);


SELECT TOP 1
    F.FNo,
    O.Name AS OriginAirport,
    COUNT(B.Bid) AS TotalBookings
FROM Flight F
INNER JOIN Airport O
    ON F.IATA = O.IATA
LEFT JOIN Booking B
    ON F.FNo = B.FNo
GROUP BY
    F.FNo,
    O.Name
ORDER BY TotalBookings DESC;


SELECT
    Class,
    SUM(Price) AS TotalRevenue,
    COUNT(Bid) AS NumberOfBookings,
    AVG(Price) AS AveragePrice,
    MAX(Price) AS HighestPrice,
    MIN(Price) AS LowestPrice
FROM Booking
GROUP BY Class;


SELECT
    P.Full_name,
    F.FNo,
    B.Bdate AS BookingDate
FROM Booking B
INNER JOIN Passenger P
    ON B.ID = P.ID
INNER JOIN Flight F
    ON B.FNo = F.FNo
WHERE F.Status = 'Cancelled';

SELECT
    F.FNo,
    COUNT(C.Lincense_NO) AS TotalCrew,
    F.DepartureDateTime
FROM Flight F
INNER JOIN Crew C
    ON F.FNo = C.FNo
GROUP BY
    F.FNo,
    F.DepartureDateTime
HAVING
    SUM(CASE WHEN C.Role = 'Pilot' THEN 1 ELSE 0 END) > 0
    AND
    SUM(CASE WHEN C.Role = 'Flight Attendant' THEN 1 ELSE 0 END) > 0;


    SELECT
    F.FNo,
    O.City AS OriginCity,
    A.model AS AircraftModel,
    A.Manufactuer AS AircraftManufacturer,
    COUNT(DISTINCT B.Bid) AS TotalPassengers,
    COUNT(DISTINCT C.Lincense_NO) AS TotalCrew,
    COALESCE(SUM(B.Price), 0) AS TotalRevenue
FROM Flight F

INNER JOIN Airport O
    ON F.IATA = O.IATA
INNER JOIN Aircraft A
    ON F.Registration_No = A.Registration_No

LEFT JOIN Booking B
    ON F.FNo = B.FNo

LEFT JOIN Crew C
    ON F.FNo = C.FNo

GROUP BY
    F.FNo,
    O.City,
    A.model,
    A.Manufactuer

ORDER BY TotalRevenue DESC;