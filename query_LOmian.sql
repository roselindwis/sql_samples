CREATE DATABASE LOmian

USE LOmian

-- b. Data Definition Language 
-- Master Table
CREATE TABLE MsEmployee(
	EmployeeID CHAR(5) PRIMARY KEY,
	EmployeeName VARCHAR(30) NOT NULL,
	EmployeeAddress VARCHAR(50) NOT NULL,
	EmployeeGender VARCHAR(30) NOT NULL,

	CONSTRAINT CheckEmployeeID CHECK (EmployeeID LIKE 'EM[0-9][0-9][0-9]'),
	CONSTRAINT CheckEmployeeName CHECK (LEN(EmployeeName) BETWEEN 15 AND 30),
	CONSTRAINT CheckEmployeeGender CHECK (EmployeeGender LIKE 'male' OR EmployeeGender LIKE 'female')
)

CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(30) NOT NULL,
	CustomerGender VARCHAR(30) NOT NULL,
	CustomerAddress VARCHAR(50) NOT NULL,

	CONSTRAINT CheckCustomerID CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CONSTRAINT CheckCustomerGender CHECK (CustomerGender LIKE 'male' OR CustomerGender LIKE 'female')
)

CREATE TABLE MsSupplier(
	SupplierID CHAR(5) PRIMARY KEY,
	SupplierName VARCHAR(30) NOT NULL,
	SupplierGender VARCHAR(30) NOT NULL,
	SupplierAddress VARCHAR(50) NOT NULL,

	CONSTRAINT CheckSupplierID CHECK (SupplierID LIKE 'SU[0-9][0-9][0-9]'),
	CONSTRAINT CheckSupplierGender CHECK (SupplierGender LIKE 'male' OR SupplierGender LIKE 'female')
)

CREATE TABLE MsIngredient (
	IngredientID CHAR(5) PRIMARY KEY,
	IngredientName VARCHAR(30) NOT NULL,
	IngredientPrice INT,

	CONSTRAINT CheckIngredientID CHECK (IngredientID LIKE 'IN[0-9][0-9][0-9]'),
	CONSTRAINT CheckIngredientPrice CHECK (IngredientPrice > 0)
)

CREATE TABLE MsNoodleType(
	NoodleTypeID CHAR(5) PRIMARY KEY,
	NoodleTypeName VARCHAR(30) NOT NULL,

	CONSTRAINT CheckNoodleTypeID CHECK (NoodleTypeID LIKE 'NT[0-9][0-9][0-9]')
)

CREATE TABLE MsNoodle(
	NoodleID CHAR(5) PRIMARY KEY,
	NoodleName VARCHAR(30) NOT NULL,
	NoodleTypeID CHAR(5) NOT NULL,
	NoodlePrice INT,

	CONSTRAINT CheckNoodleID CHECK (NoodleID LIKE 'NO[0-9][0-9][0-9]'),
	CONSTRAINT CheckNoodleName CHECk (NoodleName LIKE '% noodle'),
	CONSTRAINT CheckNoodlePrice CHECk (NoodlePrice >= 15000),
	FOREIGN KEY (NoodleTypeID) REFERENCES MsNoodleType ON UPDATE CASCADE ON DELETE CASCADE
)

-- Transaction Table (Header)
CREATE TABLE HeaderSalesTransaction(
	SalesTransactionID CHAR(5) PRIMARY KEY,
	EmployeeID CHAR(5) NOT NULL,
	CustomerID CHAR(5) NOT NULL,
	SalesTransactionDate DATE,
	
	CONSTRAINT CheckSalesTransactionID CHECK (SalesTransactionID LIKE 'TR[0-9][0-9][0-9]'),
	FOREIGN KEY (EmployeeID) REFERENCES MsEmployee ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (CustomerID) REFERENCES MsCustomer ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE HeaderPurchaseTransaction(
	PurchaseTransactionID CHAR(5) PRIMARY KEY,
	EmployeeID CHAR(5) NOT NULL,
	SupplierID CHAR(5) NOT NULL,
	PurchaseTransactionDate DATE,

	CONSTRAINT CheckPurchaseTransactionID CHECK (PurchaseTransactionID LIKE 'PU[0-9][0-9][0-9]'),
	FOREIGN KEY (EmployeeID) REFERENCES MsEmployee ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (SupplierID) REFERENCES MsSupplier ON UPDATE CASCADE ON DELETE CASCADE
)

-- Transaction Detail Table (Detail)
CREATE TABLE DetailSalesTransaction(
	SalesTransactionID CHAR(5) NOT NULL,
	NoodleID CHAR(5) NOT NULL,
	Quantity INT,

	FOREIGN KEY (SalesTransactionID) REFERENCES HeaderSalesTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (NoodleID) REFERENCES MsNoodle ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE DetailPurchaseTransaction(
	PurchaseTransactionID CHAR(5) NOT NULL,
	IngredientID CHAR(5) NOT NULL,
	Quantity INT,

	FOREIGN KEY (PurchaseTransactionID) REFERENCES HeaderPurchaseTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (IngredientID) REFERENCES MsIngredient ON UPDATE CASCADE ON DELETE CASCADE
)

-- c. Data Manipulation Language
-- Master Table
INSERT INTO MsEmployee VALUES
	('EM001','James Alexander','Jl. Bulan No. 11','Male'),
	('EM002','Roselin Dwi Septiani','Jl. Bintang No. 88','Female'),
	('EM003','Evelyn Kurniawan','Jl. Aurora No. 19','Female'),
	('EM004','Alvito Mandala Putra','Jl. Bulan No. 198','Male'),
	('EM005','Daniel Kurniawan','Jl. Pelangi No. 77','Male'),
	('EM006','Angeline Bernanda','Jl. Aurora No. 163','Female'),
	('EM007','Hanson Budhi Santoso','Jl. Pelangi No. 72','Male'),
	('EM008','Albert Christian','Jl. Pelangi No. 179','Male'),
	('EM009','Ailly Khowennie','Jl. Bintang No. 45','Female'),
	('EM010','Kevin Albert Matthew','Jl. Pelangi No. 123','Male'),
	('EM011','Vanessa Marvella','Jl. Bintang No. 56','Female'),
	('EM012','Gabriella Azzahra','Jl. Bintang No. 23','Female'),
	('EM013','Kelvin Kurniawan','Jl. Pelangi No. 27','Male'),
	('EM014','Khezia Glorie Christi','Jl. Aurora No. 13','Female'),
	('EM015','Natasya Tanuwijaya','Jl. Aurora No. 22','Male')

SELECT * FROM MsEmployee
DELETE FROM MsEmployee

INSERT INTO MsCustomer VALUES
	('CU001','Marcelrico','Male','Jl. Bumi Selatan No. 33'),
	('CU002','Beatrice','Female','Jl. Matahari No. 166'),
	('CU003','Hebert Arthur','Male','Jl. Bumi Timur No. 21'),
	('CU004','Aprian Susilo','Male','Jl. Bumi Selatan No. 19'),
	('CU005','Jovita Vania','Female','Jl. Matahari No. 45'),
	('CU006','Jerry','Male','Jl. Bumi Timur No. 67'),
	('CU007','Lovina Angeline','Female','Jl. Matahari No. 13'),
	('CU008','Tasya Liurence','Female','Jl. Matahari No. 27'),
	('CU009','Yohannes','Male','Jl. Bumi Selatan No. 77'),
	('CU010','Maria Maharani','Female','Jl. Matahari No. 7'),
	('CU011','Felicia Halim','Female','Jl. Matahari No. 88'),
	('CU012','Sylvester','Male','Jl. Bumi Timur No. 33'),
	('CU013','Franklyn','Male','Jl. Bumi Timur No. 69'),
	('CU014','Yerikho Abel','Male','Jl. Bumi Selatan No. 32'),
	('CU015','Khesia Hanlim','Female','Jl. Matahari No. 93')

SELECT * FROM MsCustomer
DELETE FROM MsCustomer

INSERT INTO MsSupplier VALUES
	('SU001','Febrianto','Male','Jl. Komet No. 33'),
	('SU002','Cindy Vidalia','Female','Jl. Meteor No. 67'),
	('SU003','Hellen Anjani','Female','Jl. Meteor Barat No. 35'),
	('SU004','Adi Sidharta','Male','Jl. Komet Utara No. 23'),
	('SU005','Reginald Lay','Male','Jl. Komet No. 177'),
	('SU006','Jesclyn','Female','Jl. Meteor No. 56'),
	('SU007','Winata','Male','Jl. Komet No. 2'),
	('SU008','Jessica Tanuwijaya','Female','Jl. Meteor Barat No. 892'),
	('SU009','Cicilia','Female','Jl. Meteor No. 18'),
	('SU010','Donny','Male','Jl. Komet Utara No. 727'),
	('SU011','Yoseph Kurniawan','Male','Jl. Komet No. 12'),
	('SU012','Kitsy Chelles','Female','Jl. Meteor Barat No. 55'),
	('SU013','Migel','Male','Jl. Komet No. 88'),
	('SU014','Selvi','Female','Jl. Meteor No. 999'),
	('SU015','Cyntia Kurniawan','Female','Jl. Meteor No. 998')

SELECT * FROM MsSupplier
DELETE FROM MsSupplier

INSERT INTO MsIngredient VALUES
	('IN001','Egg',5000),
	('IN002','Flour',30000),
	('IN003','Soybean Oil',20000),
	('IN004','Vegetable',60000),
	('IN005','Soy Sauce',25000),
	('IN006','Lemon',18000),
	('IN007','Shrimp',30000),
	('IN008','Mushroom',21000),
	('IN009','Onion',23000),
	('IN010','Chicken',42000),
	('IN011','Pork',55000),
	('IN012','Beef',50000),
	('IN013','Salmon',60000),
	('IN014','Celery',7000),
	('IN015','Cheese',24000)

SELECT * FROM MsIngredient
DELETE FROM MsIngredient

INSERT INTO MsNoodleType VALUES
	('NT001','Western Noodle'),
	('NT002','Chinese Noodle'),
	('NT003','Japanese Noodle'),
	('NT004','Korean Noodle'),
	('NT005','Hokkien Noodle'),
	('NT006','Vegetarian Noodle'),
	('NT007','Shirataki Noodle'),
	('NT008','Pork Noodle'),
	('NT009','Beef Noodle'),
	('NT010','Shrimp Noodle'),
	('NT011','Chicken Noodle'),
	('NT012','Egg Noodle'),
	('NT013','Kwetiaw'),
	('NT014','Spaghetti'),
	('NT015','Fettucine')

SELECT * FROM MsNoodleType
DELETE FROM MsNoodleType

INSERT INTO MsNoodle VALUES
	('NO001','Aglio noodle','NT001',20000),
	('NO002','Bakmi noodle','NT002',17000),
	('NO003','Sooa noodle','NT002',18000),
	('NO004','Ramen noodle','NT003',31000),
	('NO005','Udon noodle','NT003',31000),
	('NO006','Ramyeon noodle','NT004',28000),
	('NO007','Jajangmyeon noodle','NT004',55000),
	('NO008','Jjamppong noodle','NT004',47000),
	('NO009','Rabokki noodle','NT004',47000),
	('NO010','Rabokki + cheese noodle','NT004',47000),
	('NO011','Samyang noodle','NT004',60000),
	('NO012','Vegan noodle','NT006',32000),
	('NO013','Vegatarian noodle','NT006',32000),
	('NO014','Mushroom noodle','NT006',30000),
	('NO015','Shirataki noodle','NT007',34000),
	('NO016','Pork noodle','NT008',38000),
	('NO017','Beef noodle','NT009',44000),
	('NO018','Shrimp noodle','NT010',40000),
	('NO019','Chicken noodle','NT011',36000),
	('NO020','Egg noodle','NT012',42000)

SELECT * FROM MsNoodle
DELETE FROM MsNoodle

-- Transaction Table (Header)
INSERT INTO HeaderSalesTransaction VALUES
	('TR001','EM012','CU011','2020-11-15'),
	('TR002','EM012','CU008','2020-11-15'),
	('TR003','EM002','CU010','2020-11-17'),
	('TR004','EM012','CU004','2020-11-18'),
	('TR005','EM011','CU001','2020-11-19'),
	('TR006','EM002','CU002','2020-11-20'),
	('TR007','EM007','CU015','2020-11-20'),
	('TR008','EM005','CU011','2020-11-21'),
	('TR009','EM006','CU008','2020-11-22'),
	('TR010','EM006','CU007','2020-11-23'),
	('TR011','EM012','CU011','2020-11-23'),
	('TR012','EM011','CU001','2020-11-25'),
	('TR013','EM011','CU004','2020-11-25'),
	('TR014','EM011','CU008','2020-11-25'),
	('TR015','EM011','CU012','2020-11-25'),
	('TR016','EM011','CU015','2020-11-25'),
	('TR017','EM011','CU011','2020-11-25'),
	('TR018','EM008','CU015','2020-11-26'),
	('TR019','EM013','CU010','2020-11-27'),
	('TR020','EM013','CU002','2020-11-27'),
	('TR021','EM007','CU015','2020-11-27'),
	('TR022','EM005','CU004','2020-11-28'),
	('TR023','EM006','CU001','2020-11-29'),
	('TR024','EM006','CU004','2020-11-29'),
	('TR025','EM006','CU010','2020-11-29'),
	('TR026','EM006','CU002','2020-11-29'),
	('TR027','EM006','CU007','2020-11-29'),
	('TR028','EM006','CU013','2020-11-29')

SELECT * FROM HeaderSalesTransaction
DELETE FROM HeaderSalesTransaction

INSERT INTO HeaderPurchaseTransaction VALUES
	('PU001','EM009','SU002','2020-11-10'),
	('PU002','EM004','SU007','2020-11-11'),
	('PU003','EM013','SU010','2020-11-11'),
	('PU004','EM014','SU014','2020-11-12'),
	('PU005','EM004','SU002','2020-11-14'),
	('PU006','EM014','SU010','2020-11-15'),
	('PU007','EM013','SU007','2020-11-15'),
	('PU008','EM009','SU014','2020-11-17'),
	('PU009','EM009','SU002','2020-11-17'),
	('PU010','EM004','SU007','2020-11-17'),
	('PU011','EM013','SU010','2020-11-18'),
	('PU012','EM014','SU014','2020-11-19'),
	('PU013','EM004','SU007','2020-11-21'),
	('PU014','EM001','SU003','2020-11-23'),
	('PU015','EM008','SU005','2020-11-24'),
	('PU016','EM003','SU004','2020-11-25'),
	('PU017','EM012','SU001','2020-11-26'),
	('PU018','EM014','SU013','2020-11-27'),
	('PU019','EM014','SU011','2020-10-27'),
	('PU020','EM001','SU010','2020-10-27'),
	('PU021','EM003','SU005','2020-10-28'),
	('PU022','EM001','SU005','2020-10-28'),
	('PU023','EM008','SU005','2020-10-29'),
	('PU024','EM008','SU005','2020-10-30'),
	('PU025','EM003','SU005','2020-11-01'),
	('PU026','EM004','SU005','2020-11-02')

SELECT * FROM HeaderPurchaseTransaction
DELETE FROM HeaderPurchaseTransaction

-- Transaction Detail Table (Detail)
INSERT INTO DetailSalesTransaction VALUES
	('TR001','NO006',12),
	('TR001','NO012',13),
	('TR002','NO006',15),
	('TR002','NO012',12),
	('TR003','NO004',1),
	('TR004','NO006',5),
	('TR004','NO002',3),
	('TR004','NO001',6),
	('TR005','NO003',2),
	('TR006','NO003',1),
	('TR007','NO005',2),
	('TR008','NO006',4),
	('TR008','NO008',5),
	('TR009','NO003',2),
	('TR010','NO003',1),
	('TR010','NO002',1),
	('TR010','NO004',3),
	('TR011','NO006',3),
	('TR012','NO010',2),
	('TR012','NO017',1),
	('TR013','NO007',3),
	('TR014','NO009',2),
	('TR015','NO010',2),
	('TR015','NO008',1),
	('TR016','NO009',4),
	('TR017','NO002',4),
	('TR018','NO008',5),
	('TR019','NO008',1),
	('TR019','NO016',3),
	('TR020','NO018',4),
	('TR021','NO018',3),
	('TR022','NO009',5),
	('TR023','NO002',2),
	('TR024','NO011',1),
	('TR025','NO011',3),
	('TR026','NO011',2),
	('TR027','NO011',1),
	('TR028','NO011',1)

SELECT * FROM DetailSalesTransaction
DELETE FROM DetailSalesTransaction

INSERT INTO DetailPurchaseTransaction VALUES
	('PU001','IN005',4),
	('PU001','IN008',2),
	('PU002','IN004',1),
	('PU003','IN008',2),
	('PU003','IN004',1),
	('PU004','IN005',1),
	('PU004','IN013',3),
	('PU005','IN005',4),
	('PU005','IN008',2),
	('PU006','IN008',1),
	('PU006','IN004',2),
	('PU007','IN004',1),
	('PU007','IN013',1),
	('PU008','IN005',5),
	('PU009','IN004',2),
	('PU009','IN013',3),
	('PU010','IN004',3),
	('PU010','IN013',2),
	('PU011','IN008',1),
	('PU011','IN004',1),
	('PU012','IN005',5),
	('PU012','IN013',5),
	('PU013','IN004',2),
	('PU013','IN013',2),
	('PU014','IN007',3),
	('PU015','IN007',4),
	('PU016','IN007',3),
	('PU017','IN007',2),
	('PU018','IN007',1),
	('PU019','IN003',1),
	('PU020','IN005',1),
	('PU021','IN001',1),
	('PU022','IN001',1),
	('PU023','IN001',1),
	('PU024','IN001',1),
	('PU025','IN001',0),
	('PU026','IN001',0)

SELECT * FROM DetailPurchaseTransaction
DELETE FROM DetailPurchaseTransaction

-- d. Data Manupulation Language to simulate the transaction process
-- Sales Transaction
-- If Customer has been recorded in database (Jika Customer sudah tercatat di database)
INSERT INTO HeaderSalesTransaction VALUES
	('TR029','EM002','CU013','2021-01-04'),
	('TR030','EM001','CU001','2021-01-14'),
	('TR031','EM005','CU004','2021-01-17'),
	('TR032','EM004','CU014','2021-01-19'),
	('TR033','EM003','CU013','2021-01-23'),
	('TR034','EM002','CU009','2021-01-28'),
	('TR035','EM008','CU007','2021-01-29')

INSERT INTO DetailSalesTransaction VALUES
	('TR029','NO010',1),
	('TR030','NO004',2),
	('TR031','NO014',5),
	('TR031','NO002',2),
	('TR032','NO013',3),
	('TR033','NO008',1),
	('TR033','NO007',1),
	('TR034','NO006',4),
	('TR035','NO014',2),
	('TR035','NO012',1)

-- If Customer has not been recorded in database(Jika Customer belum tercatat di database)
INSERT INTO MsCustomer VALUES
	('CU016','Leony Violetta','Female','Jl. Matahari No. 99')

INSERT INTO HeaderSalesTransaction VALUES
	('TR036','EM005','CU016','2021-02-01')

INSERT INTO DetailSalesTransaction VALUES
	('TR036','NO012',1)

-- Purchase Transaction
-- If Supplier has been recorded in database (Jika Supplier sudah tercatat di database)
INSERT INTO HeaderPurchaseTransaction VALUES
	('PU027','EM001','SU005','2021-01-05'),
	('PU028','EM004','SU008','2021-01-07'),
	('PU029','EM006','SU002','2021-01-08'),
	('PU030','EM003','SU004','2021-01-08'),
	('PU031','EM005','SU010','2021-01-12'),
	('PU032','EM010','SU011','2021-01-16'),
	('PU033','EM014','SU013','2021-01-20'),
	('PU034','EM013','SU015','2021-01-23'),
	('PU035','EM011','SU002','2021-01-25')

INSERT INTO DetailPurchaseTransaction VALUES
	('PU027','IN010',2),
	('PU027','IN009',3),
	('PU028','IN013',1),
	('PU028','IN005',1),
	('PU029','IN006',5),
	('PU030','IN009',4),
	('PU031','IN012',2),
	('PU032','IN010',3),
	('PU033','IN003',1),
	('PU034','IN004',1),
	('PU035','IN007',5)

-- If Supplier has not been recorded in database(Jika Supplier belum tercatat di database)
INSERT INTO MsSupplier VALUES
	('SU016','Christine Huang','Female','Jl. Meteor No. 78')

INSERT INTO HeaderPurchaseTransaction VALUES
	('PU036','EM012','SU016','2020-02-02')

INSERT INTO DetailPurchaseTransaction VALUES
	('PU036','IN004',10)

-- e. Reporting Query 
-- 1. Display EmployeeName, CustomerName, TransactionDate, TransactionDate
SELECT 
	EmployeeName, 
	CustomerName, 
	TransactionDate = CONVERT(VARCHAR, SalesTransactionDate, 107),
	TransactionCount = COUNT(SalesTransactionID) 
FROM MsEmployee em
	JOIN HeaderSalesTransaction hst ON em.EmployeeID = hst.EmployeeID
	JOIN MsCustomer cu ON cu.CustomerID = hst.CustomerID
WHERE 
	EmployeeName LIKE '% %' 
	AND EmployeeGender = 'female'
GROUP BY EmployeeName, CustomerName, SalesTransactionDate, EmployeeGender

-- 2. Display IngredientName, IngredientPrice, TotalQuantity, SupplierName
SELECT 
	IngredientName, 
	IngredientPrice = 'Rp. ' + CAST(IngredientPrice AS VARCHAR), 
	TotalQuantity = CAST(SUM(Quantity) AS VARCHAR) + ' Items(s)',
	SupplierName = UPPER(SupplierName)
FROM MsIngredient ing
	JOIN DetailPurchaseTransaction dpt ON ing.IngredientID = dpt.IngredientID
	JOIN HeaderPurchaseTransaction hpt ON dpt.PurchaseTransactionID = hpt.PurchaseTransactionID
	JOIN MsSupplier su ON hpt.SupplierID = su.SupplierID
GROUP BY IngredientName, IngredientPrice, SupplierName
HAVING COUNT(hpt.PurchaseTransactionID) > 5
	AND SUM(Quantity) < 5

-- 3. Diplay NoodleName, NoodlePrice, TransactionCount, TotalQuantity, TotalPrice
SELECT
	NoodleName,
	NoodlePrice = 'Rp. ' + CAST(NoodlePrice AS VARCHAR),
	TransactionCount = CAST(COUNT(hst.SalesTransactionID) AS VARCHAR) + ' Transaction(s)',
	TotalQuantity = CAST(SUM(Quantity) AS VARCHAR) + ' Qty(s)',
	TotalPrice = 'Rp. ' + CAST(SUM(Quantity * NoodlePrice) AS VARCHAR)
FROM MsNoodle mn
	JOIN DetailSalesTransaction dst ON mn.NoodleID = dst.NoodleID
	JOIN HeaderSalesTransaction hst ON dst.SalesTransactionID = hst.SalesTransactionID
WHERE DAY(SalesTransactionDate) > 20
GROUP BY NoodleName, NoodlePrice
HAVING COUNT(hst.SalesTransactionID) >= 5

-- 4. Display IngredientName, IngredientPrice, PurchaseCount, TotalQuantity, TotalPrice
SELECT
	IngredientName,
	IngredientPrice = 'Rp. ' + CAST(ing.IngredientPrice AS VARCHAR),
	PurchaseCount = CAST(COUNT(hpt.PurchaseTransactionID) AS VARCHAR) + ' Purchase(s)',
	TotalQuantity = CAST(SUM(Quantity) AS VARCHAR) + ' Qty(s)',
	TotalPrice = 'Rp. ' + CAST(SUM(Quantity * IngredientPrice) AS VARCHAR)
FROM MsIngredient ing
	JOIN DetailPurchaseTransaction dpt ON ing.IngredientID = dpt.IngredientID
	JOIN HeaderPurchaseTransaction hpt ON dpt.PurchaseTransactionID = hpt.PurchaseTransactionID
WHERE  
	DATENAME(MONTH, PurchaseTransactionDate) = 'November'
	AND IngredientPrice BETWEEN 20000 AND 30000
GROUP BY IngredientName, IngredientPrice

-- 5. Display NoodleID, NoodleName, NoodlePrice
SELECT DISTINCT
	NoodleID = REPLACE(mn.NoodleID,'NO','Noodle '),
	NoodleName,
	NoodlePrice = 'Rp. ' + CAST(NoodlePrice AS VARCHAR)
FROM MsNoodle mn
	JOIN DetailSalesTransaction dst ON mn.NoodleID = dst.NoodleID
	JOIN HeaderSalesTransaction hst ON dst.SalesTransactionID = hst.SalesTransactionID,
	(SELECT AvgNoodlePrice = AVG(NoodlePrice) FROM MsNoodle) AS x
WHERE NoodlePrice > x.AvgNoodlePrice
	AND DATENAME(WEEKDAY, SalesTransactionDate) LIKE 'Wednesday'

SELECT AVG(NoodlePrice)
FROM MsNoodle

-- 6. Display TransactionDate, EmployeeName, 
SELECT
	TransactionDate = CONVERT(VARCHAR, hst.SalesTransactionDate, 107),
	EmployeeName,
	Quantity
FROM MsEmployee em
	JOIN HeaderSalesTransaction hst ON em.EmployeeID = hst.EmployeeID
	JOIN DetailSalesTransaction dst ON hst.SalesTransactionID = dst.SalesTransactionID,
	(SELECT AvgQuantity = AVG(Quantity) FROM DetailSalesTransaction) AS x
WHERE Quantity < x.AvgQuantity
	AND DATEDIFF(DAY, SalesTransactionDate, '2020-11-25') = 5

-- 7. Display IngredientID, IngredientName, IngredientPrice
SELECT 
	IngredientID = REPLACE(ing.IngredientID,'IN','Ingredient '),
	IngredientName,
	IngredientPrice
FROM MsIngredient ing
	JOIN DetailPurchaseTransaction dpt ON ing.IngredientID = dpt.IngredientID
	JOIN HeaderPurchaseTransaction hpt ON dpt.PurchaseTransactionID = hpt.PurchaseTransactionID,
	(SELECT MinPrice = MIN(IngredientPrice) FROM MsIngredient) AS x,
	(SELECT AvgPrice = AVG(IngredientPrice) FROM MsIngredient) AS y
WHERE IngredientPrice > x.MinPrice
	AND IngredientPrice < y.AvgPrice
	AND IngredientName LIKE '% %'
	AND MONTH(PurchaseTransactionDate) = 10
GROUP BY ing.IngredientID, IngredientName, IngredientPrice

-- 8. Display TransactionDate, NoodleTypeName, Total Transaction
SELECT
	TransactionDate = CONVERT(VARCHAR, hst.SalesTransactionDate, 107),
	NoodleTypeName,
	[Total Transaction] = CAST(COUNT(hst.SalesTransactionID) AS VARCHAR) + ' Transaction(s)'
FROM MsNoodleType nt
	JOIN MsNoodle mn ON nt.NoodleTypeID = mn.NoodleTypeID
	JOIN DetailSalesTransaction dst ON mn.NoodleID = dst.NoodleID
	JOIN HeaderSalesTransaction hst ON dst.SalesTransactionID = hst.SalesTransactionID,
	(SELECT MaxQuantity = MAX(Quantity) FROM DetailSalesTransaction) AS x
WHERE Quantity < x.MaxQuantity
	AND DATENAME(WEEKDAY, SalesTransactionDate) LIKE 'Wednesday' 
	OR DATENAME(WEEKDAY,SalesTransactionDate) LIKE 'Friday'
GROUP BY SalesTransactionDate, NoodleTypeName

-- 9. View 'CustomerRecord'
GO
CREATE VIEW CustomerRecord 
AS
SELECT 
	CustomerID = REPLACE(cu.CustomerID,'CU','Customer '),
	CustomerName,
	TransactionCount = COUNT(hst.SalesTransactionID),
	QuantityBought = SUM(Quantity)  
FROM MsCustomer cu
	JOIN HeaderSalesTransaction hst ON cu.CustomerID = hst.CustomerID
	JOIN DetailSalesTransaction dst ON hst.SalesTransactionID = dst.SalesTransactionID
WHERE customerName LIKE '% H%'
GROUP BY cu.CustomerID, CustomerName
HAVING SUM(Quantity) > 10

GO
DROP VIEW CustomerRecord

-- 10. View 'NoodleRecord'
GO
CREATE VIEW NoodleRecord
AS
SELECT
	TransactionDate = CONVERT(VARCHAR, hst.SalesTransactionDate, 107),
	NoodleName = LOWER(REPLACE(NoodleName,'noodle','mian')),
	NoodlePrice = 'Rp. ' + CAST(NoodlePrice - (NoodlePrice * 20 / 100) AS VARCHAR),
	QuantityBought = CAST(SUM(Quantity) AS VARCHAR) + ' Qty(s)'
FROM HeaderSalesTransaction hst
	JOIN DetailSalesTransaction dst ON hst.SalesTransactionID = dst.SalesTransactionID
	JOIN MsNoodle mn ON dst.NoodleID = mn.NoodleID
GROUP BY SalesTransactionDate, NoodleName, NoodlePrice
HAVING COUNT(hst.SalesTransactionID) < 5
	AND SUM (Quantity) > 10

GO
DROP VIEW NoodleRecord



DROP DATABASE LOmian
