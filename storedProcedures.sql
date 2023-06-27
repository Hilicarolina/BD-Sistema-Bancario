-- ----------- Creación de Stored Procedures en la Base de Datos: sistema_bancario----------- --
use sistema_bancario;

-- 1. ----- Stored Procedure: sp_ordenar ----- 
-- ##### Explicación: La funcionalidad de este stored procedure es ordenar una tabla en base a la tabla, columna dada y 
-- el tipo de orden ya sea este ascendente o descendente. Los parámetros de stored procedure son: 
-- i. tabla: Hace referencia a la tabla sobre la cual queremos recibir información 'ordenada' en una consulta.
-- ii. columna: Columna por la cual ordenaremos la tabla.
-- iii. ordenamiento: Este tendrá el valor 'asc' o 'desc'. Y determinará la forma en la que se ordenará la tabla desde
--  la columna especificada. Este orden será descendente o ascendente.

delimiter //
drop procedure if exists sp_ordenar;
create procedure sp_ordenar (
in tabla varchar(32),
in columna varchar(32),
in ordenamiento varchar(32) )
begin
   set @consultaEnTexto = 
            concat('select * from ',tabla,' order by ',columna,' ',ordenamiento);
   prepare param_stmt from @consultaEnTexto;
   execute param_stmt;
   deallocate prepare param_stmt;         
end //
delimiter ;   

-- Ejecutemos el procedimiento 'sp_ordenar':  
call sp_ordenar('cliente', 'nombre', 'asc'); -- Ordena la tabla 'cliente' por la columna 'nombre' en dirección 'ascendente'.


-- 2. ----- Stored Procedure: sp_registrarTransferencias ----- 
-- ##### Explicación: Este Stored Procedure nos permitirá la realización de transferencias bancarias de una cuenta
-- a otra. Como parámetros de entrada recibirá los número de cuenta que están involucrados en la transacción y el
-- monto por el que se hará la transferencia.

delimiter //
drop procedure if exists sp_registrarTransferencias;
create procedure sp_registrarTransferencias (
  in p_cuenta1 int,
  in p_cuenta2 int,
  in p_montoDeTransaccion decimal(12,2),
  out mensaje varchar(100))
   begin
     select monto into @montoCuenta1
     from cuenta
     where id = p_cuenta1;
     if p_montoDeTransaccion < @montoCuenta1 then
		insert into transaccion(id_cuenta,monto,tipo_de_transaccion)
        values (p_cuenta1,p_montoDeTransaccion,'Retiro');
        select monto into @montoCuenta2
        from cuenta
        where id = p_cuenta2;
        update cuenta set monto = @montoCuenta2 + p_montoDeTransaccion where id =  p_cuenta2;
        set mensaje = 'Transferencia exitosa.';
	else 
		set mensaje = 'Transferencia denegada.';
	end if;  
  end //
delimiter ;


-- 3. ----- Stored Procedure: sp_crearCuenta ----- 
-- ##### Explicación: El stored procedure 'sp_crearCuenta' nos pemitirá crear una cuenta bancaria para un cliente que 
-- así lo desee, siempre y cuando este sea titular, a lo sumo, de un máximo de 3 cuentas bancarias en el banco. 

delimiter //
drop procedure if exists sp_crearCuenta;
create procedure sp_crearCuenta(
    in p_idCliente int,
    in p_idSucursal int,
    in p_tipoDeCuenta varchar(50),
    out mensaje varchar(100))
begin
    declare v_numeroDeCuentas int;
    declare v_idCuenta int;
    set v_numeroDeCuentas = 
        (select count(*)
         from cuentaCliente
		 where id_cliente = p_idCliente
         );
    if v_numeroDeCuentas < 4  then
        insert into cuenta (id_sucursal,tipo_de_cuenta)
        values(p_idSucursal,p_tipoDeCuenta);
        set v_idCuenta = 
              (select id
               from cuenta
               order by fecha desc
               limit 1);
        insert into cuentaCliente (id_cuenta,id_cliente)
        values(v_idCuenta,p_idCliente);
	    set mensaje = 'Creación exitosa de cuenta.';
   else
	    set mensaje = 'No es posible crear la cuenta porque el cliente tiene más de 3 cuentas a su nombre.';
   end if;
end //
delimiter ;


-- 4. ----- Stored Procedure: sp_cerrarCuenta ----- 
-- ##### Explicación: Cuando una cuenta bancaria, en el objeto 'cuenta' entre sus campos tiene 'capital'
-- y 'fecha de actualización'. La única forma que se registren cambios en 'fecha de actualización' es que se registren
-- cambios en el campo 'capital'. Por lo que si una cuenta tiene un periodo de 24 meses sin movimiento en su capital,
-- esta cambiará su estado en el campo 'estado_de_cuenta' de 'Activa' a 'Inactiva'.

delimiter //
drop procedure if exists sp_cerrarCuenta;
create procedure sp_cerrarCuenta (
  in p_idCuenta int)
  begin
     select fecha into @ultimaFechaDeActualizacion
     from cuenta
     where id = p_idCuenta;
     set @tiempoLimite = date_add(@ultimaFechaDeActualizacion, interval 24 month);
     if @ultimaFechaDeActualizacion >= @tiempoLimite then
		update cuenta set estado_de_cuenta = 'Inactiva' where id = p_idCuenta;
     end if;
  end //
delimiter ;  

  
  
