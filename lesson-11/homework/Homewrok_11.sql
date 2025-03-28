
---Task 1---

SELECT 
     e.Name,
	 d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

---Task 2---

       c.ClassName
FROM Students s
LEFT JOIN Classes c
ON s.ClassID = c.ClassID


---Task 3---

SELECT
      c.CustomerName,
	  o.OrderID
FROM Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID


---Task 4---

SELECT 
     p.ProductName,
	 s.SaleID
FROM Products p
FULL OUTER JOIN Sales s
ON p.ProductID = s.ProductID


---Task 5---

SELECT 
    e.EmployeeID, 
    e.EmployeeName AS Employee, 
    m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m 
ON e.ManagerID = m.EmployeeID;


---Task 6---

SELECT 
      c.ColorName,
	  s.SizeName
FROM Colors c
CROSS JOIN Sizes s


---Task 7---

SELECT
     m.Title,
	 m.ReleaseYear,
	 a.Name
FROM Movies m
JOIN Actors a
ON m.MovieID = a.MovieID
WHERE m.ReleaseYear > 2015


---Task 8---

SELECT 
       o.OrderID,
	   o.OrderDate,
       c.CustomerName,
	   d.ProductID
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN OrderDetails d
ON o.OrderID = d.OrderID

---Task 9---

SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
INNER JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;