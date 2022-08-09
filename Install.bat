echo Instalador de la base de datos Universidad
echo Autor: Alex Estrada 
echo 08-08-2022
sqlcmd -SDESKTOP-3JHP27J\SQLEXPRESS -E -i DBUniversidad.sql
sqlcmd -SDESKTOP-3JHP27J\SQLEXPRESS -E -i DBUniversidadPA.sql
sqlcmd -SDESKTOP-3JHP27J\SQLEXPRESS -E -i DBUniversidadPA_TAlumnos.sql
echo Se ejecuto el  bat de la Base de Datos
pause