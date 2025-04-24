

----(1)----

SELECT *
FROM #Sales s1
WHERE EXISTS (
      SELECT CustomerName, Quantity
	  FROM #Sales s2
	  WHERE Quantity = 1 AND MONTH(SaleDate) = 03 AND s2.CustomerName = s1.CustomerName
 );

 ----(2)----

SELECT Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(Total)
    FROM (
        SELECT SUM(Quantity * Price) AS Total
        FROM #Sales
        GROUP BY Product
    ) AS RevenueTotals
);

 ----(3)----

 SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS AllSales
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);

 ----(4)----

 SELECT DISTINCT
    FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
    (
        SELECT SUM(Quantity)
        FROM #Sales AS S2
        WHERE FORMAT(S2.SaleDate, 'yyyy-MM') = FORMAT(S1.SaleDate, 'yyyy-MM')
    ) AS TotalQuantity
FROM #Sales AS S1
ORDER BY SaleMonth;

 ----(5)----

SELECT DISTINCT S1.CustomerName
FROM #Sales S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales S2
    WHERE S2.CustomerName <> S1.CustomerName
      AND S2.Product = S1.Product
);

 ----(6)----

SELECT  Name, Fruit, Count (Fruit)
FROM Fruits
Group by Fruit, Name;

---Second way to solve

SELECT 
  Name,
  COUNT(CASE WHEN Fruit = 'Apple' THEN 1 END) AS Apple,
  COUNT(CASE WHEN Fruit = 'Banana' THEN 1 END) AS Banana,
  COUNT(CASE WHEN Fruit = 'Orange' THEN 1 END) AS Orange
FROM Fruits
GROUP BY Name;

 ----(7)----

-- Recursive CTE to find all ancestor-descendant pairs
WITH RecursiveFamily AS (
    -- Base case: direct parent-child pairs
    SELECT ParentId, ChildID
    FROM Family

    UNION ALL

    -- Recursive case: find grandchildren, great-grandchildren, etc.
    SELECT rf.ParentId, f.ChildID
    FROM RecursiveFamily rf
    JOIN Family f ON rf.ChildID = f.ParentId
)

-- Select result
SELECT *
FROM RecursiveFamily
ORDER BY ParentId, ChildID;

 ----(8)----

SELECT *
FROM #Orders
WHERE CustomerID IN (
	SELECT CustomerID
	FROM #Orders
	WHERE DeliveryState = 'CA') AND DeliveryState = 'TX';

----(9)----

UPDATE #residents
SET address = address + ' name=' + fullname
WHERE (fullname IS NOT NULL AND fullname != '') 
  AND address NOT LIKE '%name=%';

 ----(10)----

WITH RoutePaths AS (
    -- Base case: Start from Tashkent
    SELECT 
        RouteID,
			DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        Cost AS TotalCost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    -- Recursive case: Extend the route from the last arrival city
    SELECT 
        r.RouteID,
        rp.DepartureCity,
        r.ArrivalCity,
        CAST(rp.Route + ' - ' + r.ArrivalCity AS VARCHAR(MAX)) AS Route,
        rp.TotalCost + r.Cost AS TotalCost
    FROM RoutePaths rp
    JOIN #Routes r
        ON rp.ArrivalCity = r.DepartureCity
    WHERE rp.Route NOT LIKE '%' + r.ArrivalCity + '%'
),
FinalRoutes AS (
    SELECT Route, TotalCost
    FROM RoutePaths
    WHERE ArrivalCity = 'Khorezm'
)

-- Properly get cheapest and most expensive using subqueries
SELECT * FROM (
    SELECT TOP 1 * FROM FinalRoutes ORDER BY TotalCost ASC
) AS Cheapest

UNION ALL

SELECT * FROM (
    SELECT TOP 1 * FROM FinalRoutes ORDER BY TotalCost DESC
) AS MostExpensive;


----(11)----

SELECT * FROM #RankingPuzzle
SELECT *,
SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END)
OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
AS ProductRank
FROM #RankingPuzzle;


----(12)----

WITH Ranked AS (
    -- Step 1: Assign row numbers to maintain order
    SELECT 
        Id, 
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS rn,
        ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY (SELECT NULL)) AS grp_rn
    FROM #Consecutives
),
Groups AS (
    -- Step 2: Create groups for consecutive same Vals
    SELECT 
        Id, 
        Vals,
        rn - grp_rn AS GroupNum,  -- Group number for consecutive values
        COUNT(*) OVER (PARTITION BY Id, Vals, rn - grp_rn) AS ConsecutiveLength
    FROM Ranked
),
MaxConsecutive AS (
    -- Step 3: Get the max consecutive length for each Id
    SELECT 
        Id, 
        MAX(ConsecutiveLength) AS MaxConsecutive
    FROM Groups
    GROUP BY Id
),
NextIndex AS (
    -- Step 4: Get the next index based on total rows for each Id
    SELECT 
        Id, 
        COUNT(*) + 1 AS NextIndex
    FROM #Consecutives
    GROUP BY Id
)
-- Step 5: Join the results to get both MaxConsecutive and NextIndex
SELECT 
    M.Id, 
    N.NextIndex, 
    M.MaxConsecutive
FROM MaxConsecutive M
JOIN NextIndex N ON M.Id = N.Id;

----(13)----

SELECT e1.EmployeeID, e1.Department, e1.SalesAmount
FROM #EmployeeSales e1
JOIN (
	SELECT Department, AVG(SalesAmount) AS AvgSales
	FROM #EmployeeSales
	Group by Department ) e2
ON e2.Department = e1.Department 
AND e1.SalesAmount > e2.AvgSales;

----(14)----

SELECT SalesMonth, MAX(SalesAmount) AS MaxSales
FROM #EmployeeSales
GROUP BY SalesMonth
SELECT e.EmployeeID, e.SalesMonth, e.SalesAmount
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales es
    WHERE es.SalesMonth = e.SalesMonth
      AND es.SalesAmount = (
          SELECT MAX(SalesAmount)
          FROM #EmployeeSales
          WHERE SalesMonth = e.SalesMonth
      )
      AND es.EmployeeID = e.EmployeeID
);

----(15)----

SELECT DISTINCT e.EmployeeID
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth FROM #EmployeeSales
    ) AS all_months
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales es
        WHERE es.EmployeeID = e.EmployeeID
          AND es.SalesMonth = all_months.SalesMonth
    )
);

----(16)----

SELECT Name
FROM Products
WHERE Price > (
    SELECT AVG(Price) FROM Products
);
----(17)----

SELECT Name
FROM Products
WHERE Stock < (
      SELECT MAX(Stock) FROM Products
);

----(18)----

SELECT *
FROM Products p1
WHERE EXISTS (
	SELECT *
	FROM Products p2
	WHERE Name = 'Laptop' AND p1.Category = p2.Category
);

----(19)----

SELECT *
FROM Products;

WITH CTE AS (
	SELECT *
	FROM Products p1
	WHERE EXISTS (
		SELECT *
		FROM Products p2
		WHERE Name = 'Laptop' AND p1.Category = p2.Category
)
 
 )

SELECT *
FROM CTE
WHERE Price > (SELECT MIN(Price) FROM CTE);

----(20)----

SELECT p1.Name, p1.Category, p1.Price
FROM Products p1
WHERE Price > (
	SELECT AVG(p2.Price)
	FROM Products p2
	WHERE p1.Category = p2.category
);

----(21)----

SELECT DISTINCT o.ProductID
FROM Orders o
WHERE EXISTS (
    SELECT 1
    FROM Orders o2
    WHERE o2.ProductID = o.ProductID
);

----(22)----

SELECT p1.Name
FROM Products p1
JOIN (
	SELECT ProductID
	FROM Orders 
	WHERE Quantity > (
		SELECT AVG(Quantity)
	FROM Orders )) p2 
ON p1.ProductID = p2.ProductID;

----(23)----

SELECT DISTINCT o.ProductID
FROM Orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o2
    WHERE o2.ProductID = o.ProductID
);

----(24)----

SELECT TOP 1 p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQuantity DESC;

----(25)----

WITH ProductOrderCounts AS (
    SELECT ProductID, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY ProductID
),
AverageOrderCount AS (
    SELECT AVG(OrderCount * 1.0) AS AvgOrderCount
    FROM ProductOrderCounts
)
SELECT ProductID, OrderCount
FROM ProductOrderCounts, AverageOrderCount
WHERE OrderCount < AvgOrderCount;