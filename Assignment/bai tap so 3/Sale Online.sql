create database SaleOnline
on primary
(name = 'Sales_dat', filename= 'd:\FPT Aptech\DM\BT\bai tap so 3\Sales_dat.mdf', size = 5, maxsize=unlimited, filegrowth=15%),
filegroup SalesGroup
(name = 'Sales2_dat', filename= 'd:\FPT Aptech\DM\BT\bai tap so 3\Sales2_dat.ndf', size = 5, maxsize=20, filegrowth=5%),
(name = 'Sales3_dat', filename= 'd:\FPT Aptech\DM\BT\bai tap so 3\Sales3_dat.ndf', size = 5, maxsize=20, filegrowth=5%)
log on
(name = 'Sales_log', filename= 'd:\FPT Aptech\DM\BT\bai tap so 3\Sales_log.ldf', size = 2, maxsize=100, filegrowth=10%)
go


