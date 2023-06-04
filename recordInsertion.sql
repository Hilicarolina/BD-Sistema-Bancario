use sistema_bancario;
-- Inserción en la tabla: Cliente --
insert into cliente 
values (1,15454, 'Edgard','Castellanos', 35,'M',345273884,'Calle San Eugenio 145','castellanos@email.com'),
	   (2,14557, 'Miguel','Moreno', 28,'M',455786759,'Calle San Bernardo 14','morenom@email.com'),
       (3,12099, 'Carolina','Alvarado', 21,'F',123678890,'Calle Santa Teresa 78','alvaradoc@email.com'),
       (4,11234, 'Bella','Salcedo', 38,'F',324567899,'Calle San Isidro 145','salcedo.bella@email.com'),
       (5,11266, 'Rafael','Gracía', 27,'M',345556788,'Calle Junín 11','rafa.garcia@email.com'),
       (6,15154, 'Angel','Molina', 19,'M',234888999,'Calle Alicante 122','molinaangel@email.com'),
       (7,20556, 'Nina','Torrealba', 43,'F',324445676,'Calle New York 16','nina.torrealba@email.com'),
       (8,21454, 'Alejandro','Agüero', 35,'M',324566789,'Calle España 34','agueroale@email.com'),
       (9,15445, 'María','Vargas', 37,'F',344564123,'Calle San Eugenio 5','maria.vargas@email.com'),
       (10,15454, 'Raquel','Prada', 23,'F',556677843,'Calle Bolívar 25','raquel.prada@email.com');
       
 

-- Inserción en la tabla: Cliente --
       insert into sucursal 
       values(1,'Cali',0),
             (2,'Pereira',0),
             (3,'Medellín',0),
             (4,'Bogotá',0),
             (5,'Popayán',0),
             (6,'Manizales',0),
             (7,'Santa Marta',0);
             
-- inserción en la tabla: Empleado -- 
insert into empleado
values (1,7, 198999,'Virgina','Vergara', 30,'F',334567384,'Calle Benedicto 34','virgivergara@email.com','Cajera'),
       (2,2, 164783,'Vania','Carrillo', 33,'F',454333211,'Calle San Patricio 14','vcarrillo@email.com','Gerente'),
       (3,7, 424422,'Carlos','Pirela', 40,'M',432223424,'Calle Napoleón 32','carlos.pirela@email.com','Administrador'),
       (4,3, 455476,'Jorge','Mendoza', 39,'M',322432654,'Calle San Antonio 3','j.mendoza@email.com','Cajero'),
       (5,1, 192444,'Mariela','Bencomo',26,'F',321111256,'Calle Carabobo 2','maribencomoemail.com','Cajera'),
       (6,5, 198889,'Anna','Patiño', 28,'F',233114114,'Calle El Amparo 134','annapatino@email.com','Gerente'),
       (7,4, 187669,'Sofía','Cruz', 25,'F',323334565,'Calle Arauca 45','soficruz@email.com','Cajera'),
       (8,6, 176543,'Paulina','Serna', 22,'F',43332133,'Calle Bellera 222','pau.serna@email.com','Cajera'),
       (9,2, 424422,'Miguel','Palacios',29,'M',433212234,'Calle San Andrés 42','migue.palacios@email.com','Cajero'),
       (10,1,114554,'Carlos','Pirela', 40,'M',432223424,'Calle Napoleón 32','carlos.pirela@email.com','Administrador'),
       (11,4,178892,'Paola','Cardona', 36,'M',342344222,'Calle Manzanillo 62','paocardona@email.com','Gerente');

-- inserción en la tabla: Cuenta -- 
insert into cuenta
values(1,2,'Ahorro'),
(2,5,'Corriente'),
(3,4,'Corriente'),
(4,7,'Ahorro'),
(5,1,'Corriente'),
(6,6,'Corriente'),
(7,3,'Corriente'),
(8,5,'Ahorro'),
(9,2,'Ahorro'),
(10,7,'Ahorro'),
(11,3,'Corriente'),
(12,6,'Corriente'),
(13,4,'Ahorro');

-- inserción en la tabla: cuenta - cliente --
insert into cuentaCliente
values (1,12,1),
(2,1,3),
(3,5,4),
(4,3,8),
(5,4,9),
(6,8,7),
(7,7,5),
(8,2,2),
(9,11,3),
(10,5,6),
(11,1,9),
(12,6,10),
(13,9,1),
(14,9,6),
(15,10,3);

-- inserción en la tabla: Cheque --
insert into cheque
values (1,2),
(2,3),
(3,5),
(4,5),
(5,6),
(6,3),
(7,3),
(8,11),
(9,2),
(10,11),
(11,12),
(12,6),
(13,5),
(14,3),
(15,2),
(16,6),
(17,11),
(18,6),
(19,2),
(20,3);

-- inserción en la tabla: prestamo --
insert into prestamo
values(1,3,'12',2550000),
(2,5,'6',150000),
(3,1,'18',2000000),
(4,10,'24',180000),
(5,7,'6',700000),
(6,8,'12',1000000),
(7,2,'18',350000);

-- inserción en la tabla: pago - prestamo --
insert into pagoPrestamo
values(1,5,100000),
(2,7,20000),
(3,1,50000);

-- inserción en la tabla: Transacción --
insert into transaccion (id,id_cuenta,id_sucursal,id_cheque,id_empleado,monto,tipo_de_transaccion)
values(1,3,null,null,null,150000,'Retiro'),
      (2,6,null,null,null,100000,'Depósito'),
      (3,1,null,null,null,250000,'Depósito'),
      (4,5,null,null,null,300000,'Retiro'),
      (5,10,null,null,null,50000,'Retiro'),
      (6,2,null,null,null,150000,'Depósito'),
      (7,4,null,null,null,200000,'Retiro'),
      (8,6,null,null,null,500000,'Retiro'),
      (9,6,null,null,null,70000,'Depósito'),
      (10,1,null,null,null,180000,'Retiro');
        
   


	             
             
             
             
             
       




