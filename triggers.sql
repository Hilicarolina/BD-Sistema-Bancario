-- ----------- Creación de Triggers en la Base de Datos: sistema_bancario----------- --
use sistema_bancario;

-- Creación de tabla 'log_auditoria'.
drop table if exists log_auditoria;
create table log_auditoria (
  id_log int auto_increment, -- pk de la tabla
  CampoNuevo_CampoAnterior VARCHAR(100),
  nombre_de_accion varchar(10) default null,
  nombre_tabla varchar(10), 
  usuario varchar(100),
  fecha_upd_ins_del date, 
  primary key(id_log)
  );
-- 1. ----- Trigger: trg_afterInsert_prestamo -----
-- ##### Explicación: Cuando un cliente solicita un préstamo, y este es aprobado, es decir, se crea un registro en el
-- objeto 'prestamo' tiene un número de cuotas de pago establecido que obedece a fechas y montos específicos por cada 
-- cuota de pago. Todos los registros en el objeto 'pagoPrestamo' que equivaldrán en cantidad, al mismo número 
-- almacenado en la columna 'cuotas_de_pago' desde el registro en el objeto 'prestamo' al que estos registros estén 
-- vínculado a través del id_prestamo con algún registro en el objeto 'prestamo', se crearán automáticamente en estado
-- 'Pendiente' con el valor de 'monto_a_pagar' correspondie al monto que deberá pagar el cliente en ese abono que,
-- para fines prácticos, consideraremos será el valor almacenado en 'monto_a_pagar' desde el registro en el objeto 'prestamo'
-- dividido entre el número de cuotas almacenado en el campo 'numero_de_cuotas'. Este valor se registrará en el campo
-- campo 'monto_a_pagar' en el registro en 'pagoPrestamo' al cual pertenezca. También se generará automáticamente la fecha
-- de pago en el en el campo 'fecha_de_pago'. Esto es, suponiendo que se inserta un registro en el objeto 'prestamo' con los 
-- siguientes datos:
-- id = 30
-- monto_a_pagar = 600
-- fecha_de_prestamo = '2000-01-01'
-- numero_de_cuotas = 3
-- En el objeto pagoPrestamo, esta inserción dará origen a 3 registros:
-- Registro 1:
-- id_prestamo = 30
-- monto_a_pagar = 200 (600/3)
-- monto_abonado = 0;
-- fecha_de_pago =   '2000-02-01'           
-- Registro 2:
-- monto_a_pagar = 200 (600/3)
-- monto_abonado = 0;
-- fecha_de_pago =   '2000-03-01' 
-- Registro 1:
-- monto_a_pagar = 200 (600/3)
-- monto_abonado = 0;
-- fecha_de_pago =   '2000-04-01' 

delimiter //
 drop trigger if exists trg_afterInsert_prestamo;
 create trigger trg_afterInsert_prestamo after insert on prestamo
 for each row
 begin
    -- Declaración de Variables
    declare v_idPrestamo int;
    declare v_montoPrestamo decimal(12,2);
    declare v_fechaPrestamo date;
    declare v_numeroCuotas int;
    declare contador int default 1;
    -- Inicialización de Variables
    set v_idPrestamo = new.id; 
    set v_montoPrestamo = new.monto_a_pagar;
    set v_fechaPrestamo = new.fecha_de_prestamo;
    set v_numeroCuotas = new.numero_de_cuotas;
	while contador <= v_numeroCuotas do
		insert into pagoPrestamo (id_prestamo,monto_a_pagar,fecha_de_pago)
        values (v_idPrestamo,v_montoPrestamo/v_numeroCuotas,date_add(v_fechaPrestamo, interval contador month));
        SET contador = contador + 1;
    end while;    
end //
delimiter ;

-- 2. ----- Trigger: trg_beforeInsert_prestamo -----
-- ##### Explicación: Cuando el cliente de un banco realiza una prestamo, se crea un registro en el objeto 'prestamo'
-- con dos campos que registran cantides monetarias. Uno de ellps es el valor del monto que ha sido aprobado para el
-- préstamo, 'monto_prestado', el otro 'monto_a_pagar' dependerá del valor registrado en el campo 'monto_prestado'
-- y el valor registrado en 'numero_de_cuotas'. Antes de la inserción, a través de la función 'calculo_de_monto_a_pagar
-- _por_prestamo' evaluada en los valores seteados en 'monto_prestado' y 'numero_de_cuotas', se seteará el valor que
-- deberá registar el campo 'monto_a_pagar'.

delimiter //
 drop trigger if exists trg_beforeInsert_prestamo;
 create trigger trg_beforeInsert_prestamo before insert on prestamo
 for each row
 begin
    -- Declaración de Variables
    declare v_montoPrestado decimal(12,2);
    declare v_numeroDeCuotas int;
   -- Inicialización de Variables
    set v_montoPrestado = new.monto_prestado;
    set v_numeroDeCuotas = new.numero_de_cuotas;
    set new.monto_a_pagar = (select calculo_de_monto_a_pagar_por_prestamo(v_montoPrestado,v_numeroDeCuotas));
 end //
 delimiter ;
 

-- 3. ----- Trigger: trg_afterUpdate_pagoPrestamo -----
-- ##### Explicación: Recordemos que el objeto 'pagoPrestamo' tiene la finalidad de almacenar los abonos
-- de pagos vinculados a algún préstamo que esté almacenado en el objeto 'prestamo' el cual, a su vez,
-- está vinculado a algún número de cuenta. El objeto 'prestamo', entre sus columnas, contiene 'monto_a_pagar',
-- columna que almacenará el monto monetario que deberá pagar el cliente por el monto aprobado en su préstamo
-- cuya cuenta esté referenciada en el campo 'id_cuenta'. Por otro lado, tenemos el campo 'estado_de_prestamo' 
-- que, por default, está seteado como 'Pendiente'. Cuando la sumas en el campo 'monto_abonado' en lo registros 
-- del objeto 'pagoPrestamo', asociados a un préstamo, suman una cantidad igual a la registrada en el campo 'monto_a_pagar'
-- del objeto 'prestamo', el campo 'estado_de_prestamo', en el registro alojado en el objeto 'prestamo' deberá 
-- cambiarse a 'Pagado'. Esto cual haremos posible a partir del Trigger 'trg_afterUpdatE_pagoPrestamo' bajo la acción
-- de inserción de registros en la tabla 'pagoPrestamo'. 

 delimiter //
 drop trigger if exists trg_afterUpdate_pagoPrestamo;
 create trigger trg_afterUpdate_pagoPrestamo after update on pagoPrestamo
 for each row
 begin
 -- Declaración de Variables
    declare v_totalMontoAbonado decimal(12,2);
    declare v_idPrestamo int;
    declare v_montoPrestado decimal(12,2);
    -- Inicialización de Variables
    set v_idPrestamo = old.id_prestamo; 
    select sum(monto_abonado) into v_totalMontoAbonado
    from pagoPrestamo
    where id_prestamo = v_idPrestamo;
    select monto_a_pagar into v_montoPrestado
    from prestamo
    where id = v_idPrestamo;
    if v_montoPrestado <= v_totalMontoAbonado then
       update prestamo set estado_de_prestamo = 'Pagado' where id = v_idPrestamo;
    end if;
end //
delimiter ;

-- 4. ----- Trigger: trg_beforeInsert_transaccion -----
-- ##### Explicación: Cuando el cliente de un banco realiza una transacción, si está es de tipo 'Retiro' antes de 
-- guardarse el registro en el objeto 'transacción', de debe verificar que el cliente disponga del capital en su 
-- cuenta. En caso de no contar con este capital, se generará un mensaje de advertencia y no se permitirá la inserción
-- del registro por dicha transacción. De todo esto se encargará la funcionalidad del trigger 'trg_beforeInsert_transaccion'.

 delimiter //
 drop trigger if exists trg_beforeInsert_transaccion;
 create trigger trg_beforeInsert_transaccion before insert on transaccion
 for each row
 begin
 -- Declaración de Variables
   declare v_idCuenta int;
   declare v_tipoDeTransaccion varchar(50);
   declare v_monto decimal(12,2);
   declare v_capitalDisponible decimal(12,2);
   declare mensaje varchar(100);
   -- Inicialización de variables
   set v_idCuenta = new.id_cuenta;
   set v_tipoDeTransaccion = new.tipo_de_transaccion;
   set v_monto = new.monto;
   select capital into v_capitalDisponible 
   from cuenta
   where id = v_idCuenta;
   if v_monto > v_capitalDisponible then
      signal sqlstate '45000' set message_text = 'No tiene monto disponible para realizar transacción.';
   end if;
end //
delimiter ;   


-- 5. ----- Trigger: trg_afterInser_cuentaCliente -----
-- ##### Explicación: Cuando una persona se hace cliente de un banco, se genera inmeditamente un registro en el objeto
-- 'cuentaCliente' el cual a su vez estará asociado a una persona, el cliente, y a un número de cuenta. Si la cuenta a
--  la que estará vinculada el cliente es de tipo 'Corriente', se generarán automáticamente, en el objeto 'cheque', 20
-- cheques (chequera) asociados a la cuenta del cliente. Por otro lado tenemos que, en el objeto 'sucursal' existe un
-- campo llamado 'cantidad_de_clientes' que hace referencia al número de clientes en una sucursal específica. Este 
-- campo se actualizará automáticamente cuando se inserten registros en el objeto 'cuentaCliente' cuya cuenta esté
-- vinculada a dicha sucursal.

 delimiter //
 drop trigger if exists trg_afterInsert_cuentaCliente;
 create trigger trg_afterInsert_cuentaCliente after insert on cuentaCliente
 for each row
 begin
   -- Declaración de Variables
   declare v_idCuenta int;
   declare v_tipoDeCuenta varchar(50);
   declare v_idSucursal varchar(50);
   declare contador int default 1;
   -- Inicialización de variables
   set v_idCuenta = new.id_cuenta;
   select id_sucursal, tipo_de_cuenta into v_idSucursal, v_tipoDeCuenta
   from cuenta
   where id = v_idCuenta;
   -- Actualización en el campo 'cantidad_de_clientes' en el objeto 'sucursal'
   update sucursal set cantidad_de_clientes = (cantidad_de_clientes + 1) where id = v_idSucursal; 
   -- Creación de 20 resgistros en el objeto 'Cheque'
   if v_tipoDeCuenta = 'Corriente' then
	  while contador <= 20 do
          insert into cheque (id_cuenta)
          values (v_idCuenta);
          set contador = contador + 1;
	  end while;
   end if;
end //
delimiter ;
 

-- 6. ----- Trigger: trg_afterUpdate_log_sucursal -----
-- ##### Explicación: En el objeto 'sucursal', el único campo que estará en permanente actualización es el de 
-- 'cantidad_de_clientes' deseamos estar en seguimiento permanente de la fecha de esta actualización. Registrar la 
-- fecha de estos cambios es la funcionalidad del Trigger 'trg_afterUpdate_log_sucursal' .

delimiter //
 drop trigger if exists trg_afterUpdate_log_sucursal;
 create trigger trg_afterUpdate_log_sucursal after update on sucursal
 for each row
 begin
     insert into log_auditoria (CampoNuevo_CampoAnterior,nombre_de_accion,nombre_tabla,usuario,fecha_upd_ins_del)
     values (concat('Última fecha de actualización: ', new.fecha_actualizacion),'update','sucursal',current_user(),now());
 end //
 delimiter ;
 

-- 7. ----- Trigger: trg_beforeDelete_CuentaCliente -----
-- ##### Explicación: Para desafiliar a un cliente de una cuenta de la que es titular lo hacemos desde el registro
-- en el objeto 'cuentaCliente'. Para hacer efectiva esta desafiliación, primero se debe verificar que la cuenta a 
-- la que está vinculado no registre prestamos pendientes por pagar. En caso de no cumplirse esta codición, no se debe
-- permitir la desfiliación del cliente. 
 
 delimiter //
 drop trigger if exists trg_beforeDelete_CuentaCliente;
 create trigger trg_beforeDelete_CuentaCliente before delete on cuentaCliente
for each row
 begin
    -- Declaración de variables
    declare prestamosPendientes int;
    declare titularesDeCuenta int;
    declare idCuenta int;
    declare idCliente int;
    -- Inicialización de variables
    set idCuenta = old.id_cliente;
    set idCliente = old.id_cuenta;
    select count(*) into prestamosPendientes
    from prestamo
    where id_cuenta = idCuenta and estado_de_prestamo = 'Pendiente';
    if prestamosPendientes <> 0 then
       signal sqlstate '45000' set message_text = 'Este usuario debe saldar préstamos pendientes a su cuenta.';
	else 
	   insert into log_auditoria (CampoNuevo_CampoAnterior,nombre_de_accion,nombre_tabla,usuario,fecha_upd_ins_del)
       values (concat('Número de cliente: ',idCliente,'Desuscrito de la cuenta: ',idCuenta),'delete','cuentaCliente',current_user(),now());
    end if;
end //
delimiter ; 


-- 8. ----- Trigger: trg_afterDelete_CuentaCliente -----
-- ##### Explicación: Una vez sea posible desafiliar a un cliente de una cuenta en la cual figuraba como titular,
-- eliminando su respectivo registro en el objeto 'cuentaCliente', si la cuenta a la que estaba vinculado no tiene 
-- otro titular asociado, también se procederá a eliminar desde el objeto 'cuenta' el registro del número de cuenta al
-- que dicho cliente estaba asociados. Si es posible la eliminación de la cuenta se registrará, en el objeto 'log-auditoria',
-- la fecha en la que se hizo la eliminación.

 delimiter //
 drop trigger if exists trg_afterDelete_CuentaCliente;
 create trigger trg_afterDelete_CuentaCliente after delete on cuentaCliente
 for each row
 begin
    -- Declaración de variables
    declare idCliente int;
    declare idCuenta int;
    declare titularesDeCuenta int;
    -- Inicialización de variables
    set idCuenta = old.id_cliente;
    set idCliente = old.id_cuenta;
    --
    select count(*) into titularesDeCuenta
    from cuentaCliente
    where id_cuenta = idCuenta and id_cliente <> idCliente;
    if titularesDeCuenta = 0 then
	    delete from cheque where id_cuenta = idCuenta;
        delete from cuenta where id = idCuenta;
        insert into log_auditoria (CampoNuevo_CampoAnterior,nombre_de_accion,nombre_tabla,usuario,fecha_upd_ins_del)
        values (concat('La cuenta n°: ',idCuenta, 'se ha eliminado'),'delete','cuentaCliente',current_user(),now());
    end if;
 end //   
delimiter ;


-- 9. ----- Trigger: afterUpdate_log_cuenta -----
-- ##### Explicación: En la tabla 'cuenta' se registra un campo llamado 'estado_de_cuenta'. Este tiene dos posibles
-- valores 'Activa' o 'Desactivada'. Cada registro en el objeto 'cuenta' tendrá setado, por defecto, al momento de
-- inserción, estado_de_cuenta = Activa. Se desea registrar la fecha, si llegase a ocurrir, en la que el 'estado_de_cuenta'
-- tenga valor de 'Desactivada'.
 
 delimiter //
 drop trigger if exists trg_afterUpdate_log_cuenta;
 create trigger trg_afterUpdate_log_cuenta after update on cuenta
 for each row
 begin
	 -- Declaración de variables
	 declare estado1 varchar(50);
     declare estado2 varchar(50);
     declare idCuenta int;
     -- Inicialización de variables
     set estado1 = old.estado_de_cuenta;
     set estado2 = new.estado_de_cuenta;
     set idCuenta = old.id;
     if estado1 <> estado2 then
		insert into log_auditoria (CampoNuevo_CampoAnterior,nombre_de_accion,nombre_tabla,usuario,fecha_upd_ins_del)
        values (concat('La cuenta n°: ',idCuenta, ' ha sido desactivada.'),'update','cuenta',current_user(),now());
     end if;   
 end //
 delimiter ;
 
 
 -- 10. ----- Trigger: trg_afterInsert_transaccion -----
-- ##### Explicación: Cuando en el objeto 'transacción' se inserta un registro y este tiene asociado un número de
-- cheque, desde el objeto 'cheque' se debe actualizar el campo 'estado' a 'Usado' en el registro con la
-- misma indentidificación del número de cheque usado en la transacción.

 delimiter //
 drop trigger if exists trg_afterInsert_transaccion;
 create trigger trg_afterInsert_transaccion after insert on transaccion
 for each row
 begin
	declare v_idCheque int;
    set v_idCheque = new.id_cheque;
    if v_idCheque is not null then
       update cheque set estado = 'Usado' where id = v_idCheque;
    end if;  
 end //
 delimiter ;
