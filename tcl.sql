-- -----------Modificaciones controladas mediante transacciones en la base de datos: sistema_bancario----------- --

-- Las sentencias DML que controlaremos serán aquellas que ejecutaremos en las tablas: 'cliente' y 'empleados'

-- ------ Transacción en tabla 'empleado'----- -- (Consigna n°1)
use sistema_bancario;
select @@autocommit;
set @@autocommit = 0;

-- Antes de desarrollar la consigna, crearemos un backaup de la tabla 'empleado':
drop table  if exists bkp_empleado;
create table if not exists bkp_empleado as (
select * from empleado where 1=1);
select * from bkp_empleado; -- Cuando ejecutemos esta consulta, tendremos 11 registros que fueron insertados
                            -- en la base de datos desde el script 'recordInsertion'.
set SQL_SAFE_UPDATES = 0; -- Sentencia que nos permitirá ejecutar comandos DML.

start transaction;
delete from bkp_empleado where id between 6 and 11; -- Eliminamos del sexto al décimo primer registro.
-- rollback; -- Si esta línea no estuviera comentada y comentaramos la siguiente, al hacer una consulta
commit;
select * from bkp_empleado; -- El resultado de esta consulta serán los 5 primeros registros en la tabla bkp_empleado.

-- Observación: De haber descomentado la línea 20, estaría demás la línea 21 y el resultado en la línea 22 serían
-- los mismos registros que se visaulizaron en la línea 14. Es decir, 11 registros.

-- ------ Transacción en tabla 'cliente'----- -- (Consigna n°2)
use sistema_bancario;
select @@autocommit;
set @@autocommit = 0;

start transaction;
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (45678912, 'Ana', 'López', 28, 'F', 987654321, 'Calle D, Ciudad X', 'ana@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (56789123, 'Carlos', 'García', 35, 'M', 654321987, 'Calle E, Ciudad Y', 'carlos@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (67891234, 'Laura', 'Hernández', 42, 'F', 321987654, 'Calle F, Ciudad Z', 'laura@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (78912345, 'Miguel', 'Rodríguez', 33, 'M', 111111111, 'Calle G, Ciudad X', 'miguel@example.com');
savepoint sp0;
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (89123456, 'Sofía', 'Torres', 29, 'F', 222222222, 'Calle H, Ciudad Y', 'sofia@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (91234567, 'Andrés', 'Vargas', 38, 'M', 333333333, 'Calle I, Ciudad Z', 'andres@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (23456789, 'Alejandra', 'López', 27, 'F', 444444444, 'Calle J, Ciudad X', 'alejandra@example.com');
insert into cliente (DNI, nombre, apellido, edad, sexo, telefono, direccion, email)
values (45678901, 'Isabel', 'Sánchez', 43, 'F', 666666666, 'Calle L, Ciudad Z', 'isabel@example.com');
-- release savepoint sp0 -- Eliminación de setpoint sp0.
rollback to sp0;

-- Previamente teníamos 10 registros que introdujimos desde el script 'recorInsertion'. Considerando las acciones 
-- hechas en el código desde la línea 10 hasta la 29, sólo abremos introducido los 4 primeros registros ya que
-- las últimas 4 inserciones las hemos revertido con el  rollback de la línea 29.
select * from cliente; -- El resultado de esta consulta serán 14 registros.





