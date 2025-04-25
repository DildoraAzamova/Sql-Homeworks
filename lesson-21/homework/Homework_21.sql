
----(1)----

SELECT *, ROW_NUMBER() OVER (ORDER BY SaleDate)
FROM ProductSales;

----(2)----

SELECT *, DENSE_RANK() OVER (ORDER BY Quantity)
FROM ProductSales;

----(3)----

WITH RankedSales AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
)
SELECT CustomerID, SaleID, SaleAmount, SaleDate
FROM RankedSales
WHERE rn = 1;

----(4)----

SELECT *, LEAD(SaleAmount) OVER (ORDER BY SaleDate)
FROM ProductSales;

----(5)---

SELECT *, LAG(SaleAmount) OVER (ORDER BY SaleDate)
FROM ProductSales;

----(6)----

SELECT 
    s.SaleID,
    s.ProductID,
    p.ProductCategory,
    s.SaleAmount,
    RANK() OVER (
        PARTITION BY p.ProductCategory
        ORDER BY s.SaleAmount DESC
    ) AS SaleRank
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID;

----(7)----

WITH SalesWithPrevious AS (
    SELECT 
        *,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT *
FROM SalesWithPrevious
WHERE SaleAmount > PreviousSaleAmount;

----(8)----

WITH SalesWithPrevious AS (
    SELECT 
        *,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT *, SaleAmount - PreviousSaleAmount AS SalesDiffernce
FROM SalesWithPrevious
;

----(9)----

SELECT *, LEAD(SaleAmount) OVER (Order by SaleDate),
       CAST ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / NULLIF(SaleAmount, 0)
	   AS DECIMAL(10,2)) AS PercentageChange
FROM ProductSales;

----(10)----

SELECT *, LAG(SaleAmount) OVER (Partition by ProductName ORDER BY SaleDate) AS PreviousSale,
         CAST(
        SaleAmount / NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0)
        AS DECIMAL(10, 2)
    ) AS SaleRatio
FROM ProductSales;

----(11)----

SELECT *, FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
FROM ProductSales;

----(12)----

WITH SalesWithLag AS (
    SELECT 
        *,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount
    FROM ProductSales
)
SELECT *
FROM SalesWithLag
WHERE SaleAmount > PreviousSaleAmount;
                    
----(13)----

SELECT *, SUM(SaleAmount) OVER (ORDER BY SaleDate) 
FROM ProductSales;

----(14)----

SELECT *, 
        AVG(SaleAmount) OVER (
        --PARTITION BY ProductName 
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAverage
FROM ProductSales;

----(15)----

SELECT *, AVG(SaleAmount) OVER () AS AvgSales,
       SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAverage
FROM ProductSales;


CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');

----(16)----

WITH RankedSalaries AS (
    SELECT 
        *,
        RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
),
DuplicateRanks AS (
    SELECT SalaryRank
    FROM RankedSalaries
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
SELECT *
FROM RankedSalaries
WHERE SalaryRank IN (SELECT SalaryRank FROM DuplicateRanks);

----(17)----
WITH TopSalary AS (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY Department order by Salary DESC) AS RankSalary
	FROM Employees1
)
SELECT *
FROM TopSalary
WHERE RankSalary <= 2;

----(18)----

WITH TopSalary AS (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY Department order by Salary ASC) AS RankSalary
	FROM Employees1
)
SELECT *
FROM TopSalary
WHERE RankSalary <= 2;

----(19)----

SELECT *, SUM(Salary) OVER (Partition BY Department Order by salary) 
FROM Employees1;

----(20)----

SELECT *, SUM(Salary) OVER (PARTITION BY Department )
FROM Employees1;

----(21)----

SELECT *, AVG(Salary) OVER (Partition by Department)
FROM Employees1;

----(22)----

WITH DifferSalary AS (
	SELECT *, AVG(Salary) OVER (Partition by Department) AvgSalary
	FROM Employees1
)
SELECT *, Salary - AvgSalary AS DifferenceS
FROM DifferSalary;

----(23)----

SELECT *, AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING )
FROM Employees1;

----(24)----

WITH RankedEmployees AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS rn
    FROM Employees
)
SELECT SUM(Salary) AS TotalLast3HiresSalary
FROM RankedEmployees
WHERE rn <= 3;