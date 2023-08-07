-- -----------Creación de la Base de Datos: sistema_bancario----------- --

-- Creación de Schema:
drop schema if exists sistema_bancario;
create schema if not exists sistema_bancario;
use sistema_bancario;

-- Creación de Tablas:

-- I. --------------- Cliente ---------------
create table cliente
(
id                      int                auto_increment,
DNI                     int                not null,
nombre                  varchar(50)        not null,
apellido                varchar(50)        not null,
edad                    int                not null,
sexo                    enum('F','M'),
telefono                int                not null,
direccion               varchar(250),
email                   varchar(100),
fecha_actualizacion     timestamp,
primary key (id)
)engine = InnoDB;

-- II. -------------- Sucursal -----------------
create table sucursal (
id                        int                 auto_increment,
direccion                 varchar(250)        not null,
cantidad_de_clientes      int                 default 0,
fecha_actualizacion       timestamp,
primary key (id)
)engine = InnoDB;


-- III. --------------- Empleado ---------------
create table empleado
(
id                      int                auto_increment,
id_sucursal             int                not null,
DNI                     int                not null,
nombre                  varchar(50)        not null,
apellido                varchar(50)        not null,
edad                    int                not null,
sexo                    enum('F','M'),
telefono                int                not null,
direccion               varchar(250),
email                   varchar(100),
cargo                   varchar(100)       not null,   
fecha_actualizacion     timestamp,
primary key (id),

constraint fkEmpleadoSucursal
          foreign key (id_sucursal)
          references sucursal (id)
)engine = InnoDB;

-- IV. --------------- Cuenta -------------------
create table cuenta (
id                         int                             not null    auto_increment,
id_sucursal                int                             not null,
tipo_de_cuenta             enum('Corriente','Ahorro')      not null,
capital                    decimal(12,2)                   default 0.00,
estado_de_cuenta           varchar(50)                     default 'Activa',  
fecha_actualizacion        timestamp,
primary key (id),
 
constraint fkCuentaSucursal
          foreign key (id_sucursal)
          references sucursal (id)
          
)engine = InnoDB;

-- V. --------------- CuentaCliente ---------------
create table cuentaCliente (
id                       int           auto_increment,
id_cuenta                int           not null,
id_cliente               int           not null,
fecha_actualizacion      timestamp,
primary key (id),

 constraint fkcuentaClienteCuenta
          foreign key (id_cuenta)
          references cuenta (id),
          
constraint fkcuentaClienteCliente
          foreign key (id_cliente)
          references cliente (id)
          
)engine = InnoDB;

-- VI. ----------- Cheque ------------
create table cheque (
id                      int           auto_increment,
id_cuenta               int           not null,
fecha_actualizacion     timestamp,
estado                  varchar(50)   default 'Disponible',
primary key (id),

constraint fkChequeCuenta
          foreign key (id_cuenta)
          references cuenta (id)
          
)engine = InnoDB;

-- VII. ----------------- Prestamo ----------------
create table prestamo (
id                         int                auto_increment,
id_cuenta                  int                not null,
numero_de_cuotas           tinyint            not null,
monto_prestado             decimal(12,2)      not null,
monto_a_pagar              decimal(12,2),
fecha_de_prestamo          date               not null,
estado_de_prestamo         varchar(30)        default 'Pendiente',
fecha_actualizacion        timestamp,
primary key (id),

constraint fkPrestamoCuenta
          foreign key (id_cuenta)
          references cuenta (id)
          
)engine = InnoDB;


-- VIII. ----------------- Pago de Prestamo ----------------
create table pagoPrestamo (
id                       int                    auto_increment,
id_prestamo              int                    not null,
monto_a_pagar            decimal(12,2),
monto_abonado            decimal(12,2)          default 0,
fecha_de_pago            date                   not null,
fecha_actualizacion      timestamp,
primary key (id),

constraint fkpagoPrestamoPrestamo
          foreign key (id_prestamo)
          references prestamo (id)
          
)engine = InnoDB;


-- IX. -------------- Transaccion -------------
create table transaccion  (
id                         int                          auto_increment,
id_cuenta                  int,
id_sucursal                int,
id_cheque                  int,
id_empleado                int,
monto                      decimal(12,2)                 not null,
tipo_de_transaccion        enum('Retiro','Depósito')     not null,
fecha_actualizacion        timestamp,
primary key (id),

constraint fkTransaccionCuenta
          foreign key (id_cuenta)
          references cuenta (id),
          
constraint fkTransaccionCheque
          foreign key (id_cheque)
          references cheque (id),
          
constraint fkTransaccionSucursal
          foreign key (id_sucursal)
          references sucursal (id),
          
constraint fkTransaccionEmpleado
          foreign key (id_empleado)
          references sucursal (id)
)engine = InnoDB;

