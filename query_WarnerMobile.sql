-- Roselin Dwi Septiani --

USE WarnerMobile

--1
CREATE TABLE Factory(
	FactoryID CHAR(5) PRIMARY KEY,
	FactoryName VARCHAR(100) NOT NULL,
	FactoryAddress VARCHAR(100) NOT NULL,

	CONSTRAINT CheckFactoryID CHECK (FactoryID LIKE 'FC[0-9][0-9][0-9]'),
	CONSTRAINT CheckFactoryName CHECK (FactoryName LIKE '% Factory')
)

--2
BEGIN TRAN 
ALTER TABLE Staff
ADD StaffSalary INT

ALTER TABLE Staff
ADD CONSTRAINT CheckStaffSalary CHECK (StaffSalary BETWEEN 10000 AND 200000)
ROLLBACK 

SELECT * FROM Staff

--3
BEGIN TRAN
INSERT INTO Customer VALUES
	('CU007','Ronaldo','Male','081940109052','1999-04-19','Perumahan Langpang blok C6 no 65')
ROLLBACK

SELECT * FROM Customer

--4
SELECT CustomerID, CustomerName, CustomerGender
FROM Customer
WHERE LEN(CustomerName) % 2 = 0

--5
BEGIN TRAN 
UPDATE Customer
SET CustomerAddress = 'Perumahan Testing'
FROM Customer, TransactionHeader
WHERE Customer.CustomerID = TransactionHeader.CustomerID
AND DAY(TransactionDate) = 22
ROLLBACK

SELECT * FROM Customer
