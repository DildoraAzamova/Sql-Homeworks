
---Easy-Level Task (1)---

SELECT TOP 5*
FROM Employees;


---Easy-Level Task (2)---

SELECT DISTINCT ProductName
FROM Products;

---Easy-Level Task (3)---

SELECT ProductName, Price 
FROM Products
WHERE Price > 100;

---Easy-Level Task (4)---

SELECT * 
FROM Customers
WHERE CustomerName LIKE  'A%';

---Easy-Level Task (5)---

SELECT ProductName, Price
FROM Products
ORDER BY Price ASC;

---Easy-Level Task (6)---

SELECT EmployeeID, Salary, DepartmentName
FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR';

---Easy-Level Task (7)---

SELECT EmployeeID, ISNULL (Email, 'noemail@example.com')
FROM Employees;

---Easy-Level Task (8)---

SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100;

---Easy-Level Task (9)---

SELECT DISTINCT Category, ProductName
FROM Products;

---Easy-Level Task (10)---

SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;

---Medium-Level Task (11)---

SELECT TOP 10*
FROM Products
ORDER BY Price DESC;

---Medium-Level Task (12)---

SELECT COALESCE(FirstName, LastName) AS EmployeeName
FROM Employees;


---Medium-Level Task (13)---

SELECT DISTINCT Category, Price
FROM Products;

---Medium-Level Task (14)---

SELECT *
FROM Employees
WHERE Age BETWEEN 30 AND 40 OR DepartmentName = 'Marketing';

---Medium-Level Task (15)---

SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

---Medium-Level Task (16)---

SELECT ProductName, Price, StockQuantity
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity ASC;


---Medium-Level Task (17)---

SELECT *
FROM Products
WHERE ProductName LIKE '%e%';

---Medium-Level Task (18)---

SELECT *
FROM Employees
WHERE DepartmentName IN ('HR', 'IT', 'Finance');

---Medium-Level Task (19)---

SELECT *
FROM Customers
ORDER BY City ASC, PostalCode DESC;

---Hard-Level Task (20)---

SELECT TOP(10) ProductID, SalesAmount
FROM Sales
ORDER BY SalesAmount DESC;

---Hard-Level Task (21)---

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;


---Hard-Level Task (22)---

SELECT DISTINCT Category, ProductName, Price
FROM Products
WHERE Price > 50;

---Hard-Level Task (23)---

SELECT ProductName, Price 
FROM Products
WHERE Price < (0.1 * (SELECT AVG(Price) FROM Products));	

---Hard-Level Task (24)---

SELECT EmployeeID, Age, DepartmentName
FROM Employees
WHERE Age < 30 AND DepartmentName IN ('HR', 'IT');

---Hard-Level Task (25)---

SELECT CustomerName, Email
FROM Customers
WHERE Email LIKE '%@gmail.com';

---Hard-Level Task (26)---

SELECT EmployeeID, FirstName, LastName, Salary, DepartmentName
FROM Employees
WHERE Salary > ALL
   ( SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'HR'
);

---Hard-Level Task (27)---

SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD( DAY, -180, GETDATE()) AND GETDATE();

