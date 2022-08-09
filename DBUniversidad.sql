-- BD Example
-- Alex Estrada
-- 8 /8/2022

use master
go

if DB_ID('DBUniversidad') is not null
	drop database DBUniversidad
go
create database DBUniversidad
go

use DBUniversidad
go

-- crear tablas

if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go

create table TEscuela 
(
	CodEscuela char(3) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

if OBJECT_ID('TAlumno') is not null
	drop table TAlumno
go

create table TAlumno 
(
	CodAlumno char(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela
)
go


insert into TEscuela values ('E01', 'Sistemas', 'Ingenieria')
insert into TEscuela values('E02', 'Civil', 'Ingenieria')
insert into TEscuela values('E03', 'Industrial', 'Ingenieria')
insert into TEscuela values('E04', 'Ambiental', 'Ingenieria')
insert into TEscuela values('E05', 'Arquitectura', 'Ingenieria')
go

insert into TAlumno values('A001', 'Perez Sotelo', 'Alvaro','Cusco','2021-06-03','E01')
insert into TAlumno values('A002', 'Suarez Mamani', 'Juan','Lima','2021-12-05','E05')
insert into TAlumno values('A003', 'Estrada Cuba', 'Alex','Cusco','2001-04-28','E02')
insert into TAlumno values('A004', 'Flores Cardenas', 'Diego','Cusco','1999-08-20','E02')


select * from TEscuela
select * from TAlumno
