CREATE DATABASE MYCourseTask
GO
USE MYCourseTask
GO
CREATE TABLE Academies (
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100)

)
GO
CREATE TABLE Groups  (
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100),
	AcademyId INT FOREIGN KEY(AcademyId) REFERENCES Academies(Id)

)
GO
CREATE TABLE Students  (
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100),
	Surname NVARCHAR(100),
	Age INT ,
	Adulthood NVARCHAR(10) DEFAULT 'False',
	GroupId INT FOREIGN KEY(GroupId) REFERENCES Groups(Id)
)
GO
CREATE TABLE DeletedGroups(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100),
	AcademyId INT FOREIGN KEY(AcademyId) REFERENCES Academies(Id)
)
GO
CREATE TABLE DeletedStudents   (
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100),
	Surname NVARCHAR(100),
	GroupId INT FOREIGN KEY(GroupId) REFERENCES Groups(Id)

)
INSERT INTO Academies
VALUES 
('Code Academy'),
('Dev Academy'),
('Step IT')

INSERT INTO Groups
VALUES
('BB201',1),
('BB202',1),
('BF201',1),
('CD100',2),
('DM202',3)


INSERT INTO Students
VALUES
('Agha','Badalov',19,'True',1),
('Cekah','Hacili',17,'False',1),
('Murad','Eliyev',29,'True',1),
('Sima','Maniyeva',19,'True',2),
('Ilaha','Latifova',18,'True',2),
('Rehim','Abbasov',16,'False',3),
('Kamal','Quluzade',17,'False',3),
('Zlatan','Ibrahimovic',40,'True',4),
('Hesen','Muradov',21,'True',4),
('Zabil','Medetov',15,'False',5),
('Tural','Memmedov',7,'False',5)

GO
CREATE VIEW VW_GetStudents
AS
SELECT * FROM Students

GO

CREATE VIEW VW_GetAcademies
AS
SELECT * FROM Academies

GO
CREATE VIEW VW_GetGroups
AS
SELECT * FROM Groups

GO
CREATE PROCEDURE USP_GetGroupByName @Name NVARCHAR(100)
AS
SELECT * FROM Groups
WHERE Groups.Name LIKE '%'+@name+'%'

GO
CREATE PROCEDURE USP_GetStudentsByBiggerThanAge @MinAge INT
AS
SELECT  * FROM Students
WHERE Age>@MinAge

GO
CREATE PROCEDURE USP_GetStudentsBySnallerThanAge @MaxAge INT
AS
SELECT  * FROM Students
WHERE Age<@MaxAge


GO

CREATE TRIGGER TRGR_DeleteDataStudents
ON Students
AFTER DELETE
AS
INSERT INTO  DeletedStudents(Name,Surname,GroupId)
SELECT Name,Surname,GroupId FROM deleted

GO

CREATE TRIGGER TRGR_DeleteDataGroups
ON Groups
AFTER DELETE
AS
INSERT INTO  DeletedGroups(Name,AcademyId)
SELECT Name,AcademyId FROM deleted

GO



Create Trigger TRGR_AgeUpdate
ON Students
AFTER UPDATE
AS
BEGIN
	DECLARE @age int
	DECLARE @id int
		SELECT @age = inserted.Age, @id = inserted.Id FROM inserted
		UPDATE Students
		SET AdultHood = 'FALSE'
		WHERE @age < 18 and Id = @id

		SELECT @age = inserted.Age, @id = inserted.Id FROM inserted
		UPDATE Students
		SET AdultHood = 'TRUE'
		WHERE @age >= 18 and Id = @id
END



GO
Create Trigger TRGR_CheckAge
ON Students
AFTER INSERT
AS
BEGIN
	DECLARE @id int
	DECLARE @age int
		SELECT @age = inserted.Age, @id = inserted.Id FROM inserted
		UPDATE Students
		SET AdultHood = 'False'
		WHERE @age < 18 and Id = @id

		SELECT @age = inserted.Age, @id = inserted.Id FROM inserted
		UPDATE Students
		SET AdultHood = 'True'
		WHERE @age >= 18 and Id = @id

END
GO
SELECT * FROM VW_GetStudents
GO

SELECT * FROM VW_GetAcademies

GO

SELECT * FROM VW_GetGroups
GO

EXEC  USP_GetGroupByName BB
GO
EXEC  USP_GetStudentsByBiggerThanAge 22

GO
EXEC  USP_GetStudentsBySnallerThanAge 20
GO
