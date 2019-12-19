--Prestest 2
/*
	1. Create a database named Pretest2DB with the following specifications :
	a. Primary file group with the data file pretest2.mdf. The size, maximum size, and file growth should be 5, 50 and 10% respectively.
	b. File group GroupData with the data file pretest2b.ndf. The size, maximum size, and file growth should be 10, unlimited, and 5 respectively.
	c. Log file pretest2_log.ldf. The size, maximum size, and file growth should be 2, unlimited, and 10% respectively.
*/
create database Pretest2DB
on primary
(name ='pretest2', filename='D:\FPT APtech\DM\BT\Assignment\pretest 2\Pretest2.mdf', size=5, maxsize=50, filegrowth= 10%),
filegroup MyFileGroup
(name ='pretest2b', filename='D:\FPT APtech\DM\BT\Assignment\pretest 2\Pretest2b.ndf', size=10, maxsize=unlimited, filegrowth= 5%)
log on
(name ='pretest2_log', filename='D:\FPT APtech\DM\BT\Assignment\pretest 2\Pretest2_log.ldf', size=2, maxsize=unlimited, filegrowth= 10%)
go

use Pretest2DB
go

/*
	2. Create the table tbFlight in the database, applying the specified appropriate constraints:
	- Aircaftcode: primary key
	- FType : only accept ‘Boeing’ or ‘Airbus’
	- Hours: from 1 to 20
*/

create table tbFlight
(
	AircraftCode nvarchar(10) primary key nonclustered,
	FType nvarchar(10) check (FType in ('Boeing','Airbus')),
	[Source] nvarchar(20),
	Destination nvarchar(20),
	DepTime time,
	JourneyHrs int check (JourneyHrs between 1 and 20)
)
go

insert dbo.tbFlight
(
	AircraftCode,
	FType,
	Source,
	Destination,
	DepTime,
	JourneyHrs

)
values
('UA01','Boeing','Los Angeles','London','15:30', 6),
('UA02','Boeing','Los Angeles','New York','09:30', 8),
('SA01','Boeing','Los Angeles','Ankara','10:30', 8),
('SA02','Airbus','Los Angeles','Moscow','11:15', 9),
('SQ01','Airbus','Los Angeles','Ankara','01:45', 15),
('SQ02','Boeing','Los Angeles','Aden','13:30', 10),
('SQ03','Airbus','Los Angeles','Nairobi','15:45', 6)
go

/*
	4. a. Create a clustered index IX_Source for Source column on tbFlight table.
		b. Create an index IX_Destination for Destination column on tbFlight table
*/

create clustered index IX_Source on dbo.tbFlight([Source])
go
create  index IX_Destinaton on dbo.tbFlight(Destination)
go

/*
	5. Write a query to display the flights that have journey hours less than 9.
*/
select * from dbo.tbFlight
where JourneyHrs<9
go

/*
	6. Create a view vwBoeing which contains flights that have Boeing aircrafts.
	Note: this view will need to check for domain integrity.
*/
create view vwBeoing
as
select * from dbo.tbFlight
where FType='Boeing'
with check option
go

select * from dbo.vwBeoing
go

/*
	7. Create a store procedure uspChangeHour to increase journey hours by a given value (input parameter)
*/
CREATE PROC uspChangeHour
@sogio INT =NULL 
AS
BEGIN
	--Nếu không nhập số giờ thì sẽ lấy Default =1
	IF @sogio IS NULL 
		SET @sogio=1  --Giá trị Default =1
		
	--Lệnh 1
	SELECT * FROM dbo.tbFlight
	--Lệnh 2
	UPDATE dbo.tbFlight SET JourneyHrs+=@sogio 
	--Lệnh 3
	SELECT * FROM dbo.tbFlight
END 
GO 

EXEC dbo.uspChangeHour
    @sogio = 2 -- int
GO 

/*
	8. Create a trigger tgFlightInsert for table tbFlight which will perform rollback transaction if a new record has the source same as the destination and display appropriate error message.
*/
CREATE TRIGGER tgFlightInsert
ON dbo.tbFlight
FOR INSERT,UPDATE AS
BEGIN
	DECLARE @xuatphat NVARCHAR(20)
	DECLARE @diemden NVARCHAR(20)
	SELECT @xuatphat=Inserted.Source,@diemden=Inserted.Destination FROM Inserted
	IF @xuatphat=@diemden 
	BEGIN
		PRINT N'Không được nhập Destination giống với Source'		
		ROLLBACK
	END 
END 

--Check trigger
INSERT dbo.tbFlight
    (
        Aircraftcode,
        FType,
        Source,
        Destination,
        DepTime,
        JourneyHrs
    )
VALUES
    (
        N'NhapDai01',        -- Aircraftcode - nvarchar(10)
        N'Boeing',        -- FType - nvarchar(10)
        N'Sài Gòn',        -- Source - nvarchar(20)
        N'Sài Gòn',        -- Destination - nvarchar(20)
        '02:21:59', -- DepTime - time
        10           -- JourneyHrs - int
    )
GO

UPDATE dbo.tbFlight SET Destination='Perth' WHERE Aircraftcode='SQ02'
GO 


/*
	9. Create a trigger tgFlightUpdate for table tbFlight which is not allowed to change value of aircraft code
*/
CREATE TRIGGER tgFlightUpdate
ON dbo.tbFlight
FOR UPDATE AS 
BEGIN
	IF UPDATE(Aircraftcode)
	BEGIN 
		PRINT N'Không được thay đổi giá trị Aircraft Code'
		ROLLBACK
	END 
END 
GO 

--Test Trigger
UPDATE dbo.tbFlight SET Aircraftcode='ND01' WHERE Aircraftcode='UA01'