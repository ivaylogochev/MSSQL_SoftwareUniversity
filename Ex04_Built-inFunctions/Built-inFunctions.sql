--01. Find Names of All Employees by First Name
SELECT FirstName, LastName
	FROM Employees
	WHERE FirstName LIKE 'SA%';
--02. Find Names of All Employees by Last Name
SELECT FirstName, LastName
	FROM Employees
	WHERE LastName LIKE '%EI%';
--03. Find First Names of All Employess
SELECT FirstName
	FROM Employees
	WHERE DepartmentID IN (3, 10)
	AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005;
--04. Find All Employees Except Engineers
SELECT FirstName, LastName
	FROM Employees
	WHERE JobTitle NOT LIKE '%engineer%';
--05. Find Towns with Name Length
SELECT [Name] 
	FROM Towns
	WHERE LEN([Name]) IN (5, 6)
	ORDER BY [Name];
--06. Find Towns Starting With
SELECT TownID, [Name] 
	FROM Towns
	WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
	ORDER BY [Name];
--07. Find Towns Not Starting With
SELECT TownID, [Name] 
	FROM Towns
	WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
	ORDER BY [Name];
--08. Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
	FROM Employees
	WHERE YEAR(HireDate) > 2000;
--09. Length of Last Name
SELECT FirstName, LastName
	FROM Employees
	WHERE LEN(LastName) = 5;
--10. Rank Employees by Salary
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary,
	DENSE_RANK() OVER
	(PARTITION BY e.Salary ORDER BY e.EmployeeID) AS Rank
FROM Employees AS e
WHERE e.Salary BETWEEN 10000 AND 50000 
ORDER BY e.Salary DESC;
--12. Countries Holding 'A'
SELECT [CountryName], IsoCode
	FROM Countries
	WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode;
--13. Mix of Peak and River Names
SELECT p.PeakName, r.RiverName, LOWER(p.PeakName + SUBSTRING(r.RiverName,2,LEN(r.RiverName))) as Mix
	FROM Peaks p
JOIN Rivers r ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1) 
ORDER BY Mix;
--14. Games From 2011 and 2012 Year
SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
	FROM Games
	WHERE YEAR([Start]) IN (YEAR('2011'), YEAR('2012'))
ORDER BY [Start], [Name];
--15. User Email Providers
SELECT u.Username,
	SUBSTRING(u.Email ,CHARINDEX('@', u.Email) + 1,(LEN(u.Email) - LEN(SUBSTRING(u.Email, 1, CHARINDEX('@', u.Email))))) AS [Email Provider]
FROM Users u
ORDER BY [Email Provider], u.Username;
--16. Get Users with IPAddress Like Pattern
SELECT Username, IpAddress
	FROM Users
	WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username;
--17. Show All Games with Duration
SELECT g.Name AS Game,
	CASE WHEN (DATEPART(HOUR, g.[Start]) >= 0 AND DATEPART(HOUR, g.[Start]) < 12) THEN 'Morning'
	 WHEN (DATEPART(HOUR, g.[Start]) >= 12 AND DATEPART(HOUR, g.[Start]) < 18) THEN 'Afternoon'
	 WHEN (DATEPART(HOUR, g.[Start]) >= 18 AND DATEPART(HOUR, g.[Start]) < 24) THEN 'Evening'
	END AS [Part of the Day],
	CASE WHEN (g.Duration <= 3) THEN 'Extra Short'
	 WHEN (g.Duration >= 4 AND g.Duration <= 6) THEN 'Short'
	 WHEN (g.Duration > 6 ) THEN 'Long'
	 WHEN (g.Duration IS NULL) THEN 'Extra Long'
	END AS [Duration]
	FROM Games g
	ORDER BY g.Name , CAST(g.Duration AS VARCHAR(MAX)) DESC, [Part of the Day] ASC;
	
--18. Orders Table
SELECT ProductName,
		OrderDate,
		OrderDate + DAY(3) AS [Pay Due],
		OrderDate + MONTH(1) AS [Deliver Due]
		FROM Orders
