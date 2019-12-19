--1 . Create a database called ASM7 which has two data files: one belongs to Primary group, and the other bel
create database ASM7 
on primary
(name = 'ASM7_primary', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 7\ASM_primary.mdf' , size=10, maxsize=15, filegrowth = 20%),
filegroup MyFileGroup
(name = 'ASM7_secondary', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 7\ASM_secondary.ndf' , size=10, maxsize=15, filegrowth = 20%)
go

use ASM7 
go

--2 .Create the the following tables: 
-- a. “tbBatch” table
-- b. “tbStudent” table
--	- Write a query (check constraint) to accept only positive number and less than (<) 6 in the Size field of table	tbBatch
--	- Write a query (check constraint) to accept only 2 values ‘M’ and ‘F’ in the Gender field of table tbStudent
--	- Write a query (check constraint) to accept only value of field EnrollYear >=2000
--	- Add at least 4 records in table “tbBatch” and 8 records in table “tbStudent”


create table tbBatch
(
	BatchNo varchar(10) primary key,
	--Ràng buộc CHECK được sử dụng nhằm giới hạn phạm vi giá trị mà một cột có thể chứa.
	Size int check( Size > 0 and Size < 6), --number of students
	TimeSlot varchar(20),
	RoomNo varchar(10)
)
go

create table tbStudent
(
	Rollno varchar (10) primary key, --nhớ thêm nonclustered
	LastName varchar(20) not null,
	FirstName varchar(20) not null,
	Gender varchar(1) not null default 'M' check(Gender = 'F' or Gender= 'M' ),
	DOB Date,
	[Address] varchar (40),
	EnrollYear smallint not null default year(getdate()) check (EnrollYear>=2000),
	BatchNo varchar (10) foreign key references dbo.tbBatch(BatchNo)
)
go

select * from dbo.tbBatch
select * from dbo.tbStudent
go

insert dbo.tbBatch
(
	BatchNo,
	Size,
	TimeSlot,
	RoomNo
)
values
(
	'Fighter',-- Batch no -varchar (10)
	5, --Size - int
	'Jojo_morning', --timeslit - varchar(20)
	'R205'--room no -varchar(10)
),
(
	'Mage',-- Batch no -varchar (10)
	3, --Size - int
	'Jojo_afternoon', --timeslit - varchar(20)
	'R202'--room no -varchar(10)
),
(
	'Assassin',-- Batch no -varchar (10)
	1, --Size - int
	'Jojo_midnight', --timeslit - varchar(20)
	'R205'--room no -varchar(10)
),

(
	'Healer',-- Batch no -varchar (10)
	4, --Size - int
	'Jojo_erect', --timeslit - varchar(20)
	'R206'--room no -varchar(10)
),
(
	'Gunner',-- Batch no -varchar (10)
	2, --Size - int
	'Jojo_dust', --timeslit - varchar(20)
	'R207'--room no -varchar(10)
)
go

insert dbo.tbStudent
(
	Rollno,
	LastName,
	FirstName,
	Gender,
	DOB,
	[Address],
	EnrollYear,
	BatchNo
)
values
(
	'ST01', --Rollno - varchar (10)
	'Milos', --Lastname -varchar(20)
	'Ricardo', --Firstname -varchar(20)
	'M', --Gender -varchar(1)
	'19880506', --DOB -date
	'Brazil', --Address - varchar(40)
	'2001', --Enroll year - smallint
	'Fighter' --Batchno - varchar(10)
),
(
	'ST02', --Rollno - varchar (10)
	N'Bùi', --Lastname -varchar(20)
	N'Bích Hà', --Firstname -varchar(20)
	'F', --Gender -varchar(1)
	'19981103', --DOB -date
	'VietNam', --Address - varchar(40)
	'2002', --Enroll year - smallint
	'Healer' --Batchno - varchar(10)
),
(
	'ST03', --Rollno - varchar (10)
	N'Lê', --Lastname -varchar(20)
	N'Hữu Nhân', --Firstname -varchar(20)
	'M', --Gender -varchar(1)
	'19970511', --DOB -date
	'VietNam', --Address - varchar(40)
	'2018', --Enroll year - smallint
	'Fighter' --Batchno - varchar(10)
),
(
	'ST04', --Rollno - varchar (10)
	'Penis', --Lastname -varchar(20)
	'Curved', --Firstname -varchar(20)
	'F', --Gender -varchar(1)
	'19980506', --DOB -date
	'GrimDawn', --Address - varchar(40)
	'2008', --Enroll year - smallint
	'Assassin' --Batchno - varchar(10)
),
(
	'ST05', --Rollno - varchar (10)
	'Putin', --Lastname -varchar(20)
	'Vladimir', --Firstname -varchar(20)
	'M', --Gender -varchar(1)
	'19880509', --DOB -date
	'Russia', --Address - varchar(40)
	'2002', --Enroll year - smallint
	'Gunner' --Batchno - varchar(10)
),
(
	'ST06', --Rollno - varchar (10)
	'Fuck', --Lastname -varchar(20)
	'Spring', --Firstname -varchar(20)
	'M', --Gender -varchar(1)
	'19780706', --DOB -date
	'Laos', --Address - varchar(40)
	'2005', --Enroll year - smallint
	'Mage' --Batchno - varchar(10)
),
(
	'ST07', --Rollno - varchar (10)
	'Tiamata', --Lastname -varchar(20)
	'Christina', --Firstname -varchar(20)
	'F', --Gender -varchar(1)
	'19910512', --DOB -date
	'Austria', --Address - varchar(40)
	'2004', --Enroll year - smallint
	'Mage' --Batchno - varchar(10)
),
(
	'ST08', --Rollno - varchar (10)
	'Kitty', --Lastname -varchar(20)
	'FLying', --Firstname -varchar(20)
	'F', --Gender -varchar(1)
	'19870516', --DOB -date
	'USA', --Address - varchar(40)
	'2006', --Enroll year - smallint
	'Assassin' --Batchno - varchar(10)
)
go

--3. Write Queries to retrieve the following information :
--	a. list of students sorted by gender and date of birth
--	b. count number of students grouped by gender .
--	c. list of students who have more 18 year-old, consisting of the columns: rollno, full name (lastname + firstname), gender, dob, address, batchno, roomno

--3a
select * from dbo.tbStudent
order by Gender, DOB
go

--3b
select Gender, COUNT(*) as N'Tổng số học sinh'
from dbo.tbStudent
group by Gender
go

--3c
--Cách 1 Xài SubQuerry
SELECT a.RollNo,(a.LastName +' '+ a.FirstName) AS [FullName],a.Gender,a.DoB,a.[Address],b.BatchNo,b.RoomNo
FROM dbo.tbStudent a, dbo.tbBatch b 
WHERE a.RollNo IN (SELECT a.RollNo FROM dbo.tbStudent WHERE DATEDIFF(yy,a.DoB,GETDATE())>18) 
	  AND 
	  b.BatchNo IN (SELECT BatchNo FROM dbo.tbBatch WHERE BatchNo=a.BatchNo)
GO 

--Cách 2 Xài Join cho đơn giản
SELECT  a.RollNo,(a.LastName +' '+ a.FirstName) AS [FullName],a.Gender,a.DoB,a.[Address],b.BatchNo,b.RoomNo 
FROM dbo.tbStudent a JOIN dbo.tbBatch b ON b.BatchNo = a.BatchNo
WHERE DATEDIFF(yy,a.DoB,GETDATE())>18
GO 
  -- 4. Create a view vwSchoolBoy to contain information of schoolboys which consist of columns Rollno, LastName, FirstName, age, BatchNo and Timeslot. This view needs to check for domain integrity.

 CREATE VIEW vwSchoolBoy
 AS 
 SELECT a.RollNo,a.LastName,a.FirstName,DATEDIFF(yy,a.DoB,GETDATE()) AS [Age],b.BatchNo,b.TimeSlot
 FROM dbo.tbStudent a JOIN dbo.tbBatch b ON b.BatchNo = a.BatchNo
 WHERE a.Gender='M'
 WITH CHECK OPTION
 GO 

 SELECT * FROM dbo.vwSchoolBoy
 GO 

 -- 5. Create a view vwNewStudent to see information of students enrolled in this year which contained the columns Rollno, full name, gender, DOB, BatchNo, roomNo.
 SELECT * 
 FROM dbo.tbStudent
 ORDER BY EnrollYear desc
 GO 

 CREATE VIEW vwNewStudent
 AS 
 SELECT a.RollNo,(a.LastName +' '+ a.FirstName) AS [FullName],a.Gender,a.DoB,b.BatchNo,b.RoomNo
 FROM dbo.tbStudent a JOIN dbo.tbBatch b ON b.BatchNo = a.BatchNo
 WHERE a.EnrollYear=YEAR(GETDATE())
 GO 

 SELECT * FROM dbo.vwNewStudent
 GO 