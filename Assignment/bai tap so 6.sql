create database ASS6_db
on
(name = 'Ass6', filename ='D:\FPT APtech\DM\BT\Assignment\bai tap so 6\Ass6.mdf', size= 5, filegrowth=10%, maxsize=5)
log on
(name = 'Ass6_log', filename ='D:\FPT APtech\DM\BT\Assignment\bai tap so 6\Ass6_log.ldf', size= 2, filegrowth=10%, maxsize=2)
go

 use ASS6_db
 go

 create table tbMonHoc
 (
	MSMH varchar(10) not null primary key,
	TENMH varchar (50) not null,
	SOTINCHI tinyint default 3,
	[Tinh Chat] tinyint check([Tinh Chat] = 0  or [Tinh Chat] =1) --Cau lenh check dung de tao rang buoc kiem tra
 )
 go

 create table tbLop
 (
	MALOP varchar(5) not null primary key,
	[TEN LOP] varchar(20) not null,
	[SI SO] smallint
 )
 go

 create table tbSinhVien
(
	MSSV varchar(20) not null primary key,
	HOTEN nvarchar(30) not null,
	NGAYSINH date,
	LOP varchar(5) not null foreign key references dbo.tbLop(MALOP)

)
go

create table tbDiem
(
	MSSV varchar(20) not null foreign key references dbo.tbSinhVien(MSSV),
	MSMH varchar(10) not null foreign key references dbo.tbMonHoc(MSMH),
	[Diem Thi] Smallint not null
)
go

insert dbo.tbMonHoc
(
	MSMH,
	TENMH,
	SOTINCHI,
	[Tinh Chat]
)
values
(
	'LBEP', --Ma so mon hoc -varchar(10)
	'Logic Building with C', --ten mon hoc - varchar (50)	
	6, --So tin chi - tinyint
	1-- tinh chat -tinyint
),
(
	'BNGW', --Ma so mon hoc -varchar(10)
	'HTML', --ten mon hoc - varchar (50)	
	4, --So tin chi - tinyint
	1-- tinh chat -tinyint
),
(
	'BNJ', --Ma so mon hoc -varchar(10)
	'Boostrap and Jquery', --ten mon hoc - varchar (50)	
	5, --So tin chi - tinyint
	1-- tinh chat -tinyint
),
(
	'eProject', --Ma so mon hoc -varchar(10)
	'Eproject', --ten mon hoc - varchar (50)	
	7, --So tin chi - tinyint
	0-- tinh chat -tinyint
),
(
	'DDD', --Ma so mon hoc -varchar(10)
	'Database Design and Development', --ten mon hoc - varchar (50)	
	5, --So tin chi - tinyint
	1-- tinh chat -tinyint
),
(
	'DM', --Ma so mon hoc -varchar(10)
	'Database Management (SQL)', --ten mon hoc - varchar (50)	
	5, --So tin chi - tinyint
	1-- tinh chat -tinyint
)
go

insert dbo.tbLop
(
	MALOP,
	[TEN LOP],
	[SI SO]
)
values
(
	'1907', --Ma lop --varchar (5)
	'Lop 1907', --Ten lop -varchar(20)
	22 --si so - smallint
),
(
	'1908', --Ma lop --varchar (5)
	'Lop 1908', --Ten lop -varchar(20)
	26 --si so - smallint
),
(
	'1909', --Ma lop --varchar (5)
	'Lop 1909', --Ten lop -varchar(20)
	25 --si so - smallint
),
(
	'1910', --Ma lop --varchar (5)
	'Lop 1910', --Ten lop -varchar(20)
	20 --si so - smallint
),
(
	'1911', --Ma lop --varchar (5)
	'Lop 1911', --Ten lop -varchar(20)
	22 --si so - smallint
)
go

select * from tbLop
go

insert dbo.tbSinhVien
(
	MSSV,
	HOTEN,
	NGAYSINH,
	LOP
)
values
(
	'SV01', --Ma so sinh vien - varchar(20)
	N'Lê Hữu Nhân',-- Ho ten - nvarchar(30)
	'19970511', --ngay sinh - date
	'1907'
),
(
	'SV02', --Ma so sinh vien - varchar(20)
	N'Bùi Bích Hà',-- Ho ten - nvarchar(30)
	'19980511', --ngay sinh - date
	'1908'
),
(
	'SV03', --Ma so sinh vien - varchar(20)
	N'Ricardo Milos',-- Ho ten - nvarchar(30)
	'19990621', --ngay sinh - date
	'1908'
),
(
	'SV04', --Ma so sinh vien - varchar(20)
	N'Spring Fuck',-- Ho ten - nvarchar(30)
	'19890122', --ngay sinh - date
	'1909'
),
(
	'SV05', --Ma so sinh vien - varchar(20)
	N'Nguyễn Bảo Vy',-- Ho ten - nvarchar(30)
	'19980512', --ngay sinh - date
	'1910'
)
go

select *from dbo.tbSinhVien
select *from dbo.tbMonHoc
select *from dbo.tbLop
go

--cau B ( them vao bang SV 1 cot gioi tinh va quy dinh chi dc nhap ky tu 'F' hoac 'M'
alter table dbo.tbSinhVien
	add [Gioi Tinh] varchar(1) check( [Gioi Tinh] = 'F' or [Gioi tinh] = 'M')
go

insert dbo.tbDiem
(
	MSSV,
	MSMH,
	[Diem Thi]
)
Values
(
	'SV01', --MSSV - varchar(20)
	'LBEP', --MSMH - varchar (10)
	100 --diem thi - small int
),
(
	'SV01', --MSSV - varchar(20)
	'BNGW', --MSMH - varchar(10)
	85--diem thi - small int
),
(
	'SV01', --MSSV - varchar(20)
	'BNJ', --MSMH - varchar (10)
	55 --diem thi - small int
),
(
	'SV01', --MSSV - varchar(20)
	'eProject', --MSMH - varchar (10)
	66 --diem thi - small int
),
(
	'SV01', --MSSV - varchar(20)
	'DDD', --MSMH - varchar (10)
	77 --diem thi - small int
),
(
	'SV01', --MSSV - varchar(20)
	'DM', --MSMH - varchar (10)
	59 --diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'LBEP', --MSMH - varchar (10)
	67 --diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'BNGW', --MSMH - varchar(10)
	56--diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'BNJ', --MSMH - varchar (10)
	75 --diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'eProject', --MSMH - varchar (10)
	56 --diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'DDD', --MSMH - varchar (10)
	68 --diem thi - small int
),
(
	'SV02', --MSSV - varchar(20)
	'DM', --MSMH - varchar (10)
	86 --diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'LBEP', --MSMH - varchar (10)
	100 --diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'BNGW', --MSMH - varchar(10)
	85--diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'BNJ', --MSMH - varchar (10)
	55 --diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'eProject', --MSMH - varchar (10)
	66 --diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'DDD', --MSMH - varchar (10)
	77 --diem thi - small int
),
(
	'SV03', --MSSV - varchar(20)
	'DM', --MSMH - varchar (10)
	60 --diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'LBEP', --MSMH - varchar (10)
	55--diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'BNGW', --MSMH - varchar(10)
	65--diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'BNJ', --MSMH - varchar (10)
	62 --diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'eProject', --MSMH - varchar (10)
	66 --diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'DDD', --MSMH - varchar (10)
	86 --diem thi - small int
),
(
	'SV04', --MSSV - varchar(20)
	'DM', --MSMH - varchar (10)
	55 --diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'LBEP', --MSMH - varchar (10)
	35 --diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'BNGW', --MSMH - varchar(10)
	54--diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'BNJ', --MSMH - varchar (10)
	58 --diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'eProject', --MSMH - varchar (10)
	78 --diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'DDD', --MSMH - varchar (10)
	90 --diem thi - small int
),
(
	'SV05', --MSSV - varchar(20)
	'DM', --MSMH - varchar (10)
	76 --diem thi - small int
)
go

--cau C ( Cho biet nhung mon hoc co so tinh chi cao nhat )
select * from dbo.tbMonHoc
where [Tinh Chat] = 1
--lenh order dung de sap xep du lieu tang & giam dan ( ASC: tang dan; DESC: giam dan )
order by SOTINCHI desc
go

--cau d ( liet ke danh sach gom MSSV, Ho ten, lop, diem thi cua sv mon CSDL )
select a.MSSV, a.HOTEN, a.LOP, b.[DIEM THI], c.TENMH
from dbo.tbSinhVien a join (dbo.tbDiem b join dbo.tbMonHoc c on c.MSMH = b.MSMH ) on b.MSSV = a.MSSV
where c.TENMH like '%SQL%'
go

--cau e ( Cho biet cac sinh vien co diem cao nhat mon hoc co ma la csdl )
select * from dbo.tbDiem
where MSMH = 'DM'
order by [Diem Thi] desc
go

--cau f
SELECT a.MSSV,a.HOTEN,a.NGAYSINH,a.[GIOI TINH],b.[TEN LOP],d.MSMH,d.TENMH,c.[DIEM THI] 
FROM (dbo.tbSinhVien a JOIN dbo.tbLop b ON	b.MALOP = a.LOP) LEFT JOIN (dbo.tbDiem c JOIN dbo.tbMonHoc d ON d.MSMH = c.MSMH) ON c.MSSV = a.MSSV
WHERE a.MSSV='SV02'
GO 

--cau i ( cho biet diem cua sinh vien theo tung mon )
select *
from dbo.tbDiem
order by MSMH
go

--cau G ( Liet ke ds gom MSSV, HO ten, lop, dtb co diem tb cac mon < 5 )
SELECT b.MSSV,b.HOTEN,b.LOP,AVG(a.[DIEM THI]) AS N'Điểm Trung Bình'
FROM dbo.tbDiem	a RIGHT JOIN dbo.tbSinhVien b ON b.MSSV = a.MSSV
GROUP BY b.MSSV,b.HOTEN,b.LOP
HAVING AVG(a.[DIEM THI])<75
ORDER BY AVG(a.[DIEM THI])
GO  

--cau H
CREATE VIEW vwDiemTrungBinh
AS 
SELECT b.MSSV,c.[TEN LOP],b.HOTEN,AVG([DIEM THI]) AS N'Điểm Trung Bình'
FROM dbo.tbDiem	a JOIN (dbo.tbSinhVien b JOIN dbo.tbLop c ON c.MALOP = b.LOP) ON c.MALOP = b.LOP
GROUP BY b.MSSV,c.[TEN LOP],b.HOTEN
GO 