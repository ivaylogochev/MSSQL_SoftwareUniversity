CREATE DATABASE Minions;

CREATE TABLE Minions
(
	Id INT NOT NULL,
	[Name] NVARCHAR(90) NOT NULL,
	Age TINYINT NOT NULL
);

CREATE TABLE Towns
(
	Id INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
);

ALTER TABLE Minions
ADD CONSTRAINT PK_Minion PRIMARY KEY (Id);

ALTER TABLE Towns
ADD CONSTRAINT PK_Town PRIMARY KEY (Id);

ALTER TABLE Minions
	ADD TownId INT;

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id);

-- TASK 4
INSERT INTO Towns (Id, [Name])
VALUES (1, 'Sofia'),
	   (2, 'Plovdiv'),
	   (3, 'Varna');

INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES (1,'Kevin', 22, 1),
	   (2,'Bob', 15, 3),
	   (3,'Steward', NULL, 2);
-- Task 5
TRUNCATE TABLE Minions;
-- Task 6 
DROP TABLE Minions;
DROP TABLE Towns;
--Task 7
CREATE TABLE People
(
	Id INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture NVARCHAR(MAX),
	Height FLOAT(24),
	[Weight] FLOAT(24),
	Gender BIT NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
);

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthdate, Biography) VALUES
	('Ivaylo', 'https://github.com/MightyPen', 1.85, 86.400, 0, '1990-08-09', 'Junior Web Dev' ),
	('Pesho', NULL, 1.77, 75.350, 0, '1992-07-03', 'HR'),
	('Neli', NULL, 1.66, 49.200, 1, '1995-01-06', 'HR'),
	('Gosho', NULL, 1.87, 98.670, 0, '1964-02-04', 'Security'),
	('Mihail', 'https://github.com/Mike', 1.77, 88.520, 0, '1990-01-09', 'Dev');
--Task 8
CREATE TABLE Users
(
	Id BIGINT IDENTITY PRIMARY KEY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARCHAR(MAX),
	LastLoginTime DATETIME,
	IsDeleted BIT
);

INSERT INTO Users(Username, [Password], ProfilePicture, LastLoginTime, IsDeleted) VALUES
	('THEG4ME','iNCRIPTED_Pass', 'https://stackoverflow.com/users/314488/pranay-rana', '2021-01-15 14:08:53', 0),
	('legy', 'MyPass', NULL, GETDATE(), 1),
	('nYX40', 'fAKEpASS', NULL, '2021-01-12 18:10:49', 1),
	('Narsil', 'One0Pass', 'C:\Users\igochev2\Desktop\Moq.JPG', NULL, 1 ),
	('Aremona', 'PlainTextPass', NULL, GETDATE(), 0);
--Task 9
ALTER TABLE Users 
	DROP CONSTRAINT PK__Users__3214EC07F2B198C9;

ALTER TABLE Users
	ADD CONSTRAINT PK_IdUsername PRIMARY KEY(Id, Username);
--Task 10
ALTER TABLE Users
	ADD CONSTRAINT CHK_MinPassLength CHECK (LEN([Password]) >= 5);
--Task 11
ALTER TABLE Users 
	ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime;
--Task 12
ALTER TABLE Users
	DROP CONSTRAINT PK_IdUsername;
ALTER TABLE Users
	ADD CONSTRAINT PK_IdUsername PRIMARY KEY(Id);
ALTER TABLE Users
	ADD CONSTRAINT CHK_MinUsernameLength CHECK (LEN(Username) >= 3);
ALTER TABLE Users
	ADD UNIQUE (Username);
--Task 13
CREATE DATABASE Movies;

CREATE TABLE Directors
(
	Id INT IDENTITY PRIMARY KEY,
	DirectorName VARCHAR(90) NOT NULL,
	Notes VARCHAR(MAX)
);

CREATE TABLE Genres
(
	Id INT IDENTITY PRIMARY KEY,
	GenreName VARCHAR(50) NOT NULL,
	Notes VARCHAR(MAX)
);

CREATE TABLE Categories
(
	Id INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(50) NOT NULL,
	Notes VARCHAR(MAX)
);

CREATE TABLE Movies
(
	Id INT IDENTITY PRIMARY KEY,
	Title VARCHAR(150) NOT NULL,	
	DirectorId INT FOREIGN KEY REFERENCES [dbo].[Directors] NOT NULL,
	CopyrightYear DATE NOT NULL,
	[Length] TIME,
	GenreId INT FOREIGN KEY REFERENCES [dbo].[Genres] NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES [dbo].[Categories] NOT NULL,
	Rating DECIMAL(3,2),
	Notes VARCHAR(MAX)
);

INSERT INTO Directors(DirectorName, Notes) VALUES
('George Abbott', 'George notes'),
('Ana Lily Amirpour', NULL),
('Jack Arnold', NULL),
('Miguel Arteta', NULL),
('Hal Ashby', 'sample notes');

INSERT INTO Genres(GenreName, Notes) VALUES
('Comedy', 'fun category'),
('Fantasy', 'my favourite'),
('Historical', 'movies like "Brave heart"'),
('Horror', NULL),
('Action', 'bam-bam');

INSERT INTO Categories(CategoryName, Notes) VALUES
('Comedy Category', NULL),
('Fantasy Category', 'test category'),
('Historical Category', 'test category'),
('Horror Category', NULL),
('Action Category', NULL);

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
('Lord of the Rings', 1, '2000', '03:32:16', 2, 2, 9.85, 'best movie ever'),
('Armagedon', 2, '2012', '01:45:16', 3, 5, 6.48, NULL),
('Rocky Balboa', 3, '2009', '01:26:16', 1, 4, 7.5, 'test notes'),
('Brave Heart', 4, '2015', '02:06:36', 5, 2, 6.18, NULL),
('Friends', 5, '1998', '00:25:48', 4, 3, 4.27, NULL);
--Task 14
CREATE DATABASE CarRental;

CREATE TABLE Categories
(
	Id INT IDENTITY PRIMARY KEY,
	CategoryName VARCHAR(70) NOT NULL,
	DailyRate DECIMAL(5,2) NOT NULL,
	WeeklyRate DECIMAL(5,2) NOT NULL,
	MonthlyRate DECIMAL(6,2) NOT NULL,
	WeekendRate DECIMAL(5,2) NOT NULL
);
	--•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
CREATE TABLE Cars
(
	Id INT IDENTITY PRIMARY KEY, 
	PlateNumber VARCHAR(10) NOT NULL,
	Manufacturer VARCHAR(50), 
	Model VARCHAR(50),
	CarYear DATE NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Doors TINYINT, 
	Picture VARCHAR(MAX),
	Condition VARCHAR(50),
	Available BIT NOT NULL
);
	--•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(60) NOT NULL,
	LastName VARCHAR(60) NOT NULL,
	Title VARCHAR(90) NOT NULL,
	Notes VARCHAR(MAX)
);
	--•	Employees (Id, FirstName, LastName, Title, Notes)
CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	DriverLicenceNumber VARCHAR(20) NOT NULL,
	FullName VARCHAR(120) NOT NULL,
	[Address] VARCHAR(200) NOT NULL,
	City VARCHAR(50) NOT NULL,
	ZIPCode VARCHAR(10),
	Notes VARCHAR(MAX)
);
	--•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
CREATE TABLE RentalOrders
(
	Id INT IDENTITY PRIMARY KEY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
	CarId INT FOREIGN KEY REFERENCES Cars(Id),
	TankLevel VARCHAR(50) NOT NULL,
	KilometrageStart DECIMAL(6,2) NOT NULL,
	KilometrageEnd DECIMAL(6,2) NOT NULL,
	TotalKilometrage AS KilometrageEnd - KilometrageStart,
	StartDate DATE NOT NULL, 
	EndDate DATE NOT NULL,
	TotalDays AS DAY(StartDate) - DAY(EndDate),
	RateApplied VARCHAR(50) NOT NULL,
	TaxRate DECIMAL(6,2) NOT NULL,
	OrderStatus VARCHAR(50) NOT NULL,
	Notes VARCHAR(MAX) 
);
	--•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
INSERT INTO Categories(CategoryName, DailyRate,WeeklyRate, MonthlyRate, WeekendRate) VALUES
	('Sport', 14.5, 58.5, 195.6, 48),
	('Offroad', 13.5, 45.5, 170.6, 38.46),
	('SUV', 15.5, 50.5, 180.6, 42.53);

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
	('Y5563BM', 'Toyota', 'Rav4', '2010-5-16', 3, 5, NULL, 'New', 1),
	('A3679NL', 'Audi', 'S8', '2015-11-22', 1, 3, NULL, 'Used', 0),
	('CO8888BB', 'VW', 'Tiguan', '2016-12-18', 2, 5, NULL, 'Mild', 1);

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
	('Pesho', 'Stark', 'CEO', NULL),
	('Ivan', 'Banner', 'Manager', NULL),
	('Dimitur', 'Parker', 'Mechanic', NULL);

INSERT INTO Customers(DriverLicenceNumber, FullName,[Address], City, ZIPCode, Notes) VALUES
	('6578125425', 'Steph Curry', 'USA San Francisco CA', 'Francisco', 'CA3469', NULL),
	('3236418947', 'LeBron James', 'USA Los Angeles CA', 'Francisco', 'CA8889', NULL),
	('496845665565', 'Satnislav Govedarov', 'Yambol Bulgaria', 'Yambol', '8600', NULL);
	
INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate, RateApplied, TaxRate, OrderStatus, Notes) VALUES
	( 1, 2, 2, 'half', 50.45, 350.45, '2021-01-05', '2021-01-10', 'WeekendRate',
	20, 'Ready', NULL),
	(3, 1, 3, 'full', 150.45, 250.45, '2020-12-31', '2021-01-20', 'MonthlyRate',
	20, 'Waiting', NULL),
	(2, 3, 1, 'empty', 100, 200, '2020-12-31', '2021-01-11', 'MonthlyRate',
	20, 'InProgress', NULL);
--Task 15
CREATE DATABASE Hotel

CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Title VARCHAR(50) NOT NULL,
	Notes VARCHAR(MAX)
);
--•	Employees (Id, FirstName, LastName, Title, Notes)
CREATE TABLE Customers
(
	AccountNumber VARCHAR(50) PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(20) NOT NULL,
	EmergencyName VARCHAR(50) NOT NULL,
	EmergencyNumber VARCHAR(20) NOT NULL,
	Notes VARCHAR(MAX)
);
--•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
CREATE TABLE RoomStatus
(
	RoomStatus VARCHAR(30) PRIMARY KEY, 
	Notes VARCHAR(MAX)
);
--•	RoomStatus (RoomStatus, Notes)
CREATE TABLE RoomTypes
(
	RoomType VARCHAR(30) PRIMARY KEY, 
	Notes VARCHAR(MAX)
);
--•	RoomTypes (RoomType, Notes)
CREATE TABLE BedTypes
(
	BedType VARCHAR(30) PRIMARY KEY, 
	Notes VARCHAR(MAX)
);
--•	BedTypes (BedType, Notes)
CREATE TABLE Rooms
(
	RoomNumber TINYINT PRIMARY KEY,
	RoomType VARCHAR(30) FOREIGN KEY REFERENCES RoomTypes(RoomType),
	BedType VARCHAR(30) FOREIGN KEY REFERENCES BedTypes(BedType),
	Rate DECIMAL(5,2) NOT NULL,
	RoomStatus VARCHAR(30) FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
	Notes VARCHAR(MAX)
);
--•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
CREATE TABLE Payments
(
	Id INT IDENTITY PRIMARY KEY,
	EmployeeId INT NOT NULL,
	PaymentDate DATE NOT NULL,
	AccountNumber VARCHAR(50) NOT NULL,
	FirstDateOccupied DATE NOT NULL,
	LastDateOccupied DATE NOT NULL,
	TotalDays AS DAY(LastDateOccupied) - DAY(FirstDateOccupied),
	AmountCharged DECIMAL(15,2) NOT NULL,
	TaxRate DECIMAL(15,2) NOT NULL,
	TaxAmount DECIMAL(15,2) NOT NULL,
	PaymentTotal DECIMAL(15,2) NOT NULL,
	Notes VARCHAR(MAX)
);
--•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
CREATE TABLE Occupancies
(
	Id INT IDENTITY PRIMARY KEY,
	EmployeeId INT NOT NULL,
	DateOccupied DATE NOT NULL,
	AccountNumber VARCHAR(50) NOT NULL,
	RoomNumber TINYINT NOT NULL,
	RateApplied DECIMAL(15,2) NOT NULL,
	PhoneCharge DECIMAL(15,2) NOT NULL,
	Notes VARCHAR(MAX)
);
--•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
INSERT INTO Employees (FirstName, LastName, Title, Notes) VALUES
	('Ivan', 'Ivanov', 'Manager', NULL),
	('Pesho', 'Peshev', 'Receptionist', NULL),
	('Georgy', 'Georgiev', 'Cleaner', NULL);

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
	('646351554663', 'Ivan', 'Dimitrov', '0888943067', 'Petko L.', '0888879385', NULL),
	('56461348446', 'Petar', 'Grozdanov', '088894332', 'Lili', '0888874367', NULL),
	('1661651311556', 'Stanimir', 'Shopov', '0888943067', 'Misho', '0888879654', NULL);

INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
	('Free', NULL),
	('Occupaid', NULL),
	('For Maintenance', NULL);

INSERT INTO RoomTypes (RoomType, Notes) VALUES
	('One bed', NULL),
	('Double bed', NULL),
	('Appartment', NULL);

INSERT INTO BedTypes (BedType, Notes) VALUES
	('Single', NULL),
	('Double', NULL),
	('Kingsize', NULL);

INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes) VALUES
	(22,'One bed','Single', 150.99, 'For Maintenance', NULL),
	(23,'Double bed','Double', 200.33, 'Occupaid', NULL),
	(24,'Appartment','Kingsize', 250.66, 'Free', NULL);

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) VALUES
	(1, GETDATE(), '56413315646', GETDATE(), GETDATE()+DAY(2), 320.78, 20, 61.32, 382.1, NULL),
	(2, '2021-01-15', '56413315646', '2021-01-17', '2021-01-19', 310.78, 20, 51.32, 362.1, NULL),
	(3, '2021-01-10', '56413315646', '2021-01-10', '2021-01-15', 210.78, 20, 51.32, 262.1, NULL);

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
	(3, '2021-01-17', '56413315646', 22, 66.38, 12.58, NULL),
	(1, '2021-01-15', '56151513555', 24, 56, 0, NULL),
	(2, '2021-01-10', '1613315156', 23, 76.44, 113.77, NULL);

--Task 16
CREATE DATABASE SoftUni;

CREATE TABLE Towns
(
	Id INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
);
--•	Towns (Id, Name)
CREATE TABLE Addresses
(
	Id INT IDENTITY PRIMARY KEY,
	AddressText VARCHAR(90) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id)
);
--•	Addresses (Id, AddressText, TownId)
CREATE TABLE Departments
(
	Id INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
);
--•	Departments (Id, Name)
CREATE TABLE Employees
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	MiddleName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	JobTitle VARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL(10,3),
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
);
--•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)

--Tast 17
--backup database
USE SoftUni;
GO
BACKUP DATABASE SoftUni
--TO TAPE = '\\.\Tape0'
TO DISK = 'C:\temp\softuni-backup.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of SoftUni';
GO
--restore database
USE [master]
RESTORE DATABASE SoftUni 
FROM DISK = 'C:\temp\softuni-backup.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO
--Tast 18
INSERT INTO Towns([Name]) VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas');

INSERT INTO Departments([Name]) VALUES	
	('Engineering'),
	('Sales'),
	('Software Development'),
	('Quality Assurance'),	
	('Marketing');
--Engineering, Sales, Marketing, Software Development, Quality Assurance

INSERT INTO Employees(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 3, '2013-02-01', 3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 4, '2016-08-28', 525.25),
	('Georgi', ' Teziev ', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
	('Peter', 'Pan', 'Pan', 'Intern', 5, '2016-08-28', 599.88);
--Task 19
SELECT * FROM Towns;
SELECT * FROM Departments;
SELECT * FROM Employees;
--Task 20
SELECT * FROM Towns ORDER BY [Name];
SELECT * FROM Departments ORDER BY [Name];
SELECT * FROM Employees ORDER BY Salary DESC;
--Task 21
SELECT [Name] FROM Towns ORDER BY [Name];
SELECT [Name] FROM Departments ORDER BY [Name];
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC;
--Task 22
UPDATE Employees 
	SET Salary = Salary * 1.1;
SELECT Salary FROM Employees;
--Task 23
UPDATE Payments
	SET TaxRate = TaxRate * 0.97;
SELECT TaxRate FROM Payments;
--Task 24
TRUNCATE TABLE Occupancies;