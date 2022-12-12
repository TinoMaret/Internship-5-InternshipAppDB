CREATE TABLE Internships(
	Id SERIAL PRIMARY KEY,
	Year int NOT NULL,
	DateOfBegining TIMESTAMP NOT NULL,
	DateOfEnd TIMESTAMP NOT NULL,
	Status varchar(10) CHECK (Status IN ('U pripremi', 'U tijeku', 'Završen')),
	CONSTRAINT unique_date UNIQUE
	(Year),
	CONSTRAINT end_is_bigger CHECK
	(DateOfEnd > DateOfBegining),
	CONSTRAINT check_dateofbegining CHECK
	(Year = DATE_PART('year', DateOfBegining)),
	CONSTRAINT check_dateofend CHECK
	(Year = DATE_PART('year', DateOfEnd))
);

CREATE TABLE Cities(
	Id SERIAL PRIMARY KEY,
	NAME varchar(15) NOT NULL UNIQUE
);

CREATE TABLE Members(
	Id SERIAL PRIMARY KEY,
	OIB varchar(11) NOT NULL UNIQUE,
	FirstName varchar(15) NOT NULL,
	LastName varchar(15)NOT NULL,
	Birth TIMESTAMP NOT NULL,
	Gender varchar(1) CHECK (Gender IN ('M', 'F')),
	CityId int REFERENCES Cities(id)
);

CREATE TABLE LeaderOfInternship(
	InternshipId int REFERENCES Internships(Id),
	LeaderId int REFERENCES Members(Id)
);

CREATE TABLE Fields (
	Id SERIAL PRIMARY KEY,
	Name varchar(15) NOT NULL UNIQUE CHECK (Name IN ('Programiranje', 'Dizajn', 'Marketing', 'Multimedia')),
	MemberId int REFERENCES Members(Id)
);

CREATE TABLE Interns(
	Id SERIAL PRIMARY KEY,
	OIB varchar(11) NOT NULL UNIQUE,
	FirstName varchar(15) NOT NULL,
	LastName varchar(15) NOT NULL,
	Birth TIMESTAMP NOT NULL CHECK(DATE_PART('year', CURRENT_DATE) - DATE_PART('year', Birth) BETWEEN 16 AND 24),
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
	GraderId int REFERENCES Members(Id)
);