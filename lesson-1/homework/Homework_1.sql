
---EASY (1)---
--- 1. Define the following terms: data, database, relational database, and table.
--- Data refers to raw facts or figures that have no context or meaning on their own. It can be numbers, text, images, or any other input that can be processed.
--- A Database is an organized collection of data that is stored and accessed electronically. It allows for easy retrieval, insertion, updating, and management of data.
--- A Relational Database is a type of database that stores data in tables (rows and columns) and allows relationships between the data using keys. It follows the principles of relational algebra.
--- A Table is a structured format within a database, consisting of rows (records) and columns (fields). Each table typically represents one entity, such as customers, orders, or products.

---EASY (2)---
--- 2. List five key features of SQL Server.
--- Joining Tables for Comprehensive Insights.
--- Aggregation and Grouping.
--- Sorting Data for Analysis.
--- Subqueries for Complex Queries.
--- Data Security and Access Control.

---EASY (3)---

--- 3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--- Windows Authentication and SQL Server Authentication

---Medium (4)---

CREATE DATABASE SchoolDB;

---Medium (5)---

CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT);

---Medium (6)---

--- 6.Describe the differences between SQL Server, SSMS, and SQL.
--- SQL Server (also known as Microsoft SQL Server) is a relational database management system (RDBMS) developed by Microsoft. It is the platform that stores, manages, and processes databases. It provides the infrastructure and tools to store and retrieve data, and also ensures data integrity, security, and performance.
--- SSMS is a graphical interface (GUI) for managing SQL Server databases. It's a tool used to connect to an instance of SQL Server, create and manage databases, run SQL queries, and handle various administrative tasks like backups, restores, security management, and performance tuning.
--- SQL (pronounced "ess-que-el") is the standard language used to communicate with relational databases like SQL Server. SQL is used to query, insert, update, and delete data, as well as manage database structures (tables, views, indexes, etc.).

---Hard (7)---

--- 7.Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--- DQL is used to query or retrieve data from a database. It allows you to select and view data but does not modify the database.
   SELECT * FROM Students

--- DML is used to manipulate the data inside database tables. It allows you to insert, update, and delete data.
   INSERT INTO Students (ID, Name, Age, Grade)
   VALUES (1, 'John Doe', 18, 'A');

--- DDL is used to define and manage database structures like tables, views, and indexes. It involves the creation, alteration, or deletion of database objects, but it does not manipulate the data inside those objects.
   DROP TABLE Students;

--- DCL is used to control access to the data in a database. It defines the permissions or rights of users for database operations.
   GRANT SELECT ON Students TO john;

--- TCL is used to manage transactions in a database. Transactions allow a set of SQL commands to be executed together, and TCL commands control whether changes made by these commands are saved or discarded.
   -- Create a savepoint
    SAVEPOINT BeforeUpdate;
	-- Update some data
    UPDATE Students SET Grade = 'A' WHERE ID = 1;
    -- Rollback to the savepoint if needed
    ROLLBACK TO BeforeUpdate;


---Hard (8)---

INSERT INTO Students (StudentID, Name, Age)
VALUES (1, 'John', 23),
       (2, 'Willam', 21)

---Hard (9)---

-- Backup SchoolDB
BACKUP DATABASE SchoolDB  
TO DISK = 'C:\Backups\SchoolDB.bak';

-- Restore SchoolDB
RESTORE DATABASE SchoolDB  
FROM DISK = 'C:\Backups\SchoolDB.bak'  
WITH REPLACE;