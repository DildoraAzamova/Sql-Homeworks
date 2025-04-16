
---Easy Task (1)---

WITH number AS (
   SELECT 1 AS n
   UNION ALL
   SELECT n+1 AS n
   FROM number
   WHERE n<10
)
SELECT * FROM number;

---Easy Task (2)---

WITH Doubles AS (
   SELECT 1 AS n
   UNION ALL 
   SELECT n*2 AS n
   FROM Doubles
   WHERE n<100
)
SELECT * FROM Doubles;

---Easy Task (3)---

SELECT *
FROM (
      SELECT  e.FirstName, SUM(s.SalesAmount) AS TotalSales
	  FROM Sales s
	  JOIN Employees e
	  ON s.EmployeeID = e.EmployeeID
	  GROUP BY  e.FirstName
) AS DerivedEmp;

---Easy Task (4)---

WITH AvgSalary AS (
       SELECT AVG(Salary) AS AvgSalary
	   FROM Employees
)
SELECT * FROM AvgSalary;

---Easy Task (5)---

SELECT *
FROM (
      SELECT p.ProductName, MAX(s.SalesAmount) AS HightsSale
	  FROM Sales s
	  JOIN Products p
	  ON s.ProductID = p.ProductID
	  GROUP BY p.ProductName
) AS HighSale;

---Easy Task (6)---

WITH SaleCTE AS (
    SELECT EmployeeID, Count(*) AS NumberOfSales
	FROM Sales 
	GROUP BY EmployeeId
)
SELECT e.FirstName, sc.NumberOfSales
FROM SaleCte sc
JOIN Employees e
ON sc.EmployeeID = e.EmployeeID
WHERE sc.NumberOfSales > 5;

---Easy Task (7)---

WITH ProductCTE AS (
       SELECT  ProductID, SUM(SalesAmount) AS Sales
	   FROM Sales 
	   Group By ProductID
)
SELECT p.ProductName, pc.Sales
FROM ProductCTE pc
JOIN Products p
ON pc.ProductID = p.ProductID
WHERE pc.Sales > 500;

---Easy Task (8)---

WITH AvgSalary AS (
        SELECT EmployeeID, FirstName, Salary
		FROM Employees
		WHERE Salary > ALL (SELECT AVG(Salary) FROM Employees)
)
SELECT * FROM AvgSalary;

---Easy Task (9)---

SELECT p.ProductName, dp.TotalProduct
FROM (
      SELECT ProductID, COUNT(*) AS TotalProduct
	  FROM Sales
	  GROUP BY ProductID
) AS dp
JOIN Products p
ON dp.ProductID = p.ProductID;

---Easy Task (10)---

WITH SaleCTE AS (
    SELECT EmployeeID, Count(*) AS NumberOfSales
	FROM Sales 
	GROUP BY EmployeeId
)
SELECT e.FirstName, sc.NumberOfSales
FROM SaleCte sc
JOIN Employees e
ON sc.EmployeeID = e.EmployeeID
WHERE sc.NumberOfSales = 0;

---Medium Task (1)---

WITH  FactorialCTE AS (
    SELECT 1 AS n, 1 AS factorial  -- Anchor member: 1! = 1
    UNION ALL
    SELECT n + 1, factorial * (n + 1)  -- Recursive step
    FROM FactorialCTE
    WHERE n < 10  -- Limit to 10! to prevent infinite loop
)
SELECT * FROM FactorialCTE;

---Medium Task (2)---

WITH FibonacciCTE AS (
    SELECT 1 AS n, 0 AS fib, 1 AS next_fib
	UNION ALL
	SELECT n+1, next_fib, fib+next_fib
	FROM FibonacciCTE
	WHERE n<10
)
SELECT * FROM FibonacciCTE;

---Medium Task (3)---

WITH StringChar AS (
    SELECT 1 AS pos, -- Anchor member: start at position 1
	   SUBSTRING('Hello', 1, 1) AS char_part
	UNION ALL
	SELECT pos+1,   -- Recursive member: move to the next position
	   SUBSTRING('Hello', pos+1, 1) 
FROM StringChar
WHERE pos < LEN('Hello') -- use LEN('HELLO') in SQL Server
)
SELECT * FROM StringChar;

---Medium Task (4)---

WITH EmpSaleCTE AS (
   SELECT e.EmployeeID, e.FirstName, SUM(s.SalesAmount) As TotalSales
   FROM Employees e
   JOIN Sales s
   ON e.EmployeeID = s.EmployeeID
   GROUP BY e.EmployeeID, e.FirstName
)
SELECT * FROM EmpSaleCTE;

---Medium Task (5)---

SELECT TOP 5 e.FirstName, DerEmp.NumberOfOrders
FROM (
       SELECT EmployeeID, COUNT(*) AS NumberOfOrders
	   FROM Sales s
	   GROUP BY EmployeeID
) AS DerEmp
JOIN Employees e
ON e.EmployeeiD = DerEmp.EmployeeID
ORDER BY e.EmployeeID DESC;

---Medium Task (6)---

WITH SaleCTE AS (
  SELECT MONTH(SaleDate) AS SaleMonth,
         SUM(SalesAmount) AS PrevSales
  FROM Sales 
   WHERE month(SaleDate) = month(DATEADD(month, -3, GETDATE()))
  GROUP BY MONTH(SaleDate)),
cte2 as (
select month(saledate) as CurSale,
sum(salesamount) as cursum
from Sales
where month(saledate) = month(DATEADD(month, -2, GETDATE()))
group by month(saledate)
)

select prevsales - cursum as Diff from salecte, cte2


---Medium Task (7)---

SELECT *
FROM (
      SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalSales
	  FROM Products p
	  JOIN Sales s
	  ON p.ProductID = s.ProductID
	  GROUP BY p.CategoryID
) AS DerCategory;

---Medium Task (8)---

WITH ProductCTE AS (
   SELECT p.ProductID, SUM (SalesAmount) AS TotalSales
   FROM Products p
   JOIN Sales s
   ON p.ProductID = s.ProductID
   WHERE s.SaleDate = DATEADD(YEAR, -1, GETDATE())
   GROUP BY p.ProductID
)
SELECT * FROM ProductCTE;

---Medium Task (9)---

SELECT *
FROM (
      SELECT e.EmployeeID, 
	        
	         SUM(s.SalesAmount) AS TotalSales
	  FROM Employees e
	  JOIN Sales s
	  ON e.EmployeeID = s.EmployeeID
	  GROUP  BY e.EmployeeID
	  HAVING SUM(s.SalesAmount) > 5000
 ) AS SalesQuater;

 select * from employees
 select * from sales
 , quarter(salesdate) 

---Medium Task (10)---

SELECT  TOP 3 *
FROM (
      SELECT e.EmployeeID, SUM(s.SalesAmount) AS TotalAmount
	  FROM Employees e
	  JOIN Sales s
	  ON e.EmployeeID = s.EmployeeID
	  WHERE month(s.SaleDate) = month(DATEADD(MONTH, -2, GETDATE()))
	  GROUP BY e.EmployeeID
) AS DerEmp;

---Difficul Task (1)---

WITH number AS (
   SELECT 1 AS n, cast('1' as varchar) AS n2
   UNION ALl
   SELECT n+1, cast(concat(cast(n2 as  varchar) , CAST(n + 1 AS varchar)) as varchar)
   FROM number
   WHERE n<5
)
SELECT * FROM number;

---Difficul Task (2)---

	select firstname, lastname , sum(salesamount) from employees e
	join (
	select * from sales
	where saledate > dateadd(month,-6,getdate()) ) s on e.employeeid = s.employeeid
	group by firstname , lastname

---Difficul Task (3)---

-- Recursive CTE to track running total within bounds
WITH RecursiveSteps AS (
    -- Anchor member: Boshlang'ich step
    SELECT
        Id,
        StepNumber,
        [Count],
        CAST([Count] AS INT) AS RunningTotal
    FROM Numbers
    WHERE StepNumber = 1 AND [Count] BETWEEN 0 AND 10

    UNION ALL

    -- Recursive member: Keyingi step'larni ulash
    SELECT
        n.Id,
        n.StepNumber,
        n.[Count],
        rs.RunningTotal + n.[Count] AS RunningTotal
    FROM RecursiveSteps rs
    JOIN Numbers n ON rs.Id = n.Id AND n.StepNumber = rs.StepNumber + 1
    WHERE rs.RunningTotal + n.[Count] BETWEEN 0 AND 10
)
SELECT *
FROM RecursiveSteps
ORDER BY Id, StepNumber;


---Difficul Task (4)---
SELECT * from schedule

SELECT *, case when a.endtime != a.starttime then a.endtime else a.starttime end FROM Activity a
join schedule s on a.scheduleID = s.ScheduleID
order by a.scheduleID, a.starttime

with cte1 as (
select a.scheduleID as ID, a.Endtime as WorkStartTime,  isnull(lead(a.starttime) over (partition by a.ScheduleID order by a.starttime),0) as Interval, 
s.starttime as ScheduleStart, s.endtime as ScheduleEnd
from Activity a
join schedule s on a.scheduleID = s.ScheduleID)
select *, case when Interval > WorkStartTime then Interval else ScheduleEnd end from cte1


---Difficul Task (5)---

WITH AllIntervals AS (
    -- 1. Faoliyatlar (Activity) ni chiqaramiz
    SELECT
        a.ScheduleID,
        a.StartTime,
        a.EndTime,
        a.ActivityName
    FROM Activity a

    UNION ALL

    -- 2. Jadval boshlanishida "Work" bo'shligi (if exists)
    SELECT
        s.ScheduleID,
        s.StartTime,
        a.StartTime,
        'Work'
    FROM Schedule s
    JOIN Activity a ON s.ScheduleID = a.ScheduleID
    WHERE a.StartTime > s.StartTime
      AND a.StartTime = (
          SELECT MIN(StartTime)
          FROM Activity
          WHERE ScheduleID = s.ScheduleID
      )

    UNION ALL

    -- 3. Faoliyatlar orasidagi bo'sh "Work" vaqtlar
    SELECT
        a1.ScheduleID,
        a1.EndTime,
        a2.StartTime,
        'Work'
    FROM Activity a1
    JOIN Activity a2 ON a1.ScheduleID = a2.ScheduleID
                    AND a1.EndTime < a2.StartTime
    WHERE NOT EXISTS (
        SELECT 1
        FROM Activity a3
        WHERE a3.ScheduleID = a1.ScheduleID
          AND a3.StartTime > a1.EndTime
          AND a3.StartTime < a2.StartTime
    )

    UNION ALL

    -- 4. Jadval oxirida "Work" bo'shligi (if exists)
    SELECT
        s.ScheduleID,
        a.EndTime,
        s.EndTime,
        'Work'
    FROM Schedule s
    JOIN Activity a ON s.ScheduleID = a.ScheduleID
    WHERE a.EndTime < s.EndTime
      AND a.EndTime = (
          SELECT MAX(EndTime)
          FROM Activity
          WHERE ScheduleID = s.ScheduleID
      )
)

-- Final output
SELECT *
FROM AllIntervals
ORDER BY ScheduleID, StartTime;
