-- Procedimientos Almacenados
-- Alex Estrada
-- 8 de Agosto 2022

-- PA para TEscuela

use DBUniversidad
go


-- Procedure Listar Escuela
if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go


-- Procedure Agregar Escuela
if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go

create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		--Escuela no puede ser duplicado
		if not exists (select Escuela from TEscuela where Escuela = @Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError=0, Mensaje = 'Se inserto '+@CodEscuela+' correctamente'
			end
		else select CodError =1, Mensaje = 'Error: Escuela '+@Escuela +' duplicado'
	else select CodError =1, Mensaje= 'Error:CodEscuela '+@CodEscuela+' duplicado'
end
go

exec spAgregarEscuela 'E07','Psicologia','Medicina'
go


-- Procedure Eliminar Escuela
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go

create proc spEliminarEscuela
@CodEscuela char(3)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		begin
			delete from TEscuela where CodEscuela = @CodEscuela
			select CodError=0, Mensaje = 'Se elimino '+@CodEscuela+' correctamente'
		end
	else select CodError =1, Mensaje= 'Error:CodEscuela '+@CodEscuela+' no existe'
end
go

exec spEliminarEscuela 'E07'
go


-- Procedure Actualizar Escuela
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go

create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		if not exists (select Escuela from TEscuela where Escuela = @Escuela) 
			begin
				update TEscuela set CodEscuela=@CodEscuela, Escuela=@Escuela, Facultad=@Facultad where CodEscuela =@CodEscuela
				select CodError=0, Mensaje = 'Se actualizo '+@CodEscuela+' correctamente'
			end
		else select CodError =1, Mensaje = 'Error: Escuela '+@Escuela +' no pude ser duplicado'
	else select CodError =1, Mensaje= 'Error:CodEscuela '+@CodEscuela+' no existe'
end
go

exec spActualizarEscuela 'E06','Odontologia','Medicina Huma'
go


-- Procedure Buscar Escuela
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go

create proc spBuscarEscuela
@CodEscuela char(3)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		begin
			select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@CodEscuela
			select CodError=0, Mensaje = 'Se encontro la escuela '+@CodEscuela
		end
	else select CodError =1, Mensaje= 'Error:CodEscuela '+@CodEscuela+' no existe'
end
go

exec spBuscarEscuela 'E09'
go
