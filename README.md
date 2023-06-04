# db-bank-system

**db-bank-system** es un proyecto en el que se desarrollan nociones centrales de las bases de datos relacionales. Se crea una base de datos relacional desde cero, iniciando con la generación de la estructura hasta la inserción de la información, e implementación de procesos de automatización para el mantenimiento de la base. Se implementan consultas SQL avanzadas para generar
reportes e informes para la toma de decisiones y se analiza la base de datos para extraer indicadores.

El gestor utilizado para desarrollar el proyecto es MySQL workbench.

## Índice
- [1. Descripción](#item1)
- [2. Entidades](#item2)
- [3. D-E-R](#item3)
- [4. Herramientas de desarrollo](#item4)

<a name="item1"></a>
### Descripción
Debido a la cantidad de información quese registra en un Sistema Bancario, deseamos crear una base de datos para poder almacenar
esta información de una forma organizada para su futura consulta, realización de búsquedas, nuevo ingreso de datos, etc.

<a name="item2"></a>
### Entidades
**Sucursal:** Necesitamos almacenar los datos de ubicación, teléfonos, número de clientes registrados, etc. En todas las sucursales
del banco.

**Empleado:** Esta tabla almacenará los registros de todos los empleados del banco los cuales estarán asociados a una y sólo una sucursal.

**Cliente:** Almacena toda la información de los Clientes del Banco. Una persona es cliente si tiene un número de cuenta asociado. 
Un cliente puede tenervarios números de cuentas asociadas a él.

**Cuenta:** Esta tabla almacenerá todos los números de cuentas de los clientes del banco por sucursal. Una cuenta debe ser abierta por un
empleado del Banco. Una cuenta puede pertenecer a varios clientes. Existen dos tipos de cuenta: "Ahorro" y"Corriente".

**Cuenta-Cliente:** Como un cliente puede tener varias cuentas y una misma cuenta puede estar asociada a muchos clientes, necesitamos una
entidad intermedia entre la entidad Cuenta y la entidad Cliente.

**Transacción:** Una transacción puede ser hecha por una persona no cliente o por un cliente del banco. Se categoriza por ser de tipo 
"Depósito" o "Retiro". En el caso de transacción presencial, esta puede, o no, estar asociada a un número de cheque.

**Cheque:** Los clientes que tienen cuenta corriente tienen una Chequera asignada. Cada Cheque, está asociado a uno y sólo
un número de cuenta.

**Préstamo:** Los clientes del banco, previa aprobación de este último, pueden recibir préstamos. Estos tendrán plazos específicos para 
pagarse a una tasa de interés que dependerá del plazo de pago que elija para pagar. Los préstamos estarán asociados a uno y sólo un 
número de cuenta. Un mismo número de cuenta puede estar asociado a más de un préstamo.

**Pago de Préstamo:** Esta entidad registrará los pagos que un cliente abone a un préstamo. Cada registro estará vínculado a uno y sólo
un préstamo. Varios registros pueden estar vínculados a un mismo préstamo.

<a name="item2"></a>
### D-E-R
![D-E-R](https://github.com/hc-angulo/db-bank-system/assets/14808063/f67aebfd-8b4f-459f-9f33-0c041a735674)


<a name="item3"></a>
### Herramientas


<p align="left> 
  <a href="https://www.mysql.com/" target="_blank"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="100" height="100"/>
</p>
          



