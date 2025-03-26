
---Easy-Level-task (1)

SELECT
      o.OrderID,
	  o.OrderDate,
	  c.CustomerID,
	  c.CustomerName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
AND YEAR (o.OrderDate) > 2022;


---Easy-Level-task (2)

SELECT 
     e.EmployeeID,
	 e.Name,
	 d.DepartmentID,
	 d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
and (d.DepartmentName = ('Sales') OR d.DepartmentName = ('Marketing'));


---Easy-Level-task (3)

SELECT 
     p.ProductID,
	 P.ProductName,
	 P.Price,
	 o.OrderID
FROM  (
    SELECT * FROM Products
	WHERE Price > 100
) AS p
JOIN Orders o
ON p.ProductID = o.OrderID;


---Easy-Level-task (4)

SELECT 
      o.OrderID,
	  o.CustomerID
FROM Orders o
INNER JOIN Temp_Orders tor
ON o.OrderID = tor.OrderID;


---Easy-Level-task (5)

SELECT
     e.EmployeeID,
	 e.Name,
	 TopSales.SaleID,
	 TopSales.SaleAmount,
	 TopSales.SaleDate
FROM Employees e
CROSS APPLY (               
      SELECT TOP 5 s.*   
	  FROM Sales1 s
	  WHERE s.DepartmentID = e.DepartmentID
	  ORDER BY s.SaleAmount DESC
) AS TopSales;


---Easy-Level-task (6)

SELECT
      c.CustomerID,
	  c.CustomerName,
	  c.LoyaltyStatus, 
	  o.OrderID,
	  o.OrderDate
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
AND (YEAR (o.OrderDate) = 2023
AND c.LoyaltyStatus = 'Gold';  


---Easy-Level-task (7)

SELECT
      c.CustomerName,
	  ord.CustomerID,
	  ord.TotalOrder
FROM (
   SELECT 
       o.CustomerID,
	   Count (o.OrderID) AS TotalOrder
   FROM Orders o
   GROUP BY o.CustomerID 
) AS ord
JOIN Customers c
ON c.CustomerID = ord.CustomerID

---Easy-Level-task (8)

SELECT
      p.ProductID,
	  p.ProductName,
	  s.SupplierID,
	  s.SupplierName
FROM Products p   
JOIN Suppliers s
ON p.ProductID = s.PruductID
AND s.SupplierName = 'Supplier A'
OR s.SupplierName = 'Supplier B'


---Easy-Level-task (9)

SELECT 
     c.CustomerID,
	 c.CustomerName,
	 ord.OrderID,
	 ord.OrderDate
FROM Customers c
OUTER APPLY 
(
  SELECT TOP 1*
  FROM Orders o
  Where o.CustomerID = c.CustomerID
  ORDER BY o.OrderDate DESC
) as ord


---Easy-Level-task (10)

SELECT 
    d.DepartmentID, 
    d.DepartmentName, 
    e.EmployeeID, 
    e.EmployeeName, 
    e.JobTitle
FROM Departments d
CROSS APPLY GetEmployeesByDepartment(d.DepartmentID) e;

---Easy-Level-task (11)

SELECT 

     c.CustomerID,
	c.CustomerName,
	a.total_amount
FROM Customers c
JOIN (select CustomerID, sum(OrderAmount) as Total_amount from Orders group by CustomerID ) a 
on c.CustomerID = a.CustomerID and Total_amount > 500


---Easy-Level-task (12)

SELECT
     p.ProductID,
	 p.ProductName,
	 s.SaleID,
	 s.SaleDate,
	 s.Discount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
AND (YEAR (s.OrderDate) = 2022 OR s.Discount > 20);


---Easy-Level-task (13)

SELECT 
    p.ProductID, 
    p.ProductName, 
    sales_summary.TotalSales
FROM Products p
 JOIN (
    SELECT ProductID, SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) sales_summary 
ON p.ProductID = sales_summary.ProductID;


---Easy-Level-task (14)

SELECT 
     p.ProductID,
	 p.ProductName,
	 tp.Discontinued
FROM Temp_Products tp
JOIN Products p
ON tp.ProductID = p.ProductID
WHERE tp.Discontinued = 1;


---Easy-Level-task (15)

SELECT 
    e.EmployeeID, 
    e.Name, 
    es.TotalSales, 
    es.AvgSaleAmount
FROM Employees e
CROSS APPLY GetEmployeeSales(e.EmployeeID) es;


---Easy-Level-task (16)

SELECT
      e.EmployeeID,
	  e.Name,
	  d.DepartmentName,
	  e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND d.DepartmentName = 'Human Resources' And e.Salary > 5000;


---Easy-Level-task (17)

SELECT
     o.OrderID,
	 o.CustomerID,
	 p.PaymentID,
	 p.PaymentStatus
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID
AND (p.PaymentStatus = 'FULL' OR p.PaymentStatus = 'Partial'); 


---Easy-Level-task (18)

SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate, 
    o.TotalAmount
FROM Customers c
OUTER APPLY (
    SELECT TOP 1 o.OrderID, o.OrderDate, o.TotalAmount
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY o.OrderDate DESC 
) o;

---Easy-Level-task (19)
		
SELECT
     p.ProductID,
	 p.ProductName,
	 s.SaleID,
	 s.SaleDate,
	 p.SaleRating
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID 
AND YEAR (s.SaleDate) = 2023 AND p.SaleRating > 4;


---Easy-Level-task (20)

SELECT
     e.EmployeeID,
	 e.Name,
	 e.JobTitle,
	 d.DepartmentID,
	 d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND d.DepartmentName = 'Sales' OR e.JobTitle LIKE '%Manager%';


---Easy-Level-task (21)

SELECT 
     ord.CustomerID,
	 c.CustomerName,
	 c.Country
	
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
AND c.Country = 'New Yotk' 
JOIN (
     SELECT o1.CustomerID,  COUNT (o1.OrderID) AS TotalOrders 
	 FROM Orders o1
	 GROUP BY o1.CustomerID
	 HAVING COUNT (o1.OrderID) > 10
) AS ord
ON c.CustomerID = ord.CustomerID;


---Easy-Level-task (22)

SELECT p.ProductID, 
       p.ProductName, 
	   p.Category, 
	   s.SaleID, 
	   s.SaleDate, 
	   s.Discount 
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID 
AND (p.Category = 'Electronics'
OR s.Discount > 15);


---Easy-Level-task (23)

SELECT distinct c.CategoryID, c.CategoryName, p.ProductCount 
FROM Categories c
 JOIN(
      SELECT CategoryID, COUNT(*) AS ProductCount
	  FROM Productss 
	  GROUP BY CategoryID
 ) p
 ON c.CategoryID = p.CategoryID;


 ---Easy-Level-task (24)

SELECT e.EmployeeID, e.Name, e.Salary, e.Department, t.Temp_EmployeeID
FROM Employees e
INNER JOIN Temp_Employees t
ON e.EmployeeID = t.Temp_EmployeeID
AND e.Salary > 4000
AND e.Department = 'IT';


 ---Easy-Level-task (25)

SELECT 
    d.DepartmentID, 
    d.DepartmentName, 
    e.EmployeeCount
FROM Departments d
CROSS APPLY GetEmployeeCount(d.DepartmentID) e;


 ---Easy-Level-task (26)

SELECT 
     c.CustomerName,
	 c.Country,
	 o.OrderID,
	 o.OrderAmount
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND c.Country = 'California' and o.OrderAmount > 1000;

 ---Easy-Level-task (27)

SELECT 
    e.EmployeeID, 
    e.Name, 
    e.JobTitle, 
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID 
    AND d.DepartmentName IN ('HR', 'Finance') 
    OR e.JobTitle LIKE '%Executive%';


 ---Easy-Level-task (28)

SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate, 
    o.TotalAmount
FROM Customers c
OUTER APPLY GetCustomerOrders(c.CustomerID) o
WHERE o.OrderID IS NULL;

 ---Easy-Level-task (29)

SELECT
     p.ProductID,
	 p.ProductName,
	 p.Price,
	 s.SaleID,
	 s.Quantity
FROM Sales s
JOIN Products p
ON s.ProductID = p.ProductID
AND s.Quantity > 100 AND p.Price >50;


 ---Easy-Level-task (30)

SELECT e.EmployeeID, e.Name, e.Salary, d.DepartmentID, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing')
AND e.Salary > 6000; 