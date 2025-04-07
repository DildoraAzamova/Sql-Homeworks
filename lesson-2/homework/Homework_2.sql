
---Basic-Level Task (1)---

CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2));

---Basic-Level Task (2)---

INSERT INTO Employees  (EmpID, Name, Salary)
VALUES (1, 'John', 200000.000)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES  (2, 'William', 525000.020),
        (3, 'David', 654200.100)
 
---Basic-Level Task (3)---

UPDATE Employees
SET Salary = 750000
WHERE EmpID = 1;

---Basic-Level Task (4)---

DELETE FROM Employees
WHERE EmpID =2;

---Basic-Level Task (5)---

DELETE FROM TestTable WHERE ID = 2; ---The DELETE command removes rows from a table based on a specified condition. 
                                   ---It can be rolled back if the transaction is not committed. It does not reset the identity column if there is one.

TRUNCATE TABLE TestTable; ---This will remove all rows from the table, but the table structure remains. Identity column (if present) is reset to its seed value.

DROP TABLE TestTable;   ----This completely removes the table from the database, including all data and the table structure.

---Basic-Level Task (6)---

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

---Basic-Level Task (7)---

ALTER TABLE Employees
ADD  Department VARCHAR(50);

---Basic-Level Task (8)---

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

---Basic-Level Task (9)---

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));

---Basic-Level Task (10)---

TRUNCATE TABLE Employees;

---Intermediate-Level Tasks (11)---

INSERT INTO Departments (DeptID, DeptName)
SELECT TOP 5 DeptID, DeptName
FROM SourceDepartments;

---Intermediate-Level Tasks (12)---

UPDATE Employees
SET DepartmentName = 'Management'
WHERE Salary > 5000;

---Intermediate-Level Tasks (13)---

DELETE FROM Employees;

---Intermediate-Level Tasks (14)---

ALTER TABLE Employees
DROP COLUMN Department;

---Intermediate-Level Tasks (15)---

EXEC sp_rename 'Employees', 'StaffMembers';

---Intermediate-Level Tasks (16)---

DROP TABLE Departments;

---Advanced-Level Tasks (17)---

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);
INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES 
(1, 'Wireless Mouse', 'Electronics', 25.99, 100),
(2, 'Bluetooth Speaker', 'Electronics', 45.50, 60),
(3, 'Organic Green Tea', 'Grocery', 12.75, 200),
(4, 'Notebook', 'Stationery', 3.49, 500),
(5, 'LED Desk Lamp', 'Home Decor', 29.99, 80);

---Advanced-Level Tasks (18)---

ALTER TABLE Products
ADD CONSTRAINT chk_price_positive
CHECK (Price > 0);

---Advanced-Level Tasks (19)---

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

---Advanced-Level Tasks (20)---

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

---Advanced-Level Tasks (21)---

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (6, 'Laptop', 'Electronics', 1200.00, 50);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (7, 'Smartphone', 'Electronics', 800.00, 100);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (8, 'Chair', 'Furniture', 150.00, 200);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (9, 'Table', 'Furniture', 300.00, 150);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (10, 'Headphones', 'Accessories', 50.00, 300);

---Advanced-Level Tasks (22)---

SELECT * INTO Products_Backup
FROM Products;

---Advanced-Level Tasks (23)---

EXEC sp_rename 'Products', 'Inventory';

---Advanced-Level Tasks (24)---

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

---Advanced-Level Tasks (25)---

ALTER TABLE Products
ADD ProductCode INT IDENTITY(1000, 5);