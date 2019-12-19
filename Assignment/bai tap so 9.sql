--1. Tạo database tên Ass9
create database dbAss9
go

use dbAss9 
go

-- 2. Tạo các bảng trong database với mô tả sau :
--a. tbGIAOVIEN(MaGV , TenGV)
--b. tbHOCVIEN ( MaHV , Hoten , DiaChi )
--c. tbLOPHOC( Malop , Tenlop , Siso ,MaGV)
--Check constraint : siso >=10 và <=20
--d. tbDANGKY (MaHV, Malop, NgayDK, Ghi chu)
--▪ Tạo ràng buộc khoá ngoại giữa các bảng
--▪ Nhập 1 số data thích hơp ( bằng câu lệnh INSERT, mỗi bảng ít nhất 5 mẫu tin )

create table tbGiaoVien
(
	MaGV varchar(5) primary key nonclustered,
	TenGV nvarchar(40) not null 
)
go

create table tbHocVien
(
	MaHV varchar(5) primary key nonclustered,
	HoTen nvarchar(40) not null,
	DiaChi nvarchar(40) not null,
)
go

create table tbLopHoc
(
	MaLop varchar(5) primary key nonclustered,
	TenLop nvarchar(30) not null,
	SiSo int check( SiSo >= 10 and SiSo <=20),
	MaGV varchar(5) foreign key references dbo.tbGiaoVien(MaGV)
)
go

create table tbDangKy
(
	MaHV varchar(5) foreign key references dbo.tbHocVien(MaHV),
	MaLop varchar(5) foreign key references dbo.tbLopHoc(MaLop),
	NgayDK date default getdate(),
	GhiChu varchar(100),
	primary key (MaHV, MaLop)
)
go

insert dbo.tbGiaoVien
(
	MaGV,
	TenGV
)
values
('GV01', 'Ricardo Milos'),
('GV02', 'Penis Lord'),
('GV03', 'Curved Penis'),
('GV04', 'Certified Dumbass'),
('GV05', 'Nipples Master')
go



insert dbo.tbHocVien
(
	MaHV,
	HoTen,
	DiaChi
)
values
('HV01', N'Lê Hữu Nhân', N'TP.HCM'),
('HV02', N'Bùi Bích Hà', N'Gia Lai'),
('HV03', N'Nguyễn Thị Bé Ba', N'Vũng Tàu'),
('HV04', N'Ba Gà', N'Sa Đéc'),
('HV05', N'Ricardo Milos', N'Brazil')
go

insert dbo.tbLopHoc
(
	MaLop,
	TenLop,
	SiSo,
	MaGV
)
values
('CL01', N'Fighter Class', 20, 'GV01'),
('CL02', N'Mage Class', 10, 'GV02'),
('CL03', N'Gunner Class', 15, 'GV03'),
('CL04', N'Assassin Class', 19, 'GV04'),
('CL05', N'Cleric Class', 16, 'GV05')
go

insert dbo.tbDangKy
(
	MaHV,
	MaLop,
	NgayDK,
	GhiChu
)
values
('HV01', 'CL01', '20190130', 'xnxx'),
('HV02', 'CL02', '20180321', 'pornhub'),
('HV03', 'CL03', GETDATE(), 'vlxx'),
('HV04', 'Cl04', '20120411','the shy'),
('HV05', 'Cl05', GETDATE(), 'mortherless')
go

select * from dbo.tbGiaoVien
select * from dbo.tbHocVien
select * from dbo.tbLopHoc
select * from dbo.tbDangKy
go


--3. Tạo clustered index idxHV trên cột Hoten của bảng tbHOCVIEN
--	 Tạo index idxGV trên cột TenGV của bảng tbGIAOVIEN theo thứ tự giảm dần

--Tạo clustered index idxHV trên cột Hoten của bảng tbHOCVIEN
create clustered index idxGV on dbo.tbGiaoVien(TenGV desc)
go

--4. Tìm các học viên có Hoten bắt đầu là ‘L’ và đăng ký học lớp ‘SQL Server’ ( giả sử trong phần nhập liệu có lớp này )
SELECT a.MaHV,a.HoTen,a.DiaChi,b.NgayDK,c.MaLop,c.TenLop
FROM dbo.tbHocVien a JOIN (dbo.tbDangKy b JOIN dbo.tbLopHoc c ON c.MaLop = b.MaLop) ON b.MaHV = a.MaHV
WHERE a.HoTen LIKE 'N%' and c.TenLop LIKE '%Mage Class%'
GO 

-- 5. Tìm các học viên đăng ký từ 2 lớp học trở lên
SELECT a.MaHV,a.HoTen,COUNT(*) AS N'Số Lớp Đăng Ký'
FROM dbo.tbHocVien a JOIN dbo.tbDangKy b ON b.MaHV = a.MaHV
GROUP BY a.MaHV,a.HoTen
HAVING COUNT(*)>=2
GO 

-- 6. Tạo view vwLopHoc Hiển thị Malop , Tenlop , TenGV và số lượng học viên đã đăng ký
SELECT * FROM dbo.tbLopHoc
SELECT * FROM dbo.tbGiaoVien
GO 

CREATE VIEW vwLopHoc
AS 
SELECT a.MaLop,a.TenLop,b.TenGv,a.SiSo
FROM dbo.tbLopHoc a JOIN dbo.tbGiaoVien b ON b.MaGV = a.MaGV
GO 

SELECT * FROM dbo.vwLopHoc
GO 

--7. Tạo 1 Stored procedure uspGV nhận tham số là họ tên của giáo viên và liệt kê thông tin về các lớp học mà giáo viên này đang giảng dạy
CREATE PROC uspGV
@HoTenGV NVARCHAR(50)
AS 
BEGIN
	SELECT b.TenGv,a.MaLop,a.TenLop,a.SiSo
	FROM dbo.tbLopHoc a JOIN dbo.tbGiaoVien b ON b.MaGV = a.MaGV
	WHERE b.TenGv=@HoTenGV ;
END 
GO 

EXEC dbo.uspGV
    @HoTenGV = N'Bill Gate' -- nvarchar(50)
GO 

-- 8. Tạo (insert, update) Trigger trDangky bảo đảm 1 học viên chỉ được đăng ký tối đa 2 lớp

-- Tạo Trigger Insert  ????????
CREATE TRIGGER trDangKy
ON dbo.tbDangKy
FOR INSERT AS 
BEGIN
	DECLARE @solop=
END 
GO 


-- 9. Tạo (update) Trigger trHVTen không cho phép đổi tên học viên
CREATE TRIGGER trHVTen
ON dbo.tbHocVien
AFTER UPDATE AS
BEGIN 
	IF UPDATE(HoTen)
	BEGIN 
		PRINT N'Không thể đổi tên học viên'
		ROLLBACK
	END 
END
GO 

UPDATE dbo.tbHocVien SET HoTen=N'Seohyun' WHERE MaHV='HV02'
GO 

--10. Tạo (instead of delete) Trigger trLop khi xóa 1 lớp học thì sẽ xóa luôn các dữ liệu đăng ký lớp học đó trong bảng đăng ký.
CREATE TRIGGER trLop
ON dbo.tbLopHoc
INSTEAD OF DELETE AS 
BEGIN	
	DELETE FROM dbo.tbDangKy WHERE MaLop IN 
	(SELECT MaLop FROM Deleted)
	DELETE FROM dbo.tbLopHoc WHERE MaLop IN 
	(SELECT MaLop FROM Deleted)
END 
GO 

--Tạo dữ liệu để test trigger
INSERT dbo.tbLopHoc
    (
        MaLop,
        TenLop,
        SiSo,
        MaGV
    )
VALUES
    (
        'LH10', -- MaLop - varchar(5)
        N'Lớp Tạo Cho Vui', -- TenLop - varchar(30)
        20,  -- SiSo - int
        'GV01'  -- MaGV - varchar(5)
    ),
    (
        'LH11', -- MaLop - varchar(5)
        N'Lớp Tạo Chút Xóa', -- TenLop - varchar(30)
        10,  -- SiSo - int
        'GV02'  -- MaGV - varchar(5)
    )
GO 

INSERT dbo.tbDangKy
    (
        MaHV,
        MaLop,
        NgayDK,
        GhiChu
    )
VALUES
    (
        'HV09',        -- MaHV - varchar(5)
        'LH10',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '123'         -- GhiChu - varchar(100)
    ),	
    (
        'HV07',        -- MaHV - varchar(5)
        'LH10',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        'dfd3'         -- GhiChu - varchar(100)
    ),
    (
        'HV07',        -- MaHV - varchar(5)
        'LH11',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '13253'         -- GhiChu - varchar(100)
    ),
    (
        'HV02',        -- MaHV - varchar(5)
        'LH11',        -- MaLop - varchar(5)
        GETDATE(), -- NgayDK - date
        '545'         -- GhiChu - varchar(100)
    )
GO 

SELECT * FROM dbo.tbLopHoc
SELECT * FROM dbo.tbDangKy

--Xóa thử 2 Lớp vừa tạo mã LH10 và Lh11
DELETE FROM dbo.tbLopHoc WHERE MaLop = 'LH11'
GO 

DELETE FROM dbo.tbLopHoc WHERE MaLop = 'LH10'
GO 
