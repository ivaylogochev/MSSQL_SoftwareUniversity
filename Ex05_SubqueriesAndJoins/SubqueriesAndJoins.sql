--1.Employee Address
SELECT TOP(5) e.EmployeeID,
		e.JobTitle,
		e.AddressID,
		a.AddressText
		FROM [Employees] e
		JOIN Addresses a ON E.AddressID = a.AddressID
		ORDER BY a.AddressID ASC;
--02. Addresses with Towns
SELECT TOP(50) e.FirstName,
	e.LastName,
	t.Name AS Town,
	a.AddressText
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID = t.TownID
	ORDER BY FirstName, LastName;
--03. Sales Employees
SELECT EmployeeID,
	FirstName,
	LastName,
	d.Name AS DepartmentName
	FROM Employees e
	LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE d.Name = 'Sales'
	ORDER BY EmployeeID;
--04. Employee Departments
SELECT TOP(5) e.EmployeeID,
	e.FirstName,
	e.Salary,
	d.Name AS DepartmentName
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY e.DepartmentID;
--05. Employees Without Projects --ADDITIONAL RESEARCH
SELECT TOP(3) e.EmployeeID, FirstName
	FROM Employees e
	LEFT JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
	WHERE ep.ProjectID IS NULL
	ORDER BY EmployeeID;
--06. Employees Hired After
SELECT FirstName,
	LastName, 
	HireDate,
	d.Name [DeptName]
	FROM Employees e
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
	WHERE HireDate > '01-01-1999' AND d.Name IN ('Sales', 'Finance')
	ORDER BY HireDate;
--07. Employees With Project
SELECT TOP(5) 
	e.EmployeeID,
	FirstName,
	p.Name AS [ProjectName]
	FROM Employees e
	LEFT JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	LEFT JOIN Projects p ON p.ProjectID = ep.ProjectID
	WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
	ORDER BY e.EmployeeID;
--08. Employee 24
SELECT  
	e.EmployeeID,
	FirstName,
	CASE 
	WHEN p.StartDate >= '2005' THEN NULL
	ELSE p.[Name] 
	END AS [ProjectName]
	FROM Employees e
	LEFT JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	LEFT JOIN Projects p ON p.ProjectID = ep.ProjectID
	WHERE e.EmployeeID = 24;
--09. Employee Manager
SELECT e.EmployeeID,
	e.FirstName,
	m.EmployeeID,
	m.FirstName
	FROM Employees e
	JOIN Employees m ON m.EmployeeID = e.ManagerID
	WHERE m.EmployeeID IN (3,7)
	ORDER BY e.EmployeeID;
--10. Employees Summary
SELECT TOP(50) e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS EmployeeName,
	m.FirstName + ' ' + m.LastName AS ManagerName,
	d.[Name] AS DepartmentName
	FROM Employees e
	JOIN Employees m ON m.EmployeeID = e.ManagerID
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID;
--11. Min Average Salary
SELECT TOP(1) AVG(e.Salary) AS [MinAverageSalary]
	FROM Departments d
	JOIN Employees e ON d.DepartmentID = e.DepartmentID
	GROUP BY d.DepartmentID
	ORDER BY [MinAverageSalary];
--12. Highest Peaks in Bulgaria
SELECT mc.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
	FROM Peaks p
	JOIN Mountains m ON p.MountainId = m.Id
	JOIN MountainsCountries mc ON p.MountainId = mc.MountainId
	JOIN Countries c ON c.CountryCode = mc.CountryCode
	WHERE c.CountryName = 'Bulgaria'AND p.Elevation > 2835
	ORDER BY p.Elevation DESC;
--13. Count Mountain Ranges
SELECT mc.CountryCode,
	COUNT(*)
	FROM  Mountains m
	JOIN MountainsCountries mc ON m.Id = mc.MountainId
	JOIN Countries c ON c.CountryCode = mc.CountryCode
	WHERE c.CountryName IN ('United States', 'Russia', 'Bulgaria')
	GROUP BY mc.CountryCode;
--14. Countries With or Without Rivers
SELECT TOP(5) c.CountryName,
	r.RiverName
	FROM Countries c
	LEFT JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers r ON r.Id = cr.RiverId
	LEFT JOIN Continents cn ON c.ContinentCode = cn.ContinentCode
	WHERE cn.ContinentName = 'Africa'
	ORDER BY c.CountryName ASC;
--15. Continents and Currencies
--TODO
--16. Countries Without any Mountains
SELECT COUNT(*) AS [Count]
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	WHERE mc.MountainId IS NULL;
--17. Highest Peak and Longest River by Country
SELECT TOP(5) c.CountryName, 
	MAX(p.Elevation) AS [HighestPeakElevation],
	MAX(r.Length) AS [LongestRiverLength]
	FROM Countries c
	JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	JOIN Rivers r ON r.Id = cr.RiverId
	JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	JOIN Mountains m ON m.Id = mc.MountainId
	JOIN Peaks p ON p.MountainId = m.Id
	JOIN Continents cn ON c.ContinentCode = cn.ContinentCode
	GROUP BY c.CountryName
	ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName;
--18. Highest Peak Name and Elevation by Country
--TODO