
USE AdventureWorksDW2019;

--Easy-Level Tasks (1)
Select                   
     EnglishProductName as Name
 FROM DimProduct

--Easy-Level Tasks (2)
SELECT MiddleName
FROM DimCustomer as CLient

--Easy-Level Tasks (3)
 SELECT  EnglishProductName From DimProduct
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
SELECT ProductKey,
       OrderDateKey,
	   UnitPrice,
	   ExtendedAmount
From FactInternetSales
UNION ALL
SELECT  ProductKey,
       OrderDateKey,
	   UnitPrice,
	   ExtendedAmount 
FROM FactResellerSales

--Easy-Level Task (6)
 SELECT DISTINCT  FirstName, 
                 DepartmentName              
FROM DimEmployee;

--Easy-Level Tasks (7)

SELECT *,
CASE		
    When price>100 then 'High'
	When price<=100 then 'Low'
	end as category
FROM table3;	
 
 --Easy-Level Tasks (8)

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

SELECT 
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
 
SELECT * From Products
Except              
SELECT * From DiscontinuedProducts

 --Medium-Level Tasks (14)

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

SELECT * FROM Employees
 Where  Age<25 or Salary>6000 

--Medium-Level Tasks (18)

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

Update Employee20
 Set Salary = 
      Case 
	     when Department = 'HR' then Salary * 1.10
		 else Salary
		 end;

--Hard-Level Tasks (21)

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
intersect                        
SELECT * FROM DiscontinuedProducts

--Hard-Level Tasks (23)
SELECT SalesAmountQuota as TotalSales,
       CASE
	       when SalesAmountQuota > 100000 then 'Top Teir' 
		   when SalesAmountQuota between 50000 and 100000 then 'Mid Teir'
		   else  'Low Teir' end as Category
FROM FactSalesQuota

--Hard-Level Tasks (24)

DECLARE @EmployeeID INT, @Department VARCHAR(50), @Salary DECIMAL(10,2);

DECLARE employee_cursor CURSOR FOR 
SELECT EmployeeID, Department, Salary FROM Employee24;


OPEN employee_cursor;

FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Department, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN
   
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

    FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Department, @Salary;
END;

CLOSE employee_cursor;
DEALLOCATE employee_cursor;

Select * from Employee24

--Hard-Level Tasks (25)

Select CostumerID from Orders1
Except
Select CostumerId from Invoices

--Hard-Level Tasks (26)

SELECT CustomerID, ProductID, Region, SUM(SalesAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID, ProductID, Region;

--Hard-Level Tasks (27)

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

 Select ProductID, ProductName, Stock, 
       IIF (Stock>0, 'Available', 'Out of Stock') as inStock
From Products29

 --Hard-Level Tasks (30)

 Select * from Costumers
 Except
 Select * from VIPCostumers