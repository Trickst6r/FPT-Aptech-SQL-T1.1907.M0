create database Pretest3DB
on primary
(name='Pretest3', filename='D:\FPT APtech\DM\BT\Assignment\pretest 3\Pretest3.mdf', size=5, maxsize=unlimited, filegrowth=20%)
log on
(name='Pretest3_log', filename='D:\FPT APtech\DM\BT\Assignment\pretest 3\Pretest3_log.ldf', size=2, maxsize=50, filegrowth=10%)
go

use Pretest3DB
go

create table tbEmpDetails
(
	Emp_ID varchar(5) primary key nonclustered,
	FullName varchar(30) not null,
	PhoneNumber varchar(20) not null,
	Designation varchar(30) check (Designation = 'Manager' or Designation ='Staff'),
	Salary money check (Salary >=0 and Salary <=3000),
	Join_date date,
)
go


create table tbLeaveDetails
(
	Leave_ID int identity(1,1) primary key,
	Emp_ID varchar(5) foreign key references dbo.tbEmpDetails(Emp_ID),
	LeaveTaken int check (LeaveTaken > 0 and LeaveTaken <15 ),
	FromDate date,
	Todate date,
	Reason varchar(50) not null
)
go



insert dbo.tbEmpDetails
(
	Emp_ID,
	FullName,
	PhoneNumber,
	Designation,
	Salary,
	Join_date
)
values
('C01', 'Ricardo Milos', '19001564', 'Manager', '2500', '20140504'),
('C02', 'Ricardo Lomis', '19001513', 'Staff', '1500', '20140505'),
('C03', 'Ricardo Molis', '19001561', 'Manager', '2000', '20140506'),
('C04', 'Ricardo Limos', '19001624', 'Staff', '2900', '20140501'),
('C05', 'Ricardo SiLom', '19001567', 'Staff', '1700', '20140904')
go


insert dbo.tbLeaveDetails
(
	Emp_ID,
	LeaveTaken,
	FromDate,
	Todate,
	Reason
)
values
('C01', 1, '20150506', '20150507','DotA show'),
('C02', 2, '20150406', '20150507','LOL show'),
('C03', 1, '20150706', '20151007','FAP show'),
('C04', 5, '20150608', '20151107','CS:GO show'),
('C05', 9, '20150109', '20150407','Oil up show')
go

select * from dbo.tbEmpDetails
select * from dbo.tbLeaveDetails
go

/*4 create a clustered index IX-Fullname for fullname column on tbEmDetails talbe
create an index IX_EmpID for Emp_ID column on tbLeaveDetails table

*/

create clustered index IX_Fullname on dbo.tbEmpDetails(FullName)
go
create index IX_EmpID on dbo.tbLeaveDetails(Emp_ID)
go

/*
	Create a view vwManager to retrieve the number of leaves taken by employees having designation as manager
	Note: this view will need to check for domain interity (with check option) and encrytion 
*/
alter view vwManager
with encryption
as
select a.Emp_ID, a.FullName, a.PhoneNumber, a.Salary, sum(b.LeaveTaken) as [Tong so ngay nghi]
from tbEmpDetails a left join tbLeaveDetails b on a.Emp_ID=b.Emp_ID
where Designation= 'Manager'
group by a.Emp_ID, a.FullName, a.PhoneNumber, a.Salary
with check option
go

select * from vwManager
go

/*
6.	create a store procedure uspChangeSalary to increase salary of an employee by a given value (hint using input parameters)
*/
CREATE PROC uspChangeSalary
@masonv varchar(5),
@luong INT =NULL
AS
BEGIN
	--Nếu không nhập luong thì sẽ lấy Default =100
	IF @luong IS NULL 
		SET @luong=100  --Giá trị Default =100
	--Lệnh 1
	SELECT * FROM tbEmpDetails where Emp_Id = @masonv
	--Lệnh 2
	UPDATE tbEmpDetails SET Salary+=@luong where Emp_Id = @masonv
	--Lệnh 3
	SELECT * FROM tbEmpDetails where Emp_Id = @masonv
END 
GO 
exec uspChangeSalary 
@masonv = 'C01' , @luong = 200
go

exec uspChangeSalary 
@masonv = 'c01' 
go
  

--Create a trigger tgInsertLeave for table tbLeaveDetails which will perform rollback transaction if total of leaves taken by employees in a year greater than 15 and display appropriate error message.
CREATE TRIGGER tgInsertLeave
ON dbo.tbLeaveDetails
FOR INSERT AS
BEGIN
	if exists (select Emp_Id, sum(LeaveTaken) from tbLeaveDetails 
		where Emp_Id in ( select Emp_Id from inserted )
		group by Emp_Id
		having sum(LeaveTaken) > 15) 
	begin
		PRINT 'Error!!! Can not leave more than 15 days !'
		ROLLBACK
	end
end
go

select * from vwManager
go

-- case nay : FAIL 
insert tbLeaveDetails values
('c03',11,'20181004 00:00:00','20181014 00:00:00','wedding')
go

-- case thanh cong
insert tbLeaveDetails values
('c03',5,'20181004 00:00:00','20181008 00:00:00','wedding')
go

-- Create a trigger tgUpdateEmploee for table tbEmployeeDetails which removes the employee if new salary is reset to zero.
create trigger tgUpdateEmploee
on tbEmpDetails
for update as
begin
	select * from tbEmpDetails order by Salary
	if exists (select * from tbEmpDetails where Salary = 0)
	begin
		delete from tbLeaveDetails where Emp_Id in (select Emp_Id 
													from inserted where Salary = 0) 
		delete from tbEmpDetails where Emp_Id in (select Emp_Id 
													from inserted where Salary = 0)
	end
	select * from tbEmpDetails order by Salary
end

select * from tbEmpDetails
go

-- case 1: salary 300
update tbEmpDetails set Salary = 300 where Emp_Id ='c04'
go

-- case 2: salary 0 => remove 
update tbEmpDetails set Salary = 0 where Emp_Id ='c04'
go

select * from vwManager
go
