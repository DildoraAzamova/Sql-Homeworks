
---Easy-Level Tasks (1)----

SELECT 
      Customers.CustomerName,
	  Orders.OrderDate
FROM Customers
INNER JOIN  Orders
ON Customers.CustomerID = Orders.CustomerID;


---Easy-Level Tasks (2)----

SELECT
     e.Name,
	 ed.RoleName,
	 e.Salary,
	 ed.StartDate
FROM Employees e
JOIN EmployeeDetails ed
ON e.EmployeeID = ed.EmployeeID;


---Easy-Level Tasks (3)----

SELECT 
     p.ProductName,
	 c.CategoryName
FROM Products p
INNER JOIN Categories c
ON p.ProductID = c.ProductID;


---Easy-Level Tasks (4)----

SELECT
       Customers.CustomerID, 
       Customers.CustomerName, 
       Orders.OrderDate
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


---Easy-Level Tasks (5)----

SELECT 
        o.OrderID,
		o.CustomerID,
		o.OrderDate,
		p.ProductID,
		p.ProductName,
		od.Quantity    
FROM Orders o
Inner Join OrderDetails od 
ON o.OrderID = od.OrderID
Inner Join Products p 
ON od.ProductID = p.ProductID;


---Easy-Level Tasks (6)----

SELECT 
     p.ProductName,
	 c.CategoryName
FROM Products p
CROSS JOIN Categories c;


---Easy-Level Tasks (7)----

SELECT
      c.CustomerID,
	  c.CustomerName,
	  o.OrderID,
	  o.OrderDate
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;


---Easy-Level Tasks (8)----

SELECT 
      p.ProductName,
	  o.OrderAmount
FROM Products p
CROSS JOIN Orders o
WHERE OrderAmount > 500;


---Easy-Level Tasks (9)----

SELECT e.Name,
        d.DepartmentName
FROM Employees e
Inner Join Departments d
ON e.DepartmentID = d.DepartmentID;


---Easy-Level Tasks (10)----

SELECT
      e.EmployeeID,
	  e.Name,
	  e.DepartmentID AS EmpDeptID,
	  d.DepartmentID AS DeptID,
	  d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID <> d.DepartmentID;


---Medium-Level Tasks (11)----

SELECT
	  c.CustomerName,
	  Count (o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;


---Medium-Level Tasks (12)----

SELECT 
      Students.StudentName, 
	  Courses.CourseName
FROM Students
INNER JOIN StudentCourses 
ON Students.StudentID = StudentCourses.StudentID
INNER JOIN Courses 
ON StudentCourses.CourseID = Courses.CourseID;


---Medium-Level Tasks (13)----

SELECT 
      e.EmployeeID,
	  e.Name,
	  e.Salary,
	  d.DepartmentID,
	  d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE Salary > 5000;


---Medium-Level Tasks (14)----

SELECT 
      e.EmployeeID,
	  e.Name,
	  ed. RoleName,
	  ed.Salary,
	  ed.StartDate
FROM Employees e
JOIN EmployeeDetails ed
ON e.EmployeeID = ed.EmployeeID;


---Medium-Level Tasks (15)----

SELECT
     p.ProductID,
	 p.ProductName,
	 s.SupplierID,
	 s.SupplierName
FROM Products1 p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Supplier A';
 

---Medium-Level Tasks (16)----

SELECT 
      p.ProductID,
	  p.ProductName,
	  s.Quantity
FROM Products p
LEFT JOIN Sales s
ON p.ProductID = s.ProductID;


---Medium-Level Tasks (17)----

SELECT 
      e.EmployeeID,
	  e.Name,
	  e.Salary,
	  ed.DepartmentName
FROM Employees e
JOIN EmployeeDepartments ed
ON e.EmployeeID = ed.EmployeeID
WHERE Salary > 4000 
AND ed.DepartmentName = 'HR';


---Medium-Level Tasks (18)----

SELECT 
	  o.ProductID,
	  o.Quantity
FROM Orders o
JOIN Sales s
ON o.Quantity >= s.Quantity;


---Medium-Level Tasks (19)----

SELECT 
     p.ProductID,
	 p.ProductName,
	 p.Price,
	 s.SupplierID,
	 s.SupplierName
FROM Products1 p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE p.Price >= 50;


---Medium-Level Tasks (20)----

SELECT 
      s.SalesID,
	  s.SalesAmount,
	  r.RegionName
FROM Sales s
CROSS JOIN Regions r
WHERE s.SalesAmount > 1000;


---Medium-Level Tasks (21)----

SELECT
      a.AuthorName,
	  b.BookTitle
FROM Authors a
INNER JOIN AuthorBooks ab
ON a.AuthorID = ab.AuthorID
INNER JOIN Books b
ON ab.BookID = b.BookID;


---Hard-Level Task (22)----

SELECT 
      p.ProductID,
	  p.ProductName,
	  c.CategoryName
FROM Productss p
INNER JOIN Categories c
ON p.CategoryID = c.CategoryID
where c.CategoryName != 'Electronics';


---Hard-Level Task (23)----

SELECT 
      o.OrderID,
	  o.ProductID,
	  p.ProductName,
	  p.StockQuantity
FROM Orders o
CROSS JOIN Productss p
Where StockQuantity > 100;


---Hard-Level Task (24)---

SELECT 
      e.EmployeeID,
	  e.Name,
	  d.DepartmentName,
	  e.HireDate
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND DATEDIFF (YEAR, e.HireDate, GETDATE ()) > 5;


---Hard-Level Task (25)---

SELECT 
	  e.Name,
	  d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;

SELECT 
	  e.Name,
	  d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID;


---Hard-Level Task (26)----

SELECT 
      p.ProductID,
	  p.ProductName,
	  p.Category,
	  s.SupplierID,
	  s.SupplierName
FROM Products1 p
CROSS JOIN Suppliers s
WHERE p.Category = 'Category A';


---Hard-Level Task (27)----

SELECT
      c.CustomerID,
	  c.CustomerName,
	  o.OrderID,
	  o.Quantity
FROM Customers c 
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
Where	Quantity >= 10;


---Hard-Level Task (28)----

SELECT 
      Courses.CourseID, Courses.CourseName, 
      COUNT(Enrollments.StudentID) AS StudentCount
FROM Courses
INNER JOIN Enrollments 
ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseID, Courses.CourseName;


---Hard-Level Task (29)----

SELECT  
       e.EmployeeID,
	   e.Name,
	   d.DepartmentID,
	   d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';


---Hard-Level Task (30)----

 SELECT 
       e.EmployeeID,
	   e.Name,
	   e.HireDate,
	   s.OrderDate 
 FROM Employees e
 INNER JOIN Sales s
 ON e.HireDate <= s.OrderDate;

