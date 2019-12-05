create database StudentDB
on
(name = 'Student_dat', filename='d:\FPT Aptech\DM\student\Student_dat.mdf', size=5, maxsize=unlimited, filegrowth= 10%)
log on
(name = 'Student_log', filename='d:\FPT Aptech\DM\student\Student_dat_log.mdf', size =5, maxsize=15, filegrowth=1)
go

use StudentDB
go

create table tbStudent
(
roll_no int identity primary key,
FullName Varchar(40) not null,
Grade varchar(1) not null check (Grade = 'A' or grade = 'B' or grade = 'c') ,
sex varchar (6) default 'Female',
[Address] varchar(60),
DOB Date
)
go

select * from tbStudent
go

INSERT dbo.tbStudent
    (
        Fullname,
        Grade,
        Sex,
        [Address],
        DOB
    )
VALUES
    (
        'Rita',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'New York',       -- Address - varchar(60)
        '19850412' -- DOB - date
    ),
    (
        'Beck',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19861223' -- DOB - date
    ),
    (
        'Wilson',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'New Jersey',       -- Address - varchar(60)
        '19880709' -- DOB - date
    ), 
    (
        'Leonard',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Ohio',       -- Address - varchar(60)
        '19871217' -- DOB - date
    ),	
    (
        'Julia',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'Chicago',       -- Address - varchar(60)
        '19860131' -- DOB - date
    ),	
    (
        'Ringo',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Atlanta',       -- Address - varchar(60)
        '19851218' -- DOB - date
    ), 
    (
        'Annie',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'Washington',       -- Address - varchar(60)
        '19880415' -- DOB - date
    ),	   
    (
        'Sandra',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19860912' -- DOB - date
    ),
    (
        'Tom',       -- Fullname - varchar(40)
        'A',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Ohio',       -- Address - varchar(60)
        '19870801' -- DOB - date
    ),	 
    (
        'Susie',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'California',       -- Address - varchar(60)
        '19881203' -- DOB - date
    ),	
    (
        'Bob',       -- Fullname - varchar(40)
        'B',       -- Grade - varchar(1)
        'Male',       -- Sex - varchar(6)
        'Washington',       -- Address - varchar(60)
        '19871204' -- DOB - date
    ),	
    (
        'Rosy',       -- Fullname - varchar(40)
        'C',       -- Grade - varchar(1)
        'Female',       -- Sex - varchar(6)
        'New York',       -- Address - varchar(60)
        '19850305' -- DOB - date
    )

create table tbBatch
(
	Batch_no Varchar(10) not null primary key,
	Course_name varchar(40) not null,
	[Start_Date] DATE
)
go

insert dbo.tbBatch
(
	Batch_no,
	Course_name,
	Start_Date
)
Values
(
	'F2_1401', -- Batch_no - varchar(10)
	'ACCP 2011', -- Course_name - varchar(40)
	'20140102' -- Start_Date - date
),
(
	'F2_1402',
	'ACCP 2011',
	'20140201'
),
(
	'F2_1403',
	'ACCP 2013 new',
	'20140305'
),
(
	'F3_1402',
	'ACCP 2011',
	'20140202'
),
(
	'F3_1404',
	'ACCP 2011',
	'20140403'
)
go



create table tbRegister
(
	Batch_no varchar(10) not null,
	Roll_no int,
	Comment varchar(100),
	Register_date Date default getdate(),
	Foreign key (Batch_no) references dbo.tbBatch,
	Foreign key (Roll_no) references dbo.tbStudent,
	Primary key (Batch_no, Roll_no)
)
go

select * from dbo.tbRegister
go

SELECT* FROM dbo.tbStudent
GO

SELECT * FROM dbo.tbBatch
GO 

 insert dbo.tbRegister
 (
	Batch_no,
	Roll_no,
	Comment,
	Register_date
 )
 Values 
 (
	'F2_1401' ,--Batch_no - varchar (10)
	8, --Roll_no - int *Lưu ý khoái ngoại phải giống khoá bên cột chính
	'Ricardo Milos', --Comment - varchar (100)
	GETDATE() --Register_date - date
 ),
 (
	'F2_1402' ,--Batch_no - varchar (10)
	9, --Roll_no - int
	'Chimichanga', --Comment - varchar (100)
	GETDATE() --Register_date - date
 ),
 (
	'F2_1401' ,--Batch_no - varchar (10)
	10, --Roll_no - int
	'Curved Penis', --Comment - varchar (100)
	GETDATE() --Register_date - date
 ),
 (
	'F2_1401' ,--Batch_no - varchar (10)
	11, --Roll_no - int
	'Curved Banana', --Comment - varchar (100)
	GETDATE() --Register_date - date
 ),
 (
	'F2_1401' ,--Batch_no - varchar (10)
	12, --Roll_no - int
	'Prime minister Spring Fuck', --Comment - varchar (100)
	GETDATE() --Register_date - date
 )
 go




