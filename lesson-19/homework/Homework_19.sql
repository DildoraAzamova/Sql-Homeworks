
-----(1)-----

SELECT *
FROM #Employees
WHERE Salary > (SELECT AVG(Salary) FROM #Employees);

-----(2)-----

SELECT *
FROM #Employees e
WHERE EXISTS (SELECT DepartmentID 
              FROm #Departments d 
			  WHERE e.DepartmentID=d.DepartmentID AND e.DepartmentID = '1');

-----(3)-----

SELECT FirstName, LastName
FROM #Employees e
WHERE e.DepartmentID = (SELECT DepartmentID 
              FROm #Employees e
			  WHERE e.FirstName = 'Rachel' AND e.LastName = 'Collins');

-----(4)-----

SELECT FirstName, LastName	
FROM #Employees 
WHERE HireDate > ( SELECT MAX(HireDate)
    FROM Employees
    WHERE DepartmentID = 2
);

-----(5)-----

SELECT e.FirstName, e.Salary, e.DepartmentID
FROM #employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM #employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);

-----(6)-----
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.DepartmentID,
    e.Salary,
    (
        SELECT COUNT(*) 
        FROM #Employees AS sub 
        WHERE sub.DepartmentID = e.DepartmentID
    ) AS DepartmentEmployeeCount
FROM #Employees AS e;

-----(7)-----

SELECT *
FROM #Employees
Where Salary = (select min(Salary) from #Employees);

-----(8)-----

SELECT* from #Departments
SELECT*from #Employees
SELECT *
FROM #Employees e1
WHERE DepartmentID IN (SELECT DepartmentID
						FROM #Employees 
						Group by DepartmentID
						HAVING AVG(Salary) > 65000);

-----(9)-----

SELECT *
FROM #Employees
WHERE HireDate >= (
    SELECT DATEADD(YEAR, -3, MAX(HireDate))
    FROM #Employees
);

-----(10)-----

SELECT* from #Departments
SELECT*from #Employees
SELECT *
FROM #Employees
WHERE DepartmentID IN (
               SELECT DepartmentID
			   FROM #Employees
			   WHERE Salary >= 80000
);

-----(11)-----

SELECT *
FROM #Employees e
WHERE Salary = (
    SELECT MAX(Salary)
    FROM #Employees
    WHERE DepartmentID = e.DepartmentID
);

-----(12)-----

SELECT d.DepartmentName, e.FirstName, e.LastName, e.HireDate
FROM #Departments d
JOIN (SELECT *
FROM #Employees e
WHERE HireDate = (SELECT MAx(HireDate)
FROM #Employees
WHERE DepartmentID = e.DepartmentID)) e
ON e.DepartmentID = d.DepartmentID;

-----(13)-----

SELECT 
    d.Location,
    d.DepartmentName,
    AVG(e.Salary) AS AverageSalary
FROM 
    #Employees e
JOIN 
    #Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY 
    d.Location, d.DepartmentName;

	-----(14)-----

SELECT e.*
FROM #Employees e
WHERE e.DepartmentID IN (
    SELECT DepartmentID
    FROM #Employees
    GROUP BY DepartmentID
    HAVING AVG(Salary) IN (
        SELECT Salary
        FROM #Employees
        WHERE #Employees.DepartmentID = #Employees.DepartmentID
    )
);

-----(15)-----

SELECT DepartmentID, COUNT(*) AS EmpCount
FROM #Employees
GROUP BY DepartmentID
HAVING COUNT(*) < 
	(SELECT AVG(CountEmp) avge
	FROM (SELECT COUNT(*) as CountEmp, DepartmentID
		FROM #Employees
		GROUP BY DepartmentID) AS DeptCount );

-----(16)-----

SELECT *
FROM #Employees
WHERE DepartmentID NOT IN(
	SELECT TOP 1 DepartmentID
	FROM (
		 SELECT DepartmentID, AVG(salary) AvgSalary
		 FROM #Employees
		 GROUP BY DepartmentID) AS DeptAvg
	Order BY AvgSalary desc);

-----(17)-----

SELECT DepartmentName
FROM #Departments D
WHERE EXISTS (
    SELECT 1
    FROM #Employees E
    WHERE E.DepartmentID = D.DepartmentID
);

-----(18)-----

WITH ExperienceCalc AS (
    SELECT 
        DepartmentID,
        CASE 
            WHEN DATEDIFF(YEAR, HireDate, (SELECT MAX(HireDate) FROM Employees)) > 3 THEN 'Senior'
            ELSE 'Junior'
        END AS ExperienceLevel
    FROM #Employees
),
ExperienceCount AS (
    SELECT 
        DepartmentID,
        SUM(CASE WHEN ExperienceLevel = 'Senior' THEN 1 ELSE 0 END) AS SeniorCount,
        SUM(CASE WHEN ExperienceLevel = 'Junior' THEN 1 ELSE 0 END) AS JuniorCount
    FROM ExperienceCalc
    GROUP BY DepartmentID
)
SELECT DepartmentID
FROM ExperienceCount
WHERE SeniorCount > JuniorCount;

-----(19)-----

SELECT *
FROM #Employees
WHERE DepartmentID IN (
		SELECT TOP 1 DepartmentID
		FROM (
			SELECT DepartmentID, COUNT(*) As EmpCount
			FROM #Employees
			GROUP BY DepartmentID ) EmpC
			Order by EmpCount desc );

-----(20)-----

SELECT *, MaxSalary-MinSalary As DifferenceS
FROM (
	SELECT DepartmentID, MAX(Salary) As MaxSalary, MIN(Salary) As MinSalary
	FROM #Employees
	GROUP BY DepartmentID) Differnce;

-----(21)-----

SELECT P.ProjectName
FROM Projects P
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    WHERE Ep.ProjectID = P.ProjectID
    AND Ep.Role = 'Lead'
);

-----(22)----

SELECT 
    e.FirstName, 
    e.LastName, 
    e.Salary
FROM Employees e
JOIN EmployeeProject ep ON e.EmployeeID = ep.EmployeeID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM EmployeeProject ep2
    JOIN Employees e2 ON ep2.EmployeeID = e2.EmployeeID
    WHERE ep2.ProjectID = ep.ProjectID
)
-----(23)-----

SELECT *
FROM Projects
WHERE EXISTS (
	SELECT *
	FROM (SELECT ProjectID, COUNT(*) as member
	FROM EmployeeProject ep
	Group by ProjectID) AS p
	WHERE member =1 );

-----(24)-----

SELECT 
    ProjectName,
    Budget,
    (SELECT MAX(Budget) FROM Projects) - Budget AS BudgetDifference
FROM Projects;


-----(25)-----

SELECT pa.ProjectID
FROM EmployeeProject pa
JOIN Employees e ON pa.EmployeeID = e.EmployeeID
WHERE pa.Role = 'Lead'
GROUP BY pa.ProjectID
HAVING SUM(e.Salary) > (
    SELECT AVG(e2.Salary)
    FROM EmployeeProject pa2
    JOIN Employees e2 ON pa2.EmployeeID = e2.EmployeeID
    WHERE pa2.Role = 'Lead'
);