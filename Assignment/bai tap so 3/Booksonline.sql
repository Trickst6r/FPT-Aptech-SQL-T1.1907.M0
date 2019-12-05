create database Booksonline
on 
(name = 'Book_dat', filename='d:\FPT Aptech\DM\BT\bai tap so 3\Book_dat.mdf', size = 5, maxsize = unlimited, filegrowth = 15%)
log on
(name = 'Book_log', filename='d:\FPT Aptech\DM\BT\bai tap so 3\Book_dat_log.ldf', size = 2, maxsize = 10, filegrowth = 1%)
go