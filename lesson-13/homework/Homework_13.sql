
---Beginner Level (1)---

SELECT SUBSTRING('Database', 1, 4);

---Beginner Level (2)---

SELECT CHARINDEX('SQL', 'I love SQL Server' );

---Beginner Level (3)---

SELECT REPLACE('Hello World', 'Hello', 'SQL');

---Beginner Level (4)---

SELECT LEN( 'Microsoft SQL Server');

---Beginner Level (5)---

SELECT RIGHT('Database', 3 );

---Beginner Level (6)---

SELECT 
    'apple' AS Word,
    LEN('apple') - LEN(REPLACE('apple', 'a', '')) AS A_Count
UNION ALL
SELECT
    'banana' AS Word,
	LEN('banana') - LEN(REPLACE('banana', 'a', '')) AS A_Count
UNION ALL
SELECT 
     'grape' AS Word,
	 LEN('grape') - LEN(REPLACE('grape', 'a', '')) AS A_Count

---Beginner Level (7)---

SELECT RIGHT('abcdefg', LEN('abcdefg') - 5) AS Result;

---Beginner Level (8)---

SELECT 
    SUBSTRING(
        'SQL is powerful', 
        CHARINDEX(' ', 'SQL is powerful') + 1, 
        CHARINDEX(' ', 'SQL is powerful', CHARINDEX(' ', 'SQL is powerful') + 1) - CHARINDEX(' ', 'SQL is powerful') - 1
    ) AS SecondWord;

SELECT
    SUBSTRING(
	      'I love Databases',
		  CHARINDEX(' ', 'I love Databases')+1,
		  CHARINDEX(' ', 'I love Databases', CHARINDEX(' ', 'I love Databases')+1) - CHARINDEX(' ', 'I love Databases')-1
	) AS SecondWord


---Beginner Level (9)---

SELECT ROUND(15.6789, 2);

---Beginner Level (10)---

SELECT ABS ( -345.67);

---Intermediate Level (11)---

SELECT SUBSTRING('ABCDEFGHI', LEN('ABCDEFGHI') / 2, 3) AS MiddleCharacters;

---Intermediate Level (12)---

SELECT STUFF('Microsoft', 1, 3, 'XXX');

---Intermediate Level (13)---

SELECT CHARINDEX(' ', 'SQL Server 2025');

---Intermediate Level (14)---

SELECT CONCAT('FirstName', ',', 'LastName');

---Intermediate Level (15)---

SELECT 
    SUBSTRING(
	       'The database is very efficient',
		   CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient')+1)+1,
		   CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient') + 1) + 1) - CHARINDEX(' ', 'The database is very efficient', CHARINDEX(' ', 'The database is very efficient') + 1) - 1
	)

---Intermediate Level (16)---

SELECT SUBSTRING('INV1234', PATINDEX('%[0-9]%', 'INV1234'), LEN('INV1234'))
SELECT SUBSTRING('ORD5678', PATINDEX('%[0-9]%', 'ORD5678'), LEN('ORD5678'));

---Intermediate Level (17)---

SELECT CEILING(99.5);

---Intermediate Level (18)---

SELECT DATEDIFF(DAY, '2025-01-01', '2025-03-15');

---Intermediate Level (19)---

SELECT DATENAME(MONTH, '2025-06-10');

---Intermediate Level (20)---

SELECT DATEPART(WEEK, '2025-04-22');

---Advanced Level (21)---

SELECT SUBSTRING('user1@gmail.com', CHARINDEX('@', 'user1@gmail.com')+1, LEN('user1@gmail.com'));

---Advanced Level (22)---

SELECT LEN('experience') - CHARINDEX('e', REVERSE('experience'))+1;

---Advanced Level (23)---

SELECT FLOOR(RAND() * (500-100+1)) + 100; 

---Advanced Level (24)---

SELECT FORMAT(9876543, 'N0') AS FormattedNumber;

---Advanced Level (25)---

SELECT 
SUBSTRING(Fullname, 1, CHARINDEX(' ', Fullname)-1)
FROM Customers

---Advanced Level (26)---

SELECT REPLACE( 'SQL Server is great', ' ', '-');

---Advanced Level (27)---

SELECT FORMAT(42, '00000') AS PaddedNumber;

---Advanced Level (28)---

SELECT MAX(LEN(value)) AS LongestWordLength
FROM STRING_SPLIT('SQL is fast and efficient', ' ');

---Advanced Level (29)---

SELECT SUBSTRING( 'Error: Connection failed', CHARINDEX(' ',  'Error: Connection failed')-1, LEN( 'Error: Connection failed') )

---Advanced Level (30)---

SELECT DATEDIFF(MINUTE, '08:15:00' , '09:45:00');