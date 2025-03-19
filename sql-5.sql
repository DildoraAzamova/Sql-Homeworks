
USE AdventureWorksDW2019;

--Easy-Level Tasks (1)
Select Top 10                   --ko'p bo'lgani uchun 10 tasini oldim
     EnglishProductName as Name
 FROM DimProduct

--Easy-Level Tasks (2)
SELECT MiddleName
FROM DimCustomer as CLient

--Easy-Level Tasks (3)
 SELECT TOP 10 EnglishProductName From DimProduct
 UNION
 SELECT EnglishProductCategoryName From DimProductCategory;

--Easy-Level Tasks (4)

SELECT EnglishProductName,
       SpanishProductName,
	   FrenchProductName
FROM DimProduct
Intersect
SELECT EnglishProductSubcategoryName,
       SpanishProductSubcategoryName,
	   FrenchProductSubcategoryName
FROM DimProductSubcategory;

--Easy-Level Tasks (5)
SELECT top 10 ProductKey,
       OrderDateKey,
	   UnitPrice,
	   ExtendedAmount
From FactInternetSales
UNION ALL
SELECT top 10 ProductKey,
       OrderDateKey,
	   UnitPrice,
	   ExtendedAmount 
FROM FactResellerSales

--Easy-Level Task (6)
 SELECT DISTINCT top 50 FirstName, --Ko'p bo'lgani uchun 50 tasini oldim
                 DepartmentName              
FROM DimEmployee;

--Easy-Level Tasks (7)
CREATE table table3(price int);
insert into table3 
values
(100),
(250),
(55),
(449),
(226),
(90),
(101),
(89),
(150),
(25)
SELECT *,
CASE		
    When price>100 then 'High'
	When price<=100 then 'Low'
	end as category
FROM table3;	
 
 --Easy-Level Tasks (8)
Create table Employees1 (EmployeeID int, Name varchar (20), Department varchar(20), Country varchar(20))
insert into Employees1
values
(1, 'Alice', 'HR', 'Canada'),
(2, 'Emma', 'Sale', 'Korea'),
(3, 'William', 'IT', 'USA'),
(4, 'Frank', 'IT', 'Canada'),
(5, 'Bob', 'IT', 'USA'),
(6, 'Kate', 'Sale', 'USA'),
(7, 'David', 'IT', 'Korea')
Select * From Employees1

Select Country, Count (*) as EmployeeCount
From Employees1
where Department = 'IT'
Group by Country

 --Easy-Level Tasks (9)

 SELECT COUNT(*) as [Number of Product], ProductCategoryKey
FROM DimProductSubcategory
GROUP BY ProductCategoryKey;

--Easy-Level Tasks (10)
SELECT 
      price,
	  IIF (price>100, 'Yes', 'No') as Stock
From table3;

--Medium-Level Tasks (11)

SELECT TOP 10
            DimCustomer.CustomerKey as [ClientKey], 
			DimCustomer.YearlyIncome,
			De.Title
 From DimCustomer 
INNER JOIN DimEmployee as De on DimCustomer.FirstName = De.FirstName

--Medium-Level Tasks (12)
SELECT 
      SpanishProductSubcategoryName
 FROM DimProductSubcategory
 Union
SELECT 
      SpanishProductCategoryName
 FROM DimProductCategory

 --Medium-Level Tasks (13)
 --Create table Products (ProductName varchar (50))
 --Insert into Products 
 --values
 --('Apple'),
 --('Orange'),
 --('Banana'),
 --('Melon'),
 --('Watermelon'),
 --('Pear')
 --Create table DiscontinuedProducts (ProductName varchar (50))
 --Insert into DiscontinuedProducts
 --values
 --('Apple'),
 --('Mandarin'),
 --('Kiwi'),
 --('Melon'),
 --('Watermelon'),
 --('Coconut')
 
SELECT * From Products
Except              -- 2 ta table taqqoslab, 2-table yo'q ma'lumotni oladi
SELECT * From DiscontinuedProducts

 --Medium-Level Tasks (14)
--Create table employee (Costumer varchar (30), Orders varchar (20))
--Insert into  employee
--values 
--('William', 'apple'),
--('Emma', 'apple'),
--('John', 'apple'),
--('Sara', 'apple'),
--('Kate', 'apple'),
--('William', 'orange'),
--('William', 'banana'),
--('William', 'kiwi'),
--('William', 'apple'),
--('Kate', 'abricot'),
--('Kate', 'kiwi'),
--('Kate', 'banana'),
--('Sara', 'melon'),
--('Kate', 'melon'),
--('Emma', 'watermelon')

Select Costumer,count(Orders) as cnt,
case when count(orders) >=5 then 'Eligeble' else 'Not Eligible' end as type from employee
Group by Costumer


 --Medium-Level Tasks (15)
SELECT 
      price,
	  IIF (price>100, 'Expensive', 'Affordable') as Category
From table3;
 
 --Medium-Level Tasks (16)
SELECT TOP 20
       MiddleName as [CustomerID],
	   COUNT(*) as [Number of Orders]
From DimCustomer
Group by GeographyKey, MiddleName

--Medium-Level Tasks (17)
--Create table Employees (FirstName varchar (55),
--                        Age int,
--						Salary int )
--Insert into Employees
--Values
--('Kate', 28, 8000),
--('Leo', 24, 5999),
--('John', 32, 6000),
--('Oliver', 18, 12000),
--('Emma', 23, 15000),
--('William', 29, 4000)

SELECT * FROM Employees
 Where  Age<25 or Salary>6000 

--Medium-Level Tasks (18)
Create table SalesTable (Region varchar (15), SalesAmount int)
Insert into SalesTable
values 
('Samarqand', 255000),
('Buxoro', 550000),
('Tashkent', 1500000),
('Samarqand', 856000),
('Andijon', 365000),
('Samarqand', 1200000),
('Tashkent', 999099),
('Andijon', 856000)

Select Region, Sum(SalesAmount)
from SalesTable
Group by Region


--Medium-Level Tasks (19)
SELECT
      DimCurrency.CurrencyName as Costumers,
	  DimCurrency.CurrencyAlternateKey as Orders,
	  DimOrganization.OrganizationKey as OrderDate
FROM DimCurrency
Left JOIN DimOrganization
ON DimCurrency.CurrencyKey = DimOrganization.CurrencyKey

--Medium-Level Tasks (20)
--Create table Employee20 (EmployeeID int, Name varchar (20), Department varchar (20), Salary int)
--Insert into Employee20
--values 
--(1, 'Kate', 'HR', 800000),
--(1, 'William', 'IT', 10100200),
--(1, 'Sara', 'Sales', 890000),
--(1, 'David', 'HR', 650000)


Update Employee20
 Set Salary = 
      Case 
	     when Department = 'HR' then Salary * 1.10
		 else Salary
		 end;

--Hard-Level Tasks (21)

--Create table Sales (SaleID int, ProductID varchar(10), Quantity int, SaleAmount int)
--Insert into Sales (SaleID, ProductID, Quantity, SaleAmount)
--Values 
--(101, 'A', 10, 100),
--(102, 'B', 20, 200),
--(103, 'A', 7, 70),
--(104, 'C', 5, 50)

--Create table Returns (SaleID int, ProductID varchar(10), Quantity int, SaleAmount int)
--Insert into Returns (SaleID, ProductID, Quantity, SaleAmount)
--Values 
--(201, 'A', 3, 50),
--(202, 'B', 2, 10),
--(203, 'A', 1, 20),
--(204, 'C', 5, 30)

Select ProductID,
         Sum(case when TransactionType = 'Sale' then Quantity Else 0 end) as TotalSalas,
		 Sum(case when TransactionType = 'Return' then Quantity Else 0 end) as TotalReturns
From(
Select ProductID, Quantity, 'Sale' as TransactionType
from Sales
Union all
Select ProductID, Quantity,'Return' as TransactionType
from Returns
) as CombinedTransactions
Group by ProductID
	

--Hard-Level Tasks (22)
SELECT * FROM Products
intersect                         --2 ta table da bor ma'lumotni oladi.
SELECT * FROM DiscontinuedProducts

--Hard-Level Tasks (23)
SELECT SalesAmountQuota as TotalSales,
       CASE
	       when SalesAmountQuota > 100000 then 'Top Teir' 
		   when SalesAmountQuota between 50000 and 100000 then 'Mid Teir'
		   else  'Low Teir' end as Category
FROM FactSalesQuota

--Hard-Level Tasks (24)

Create table Employee24 (EmployeeID int, Name varchar (20), Department varchar (20), Salary int)
Insert into Employee24
values 
(1, 'Kate', 'HR', 800000),
(1, 'William', 'IT', 10100200),
(1, 'Sara', 'Sales', 890000),
(1, 'David', 'HR', 650000)

DECLARE @EmployeeID INT, @Department VARCHAR(50), @Salary DECIMAL(10,2);

-- Declare a cursor to iterate through the Employees table
DECLARE employee_cursor CURSOR FOR 
SELECT EmployeeID, Department, Salary FROM Employee24;

-- Open the cursor
OPEN employee_cursor;

-- Fetch the first row
FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Department, @Salary;

-- WHILE loop to process each employee
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update salary based on department
    IF @Department = 'HR'
    BEGIN
        UPDATE Employee24 SET Salary = @Salary * 1.10 WHERE EmployeeID = @EmployeeID;
    END
    ELSE IF @Department = 'IT'
    BEGIN
        UPDATE Employee24 SET Salary = @Salary * 1.15 WHERE EmployeeID = @EmployeeID;
    END
    ELSE IF @Department = 'Sales'
    BEGIN
        UPDATE Employee24 SET Salary = @Salary * 1.12 WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        UPDATE Employee24 SET Salary = @Salary * 1.05 WHERE EmployeeID = @EmployeeID;
    END

    -- Fetch the next row
    FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Department, @Salary;
END;

-- Close and deallocate the cursor
CLOSE employee_cursor;
DEALLOCATE employee_cursor;

Select * from Employee24

--Hard-Level Tasks (25)

Create table Orders1 (OrderID int, CostumerID int)
Insert into Orders1
Values 
(3, 101),
(5, 102),
(2, 103),
(6, 104)

Create table Invoices (InvoiceID int, CostumerID int)
Insert into Invoices
Values 
(206, 101),
(323, 104)

Select CostumerID from Orders1
Except
Select CostumerId from Invoices

--Hard-Level Tasks (26)
--Create table Orders
--(OrderID int, CustomerID int, ProductID varchar(10), Region varchar (10), SalesAmount int)
--Insert into Orders
--Values 
--(1, 111, 'A002', 'North', 250),
--(2, 111, 'A002', 'North', 200),
--(3, 102, 'A004', 'South', 550),
--(4, 104, 'A002', 'East', 150),
--(5, 111, 'A004', 'North', 450)
--Select * from Orders
SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID, ProductID, Region;

--Hard-Level Tasks (27)


--Create table Orders27 (OrderID int, ProductID varchar(10), Quantity int)
--Insert into Orders27 (OrderID, ProductID, Quantity)
--Values 
--(201, 'A1', 125),
--(202, 'B2', 75),
--(203, 'A2', 60),
--(204, 'C3', 50)


Select OrderID 
       ProductID,
	   Quantity,
	   Case 
	       WHEN Quantity >= 100 THEN 20  -- 20% discount for 100+ items
        WHEN Quantity >= 50 THEN 15   -- 15% discount for 50-99 items
        WHEN Quantity >= 20 THEN 10   -- 10% discount for 20-49 items
        WHEN Quantity >= 10 THEN 5    -- 5% discount for 10-19 items
        ELSE 0                        -- No discount for less than 10 items
    END AS DiscountPercentage

From Orders27

--Hard-Level Tasks (28)
--Create table DisContinuedProducts29 (ProductID int, ProductName varchar(10), Stock int)
-- Insert into DisContinuedProducts29
-- values 
-- (109, 'IPhone', 12),
-- (101, 'IPad', 0),
-- (105, 'SDcard', 15),
-- (100, 'HardDisk', 0)


 Select Products29.ProductID, Products29.ProductName, Products29.Stock,
        Case when Products29.Stock>0 then 'In Stock' else 'Out of Stock' end as StockStatus,
		'Active' As ProductStatus 
 From Products29
 Inner Join 
 DisContinuedProducts29 on Products29.ProductID = DisContinuedProducts29.ProductID

 Union

 Select DiscontinuedProducts29.ProductID, DiscontinuedProducts29.ProductName, DiscontinuedProducts29.Stock,
         Case when DisContinuedProducts29.Stock>0 then 'In Stock' else 'Out of Stock' end as StockStatus,
		'DisActive' as ProductStatus
 From DiscontinuedProducts29

inner Join 
 Products29 on DisContinuedProducts29.ProductID = Products29.ProductID;
 
 --Hard-Level Tasks (29)
 --Create table Products29 (ProductID int, ProductName varchar(10), Stock int)
 --Insert into Products29
 --values 
 --(109, 'IPhone', 12),
 --(108, 'Monitor', 0),
 --(106, 'Laptop', 10),
 --(101, 'IPad', 0)

 Select ProductID, ProductName, Stock, 
       IIF (Stock>0, 'Available', 'Out of Stock') as inStock
From Products29

 --Hard-Level Tasks (30)

 Create table Costumers (CustomerID int , CostumerName varchar (10))
 Insert into Costumers
 values 
 (11, 'David'),
 (13, 'Emma'),
 (21, 'Kate'),
 (15, 'John')
  Create table VIPCostumers (CustomerID int , CostumerName varchar (10))
 Insert into VIPCostumers
 values 
 (13, 'Emma'),
 (15, 'John')

 Select * from Costumers
 Except
 Select * from VIPCostumers