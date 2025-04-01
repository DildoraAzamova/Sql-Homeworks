
---Easy Quation (1)---

SELECT ASCII('A');

---Easy Quation (2)---

SELECT LEN('Hello World');

---Easy Quation (3)---

SELECT REVERSE('OpenAI');

---Easy Quation (4)---

SELECT CONCAT(SPACE(5), 'OpenAI');

---Easy Quation (5)---

SELECT TRIM ('  SQL Server  ');

---Easy Quation (6)---

SELECT UPPER ('sql');

---Easy Quation (7)---

SELECT LEFT ('Database', 3);

---Easy Quation (8)---

SELECT RIGHT('Database', 4 );

---Easy Quation (9)---

SELECT SUBSTRING('Programming', 3, 4) AS ExtractedChars;

---Easy Quation (10)---

SELECT CONCAT('SQL', 'Server');

---Easy Quation (11)---

SELECT REPLACE ('apple orange', 'orange', 'pie');

---Easy Question (12)---

SELECT CHARINDEX('learn', 'Learn SQL with LearnSQL');

---Easy Question (13)---

SELECT CHARINDEX ('er', 'Server');

---Easy Question (14)---

SELECT VALUE 
FROM string_split ('apple,orange,banana', ',');

---Easy Question (15)---

SELECT POWER(2,3);

---Easy Question (16)---

SELECT SQRT (16);

---Easy Question (17)---

SELECT GETDATE() as CurrentDate;

---Easy Question (18)---

SELECT GETUTCDATE();

---Easy Question (19)---

SELECT DAY('2025-02-03') AS DayOfMonth;

---Easy Question (20)---

SELECT DATEADD(DAY, 10, '2025-02-03');


---Medium Question (1)---

SELECT CHAR (65);

---Medium Question (2)---

SELECT LTRIM('  Hello  '), ---delete left space
       RTRIM('  Hello  ');  ---deelete right space

---Medium Question (3)---

SELECT CHARINDEX('SQL', 'Learn SQL basics');

---Medium Question (4)---

SELECT Concat_ws(',', 'SQL', 'Server'); 

---Medium Question (5)---

SELECT STUFF('Test day', 1, 4, 'Exam');

---Medium Question (6)---

SELECT SQUARE(7);

---Medium Question (7)---

SELECT LEFT('International', 5);

---Medium Question (8)---

SELECT RIGHT ('Database', 2);

---Medium Question (9)---

SELECT Patindex('%n%', 'Learn SQL'); ---Result is '5'

---Medium Question (10)---

SELECT DATEDIFF(DAY, '2025-01-01' , '2025-02-03');

---Medium Question (11)---

SELECT MONTH('2025-02-03');

---Medium Question (12)---

SELECT DATEPART( YEAR, '2025-02-03');

---Medium Question (13)---

SELECT CAST(GETDATE() AS TIME) AS CurrentTime;

---Medium Question (14)---

SELECT Sysdatetime()  ---Returns date and time in datetime2(7) format.

---Medium Question (15)--- 

DECLARE @Today DATE = GETDATE();

SELECT DATEADD(DAY, 
    (7 - DATEPART(WEEKDAY, @Today) + 4) % 7, 
    @Today) AS NextWednesday;

---Medium Question (16)---

SELECT GETDATE();   ---Returns the current date and time of the server's local time zone.
SELECT GETUTCDATE();   ---Returns the current UTC (Coordinated Universal Time) date and time.

---Medium Question (17)---

SELECT ABS(-15);

---Medium Question (18)---

SELECT CEILING(4.57);

---Medium Question (19)---

 SELECT Current_Timestamp;

---Medium Question (20)---

SELECT DATENAME(WEEKDAY, '2025-02-03');


---Hard Question (1)---

SELECT REPLACE(REVERSE ('SQL Server'), ' ', '');

---Hard Question (2)---

SELECT STRING_AGG(City, ', ') AS CitiesList
FROM Employees;

---Hard Question (3)---

SELECT 
    CASE 
        WHEN CHARINDEX('SQL', 'SQL Server is powerful') > 0 
         AND CHARINDEX('Server', 'SQL Server is powerful') > 0 
        THEN 'Contains both SQL and Server' 
        ELSE 'Does not contain both' 
    END AS Result;

---Hard Question (4)---

SELECT POWER(5,3);

---Hard Question (5)--- 

SELECT value AS Fruit
FROM string_split('apple;orange;banana', ';');

---Hard Question (6)--- 

SELECT TRIM ('  SQL  ');

---Hard Question (7)--- 

SELECT DATEDIFF(HOUR, '2024-03-20 10:00:00', '2024-03-21 15:30:00' );

---Hard Question (8)--- 

SELECT 
    (DATEPART(MONTH, '2025-02-03') - DATEPART(MONTH, '2023-05-01')) AS MonthDifference;

---Hard Question (9)---

SELECT CHARINDEX('LQS', REVERSE ('Learn SQL Server'));

---Hard Question (10)--- 

SELECT value as Fruit
FROM string_split('apple,orange,banana', ',');

---Hard Question (11)--- 

SELECT DATEDIFF(DAY, '2025-01-01' , GETDATE());

---Hard Question (12)--- 

SELECT LEFT('Data Science', 4);

---Hard Question (13)---

SELECT CEILING(SQRT(225));

---Hard Question (14)--- 

 SELECT CONCAT_WS('|', 'John', 'Doe');

---Hard Question (15)--- 

SELECT PATINDEX('%[0-9]%', 'abc123xyz');

---Hard Question (16)--- 

SELECT CHARINDEX('SQL','SQL Server SQL', CHARINDEX('SQL', 'SQL Server SQL') + 1);

---Hard Question (17)--- 

SELECT DATEPART(YEAR, getdate ());

---Hard Question (18)--- 

SELECT DATEADD(DAY, -100, GETDATE()) AS Date_100_Days_Ago;

---Hard Question (19)--- 

SELECT DATENAME(WEEKDAY, '2025-02-03');

---Hard Question (20)--- 

SELECT POWER(36,3);