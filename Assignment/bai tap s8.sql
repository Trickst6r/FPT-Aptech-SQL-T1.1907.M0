create database ASS7b
go

use ASS7b 
go

--Tao bang trong database voi mo ta sau
create table tbKhachHang
(
	MaKH varchar (5) primary key,
	HoTen nvarchar(30) not null,
	DiaChi nvarchar(60)
)
go

create table tbMatHang
(
	MaMH varchar(5) primary key,
	TenMH nvarchar(30) not null,
	DonViTinh nvarchar(20) not null,
	DonGia int not null
)
go

create table tbDonHang
(
	MaDH int identity (1,1) primary key,
	MaKH varchar(5) foreign key references dbo.tbKhachHang(MaKH),
	--tạo default constraint bảo đảm field NgayDat là ngày hiện hành
	NgayDat date default getdate(),
	DaThanhToan bit --bit - 0: chưa thanh toán, 1: đã thanh toán
)
go

create table tbCDonHang
(
	MaDH int foreign key references dbo.tbDonHang(MaDH),
	MaMH varchar(5) foreign key references dbo.tbMatHang(MaMH),
	SoLuong smallint,
	Primary key (MaDH,MaMH)
)
go

insert dbo.tbKhachHang
(
	MaKH,
	HoTen,
	DiaChi
)
Values
(
	'C01', --Mã khách hàng - varchar(10)
	'An An', --Tên khách hàng - nvarchar (30)
	N'Nguyễn Huệ'--Địa chỉ khách hàng - nvarchar (60)
),
(
	'C02', --Mã khách hàng - varchar(10)
	N'Bảo Bảo', --Tên khách hàng - nvarchar (30)
	N'Phạm Ngũ Lão'--Địa chỉ khách hàng - nvarchar (60)
),
(
	'C03', --Mã khách hàng - varchar(10)
	N'Kỳ Kỳ', --Tên khách hàng - nvarchar (30)
	N'Lê Lợi'--Địa chỉ khách hàng - nvarchar (60)
)
go

select * from dbo.tbKhachHang
select * from dbo.tbMatHang
select * from dbo.tbDonHang
go

insert dbo.tbMatHang
(
	MaMH,
	TenMH,
	DonViTinh,
	DonGia
)
values
(
	'P01', --Mã MH - varchar(5)
	'Cocacola', --Tên Mã hàng - nvarchar (30)
	'Lon',--Don vi tinh -nvarchar (20)
	2 --Don gia - int
),
(
	'P02', --Mã MH - varchar(5)
	'Chocolate Cake', --Tên Mã hàng - nvarchar (30)
	N'Cái',--Don vi tinh -nvarchar (20)
	5 --Don gia - int
),
(
	'P03', --Mã MH - varchar(5)
	N'Kẹo Dẻo', --Tên Mã hàng - nvarchar (30)
	N'Gói',--Don vi tinh -nvarchar (20)
	3 --Don gia - int
),
(
	'P04', --Mã MH - varchar(5)
	N'Đường', --Tên Mã hàng - nvarchar (30)
	'Kg',--Don vi tinh -nvarchar (20)
	1.5 --Don gia - int
),
(
	'P05', --Mã MH - varchar(5)
	N'Sữa', --Tên Mã hàng - nvarchar (30)
	'Lon',--Don vi tinh -nvarchar (20)
	20 --Don gia - int
)
go

insert dbo.tbDonHang
(
	MaKH,
	NgayDat,
	DaThanhToan
)
values
(
	'C01',  --Ma KH - varchar(5)
	'20141015', --Ngay dat -date
	1 --da thanh toan -  bit
),
(
	'C01',  --Ma KH - varchar(5)
	'20141017', --Ngay dat -date
	0 --da thanh toan -  bit
),
(
	'C02',  --Ma KH - varchar(5)
	'20141012', --Ngay dat -date
	1 --da thanh toan -  bit
),
(
	'C03',  --Ma KH - varchar(5)
	'20141014', --Ngay dat -date
	0 --da thanh toan -  bit
),
(
	'C02',  --Ma KH - varchar(5)
	'20141010', --Ngay dat -date
	0 --da thanh toan -  bit
)
go
select * from dbo.tbCDonHang
go

insert dbo.tbCDonHang
(
	MaDH,
	MaMH,
	SoLuong
)
Values
(
	5, --Ma DH - int
	'P02', --Ma MH - varchar(5)
	5 -- so luong - smallint
),
(
	8, --Ma DH - int
	'P03', --Ma MH - varchar(5)
	1 -- so luong - smallint
),
(
	5, --Ma DH - int
	'P01', --Ma MH - varchar(5)
	10 -- so luong - smallint
),
(
	8, --Ma DH - int
	'P05', --Ma MH - varchar(5)
	2 -- so luong - smallint
),
(
	9, --Ma DH - int
	'P04', --Ma MH - varchar(5)
	 2-- so luong - smallint
),
(
	9, --Ma DH - int
	'P03', --Ma MH - varchar(5)
	1 -- so luong - smallint
),
(
	5, --Ma DH - int
	'P03', --Ma MH - varchar(5)
	2 -- so luong - smallint
),
(
	7, --Ma DH - int
	'P01', --Ma MH - varchar(5)
	12 -- so luong - smallint
),
(
	6, --Ma DH - int
	'P03', --Ma MH - varchar(5)
	3 -- so luong - smallint
)
go

-- b) Hiển thị các Don Hang đã quá 1 năm so với ngày hiện hành
select * from dbo.tbDonHang
where DATEDIFF(dd,NgayDat, getdate())> 365
go

-- c) Xác định tên mặt hàng nào được đặt mua nhiều lần nhất
select * from dbo.tbCDonHang
order by MaMH
go

-- d) Tạo view vwDH để liệt kê các DON HANG chưa thanh toán trên 30 ngày so với ngày hiện hành
CREATE VIEW vwDH
AS 
SELECT *
FROM dbo.tbDonHang
WHERE DaThanhToan =0 AND DATEDIFF(dd,NgayDat,GETDATE())>30
GO 
