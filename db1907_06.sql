use db_1907
go

--viet function tinh giai thua

create function ufn_giaithua(@n int)
returns bigint
as
begin
	declare @kq bigint,@i int
	set @kq = 1
	set @i = 1
	while (@i <= @n)
	begin
		set @kq += @i
		set @i += 1
	end
	return @kq
end
go
--thuc hien ham tinh gia thua cua 5
declare @ketqua bigint
set @ketqua = dbo.ufn_giaithua(5)
print 'giaithua cua 5 =' + cast (@ketqua as varchar(10))
go

select * from tbExam
go

insert tbExam values ('ST01', 105, 70)
go

insert tbExam values ('ST01', 105, 101)--error
go

--vi du ve cau truc loi Try-Catch
begin try
	select * from tbExam where mark < 40
	update tbExam set mark +=1 where mark <40
	select @@ROWCOUNT as [So ket qua duoc thay doi]
	select * from tbExam where mark < 40
end try
begin catch
	select ERROR_LINE() [dong loi], ERROR_MESSAGE() [thong bao loi], ERROR_NUMBER() [ma so loi sai]
end catch
go

--vi du ve cau truc loi Try-Catch: Bao loi sai do cap nhat diem > 100
begin try
	select * from tbExam where mark < 40
	update tbExam set mark +=1 --dong loi
	select @@ROWCOUNT as [So ket qua duoc thay doi]
	select * from tbExam where mark < 40
end try
begin catch
	select ERROR_LINE() [dong loi], ERROR_MESSAGE() [thong bao loi], ERROR_NUMBER() [ma so loi sai]
end catch
go