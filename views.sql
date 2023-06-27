-- -----------Creación de vistas en la Base de Datos: sistema_bancario----------- --
use sistema_bancario;

-- 1. ----- View: vw_cliente_cuenta__nombre_apellido_con_cuenta_corriente -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'cuenta', 'cuentaCliente' y
-- 'cliente', listar Nombre y Apellido de Clientes con cuenta corriente.
 
create or replace view vw_cliente_cuenta__nombre_apellido_con_cuenta_corriente as (
select cliente.nombre, cliente.apellido 
from cuenta
join cuentaCliente join cliente
on cuenta.id = cuentaCliente.id_cuenta
and cuentaCliente.id_cliente = cliente.id
where tipo_de_cuenta = 'Corriente'
order by 1,2);
-- Consulta:
select * from vw_cliente_cuenta__nombre_apellido_con_cuenta_corriente;

-- 2. ----- View: vw_cliente___nombre_apellido_de_clientes_con_prestamo -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'prestamo','cuenta','cuentaCliente' y
-- 'cliente', Nombre y Apellido de Clientes con préstamo.

create or replace view vw_cliente___nombre_apellido_de_clientes_con_prestamo as (
select nombre,apellido
from cliente
join cuentaCliente join cuenta join prestamo
on  cliente.id = cuentaCliente.id_cliente
and cuentaCliente.id_cuenta = cuenta.id
and cuenta.id = prestamo.id_cuenta
order by 1,2
);
-- Consulta:
select * from vw_cliente___nombre_apellido_de_clientes_con_prestamo;

-- 3. ----- View: vw_sucursal_empleado__Empleados_por_Sucursal -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'empleado' y 'sucursal'
-- listar, Nombre y Apellido de Empleados por Sucursal.

create or replace view vw_sucursal_empleado__Empleados_por_Sucursal as (
select sucursal.direccion , concat(empleado.nombre,' ',empleado.apellido) as Empleado
from sucursal
join empleado 
on sucursal.id = empleado.id_sucursal
order by sucursal.direccion
);

select * from vw_sucursal_empleado__Empleados_por_Sucursal;

-- 4. ----- View: vw_cuenta_cliente_sucursal__Clientes_sin_prestamo_en_pereira -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'cuenta','cuentaCliente',
-- 'cliente' y 'sucursal', listar nombre y apellido de Clientes que no tienen préstamo en Banco con sucursal
-- en 'Pereira'.

create or replace view vw_cuenta_cliente_sucursal__Clientes_sin_prestamo_en_pereira as (
select cuenta.id,sucursal.direccion,concat(cliente.nombre,' ',cliente.apellido) as Cliente
from cuenta join cuentacliente join cliente join sucursal
on cuenta.id = cuentacliente.id_cuenta
and cuenta.id_sucursal = sucursal.id
and cuentacliente.id_cliente = cliente.id
where cuenta.id not in (select distinct id_cuenta from prestamo) and sucursal.direccion = 'Pereira'
);

select * from vw_cuenta_cliente_sucursal__Clientes_sin_prestamo_en_pereira;

-- 5. ----- View: vw_cuenta_sucursal__total_capital_de_clientes_por_sucursal -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'cuenta' y 'sucursal',
-- listar el total de capital de clientes por sucursal de banco.

create or replace view vw_cuenta_sucursal__total_capital_de_clientes_por_sucursal as (
select sucursal.direccion, sum(cuenta.capital) as 'total de capital de clientes en sucursal'
from cuenta join sucursal
on cuenta.id_sucursal = sucursal.id
group by sucursal.direccion
order by 'total de capital de clientes en sucursal'
);

select * from vw_cuenta_sucursal__total_capital_de_clientes_por_sucursal;

-- 6. ----- View: vw_prestamo_sucursal__informacion_de_prestamos_por_sucursal -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'prestamo' y 'sucursal',
-- listar cantidad de préstamos otorgados, y totalidad de montos otorgados, por cada sucursal bancaria.

create or replace view vw_prestamo_sucursal__informacion_de_prestamos_por_sucursal as (
select sucursal.direccion,sum(prestamo.monto_prestado) as 'monto total prestado', count(*) as 'cantidad de prestamos otorgados'
from prestamo join cuenta join sucursal
on prestamo.id_cuenta = cuenta.id and cuenta.id_sucursal = sucursal.id
group by sucursal.direccion
);

select * from vw_prestamo_sucursal__informacion_de_prestamos_por_sucursal;

-- 7. ----- View: vw_cuenta__mayor_capital_de_cliente_por_sucursal -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde la tabla 'cuenta',
-- listar mayor monto de capital de cliente por sucursal.

create or replace view vw_cuenta__mayor_capital_de_cliente_por_sucursal as (
select cuenta.id_sucursal, max(cuenta.capital) as 'Mayor capital de cliente por sucursal'
from cuenta 
group by cuenta.id_sucursal
order by 'Mayor capital de cliente por sucursal' asc
);

select * from vw_cuenta__mayor_capital_de_cliente_por_sucursal;

-- 8. ----- View: vw_cuenta__mayor_capital_de_cliente_por_sucursal -----
-- ##### Explicación: La funcionalidad de esta view consiste en, desde las tablas 'cuenta' y 'sucursal'
-- listar cantidad de clientes por sucursal.
create or replace view vw_cuenta_sucursal__cantidad_de_clientes_por_sucursal as (
select sucursal.direccion, count(*) as 'Cantidad de Clientes'
from cuenta left join sucursal
on cuenta.id_sucursal = sucursal.id
group by sucursal.direccion
order by 'Cantidad de Clientes' asc
);

select * from vw_cuenta_sucursal__cantidad_de_clientes_por_sucursal;