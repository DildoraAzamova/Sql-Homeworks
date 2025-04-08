
---Easy-Level Tasks (1)---

--- 1. Define and explain the purpose of BULK INSERT in SQL Server.
--- BULK INSERT in SQL Server is a Transact-SQL (T-SQL) command used to import a large volume of data from a data file into a SQL Server table or view quickly and efficiently.
--- High Performance: It is optimized for speed and can insert thousands or millions of records much faster than individual INSERT statements.
--- Efficient Data Migration: Useful for importing data from external sources (like logs, CSV exports, or ETL pipelines).
--- Simplicity: A straightforward way to load flat file data without needing extra tools like SSIS or bcp.

---Easy-Level Tasks (2)---

---CSV (Comma-Separated Values): Widely used format where fields are separated by commas. Easily handled by BULK INSERT, bcp, and SQL Server Import Wizard.

---TXT (Plain Text Files): Often used with custom delimiters like tabs (\t) or pipes (|). Compatible with BULK INSERT and bcp.

---Excel Files (.xls, .xlsx): Requires using SQL Server Integration Services (SSIS), OPENROWSET, or linked servers. Not supported directly by BULK INSERT.

---XML (eXtensible Markup Language): Can be imported using OPENXML, xml data type, or SSIS. Ideal for hierarchical or structured data.

---Easy-Level Tasks (3)---

CREATE TABLE Product (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2));

---Easy-Level Tasks (4)---

INSERT INTO Products
VALUES (1, 'Apple', 150000),
       (1, 'Orange', 256000);

---Easy-Level Tasks (5)---

---NULL represents missing, unknown, or undefined data. It means no value has been assigned to the column. NULL is not equal to zero, an empty string (''), or any specific value.
---NOT NULL is a constraint that prevents a column from having NULL values. You must provide a value when inserting data.

---Easy-Level Tasks (6)---

ALTER TABLE Products
ADD CONSTRAINT UC_ProductName UNIQUE (ProductName);

---Easy-Level Tasks (7)---

--- In SQL, comments are used to explain the purpose or logic of a query. There are two ways to write comments in SQL: Single-line comments: Use -- to write comments for a single line. Multi-line comments: Use /* */ to write comments across multiple lines.

---Easy-Level Tasks (8)---

CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE);

---Easy-Level Tasks (9)---

---In SQL Server, the IDENTITY column is used to automatically generate unique, sequential numeric values for a column. This is typically used for primary key columns or any column where each row needs a unique identifier. The values are automatically incremented for each new row inserted into the table.

---Medium-Level Tasks (10)---
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
       FIELDTERMINATOR = ',',
	   ROWTERMINATOR = '\n',
	   FIRSTROW = 2
      );


---Medium-Level Tasks (11)---

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

---Medium-Level Tasks (12)---

--- PRIMARY KEY is Enforces unique values, Not allowed (cannot be NULL), Only one PRIMARY KEY per table, Creates a clustered index by default, Identifies records uniquely
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,       -- Must be unique and NOT NULL
    Name VARCHAR(100),
    Email VARCHAR(100)
);

--- UNIQUE KEY is Enforces unique values, Allowed (but only one NULL per column), Can have multiple UNIQUE keys, Creates a non-clustered index by default, Ensures data uniqueness for a column
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE         -- Must be unique, but can be NULL once
);

---Medium-Level Tasks (13)---

ALTER TABLE Products
ADD CHECK (Price > 0);

---Medium-Level Tasks (14)---

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

---Medium-Level Tasks (15)---

SELECT ISNULL(NULL, 'Replacement') AS result;

---Medium-Level Tasks (16)---

---A FOREIGN KEY constraint is used to enforce a link between the data in two tables. It ensures referential integrity by making sure that a value in one table (child) must match a value in another table (parent).

---Hard-Level Tasks (17)---

CREATE TABLE Customers (CustomerID int, CustomerName VARCHAR(50), Age INT ChECK (Age >= 18) );

---Hard-Level Tasks (18)---

CREATE TABLE Orders (OrderID int IDENTITY (100, 10),
                     CustomerName VARCHAR(100),
                     OrderDate DATE
);

---Hard-Level Tasks (19)---

CREATE TABLE OrderDetails(
          OrderID INT,
		  ProductID INT,
          Quantity INT,
          Price DECIMAL(10, 2),
		  PRIMARY KEY (OrderID, ProductID)
);

---Hard-Level Tasks (20)---

---ISNULL() replaces a single NULL value with a specified value.
SELECT ProductName, ISNULL(Description, 'No description') AS Description
FROM Products1;

--- COALESCE() Returns the first non-null value from a list of expressions.
SELECT ProductName,
       COALESCE(Description, ShortDescription, 'No info') AS Description
FROM Products1;

---Hard-Level Tasks (21)---

CREATE TABLE Employees(
         EmpID INT PRIMARY KEY,
		 EmpName VARCHAR(50),
		 Email VARCHAR (50) UNIQUE
);

---Hard-Level Tasks (22)---

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE;
