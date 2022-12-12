CREATE TABLE Cities(
	Id SERIAL PRIMARY KEY,
	NAME varchar(15) NOT NULL UNIQUE
);

CREATE TABLE Members(
	Id SERIAL PRIMARY KEY,
	OIB varchar(11) NOT NULL UNIQUE CHECK (LENGTH(OIB) = 11),
	FirstName varchar(15) NOT NULL,
	LastName varchar(15)NOT NULL,
	Birth DATE NOT NULL,
	Gender varchar(1) CHECK (Gender IN ('M', 'F')),
	CityId int REFERENCES Cities(Id)
);

CREATE TABLE Internships(
	Id SERIAL PRIMARY KEY,
	Year int NOT NULL,
	DateOfBegining DATE NOT NULL,
	DateOfEnd DATE NOT NULL,
	Status varchar(10) CHECK (Status IN ('U pripremi', 'U tijeku', 'Završen')),
	LeaderId int REFERENCES Members(Id),
	CONSTRAINT unique_date UNIQUE
	(Year),
	CONSTRAINT end_is_bigger CHECK
	(DateOfEnd > DateOfBegining),
	CONSTRAINT check_dateofbegining CHECK
	(Year = DATE_PART('year', DateOfBegining)),
	CONSTRAINT check_date_of_end CHECK
	(Year+1 = DATE_PART('year', DateOfEnd))
);



CREATE TABLE Fields (
	Id SERIAL PRIMARY KEY,
	Name varchar(15) NOT NULL CHECK (Name IN ('Programiranje', 'Dizajn', 'Marketing', 'Multimedia')),
	LeaderId int REFERENCES Members(Id),
	InternshipId int REFERENCES Internships(Id)
);

CREATE TABLE FieldMember(
	FieldId int REFERENCES Fields(Id),
	MemberId int REFERENCES Members(Id)
);


CREATE TABLE Interns(
	Id SERIAL PRIMARY KEY,
	OIB varchar(11) NOT NULL UNIQUE CHECK (LENGth(OIB) = 11),
	FirstName varchar(15) NOT NULL,
	LastName varchar(15) NOT NULL,
	Birth DATE NOT NULL CHECK(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', Birth) BETWEEN 16 AND 24),
	Gender varchar(1) CHECK (Gender IN ('M', 'F')),
	CityId int REFERENCES Cities(Id)
);

CREATE TABLE InternStatus(
	Status varchar(20) NOT NULL CHECK(Status IN ('Pripravnik', 'Izbačen', 'Završen Internship')),
	FieldId int REFERENCES Fields(Id),
	InternId int REFERENCES Interns(Id)
);

CREATE TABLE Homeworks(
	Id SERIAL PRIMARY KEY,
	Grade int NOT NULL CHECK (Grade BETWEEN 1 AND 5),
	InternId int REFERENCES Interns(Id),
	GraderId int REFERENCES Members(Id),
	FieldId int REFERENCES Fields(id)
);





	
	
SELECT CONCAT(m.FirstName, m.LastName) AS ImeIPrezime FROM Members m
WHERE m.CityId NOT IN
(SELECT CityId FROM Cities WHERE Name LIKE 'Split');

SELECT i.DateOfBegining AS DatumPocetka, i.DateOfEnd AS DatumKraja FROM Internships I
ORDER BY i.DateOfBegining desc;

SELECT i.FirstName, i.LastName FROM Interns i
WHERE i.ID IN
(SELECT ins.Id FROM InternStatus ins WHERE ins.InternId = i.Id IN
 (SELECT f.Id FROM Fileds f WHERE f.Id = ins.FieldId IN
  (SELECT ints.Id FROM Internships inst WHERE inst.year LIKE '2021' OR inst.yeat LIKE '2022' )));
  
SELECT COUNT(*) FROM Interns i
where i.Gender LIKE 'F';

SELECT COUNT(*) FROM Interns i
WHERE i.Id IN
(SELECT ins.Id FROM InternStatus ins WHERE ins.InternId = i.Id IN
 (SELECT f.Id FROM Fields f WHERE f.Id = ins.Field ID IN(SELECT f.Id WHERE f.Status LIKE 'Izbačen');
 
 




	
