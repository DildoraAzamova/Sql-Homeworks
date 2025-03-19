
 
 ---- Easy-Level Task (1) -----

Select
       Min(SalesAmount) as MinPrice
 from Orders

 ---- Easy-Level Task (2) -----
 Select 
       Max(Salary) as MaxSalary
 From Employees

  ---- Easy-Level Task (3) -----
  Select
       Count(*) as number_of_rows
  from DimCurrency

    ---- Easy-Level Task (4) -----
Select EnglishProductName as ProductName,
      Count(Distinct EnglishProductName ) as ProductCategory
from DimProduct
group by EnglishProductName

    ---- Easy-Level Task (5) -----
Select 
      Sum(SaleAmount) as TotalSale
From Sales

    ---- Easy-Level Task (6) -----
Select 
     Avg (Age) as AvaregeAge
from Employees 

    ---- Easy-Level Task (7) -----
Select Department, 
       Count (EmployeeID) as [Number of Employee]
From Employees1
Group by Department;

    ---- Easy-Level Task (8) -----

Select ProductID,
      Min (SalesAmount) as MinSale,
	  Max (SalesAmount) as MaxSale
From Orders
Group by ProductId;

    ---- Easy-Level Task (9) -----

Select Region,
       Sum(SalesAmount) as TotalSale
From SalesTable
Group by Region;

    ---- Easy-Level Task (10) -----

Select Department
       Department, 
	  Count (EmployeeID) as EmployeeCount
From Employees1
Group by Department
Having Count (EmployeeID)>5;

     ----  Medium-Level Task (11) -----

Select ProductID,
       Sum (SaleAmount) as TotalSale,
	   Avg (SaleAmount) as AvgSale
From Sales
Group by ProductID;

    ----  Medium-Level Task (12) -----

Select EnglishOccupation as Jobtitle,
       Count (FirstName) as [Number of Employee]
From DimCustomer
Group by EnglishOccupation;
 
 ----  Medium-Level Task (13) -----

Select Department, 
       MAX (Salary) as MaxSalary,
	   Min (Salary) as MinSalary
From Employee20
Group by Department;

    ----  Medium-Level Task (14) -----
Select Department,
       AVG(Salary) as AvgSalary
From Employee20
Group by Department;

    ----  Medium-Level Task (15) -----

 Select EnglishOccupation as Department,
        AVG (YearlyIncome) as  AvgSalary,
		Count (FirstName)  as Employees
from DimCustomer
Group by EnglishOccupation;

    ----  Medium-Level Task (16) -----

Select 
     EnglishProductName as Product,
	 Avg (ListPrice) as AvgPrice
From DimProduct
Group by EnglishProductName
Having Avg(ListPrice)>100;

    ----  Medium-Level Task (17) -----

Select 
     Count (Distinct ProductID) ProductCount
From Sales
group by ProductID
Having Sum (Quantity)>100;

    ----  Medium-Level Task (18) -----

SELECT YEAR(StartDate) AS Year, SUM(SafetyStockLevel) AS TotalSales
FROM DimProduct
GROUP BY YEAR(StartDate)
ORDER BY Year;

    ---- Medium-Level Task (19) -----
Select * from Orders
Select Region,
       Count (CustomerID) as [Number of Costumer]
From Orders
group by Region;

    ---- Medium-Level Task (20) -----

Select 
     Department,
	 Sum (Salary) as TotalSalary
From Employee20
Group by Department
Having Sum (Salary)>100000



    ---- Hard-Level Task (21) -----

Select ProductID,
      Avg(SalesAmount) as AvgSale
From Orders
group by ProductID
Having Avg (SalesAmount)>200;

    ---- Hard-Level Task (22) -----

Select 
      CustomerID,
	  Sum (SalesAmount)  as TotalSales
from Orders
Group by CustomerID
Having Sum (SalesAmount)>5000;

    ---- Hard-Level Task (23) -----

Select EnglishOccupation as Department,
       Sum (YearlyIncome) as TotalSalary,
	   AVG (YearlyIncome) as AvgSalaruy
From DimCustomer
Group by EnglishOccupation
Having Avg (YearlyIncome)>6000;

    ---- Hard-Level Task (24) -----
Select * from DimEmployee
Select FirstName,
       Min (PayFrequency) as MinOrder,
	   MAx (PayFrequency) as MaxOrder
From DimEmployee
Group by FirstName
Having Sum (PayFrequency)<50;

    ---- Hard-Level Task (25) -----
Select * from Orders
Select 
      Region, ProductID,
      Sum (SalesAmount) as TotalSale,
	  Count(Distinct ProductID) as EachRegion
From Orders
Group by Region, ProductID

    ---- Hard-Level Task (26) -----

Select 
     ProductID as ProductCategpry, 
	 Min(Quantity) as MinQuantity,
	 Max(Quantity) as MaxQuantity
from Sales
Group by ProductID

    ---- Hard-Level Task (29) -----

Select 
     EnglishProductName as ProductName,
	 Count(ProductSubcategoryKey) as [Number of orders]
from  DimProduct
group by EnglishProductName
Having Count(Distinct ProductSubcategoryKey)>50