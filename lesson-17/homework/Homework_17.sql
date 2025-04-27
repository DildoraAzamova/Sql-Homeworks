
----(1)----

SELECT s.ProductID, SUM(s.Quantity) AS TotalQuantity, SUM(s.Quantity * p.Price) AS TotalRevenue 
INTO #MonthlySales
FROM Sales s
JOIN Products p
ON s.ProductID = p.ProductID
WHERE 
  MONTH(s.SaleDate) = MONTH(GETDATE()) AND
  YEAR(s.SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID

SELECT *
from #MonthlySales
order by ProductID;

----(2)----

CREATE VIEW vw_ProductSalesSummary AS 
SELECT p.ProductID, p.ProductName, SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
GROUP  BY p.ProductID, p.ProductName

SELECT * FROM vw_ProductSalesSummary;

----(3)----

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TotalRevenue FLOAT;

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;

SELECT dbo.fn_GetTotalRevenueForProduct(2);

----(4)----

CREATE FUNCTION  fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS Table
AS
Return
(
     SELECT p.ProductName,
	        SUM(s.Quantity) AS TotalQuantity,
	        SUM(s.Quantity * p.Price) AS TotalRevenue
	 FROM Sales s
	 JOIN Products p ON s.ProductID = p.ProductID
	 WHERE p.Category = @Category
	 GROUP BY ProductName
);
SELECT *
FROM fn_GetSalesByCategory('Electronics');

----(5)----

Create function dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    
    -- Edge cases: numbers <= 1 are not prime
    IF @Number <= 1
        RETURN 'No';

    -- Check divisibility from 2 up to square root of number
    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;

SELECT dbo.fn_IsPrime(7) AS Result; -- Output: Yes
SELECT dbo.fn_IsPrime(12) AS Result; -- Output: No


----(6)----

CREATE FUNCTION dbo.fn_GetNumbersBetween (
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE (
    Number INT
)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END
SELECT * FROM dbo.fn_GetNumbersBetween(5, 10);

----(7)----

CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;
    
    WITH RankedSalaries AS (
        SELECT DISTINCT Salary,
               DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
        FROM Employee
    )
    SELECT @Result = Salary
    FROM RankedSalaries
    WHERE SalaryRank = @N;

    RETURN @Result;
END;

SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;

----(8)----

WITH AllFriends AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
)
SELECT TOP 1
    id,
    COUNT(*) AS num
FROM AllFriends
GROUP BY id
ORDER BY num DESC;

----(9)----

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(o.amount) AS total_amount, 
    MAX(o.order_date) AS last_order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;
SELECT *  FROM vw_CustomerOrderSummary;

----(10)----

SELECT RowNumber, 
       MAX(TestCase) OVER (Order by (Select NULL) rows between unbounded preceding and current row)
FROM Gaps;
