--01. One-To-One Relationship
CREATE TABLE Passports
(
	PassportID INT IDENTITY(101,1) PRIMARY KEY,
	PassportNumber NVARCHAR(20) NOT NULL,
);

CREATE TABLE Persons
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	Salary DECIMAL(8,2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID)
);
	-- unique constraint for FK in order to create One-to-one relation
ALTER TABLE Persons
	ADD CONSTRAINT UC_PersonToPassportID UNIQUE(PassportID);

INSERT INTO Passports(PassportNumber) VALUES
	('N34FG21B'),
	('K65LO4R7'),
	('ZE657QP2');

INSERT INTO Persons(FirstName, Salary, PassportID) VALUES
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101);

--02. One-To-Many Relationship
CREATE TABLE Manufacturers
(
	ManufacturerID INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL,
	EstablishedOn DATE NOT NULL
);

CREATE TABLE Models
(
	ModelID INT IDENTITY(101,1) PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
);

INSERT INTO Manufacturers([Name], EstablishedOn) VALUES
	('BMW', '1916-03-07'),
	('Tesla', '2003-01-01'),
	('Lada', '1966-05-01');

INSERT INTO Models([Name], ManufacturerID) VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3);
--03. Many-To-Many Relationship
CREATE TABLE Students
(
	StudentID INT IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE Exams
(
	ExamID INT IDENTITY(101,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES ExamS(ExamID),
	CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID)
);
	--ALTER TABLE StudentsExams
	--	ADD FOREIGN KEY (ExamID) REFERENCES ExamS(ExamID);

	--ALTER TABLE StudentsExams
	--	ADD FOREIGN KEY (StudentID) REFERENCES Students(StudentID);
	
	--ALTER TABLE StudentsExams
	--	ADD CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID);

INSERT INTO Students([Name]) VALUES
	('Mila'),
	('Toni'),
	('Ron');

INSERT INTO Exams([Name]) VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g');

INSERT INTO StudentsExams(StudentID, ExamID) VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103);
--04. Self-Referencing
CREATE TABLE Teachers
(
	TeacherID INT IDENTITY(101,1) PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
);

INSERT INTO Teachers([Name], ManagerID) VALUES
	('John', NULL),
	('Maya', 106),
	('Silvia', 106),
	('Ted', 105),
	('Mark', 101),
	('Greta', 101);
--05. Online Store Database
CREATE DATABASE [Online Store Database];

CREATE TABLE ItemTypes
(
	ItemTypeID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50)
);

CREATE TABLE Items
( 
	ItemID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50),
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
);

CREATE TABLE Cities
(
	CityID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50)
);

CREATE TABLE Customers
( 
	CustomerID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50),
	Birthday DATE,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
);

CREATE TABLE Orders
(
	OrderID INT IDENTITY PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems
(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID)
	CONSTRAINT PK_Orderitem PRIMARY KEY(OrderID, ItemID)
);
--06. University Database
CREATE DATABASE [University];

CREATE TABLE Majors
(
	MajorID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50)
);

CREATE TABLE Students
(
	StudentID INT IDENTITY PRIMARY KEY,
	StudentNumber INT NOT NULL,
	[StudentName] VARCHAR(50),
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
);

CREATE TABLE Payments
(
	PaymentID INT IDENTITY PRIMARY KEY,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(10,2),
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
);

CREATE TABLE Subjects
(
	SubjectID INT IDENTITY PRIMARY KEY,
	SubjectName VARCHAR(50)
);

CREATE TABLE Agenda
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_Agenda PRIMARY KEY(StudentID, SubjectID)
);

--09. *Peaks in Rila
SELECT MountainRange, PeakName, Elevation 
	FROM Mountains
	JOIN Peaks ON Mountains.Id = Peaks.MountainId
WHERE MountainRange = 'Rila'
ORDER BY Elevation DESC;