

----(1)----

select *, FORMAT(Dt, 'MM') as MonthPrefixedWithZero 
from Dates;

----(2)----

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT 
        Id,
        rID,
        MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxValues
GROUP BY rID;

----(3)----

SELECT 
    Id, 
    Vals
FROM 
    TestFixLengths
WHERE 
    LEN(Vals) BETWEEN 6 AND 10
    AND Vals IS NOT NULL;

----(4)----

SELECT 
    T1.ID, 
    T1.Item, 
    T1.Vals
FROM 
    TestMaximum T1
JOIN (
    SELECT 
        ID, 
        MAX(Vals) AS MaxVals
    FROM 
        TestMaximum
    GROUP BY 
        ID
) T2
ON T1.ID = T2.ID 
AND T1.Vals = T2.MaxVals;

----(5)----

select * from SumOfMax
select id, sum(mx)
from (
	select id, detailedNumber, max(vals) mx
	from SumOfMax
	group by id, detailedNumber
) c
group by id;

----(6)----

SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN (a - b) = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR(100))
    END AS Difference
FROM 
    TheZeroPuzzle;

----(7)----

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50)
);

----(8)----

select avg(UnitPrice)
from Sales;

----(9)----

select Count(*)
from Sales;

----(10)----

select MAx(QuantitySold)
from Sales;

----(11)----

select Category, SUM(QuantitySold) 
from Sales
group by category;

----(12)----

select region, sum(tOtalRevenue)
from (
	select *, QuantitySold * unitprice As TotalRevenue
	from Sales
) a
group by region;
	
----(13)----

select Month(SaleDate), Sum(QuantitySold) 
from Sales
group by MONTH(SaleDate);

----(14)----

select TOP 1 *
from (
	select *, QuantitySold * unitprice As TotalRevenue
	from Sales
) r
order by TotalRevenue desc;

----(15)----

select *, sum(TotalRevenue) over (order by SaleDate)
from (
	select *, QuantitySold * unitprice As TotalRevenue
	from Sales
) s;

----(16)----

select category, sum(TotalRevenue)
from (
	select *, QuantitySold * unitprice As TotalRevenue
	from Sales
) s
group by category;

----(17)----

SELECT 
    Customers.CustomerName,
    Sales.Product,
    Sales.Quantity,
    Sales.UnitPrice,
    (Sales.QuantitySold * Sales.UnitPrice) AS TotalSaleAmount
FROM 
    Sales
INNER JOIN 
    Customers ON Sales.CustomerID = Customers.CustomerID;

----(18)----

SELECT 
    Customers.CustomerName
FROM 
    Customers
LEFT JOIN 
    Sales ON Customers.CustomerID = Sales.CustomerID
WHERE 
    Sales.CustomerID IS NULL;

----(19)----

SELECT 
    Customers.CustomerName,
    SUM(Sales.QuantitySold * Sales.UnitPrice) AS TotalRevenue
FROM 
    Sales
INNER JOIN 
    Customers ON Sales.CustomerID = Customers.CustomerID
GROUP BY 
    Customers.CustomerName;

----(20)----

SELECT TOP 1 
    Customers.CustomerName,
    SUM(Sales.QuantitySold * Sales.UnitPrice) AS TotalRevenue
FROM 
    Sales
INNER JOIN 
    Customers ON Sales.CustomerID = Customers.CustomerID
GROUP BY 
    Customers.CustomerName
ORDER BY 
    TotalRevenue DESC;

----(21)----

SELECT 
    Customers.CustomerName,
    YEAR(Sales.SaleDate) AS SaleYear,
    MONTH(Sales.SaleDate) AS SaleMonth,
    SUM(Sales.Quantity * Sales.PricePerUnit) AS TotalSales
FROM 
    Sales
INNER JOIN 
    Customers ON Sales.CustomerID = Customers.CustomerID
GROUP BY 
    Customers.CustomerName, 
    YEAR(Sales.SaleDate),
    MONTH(Sales.SaleDate)
ORDER BY 
    SaleYear, SaleMonth, Customers.CustomerName;

----(22)----

SELECT DISTINCT 
    Sales.ProductName
FROM 
    Sales
WHERE 
    Sales.Quantity > 0;

----(23)----

SELECT TOP 1 
    ProductName,
    Price
FROM 
    Products
ORDER BY 
    Price DESC;

----(24)----

SELECT 
    Sales.SaleID,
    Customers.CustomerName,
    Sales.ProductName,
    Sales.Quantity,
    Sales.PricePerUnit AS SalePrice,
    Products.CostPrice,
    (Sales.Quantity * Products.CostPrice) AS TotalCost
FROM 
    Sales
INNER JOIN 
    Products ON Sales.ProductName = Products.ProductName
INNER JOIN 
    Customers ON Sales.CustomerID = Customers.CustomerID;
----(25)----
SELECT 
    p.ProductName,
    p.Category,
    p.Price AS SellingPrice
FROM 
    Products p
INNER JOIN (
    SELECT 
        Category,
        AVG(Price) AS AvgPrice
    FROM 
        Products
    GROUP BY 
        Category
) avg_prices
ON p.Category = avg_prices.Category
WHERE 
    p.Price > avg_prices.AvgPrice;