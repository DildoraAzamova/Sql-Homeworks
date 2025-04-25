

----(1)----

-- Recursive CTE to expand each row based on Quantity
WITH RecursiveExpand AS (
    -- Anchor member: start with count 1
    SELECT Product, Quantity, 1 AS cnt
    FROM Grouped

    UNION ALL

    -- Recursive member: increment count
    SELECT Product, Quantity, cnt + 1
    FROM RecursiveExpand
    WHERE cnt + 1 <= Quantity
)
SELECT Product, 1 AS Quantity
FROM RecursiveExpand
ORDER BY Product;

----(2)----

-- Step 1: Get all distinct Regions and Distributors
WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),

-- Step 2: Create all combinations
AllCombos AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)

-- Step 3: Left join sales and coalesce NULLs to 0
SELECT 
    c.Region,
    c.Distributor,
    COALESCE(s.Sales, 0) AS Sales
FROM AllCombos c
LEFT JOIN #RegionSales s
    ON s.Region = c.Region AND s.Distributor = c.Distributor
ORDER BY c.Distributor, c.Region;

----(3)----

WITH CountManager AS (
	SELECT COunt(*) AS Report, managerId 
	FROM Employee
	GRoup by managerId
),
FindManager AS (
    SELECT * from CountManager
	WHERE Report >= 5
)
SELECT e.name
FROM FindManager fm
JOIN Employee e
ON fm.managerId = e.id;

----(4)----

SELECT p.product_name, SUM(o.unit) AS total_units_ordered
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'  -- Filter for February 2020
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;  -- Only include products with at least 100 units ordered

----(5)----

SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor, COUNT(*) AS OrderCount,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
) AS RankedOrders
WHERE rn = 1;

----(6)----

DECLARE @Check_Prime INT = 91;  -- Example input
DECLARE @IsPrime BIT = 1;  -- Assume the number is prime initially
DECLARE @Divisor INT = 2;  -- Start checking divisors from 2

-- Check if the number is prime
WHILE @Divisor <= SQRT(@Check_Prime)  -- We only need to check divisors up to the square root of the number
BEGIN
    IF @Check_Prime % @Divisor = 0  -- If the number is divisible by the divisor
    BEGIN
        SET @IsPrime = 0;  -- It's not a prime number
        BREAK;  -- Exit the loop as we found a divisor
    END
    SET @Divisor = @Divisor + 1;  -- Check the next number
END

-- Return the result based on whether the number is prime
IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

----(7)----

SELECT 
    Device_id,
    COUNT(DISTINCT Locations) AS no_of_location,
    (SELECT TOP 1 Locations
     FROM Device d2
     WHERE d2.Device_id = d1.Device_id
     GROUP BY Locations
     ORDER BY COUNT(*) DESC) AS max_signal_location,
    COUNT(*) AS no_of_signals
FROM Device d1
GROUP BY Device_id;

----(8)----

SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

----(9)----

SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor, COUNT(*) AS OrderCount,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
) AS RankedOrders
WHERE rn = 1;

----(10)----

SELECT Spend_date,
       Platform,
       SUM(Amount) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT User_id, Spend_date, Amount,
           CASE 
               WHEN Platform = 'Mobile' AND User_id NOT IN (SELECT User_id FROM Spending WHERE Platform = 'Desktop' AND Spend_date = s.Spend_date) THEN 'Mobile'
               WHEN Platform = 'Desktop' AND User_id NOT IN (SELECT User_id FROM Spending WHERE Platform = 'Mobile' AND Spend_date = s.Spend_date) THEN 'Desktop'
               WHEN Platform = 'Mobile' AND User_id IN (SELECT User_id FROM Spending WHERE Platform = 'Desktop' AND Spend_date = s.Spend_date) THEN 'Both'
               ELSE 'Both'
           END AS Platform
    FROM Spending s
) AS PlatformData
GROUP BY Spend_date, Platform
ORDER BY Spend_date, Platform;