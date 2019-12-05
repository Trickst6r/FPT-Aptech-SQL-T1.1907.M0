create database UnitedAirs
on primary
(name ='UnitedAir_1', filename='d:\FPT Aptech\DM\student\UnitedAir_1_dat.mdf', size=5, maxsize=10, filegrowth=15%),
(name ='UnitedAir_2', filename='d:\FPT Aptech\DM\student\UnitedAir_2_dat.mdf', size=5, maxsize=10, filegrowth=15%),
filegroup UnitedAirGroup
(name ='UnitedAirGroup1f1', filename='d:\FPT Aptech\DM\student\UnitedAir_2_gr1f1.ndf'),
(name ='UnitedAirGroup1f2', filename='d:\FPT Aptech\DM\student\UnitedAir_2_gr1f2.ndf'),
filegroup UnitedAirGroup2
(name ='UnitedAirGroup2f1', filename='d:\FPT Aptech\DM\student\UnitedAir_2_gr2f1.ndf'),
(name ='UnitedAirGroup2f2', filename='d:\FPT Aptech\DM\student\UnitedAir_2_gr2f2.ndf')
go

drop database SQLDBQuery1
go