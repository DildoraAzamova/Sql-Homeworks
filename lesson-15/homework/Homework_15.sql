
---Easy Task(1)---

SELECT * FROM #Cart1 c1
FULL JOIN #Cart2 c2 
ON c1.Item = c2.Item;

---Easy Task(2)---

SELECT WorkFlow, AVG(DAY(ExecutionDate))
FROM #ProcessLog
GROUP BY WorkFlow;

---Easy Task(3)---

SELECT *
FROM Movie
WHERE MName IN (
	SELECT MName
	FROM Movie 
	WHERE Roles = 'Actor' AND Aname IN('Amitabh', 'Vinod')
	GROUP BY MName
	HAVING COUNT(DISTINCT AName) = 2
	);

---Easy Task(4)---

SELECT 
    CustomerID,
	MAX( CASE WHEN Type = 'Home' THEN PhoneNumber end) AS HomePhone,
	MAX(CASE WHEN TYPE = 'Cellular' THEN PhoneNumber end) AS CellularPhone,
	MAX(CASE WHEN TYPE = 'Work' THEN PhoneNumber end) AS WorkPhone
from #PhoneDirectory
GROUP BY CustomerID;

---Easy Task(5)---

WITH Number AS (
    SELECT 1 AS n
	UNION ALL
	SELECT n+1 FROM Number WHERE n<100
)
SELECT * FROM Number
WHERE n%9=0;

---Easy Task(6)---

SELECT bs.Batch, bs.BatchStart, MIN(bl.Line) AS BatchEnd 
FROM #BatchLines bl
JOIN #BatchStarts bs
ON bl.Batch = bs.Batch
AND bl.Line > bs.BatchStart AND bl.Syntax = 'GO' 
GROUP BY bs.Batch, bs.BatchStart;

---Easy Task(7)---

SELECT InventoryDate,
       QuantityAdjustment,
       SUM(QuantityAdjustment) over (Order BY inventoryDate) AS Runningtotal
FROM #Inventory;

---Easy Task(8)---

SELECT MAX(Salary) AS MaxSalary
FROM NthHighest
WHERE Salary < (
                SELECT MAX(Salary)
				FROM NthHighest
				  );


---Easy Task(9)---

SELECT
  SUM(CASE WHEN Year = YEAR(DATEADD(YEAR, 0, GETDATE())) THEN Amount END) AS ThisYearSales,
  SUM(CASE WHEN Year = 2024 THEN Amount END) AS LastYearSales,
  SUM(CASE WHEN Year = 2023 THEN Amount END) AS TwoYearsAgoSales
FROM 
  #Sales;

---Medium Task(1)---

SELECT b1.Box, b2.Height, b2.Length, b2.Width
FROM #Boxes b1
JOIN #Boxes b2
ON b1.Box < b2.Box 
AND b1.Width = b2.Width AND 
b1.Height = b2.Height AND 
b1.Length = b2.Length;

---Medium Task(2)---

WITH Number AS (
   SELECT 1 AS n
   UNION ALL
   SELECT 
   CASE 
        WHEN n * 2 < 100 THEN n * 2
        ELSE n + 1
      END
   FROM Number
   WHERE n < 100)
SELECT * FROM Number;

---Medium Task(3)---

SELECT 
  StepID,
  Workflow,
  [Status],
  COUNT(DISTINCT [Status]) OVER (
    PARTITION BY Workflow
    ORDER BY StepID
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS UniqueStatusesSoFar
FROM #WorkflowSteps;

---Medium Task(4)---

WITH MaleRow AS (SELECT 
  ID, Name, Gender,
  ROW_NUMBER() OVER (ORDER BY ID) AS m
FROM dbo.AlternateMaleFemale
WHERE Gender = 'M'
),
FemaleRow AS (SELECT
  ID, NAme, GENder,
  ROW_NUMBER() OVER (ORDER BY ID) AS f
FROM dbo.AlternateMaleFemale
WHERE Gender = 'F')

SELECT m.Name AS MaleName, f.Name AS FemaleName
FROM MaleRow m
Left JOIN FemaleRow f
ON m.m = f.f
ORDER BY m.m;

---Medium Task(5)---

WITH NumberedSteps AS (
    SELECT *,
	       ROW_NUMBER() OVER (PARTITION BY TestCase Order by stepNumber)
          -ROW_NUMBER() OVER (PARTITION BY TestCase, Status order by StepNumber) AS grp
	FROM #Groupings
)
SELECT 
    MIN(StepNumber) AS Min_Step,
    MAX(StepNumber) AS Max_Step,
    Status,
    COUNT(*) AS Step_Count
FROM NumberedSteps
GROUP BY TestCase, Status, grp
ORDER BY Min_Step;

---Medium Task(6)---

-- Set the desired length
DECLARE @n INT = 4;

-- Recursive CTE to build all binary strings of length @n
WITH BinaryStrings AS (
    SELECT CAST('' AS VARCHAR(MAX)) AS bits
    UNION ALL
    SELECT bits + '0'
    FROM BinaryStrings
    WHERE LEN(bits) < @n
    UNION ALL
    SELECT bits + '1'
    FROM BinaryStrings
    WHERE LEN(bits) < @n
)
SELECT bits
FROM BinaryStrings
WHERE LEN(bits) = @n
OPTION (MAXRECURSION 32767);

---Medium Task(7)---

SELECT 
    PrimaryID,
    SpouseID,
    CASE 
        WHEN PrimaryID < SpouseID THEN PrimaryID
        ELSE SpouseID
    END AS GroupKey
FROM #Spouses;

---Medium Task(8)---

SELECT *,
       LAG(CurrentQuota, 1, NULL) OVER (Order by salesYear ) AS prev
FROM lag

---Medium Task(9)---

WITH RankedBowlers AS (
    SELECT 
        GameID,
        Bowler,
        Score,
        ROW_NUMBER() OVER (PARTITION BY GameID ORDER BY Score DESC) AS Ran
    FROM #BowlingResults
),
ADPairs AS (
    SELECT  b1.GameID,
        b1.Bowler AS Bowler1,
		
        b2.Bowler AS Bowler2
	FROM RankedBowlers b1
	JOIN RankedBowlers b2
	ON b1.GameID = b2.GameID 
        AND b1.Ran = b2.Ran - 1
) SELECT * from ADPairs
SELECT 
    Bowler1,
    Bowler2,
    COUNT(*) AS TimesTogether
FROM ADPairs 
GROUP BY Bowler1, Bowler2
ORDER BY TimesTogether DESC;

---Medium Task(10)---

WITH PrimeNumber AS (
   SELECT 2 AS n
   UNION ALL
   SELECT n+1 n
   FROM PrimeNumber
   WHERE n<=100
)
SELECT n
from PrimeNumber n
WHERE NOT EXISTS (
     SELECT 1 
	 FROM PrimeNumber n1
	 WHERE n1.n BETWEEN 2 AND FLOOR(SQRT(n.n))
	 AND n.n%n1.n=0
)
ORDER BY n

---Difficult Taks (1) ---

DECLARE @n INt =4;

WITH BinaryCode AS (
   SELECT CAST ('' AS varchar(MAX)) AS bits
   UNION ALL
   SELECT bits+'0'
   FROM BinaryCode
   WHERE LEN(bits)<@n
   UNION ALL
   SELECT bits + '1'
   FROM BinaryCode
   WHERE LEN(bits)<@n
)
SELECT bits
FROM BinaryCode
WHERE LEN(bits) = @n;

---Difficult Taks (2) ---

WITH CombinedPlayer AS(
     SELECT PlayerA AS Player, Score FROM #PlayerScores
	 UNION ALL
	 SELECT PlayerB, Score FROM #PlayerScores
),
 RankedPlayer AS(
     SELECT Player, Score,
	        ROW_NUMBER() OVER (ORDER BY Score DESC) As Rank,
			COUNT(*) OVER() AS TotalPlayers
	 FROM CombinedPlayer
 )
 SELECT Player, Score,
         CASE
           WHEN Rank <= TotalPlayers / 2 THEN 1  -- Top half
           ELSE 2  -- Bottom half
       END AS GroupValue
 FROM RankedPlayer;

---Difficult Taks (3) ---

SELECT * from #Strings;
WITH WordPosition As
	(SELECT QuoteId, value as word,
		  CHARINDEX(value, String) AS start_pos, -- Find start position of word
			CHARINDEX(value, String) + LEN(value) - 1 AS end_pos -- Find end position of word
	FROM #strings
	CROSS APPLY string_split(String, ' ')
)
SELECT 
    quoteID,
    word,
    start_pos,
    end_pos
FROM WordPosition
ORDER BY quoteID, start_pos;

---Difficult Taks (4) ---
;
WITH Number AS (
  SELECT 1 as n
  UNION ALL
  SELECT 1+n 
  FROM Number
  WHERE n<3
),
Permutation AS (
	SELECT CAST(n AS varchar(10)) as permutation, n
	FROM Number
	where n<=3

	UNION ALL

	SELECT p.permutation + ',' + CAst(n.n As varchar(10)), n.n
	FROM Permutation p
	JOIN Number n
	ON CHARINDEX(CAST(n.n AS VARCHAR(10)), p.permutation) = 0
	WHERE len(p.permutation)<5
)
SELECT permutation
FROM Permutation
WHERE LEN(permutation) = 5  -- For `n = 3`, length would be 5 (3 digits + commas)
ORDER BY permutation;

---Difficult Taks (5) ---

WITH NumberDigits AS (
   SELECT 1 AS num
   UNION ALL
   SELECT 1+num
   FROM NumberDigits
   WHERE num<100
),
SumOfDigits AS (
    -- Calculate the sum of digits for each number
    SELECT num,
          SUM(CAST(SUBSTRING(CAST(num AS VARCHAR), n, 1) AS INT)) AS sum_digits
    FROM NumberDigits
    CROSS APPLY (SELECT TOP (LEN(CAST(num AS VARCHAR))) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
                 FROM master.dbo.spt_values) AS digits
    GROUP BY num
)
SELECT num
FROM SumOfDigits
WHERE num % sum_digits = 0; 