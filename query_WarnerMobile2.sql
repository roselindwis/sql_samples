-- Roselin Dwi Septiani --

USE [WarnerMobile]

-- 1
GO
CREATE VIEW ViewStaffData AS
SELECT *
FROM Staff
WHERE LEN(StaffName ) > 9

GO
SELECT * FROM ViewStaffData

-- 2
SELECT CustomerName, CustomerPhone, CustomerDOB
FROM Customer cu
WHERE EXISTS (
	SELECT *
	FROM TransactionHeader th
	WHERE cu.CustomerID = th.CustomerID
	AND DATENAME(WEEKDAY, TransactionDate) = 'Monday'
)

-- 3
SELECT 
	cu.CustomerID, CustomerName, CustomerPhone, TransactionDate,
	TransactionMonth = MONTH(TransactionDate),
	TransactionCount = COUNT(th.TransactionID)
FROM Customer cu, TransactionHeader th
WHERE 
	cu.CustomerID = th.CustomerID
	AND TransactionDate = '2019-12-14'
GROUP BY cu.CustomerID, CustomerName, CustomerPhone, TransactionDate
UNION
SELECT 
	cu.CustomerID, CustomerName, CustomerPhone, TransactionDate,
	TransactionMonth = MONTH(TransactionDate),
	TransactionCount = COUNT(th.TransactionID)
FROM Customer cu, TransactionHeader th
WHERE 
	cu.CustomerID = th.CustomerID
	-- AND cu.CustomerName NOT LIKE '% %'
	AND CHARINDEX(' ', cu.CustomerName, 0) LIKE 0
GROUP BY cu.CustomerID, CustomerName, CustomerPhone, TransactionDate

-- 4
SELECT 
	th.TransactionID, 
	TransactionDate, 
	[Total Quantity] = SUM(Quantity),
	[Total Price] = SUM(Price * Quantity) 
FROM TransactionHeader th
	JOIN TransactionDetail td
	ON th.TransactionID = td.TransactionID
	JOIN Mobile mo
	ON mo.MobileID = td.MobileID
WHERE 
	RIGHT(th.TransactionID, 3) % 2 = 0
	AND YEAR(TransactionDate) = 2019
GROUP BY th.TransactionID, TransactionDate

-- 5
SELECT 
	sf.StaffID, 
	StaffName, 
	StaffGender,
	[Transaction Month] = MONTH (TransactionDate),
	[Transaction Year] = DATENAME(YEAR, TransactionDate)
FROM 
	Staff sf, TransactionHeader th,TransactionDetail td,Mobile mo,
	(SELECT [Max Price] = MAX(Price)
	 FROM Mobile
	) AS x
WHERE 
	sf.StaffID = th.StaffID
	AND td.TransactionID = th.TransactionID
	AND td.MobileID = mo.MobileID
	-- AND sf.StaffName LIKE '% %'
	AND CHARINDEX(' ', sf.StaffName, 0) NOT LIKE 0
	AND mo.Price = x.[Max Price]
