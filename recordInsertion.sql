-- -----------Inserción de Registros en la Base de Datos: sistema_bancario----------- --
use sistema_bancario;
-- Inserción en la tabla: Cliente --
insert into cliente (DNI,nombre,apellido,edad,sexo,telefono,direccion,email)
values (15454, 'Edgard','Castellanos', 35,'M',345273884,'Calle San Eugenio 145','castellanos@email.com'),
	   (14557, 'Miguel','Moreno', 28,'M',455786759,'Calle San Bernardo 14','morenom@email.com'),
       (12099, 'Carolina','Alvarado', 21,'F',123678890,'Calle Santa Teresa 78','alvaradoc@email.com'),
       (11234, 'Bella','Salcedo', 38,'F',324567899,'Calle San Isidro 145','salcedo.bella@email.com'),
       (11266, 'Rafael','Gracía', 27,'M',345556788,'Calle Junín 11','rafa.garcia@email.com'),
       (15154, 'Angel','Molina', 19,'M',234888999,'Calle Alicante 122','molinaangel@email.com'),
       (20556, 'Nina','Torrealba', 43,'F',324445676,'Calle New York 16','nina.torrealba@email.com'),
       (21454, 'Alejandro','Agüero', 35,'M',324566789,'Calle España 34','agueroale@email.com'),
       (15445, 'María','Vargas', 37,'F',344564123,'Calle San Eugenio 5','maria.vargas@email.com'),
       (15454, 'Raquel','Prada', 23,'F',556677843,'Calle Bolívar 25','raquel.prada@email.com');
       

-- Inserción en la tabla: Cliente --
       insert into sucursal (direccion,cantidad_de_clientes)
       values('Cali',0),
             ('Pereira',0),
             ('Medellín',0),
             ('Bogotá',0),
             ('Popayán',0),
             ('Manizales',0),
             ('Santa Marta',0);
             
-- inserción en la tabla: Empleado -- 
insert into empleado (id_sucursal,DNI,nombre,apellido,edad,sexo,telefono,direccion,email,cargo )
values (7, 198999,'Virgina','Vergara', 30,'F',334567384,'Calle Benedicto 34','virgivergara@email.com','Cajera'),
       (2, 164783,'Vania','Carrillo', 33,'F',454333211,'Calle San Patricio 14','vcarrillo@email.com','Gerente'),
       (7, 424422,'Carlos','Pirela', 40,'M',432223424,'Calle Napoleón 32','carlos.pirela@email.com','Administrador'),
       (3, 455476,'Jorge','Mendoza', 39,'M',322432654,'Calle San Antonio 3','j.mendoza@email.com','Cajero'),
       (1, 192444,'Mariela','Bencomo',26,'F',321111256,'Calle Carabobo 2','maribencomoemail.com','Cajera'),
       (5, 198889,'Anna','Patiño', 28,'F',233114114,'Calle El Amparo 134','annapatino@email.com','Gerente'),
       (4, 187669,'Sofía','Cruz', 25,'F',323334565,'Calle Arauca 45','soficruz@email.com','Cajera'),
       (6, 176543,'Paulina','Serna', 22,'F',43332133,'Calle Bellera 222','pau.serna@email.com','Cajera'),
       (2, 424422,'Miguel','Palacios',29,'M',433212234,'Calle San Andrés 42','migue.palacios@email.com','Cajero'),
       (1,114554,'Carlos','Pirela', 40,'M',432223424,'Calle Napoleón 32','carlos.pirela@email.com','Administrador'),
       (4,178892,'Paola','Cardona', 36,'M',342344222,'Calle Manzanillo 62','paocardona@email.com','Gerente');

-- inserción en la tabla: Cuenta -- 
insert into cuenta (id_sucursal,tipo_de_cuenta,capital)
values(2,'Ahorro',100000),
(5,'Corriente',250000),
(4,'Corriente',14500),
(7,'Ahorro',1250000),
(1,'Corriente',6500),
(6,'Corriente',500000),
(3,'Corriente',1580000),
(5,'Ahorro',30000),
(2,'Ahorro',100000),
(7,'Ahorro',45000),
(3,'Corriente',115000),
(6,'Corriente',680000),
(4,'Ahorro',4000000);

-- inserción en la tabla: cuenta - cliente --
insert into cuentaCliente (id_cuenta,id_cliente)
values (12,1),
(1,3),
(5,4),
(3,8),
(4,9),
(8,7),
(7,5),
(2,2),
(11,3),
(5,6),
(1,9),
(6,10),
(9,1),
(9,6),
(10,1),
(11,4),
(13,2);

-- inserción en la tabla: Cheque --
insert into cheque (id_cuenta)
values (2),
(3),
(5),
(5),
(6),
(3),
(3),
(11),
(2),
(11),
(12),
(6),
(5),
(3),
(2),
(6),
(11),
(6),
(2),
(3);

-- inserción en la tabla: prestamo --
insert into prestamo (id_cuenta,numero_de_cuotas,monto_prestado,fecha_de_prestamo)
values (5,6,150000,'2023-01-01'), --
       (3,12,2550000,'2023-02-15'), -- 0
       (1,18,2000000,'2023-02-20'), -- &
       (10,24,180000,'2023-02-25'), -- %
       (7,6,700000,'2023-03-01'), -- $
       (8,12,1000000,'2023-03-15'), -- #
       (2,18,350000,'2023-03-28'), -- !
       (5,6,50000,'2023-04-01'); -- ?



-- inserción en la tabla: pago - prestamo --
insert into pagoPrestamo (id_prestamo,monto_abonado,fecha_de_pago)   -- Ojooo
values(1,20000,'2023-02-02'), --
	  (1,20000,'2023-03-02'), --
      (2,200000,'2023-03-15'), -- 0
      (3,100000,'2023-03-20'), -- &
      (4,20000,'2023-03-25'), -- %
      (5,20000,'2023-04-01'), -- $
      (1,100000,'2023-04-01'), --
      (2,80000,'2023-04-15'), -- 0
	  (6,80000,'2023-04-15'), -- #
      (3,250000,'2023-04-20'), -- &
      (4,250000,'2023-04-25'),  -- %
      (7,250000,'2023-04-28'),  -- !
      (8,10000,'2023-05-01'), -- ?
      (1,10000,'2023-05-01'), -- 
      (5,10000,'2023-05-01'), -- %
      (2,200000,'2023-05-15'), -- 0
      (6,100000,'2023-05-15'), -- #
      (3,200000,'2023-05-20'), -- &
      (4,100000,'2023-05-25'), -- %
	  (7,100000,'2023-05-28'),  -- !
      (1,20000,'2023-06-01'), --
      (7,20000,'2023-06-01'), -- !
      (4,20000,'2023-06-01'), -- %
      (2,200000,'2023-06-15'), -- 0
      (6,100000,'2023-06-15'); -- #

-- inserción en la tabla: Transacción --
insert into transaccion (id_cuenta,monto,tipo_de_transaccion)
values(3,150000,'Retiro'),
      (6,100000,'Depósito'),
      (1,250000,'Depósito'),
      (5,300000,'Retiro'),
      (10,50000,'Retiro'),
      (2,150000,'Depósito'),
      (4,200000,'Retiro'),
      (6,500000,'Retiro'),
      (6,70000,'Depósito'),
      (11,180000,'Retiro');
        
   


	             
             
             
             
             
       




