-- -----------Creación de funciones en la Base de Datos: sistema_bancario----------- --
use sistema_bancario;

-- 1. ----- Function: calculo_de_monto_a_pagar_por_prestamo -----
-- ##### Explicación: El objeto 'prestamo' almacena registros de los préstamos solicitados por clientes.
-- Estos estarán identificados por el número de cuenta de dicho cliente. El cobro de interesés por
-- parte del banco estará condicionado al valor de dos campos: monto de préstamo, almacenado en el 
-- campo 'monto_prestado', y el número de cuotas en las que se elige pagar el préstamo, almacenando esta 
-- información en el campo 'numero_de_cuotas', cuya alternativa será: 3,6,12,18,24. Con base en esta 
-- información, el interés a cobrar será el siguiente:
-- i. Si numero_de_cuota = 3, interes por préstamo = 0.2
-- ii. Si numero_de_cuota = 6, interes por préstamo = 0.25
-- iii. Si numero_de_cuota = 12, interes por préstamo = 0.3
-- iv. Si numero_de_cuota = 18, interes por préstamo = 0.4
-- iv. Si numero_de_cuota = 24, interes por préstamo = 0.5
-- La funcion 'calculo_de_monto_a_pagar_por_prestamo', recibirá como parámetros los campos: 'monto_prestado' y 'numero_de_cuotas'
-- y devolverá un valor de tipo decimal el cual, en el contexto de nuestro Sistema de Base de Datos, representará
-- el total a pagar por el cliente por el préstamo otorgado por el banco.

drop function if exists calculo_de_monto_a_pagar_por_prestamo;
 delimiter //
 create function calculo_de_monto_a_pagar_por_prestamo(
   p_monto_prestado decimal(12,2), 
   p_numero_cuotas int)
   returns decimal(12,2)
   deterministic
 begin
  if p_numero_cuotas <= 3 then return p_monto_prestado + p_monto_prestado*0.2;
  elseif p_numero_cuotas > 3 and p_numero_cuotas <= 6 then return p_monto_prestado + p_monto_prestado*0.25;
  elseif p_numero_cuotas > 6 and p_numero_cuotas <= 12 then return p_monto_prestado + p_monto_prestado*0.3;
  elseif p_numero_cuotas > 12 and p_numero_cuotas <= 18 then return p_monto_prestado + p_monto_prestado*0.4;
  elseif p_numero_cuotas > 18 then return p_monto_prestado + p_monto_prestado*0.5;
  end if;
end //
delimiter ;

-- Ejecución de la función 'calculo_de_monto_a_pagar_por_prestamo' desde el objeto Préstamo:
select id_cuenta, monto_prestado, numero_de_cuotas,calculo_de_monto_a_pagar_por_prestamo(monto_prestado,numero_de_cuotas) as 'Deuda por préstamo' 
from prestamo;


-- 2. ----- Function: sucursal_donde_se_apertura_cuenta -----
-- ##### Expliación: El objeto 'cuenta' almacena los registros de aquellos números que son 
-- asignados a una persona una vez se hace cliente del banco. Estos números, de manera única, 
-- tendrán un identificador que hará referencia a la sucursal en donde fue aperturada la cuenta.

drop function if exists sucursal_donde_se_apertura_cuenta;
 delimiter //
 create function sucursal_donde_se_apertura_cuenta( 
  p_id_sucursal int)
   returns varchar(50)
   deterministic
 begin
  declare sucursal_de_apertura varchar(15);
  set sucursal_de_apertura = 
     (select direccion 
     from sucursal
     where id = p_id_sucursal);
return sucursal_de_apertura; 
end //
delimiter ;

-- Ejecución de la función 'sucursal_donde_se_apertura_cuenta' desde el objeto cuenta:
select id as 'Número de cuenta',sucursal_donde_se_apertura_cuenta(id_sucursal) as 'Sucursal de apertura' 
from cuenta
order by 'Sucursal de apertura';

-- 3. ----- Function: contador_de_cuotas_faltantes -----
-- ##### Explicación: El objeto 'prestamo' tiene un campo llamado 'numero_de_cuotas' que hace 
-- referencia al número de cuotas que un cliente elige pagar al momento de realizar un préstamo
-- la función 'contador_de_cuotas_faltantes' permitirá calcular el número de cuotas
-- faltantes por pagar a la fecha actual. 

drop function if exists contador_de_cuotas_faltantes;
 delimiter //
 create function contador_de_cuotas_faltantes( 
  p_id_prestamo int)
   returns int
   deterministic
 begin
  declare v_numero_de_pagos_hechos int;
  declare v_cuotas_totales int;
  declare v_numero_de_cuotas_faltantes int;
  set v_numero_de_pagos_hechos = 
     (select count(*) 
     from pagoPrestamo
     where id_prestamo = p_id_prestamo);
  set v_cuotas_totales = 
     (select numero_de_cuotas
     from prestamo
     where id = p_id_prestamo);
   set v_numero_de_cuotas_faltantes = v_cuotas_totales - v_numero_de_pagos_hechos;
return v_numero_de_cuotas_faltantes; 
end //
delimiter ;

-- Ejecución de la función 'contador_de_cuotas_faltantes' desde el objeto prestamo:
 select id_cuenta as 'Número de cuenta',
 numero_de_cuotas as 'Número total de cuotas',
 contador_de_cuotas_faltantes(id) as 'Número de cuotas faltantes'
 from prestamo;









