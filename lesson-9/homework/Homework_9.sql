
---Easy-Level-Task (1)---

SELECT
      e.EmployeeID,
	  e.Name,
	  e.Salary,
	  d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 5000;

---Easy-Level-Task (2)---

SELECT
      c.CustomerID,
	  c.CustomerName,
	  o.OrderID,
	  o.OrderDate
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
Where YEAR (o.OrderDate) = 2023;

---Easy-Level-Task (3)---

SELECT 
     e.EmployeeID,
	 e.Name,
	 d.DepartmentName
FROM Employees e
LEFT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

---Easy-Level-Task (4)---

SELECT 
      s.SupplierName,
	  p.ProductName
FROM Products1 p
RIGHT OUTER JOIN Suppliers s
ON p.SupplierID = s.SupplierID;


---Easy-Level-Task (5)---

SELECT 
      o.OrderID,
	  o.CustomerID,
	  o.OrderDate,
	  p.PaymentID,
	  p.PaymentDate,
	  p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID;

---Easy-Level-Task (6)---

SELECT 
     e1.EmployeeID,
	 e1.Name,
	 e2.ManagerID,
	 e2.ManagerName
FROM Employees e1
LEFT JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID;


---Easy-Level-Task (7)---

SELECT
      p.ProductID,
	  p.ProductName,
	  s.SaleID,
	  s.SalesAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE SalesAmount > 100;

---Easy-Level-Task (8)---
select * from Students
select * from Courses


---Easy-Level-Task (9)---

SELECT
      c.CustomerID,
	  c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
Group by c.CustomerID, c.CustomerName
Having COUNT (o.OrderID) > 3;


---Easy-Level-Task (10)---

SELECT 
     e.EmployeeID,
	 e.Name,
	 d.DepartmentID,
	 d.DepartmentName
FROM Employees e
LEFT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR';


---Medium-Level-Task (11)---

SELECT 
      e.EmployeeID,
	  d.DepartmentName,
	  COUNT (d.DepartmentID) as [Number of Employee]
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY e.EmployeeID, d.DepartmentName
Having COUNT (d.DepartmentID) > 10;


---Medium-Level-Task (12)---

SELECT 
     p.ProductID,
	 p.ProductName,
	 s.SaleID,
	 s.Quantity
FROM Products p
LEFT OUTER JOIN Sales s
ON p.ProductID = s.ProductID
WHERE Quantity = 0;


---Medium-Level-Task (13)---

SELECT 
      c.CustomerID,
	  c.CustomerName,
	  o.OrderID
FROM Customers c
RIGHT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
Where o.OrderID IS NOT NULL;


---Medium-Level-Task (14)---

SELECT 
      e.EmployeeID,
	  e.Name,
	  d.DepartmentID,
	  d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IS NULL;


---Medium-Level-Task (15)---

SELECT
      e1.EmployeeID,
	  e1.Name,
	  e2.ManagerID,
	  e2.ManagerName
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.ManagerID
AND e1.EmployeeID <> e2.EmployeeID
ORDER BY e1.ManagerID;


---Medium-Level-Task (16)---

SELECT 
      c.CustomerName,
	  o.OrderID,
	  o.OrderDate
FROM Orders o
LEFT OUTER JOIN Customers c
ON o.CustomerID = c.CustomerID 
WHERE DATEDIFF (YEAR, o.OrderDate, GETDATE ()) = 2022;


---Medium-Level-Task (17)---

SELECT
      e.EmployeeID,
	  e.Name,
	  e.Salary,
	  d.DepartmentID,
	  d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID AND (d.DepartmentName = 'Sales' and e.Salary > 5000);


---Medium-Level-Task (18)---

SELECT
      e.EmployeeID,
	  e.Name,
	  d.DepartmentID,
	  d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'IT';


---Medium-Level-Task (19)---

SELECT 
      o.OrderID, 
      o.CustomerID, 
      o.OrderDate, 
      p.PaymentID, 
      p.PaymentDate, 
      p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.PayemntID
WHERE o.OrderID IS NOT NULL and p.PaymentID IS NOT NULL;


---Medium-Level-Task (20)---

SELECT
	  p.ProductID,
	  p.ProductName,
	  o.OrderID
FROM Products p
LEFT OUTER JOIN Orders o
ON p.ProductID = o.ProductID 
WHERE o.OrderID IS NULL;


---Hard-Level-Task (21)---

SELECT 
     e.EmployeeID,
	 e.Name,
	 e.Salary,
	 d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID 
WHERE e.Salary > (
      SELECT 
	       AVG (e1.Salary)
	  FROM Employees e1
	  WHERE e1.DepartmentID = d.DepartmentID
);


---Hard-Level-Task (22)---

SELECT
      o.OrderID,
	  o.CustomerID,
	  o.OrderDate,
	  p.PaymentID,
	  p.PaymentDate
FROM Orders o
LEFT OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE OrderDate < '2020-01-01' AND p.PaymentID IS NULL;


---Hard-Level-Task (23)---

SELECT 
      p.ProductID,
	  p.ProductName,
	  c.CategoryID,
	  c.CategoryName
FROM Products p
FULL OUTER JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryID is NULL;


---Hard-Level-Task (24)---

SELECT 
     e1.EmployeeID,
	 e1.Name,
	 e1.Salary,
	 e2.ManagerID,
	 e2.ManagerName
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.ManagerID
AND e1.EmployeeID <> e2.EmployeeID
WHERE e1.Salary > 5000;


---Hard-Level-Task (25)---

SELECT 
     e.EmployeeID,
	 e.Name,
	 d.DepartmentID,
	 d.DepartmentName
FROM Employees e
RIGHT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';


---Hard-Level-Task (26)---

SELECT
     p.ProductID,
	 p.ProductName,
	 s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE SaleAmount > 1000;


---Hard-Level-Task (27)---

SELECT s.StudentID, s.StudentName
FROM Students s
LEFT OUTER JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT OUTER JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName IS NULL OR c.CourseName <> 'Math 101';


---Hard-Level-Task (28)---

SELECT 
      o.OrderID,
	  o.CustomerID,
	  p.PaymentID
	  p.AmountPayment
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NOT NULL;


---Hard-Level-Task (29)---

SELECT
      p.ProductID,
	  p.ProductName,
	  c.CategoryName
FROM Products p
INNER JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR c.CategoryName = 'Furniture';


---Hard-Level-Task (30)---

SELECT 
      c.CustomerID,
	  c.CustomerName,
	  COUNT (o.OrderID) AS TotalOrders
FROM Customers c
CROSS JOIN Orders o
WHERE YEAR (o.OrderDate) = 2023
Group by c.CustomerID, c.CustomerName
HAVING COUNT (o.OrderID) > 2;
