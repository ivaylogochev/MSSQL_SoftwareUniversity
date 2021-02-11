--01. Records’ Count
SELECT COUNT(*) AS Count 
	FROM WizzardDeposits;
--02. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits;
--03. Longest Magic Wand per Deposit Groups
SELECT w.DepositGroup AS [DepositGroup],
	MAX(w.MagicWandSize) AS [LongestMagicWand]
	FROM WizzardDeposits w
	GROUP BY w.DepositGroup;
--04. Smallest Deposit Group per Magic Wand Size 
--TODO
--05. Deposits Sum
SELECT w.DepositGroup AS [DepositGroup],
	SUM(w.DepositAmount) AS [TotalSum]
	FROM WizzardDeposits w
	GROUP BY w.DepositGroup;
--06. Deposits Sum for Ollivander Family
SELECT w.DepositGroup AS [DepositGroup],
	SUM(w.DepositAmount) AS [TotalSum]
	FROM WizzardDeposits w
	WHERE w.MagicWandCreator = 'Ollivander family'
	GROUP BY w.DepositGroup;
--07. Deposits Filter
SELECT w.DepositGroup AS [DepositGroup],
	SUM(w.DepositAmount) AS [TotalSum]
	FROM WizzardDeposits w
	WHERE w.MagicWandCreator = 'Ollivander family' 
	GROUP BY w.DepositGroup
	HAVING SUM(w.DepositAmount) < 150000
	ORDER BY [TotalSum] DESC;
--08. Deposit Charge
SELECT w.DepositGroup AS [DepositGroup],
	w.MagicWandCreator,
	MIN(w.DepositCharge) AS [MinDepositCharge]
	FROM WizzardDeposits w
	GROUP BY w.DepositGroup, w.MagicWandCreator
	ORDER BY w.MagicWandCreator, [DepositGroup];
--09. Age Groups
SELECT CASE
	WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
	END AS [AgeGroup],
	COUNT(*)
	 FROM WizzardDeposits w
	 GROUP BY  CASE
	WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
	END;
--09. Age Groups(SUBQUERY)
SELECT g.AgeGroup, COUNT(*)
FROM (SELECT CASE WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
	END AS [AgeGroup]
	FROM WizzardDeposits w) g
	GROUP BY g.AgeGroup;

--10. First Letter
SELECT LEFT(w.FirstName, 1) AS FirstLetter 
	FROM WizzardDeposits w
	WHERE w.DepositGroup = 'Troll Chest'
	GROUP BY LEFT(w.FirstName, 1)
	ORDER BY FirstLetter;
	--11. Average Interest
SELECT w.DepositGroup,
	w.IsDepositExpired,
	AVG(w.DepositInterest) AS AverageInterest
	FROM WizzardDeposits w
	WHERE w.DepositStartDate > '1985-01-01'
	GROUP BY w.DepositGroup, w.IsDepositExpired
	ORDER BY w.DepositGroup DESC, w.IsDepositExpired;
--12. Rich Wizard, Poor Wizard
--TODO
--13. Departments Total Salaries
SELECT e.DepartmentID,
	SUM(e.Salary)
	FROM Employees e
	GROUP BY DepartmentID;
--14. Employees Minimum Salaries
SELECT e.DepartmentID,
	MIN(e.Salary)
	FROM Employees e
	WHERE e.HireDate > '2000-01-01'
	GROUP BY DepartmentID
	HAVING DepartmentID IN (2,5,7);
--15. Employees Average Salaries
SELECT * INTO #TempEmploees 
	FROM Employees e
	WHERE e.Salary > 30000;
DELETE FROM #TempEmploees
	WHERE ManagerID = 42;
UPDATE  #TempEmploees
	SET SALARY += 5000
	WHERE DepartmentID = 1;
SELECT DepartmentID,
	AVG(Salary) AverageSalary
	FROM #TempEmploees
	GROUP BY DepartmentID;
--16. Employees Maximum Salaries
SELECT DepartmentID,
	MAX(Salary) MaxSalary
	FROM Employees	
	GROUP BY DepartmentID
	HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;
--17. Employees Count Salaries
SELECT COUNT(*) AS Count
	FROM Employees
	WHERE ManagerID IS NULL;
--18. 3rd Highest Salary
--TODO
--19. Salary Challenge
--TODO