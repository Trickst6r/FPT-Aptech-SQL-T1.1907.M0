/*
	1. Create a database named Ass10_Db with the following specifications :
	a. Primary file group with the data file Ass10.mdf. The size, maximum size, and file growth should be 5, 50 and 10% respectively.
	b. File group Group1 with the data file Ass10_1.ndf. The size, maximum size, and file growth should be 10, unlimited, and 5 respectively.
	c. Log file Ass10_log.ldf. The size, maximum size, and file growth should be 2, unlimited, and 10% respectively.
*/


create database Ass10_db
on primary
(name = 'Ass10', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 10\Ass10.mdf', size=5,maxsize=50, filegrowth = 10%),
filegroup MyFileGroup
(name = 'Ass10_sec', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 10\Ass10_sec.ndf', size=10,maxsize=unlimited, filegrowth = 5%)
log on
(name = 'Ass10_log', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 10\Ass10_log.ldf', size=2,maxsize=unlimited, filegrowth = 10%)
go

use Ass10_db
go

create table tbCustomer
(
	CustCode varchar(5) primary key nonclustered,
	CustName varchar(30) not null,
	CustAddress varchar(50) not null,
	CustPhone varchar(15) ,
	CustEmail varchar(25),
	CustStatus varchar(10) default 'Valid' check(CustStatus = 'Valid' or CustStatus ='Invalid')
)
go

create table tbMessage
(
	MsgNo int identity(1000,1) primary key nonclustered, --identity: cột tăng tự động 
	CustCode varchar(5) foreign key references dbo.tbCustomer(CustCode),
	MsgDetails varchar(300) not null,
	MsgDate date not null default getdate(),
	[Status] varchar(10) check([Status]='Peding' or [Status]='Resolved')
)
go

--3. thêm dữ liệu vào bảng
insert dbo.tbCustomer
(
	CustCode,
	CustName,
	CustAddress,
	CustPhone,
	CustEmail,
	CustStatus
)
values
('C001','Rahul Khana','7th Cross Road','298345878','khana@hotmail.com', 'Valid'),
('C002','Anil Thakkar','Line All Road','657654323','Thakkar2002@yahoo.com', 'Valid'),
('C004','Sanjay Gupta','Link Road','367654323','Sanjay@indiatimes.com', 'Invalid'),
('C005','Sagar Vyas','Link Road','376543255','Sagarvyas@india.com', 'Valid')
go

insert dbo.tbMessage
(
	CustCode,
	MsgDetails,
	MsgDate,
	Status
)
Values
('C001','Voice mail always give Access Denied message', '20140831','Peding'),
('C005','Voice mail activation always give No Access message', '20140901','Peding'),
('C001','Please send all future bill to my residental address instead of my office address', '20140905','Resolved'),
('C004','Please send new mothly brochure', '20141108','Peding')
go

/*
	4. a. Create a clustered index IX_Name for CustName column on tbCustomer table.
	   b. Create a composite index IX_CustMsg fot CustCode and MsgNo columns on tbMessage table
*/
create clustered index IX_Name on dbo.tbCustomer(CustName)
go
create clustered index IX_Custsg on dbo.tbMessage(CustCode, MsgNo)
go

/*
	5. Write a query to display the list of customers have no message sent yet.
*/
select * from dbo.tbCustomer 
WHERE NOT EXISTS(SELECT * FROM dbo.tbMessage  WHERE CustCode=CustCode)
GO 

/*
	6. Create a view vReport which displays messages sended after 1 – Sep – 2014 as following:
		MsgNo MsgDetails			DatePosted	 PostedBy			Status
		1002  Please send all …		09/05/2014	 RahulKhana			Resolved
		1003  Please send new…		11/08/2014	 Sanjay Gupta		Pending
		…
	Note: The definition of view must be hidden from users.
*/

create view vReport
with encryption --hidden from users
as
select b.MsgNo, b.MsgDetails, b.MsgDate as [DatePosted], a.CustName as [PostedBy], a.CustStatus as [Status]
from dbo.tbCustomer a join dbo.tbMessage b on b.CustCode= a.CustCode
go

select * from dbo.vReport
go

/*
	7. Create a store procedure uspChangeStatus to modify CustStatus column in Customer table from “invalid” to “valid” and display the number of records were changed.
*/

CREATE PROC uspChangeStatus
@sodong INT OUTPUT 
AS
BEGIN 
	--Bước 1 Liệt kê danh sách Customer sắp xếp theo Status
	SELECT *
	FROM dbo.tbCustomer 
	ORDER BY CustStatus;
	--Bước 2 Cập nhật Status 
	UPDATE dbo.tbCustomer 
	SET CustStatus='Valid' 
	WHERE CustStatus='Invalid' ;
	--Bước 3 Cập nhật biến Output
	SET @sodong=@@ROWCOUNT
	--Bước 4 Liệt kê bảng sau khi update
	SELECT *
	FROM dbo.tbCustomer 
	ORDER BY CustStatus;
END 
GO 

DECLARE @SoKQ INT;
EXEC dbo.uspChangeStatus
    @sodong = @SoKQ OUTPUT -- int
SELECT @SoKQ AS N'Number of Records Changed'
GO 
