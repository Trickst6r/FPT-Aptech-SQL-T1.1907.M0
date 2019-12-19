create database Ass5_db
on
(name='Ass5', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 5\Ass5.mdf', size =5, filegrowth =10%, maxsize= 5)
log on
(name='Ass5_log', filename='D:\FPT APtech\DM\BT\Assignment\bai tap so 5\Ass5_log.ldf', size =2, filegrowth =10%, maxsize= 2)
go

use Ass5_db
go
--Note số ko cần nháy '', chuỗi mới cần
alter table tbCustomer
alter column phone int
go


create table tbCustomer
(
	CUSID varchar(5) not null primary key,
	FullName varchar(30) not null,
	[Address] varchar (60),
	phone varchar(15)
)
go

create table tbCategory
(
	CATID varchar(5) not null primary key,
	Catname varchar(30) not null
)
go

create table tbProduct
(
	PROID varchar(5) not null primary key, 
	ProName varchar(30) not null,
	UnitPrice float check( UnitPrice between 1 and 200) not null,
	Unit varchar(10),
	CATID varchar(5) Not null foreign key references dbo.tbCategory(CATID) --CATID

)
go

create table tbOrder
(
	ORDERID int identity(300,1) primary key,
	Orderdate Date Default Getdate(),
	Comment varchar(100),
	CUSID varchar(5) not null Foreign key references dbo.tbCustomer(CUSID)
)
go

create table tbOrderDetail
(
	ORDERID int not null foreign key references dbo.tbOrder(ORDERID),
	PROID varchar(5) not null foreign key references dbo.tbProduct(PROID),
	Quantity smallint default 1,
	Primary key ( Orderid, ProID)
)
go

insert dbo.tbCustomer
(
	CUSID,
	FullName,
	Address,
	phone
)
Values
(
	'C01', -- CUSTID - varchar (5)
	'Lyly Tran', --Fullname - varchar(5)
	'No Trang Long', --Address - varchar (60)
	'113' -- Phone - varchar (25)
),
(
	'C02', -- CUSTID - varchar (5)
	'Alex Pham', --Fullname - varchar(5)
	'Nguyen Trai', --Address - varchar (60)
	'911' -- Phone - varchar (25)
),
(
	'C03', -- CUSTID - varchar (5)
	'Rose Nguyen', --Fullname - varchar(5)
	'Pham Ngu Lao', --Address - varchar (60)
	'1080' -- Phone - varchar (25)
),
(
	'C04', -- CUSTID - varchar (5)
	'Alan Pham', --Fullname - varchar(5)
	'Pham Ngu Lao', --Address - varchar (60)
	'118' -- Phone - varchar (25)
)
go

insert dbo.tbCategory
(
	CATID,
	Catname
)
Values
(
	'FO' , --CATID - varchar (5)
	'Food' --Catname - varchar (30) 
),
(
	'Be' , --CATID - varchar (5)
	'Beverage' --Catname - varchar (30) 
),
(
	'OT' , --CATID - varchar (5)
	'Other' --Catname - varchar (30) 
)
go



insert dbo.tbProduct
(
	PROID,
	ProName,
	UnitPrice,
	Unit,
	CATID
)
Values
(
	'P01', --PROID - varchar(5)
	'Coca Cola', --Proname - varchar(30)
	2.5, --Unitprice - float
	'can', --Unit - varchar(10)
	'BE' --CATID - varchar(5)
),
(
	'P02', --PROID - varchar(5)
	'Beer 333', --Proname - varchar(30)
	4, --Unitprice - float
	'can', --Unit - varchar(10)
	'BE' --CATID - varchar(5)
),
(
	'P03', --PROID - varchar(5)
	'Chocolate', --Proname - varchar(30)
	9, --Unitprice - float
	'pack', --Unit - varchar(10)
	'FO' --CATID - varchar(5)
),
(
	'P04', --PROID - varchar(5)
	'Chocopie Cake', --Proname - varchar(30)
	4, --Unitprice - float
	'pack', --Unit - varchar(10)
	'FO' --CATID - varchar(5)
),
(
	'P05', --PROID - varchar(5)
	'Cheese', --Proname - varchar(30)
	10, --Unitprice - float
	'pack', --Unit - varchar(10)
	'FO' --CATID - varchar(5)
),
(
	'P06', --PROID - varchar(5)
	'Sampoo', --Proname - varchar(30)
	8, --Unitprice - float
	'bottle', --Unit - varchar(10)
	'OT' --CATID - varchar(5)
)
go

insert dbo.tbOrder
(
	Orderdate,
	Comment,
	CUSID
)
Values
(
	'20140830', --Orderdate - date
	'Nothing', -- comment -varchar (100)
	'C01' --CusID - varchar (5)

),
(
	'20141031', --Orderdate - date
	'Nothing', -- comment -varchar (100)
	'C01' --CusID - varchar (5)

),
(
	'20141107', --Orderdate - date
	'Nothing', -- comment -varchar (100)
	'C03' --CusID - varchar (5)

),
(
	'20141107', --Orderdate - date
	'Nothing', -- comment -varchar (100)
	'C02' --CusID - varchar (5)

)
go

insert dbo.tbOrderDetail
(
	ORDERID,
	PROID,
	Quantity
)
Values
(
	300, --ORDERid - int
	'P01', --PROid - varchar(5)
	3 --Quantity
),
(
	300, --ORDERid - int
	'P03', --PROid - varchar(5)
	1 --Quantity
),
(
	301, --ORDERid - int
	'P02', --PROid - varchar(5)
	8 --Quantity
),
(
	301, --ORDERid - int
	'P03', --PROid - varchar(5)
	1 --Quantity
),
(
	301, --ORDERid - int
	'P05', --PROid - varchar(5)
	15 --Quantity
),
(
	302, --ORDERid - int
	'P06', --PROid - varchar(5)
	5 --Quantity
),
(
	303, --ORDERid - int
	'P02', --PROid - varchar(5)
	4 --Quantity
)
go

--4a
select * from dbo.tbCustomer
go

--4b (hiển thị danh sách sản phẩm, sắp xếp theo thứ tự giá )
select * from dbo.tbProduct
order by UnitPrice
go

--4c
select * from dbo.tbOrder
select * from dbo.tbCustomer
select * from dbo.tbOrderDetail
select * from dbo.tbProduct
go

SELECT c.ORDERID,c.OrderDate,d.FullName,b.ProName,a.Quantity,b.Unit,b.UnitPrice,a.Quantity * b.UnitPrice AS Amount
FROM 
(dbo.tbOrderDetail a JOIN dbo.tbProduct b ON a.PROID=b.PROID) JOIN (dbo.tbOrder c JOIN dbo.tbCustomer d ON c.CUSID=d.CUSID) ON a.ORDERID=c.ORDERID 
GO 


--4d
select* from dbo.tbProduct
where CATID = 'FO'
go

--4d cach 2 
SELECT * 
FROM dbo.tbProduct
WHERE CATID IN (SELECT CATID FROM dbo.tbCategory WHERE CatName = 'Food') 
GO 

--4e ( COunt Products belonged to each category)
select b.CATID, b.Catname, count(*)
from dbo.tbProduct a join dbo.tbCategory b on a.CATID=b.CATID
group by b.CATID, b.Catname
go

--4e2
SELECT CATID, COUNT(*) AS [Total Quantity]
FROM dbo.tbProduct 
GROUP BY CATID
GO 

--4f 
select * from dbo.tbOrderDetail
where ORDERID = 302
go
--4f2
select a.*
from tbCustomer a join tbOrder b on a.CUSID=b.CUSID
where b.ORDERID=302
go

--4g
select * from dbo.tbOrderDetail
where Quantity > 2
go

--4h
SELECT * 
FROM dbo.tbOrderDetail
ORDER BY PROID
GO

SELECT PROID,SUM(Quantity) as [Total Quantity]
FROM dbo.tbOrderDetail
GROUP BY PROID
ORDER BY [Total Quantity] desc
GO 

SELECT TOP 2 WITH TIES PROID,SUM(Quantity) as [Total Quantity]
FROM dbo.tbOrderDetail
GROUP BY PROID
ORDER BY [Total Quantity] desc
GO 


select top 2 Proid, sum(quantity) as [So luong ban ra]
from tbOrderDetail
group by PROID
order by 2 desc
go