-- Procedimientos Almacenados
-- Alex Estrada
-- 8 de Agosto 2022

-- PA para TAlumnos

use DBUniversidad
go


-- Procedure Listar Alumnos
if OBJECT_ID('spListarAlumnos') is not null
	drop proc spListarAlumnos
go

create proc spListarAlumnos
as
begin
	select * from TAlumno
end
go

exec spListarAlumnos
go


-- Procedure Agregar Alumno
if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go

create proc spAgregarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime ,@CodEscuela char(3)
as
begin
	-- CodAlumno no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		--Escuela debe exisistir
		if exists (select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
			begin
				insert into TAlumno values(@CodAlumno,@Apellidos,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
				select CodError=0, Mensaje = 'Se inserto '+@CodAlumno+' correctamente'
			end
		else select CodError =1, Mensaje = 'Error: CodEscuela '+@CodEscuela +' no existe'
	else select CodError =1, Mensaje= 'Error:CodAlumno '+@CodAlumno+' duplicado'
end
go

exec spAgregarAlumno 'A008','Delgado Champi','Rosio','Arequipa','1995-11-04','E02'
go


-- Procedure Eliminar Alumno
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go

create proc spEliminarAlumno
@CodAlumno char(5)
as
begin
	-- CodAlumno no puede ser duplicado
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			delete from TAlumno where CodAlumno = @CodAlumno
			select CodError=0, Mensaje = 'Se elimino '+@CodAlumno+' correctamente'
		end
	else select CodError =1, Mensaje= 'Error:CodAlumno '+@CodAlumno+' no existe'
end
go

exec spEliminarAlumno 'A008'
go


-- Procedure Actualizar Alumno
if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go

create proc spActualizarAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), @LugarNac varchar(50), @FechaNac datetime ,@CodEscuela char(3)
as
begin
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		if exists (select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
			begin
				update TAlumno set CodAlumno=@CodAlumno, Apellidos=@Apellidos, Nombres=@Nombres, LugarNac=@LugarNac, FechaNac=@FechaNac, CodEscuela=@CodEscuela where CodAlumno =@CodAlumno
				select CodError=0, Mensaje = 'Se actualizo '+@CodAlumno+' correctamente'
			end
		else select CodError =1, Mensaje = 'Error: CodEscuela '+@CodEscuela +' no existe'
	else select CodError =1, Mensaje= 'Error:CodAlumno '+@CodAlumno+' no existe'
end
go

exec spActualizarAlumno 'A008','Zamalloa Tejada','Roberto','Ayacucho','1994-03-02','E02'
go


-- Procedure Buscar un Alumno
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go

create proc spBuscarAlumno
@CodAlumno char(5)
as
begin
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			select * from TAlumno where CodAlumno=@CodAlumno
			select CodError=0, Mensaje = 'Se encontro '+@CodAlumno
		end
	else select CodError =1, Mensaje= 'Error:CodAlumno '+@CodAlumno+' no existe'
end
go

exec spBuscarAlumno 'A008'
go