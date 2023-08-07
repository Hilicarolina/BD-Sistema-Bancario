
--
-- Host: localhost    Database: sistema_bancario
-- ------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- ------------------ Dumping data for table `cliente` ------------------
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,15454,'Edgard','Castellanos',35,'M',345273884,'Calle San Eugenio 145','castellanos@email.com',NULL),(2,14557,'Miguel','Moreno',28,'M',455786759,'Calle San Bernardo 14','morenom@email.com',NULL),(3,12099,'Carolina','Alvarado',21,'F',123678890,'Calle Santa Teresa 78','alvaradoc@email.com',NULL),(4,11234,'Bella','Salcedo',38,'F',324567899,'Calle San Isidro 145','salcedo.bella@email.com',NULL),(5,11266,'Rafael','Gracía',27,'M',345556788,'Calle Junín 11','rafa.garcia@email.com',NULL),(6,15154,'Angel','Molina',19,'M',234888999,'Calle Alicante 122','molinaangel@email.com',NULL),(7,20556,'Nina','Torrealba',43,'F',324445676,'Calle New York 16','nina.torrealba@email.com',NULL),(8,21454,'Alejandro','Agüero',35,'M',324566789,'Calle España 34','agueroale@email.com',NULL),(9,15445,'María','Vargas',37,'F',344564123,'Calle San Eugenio 5','maria.vargas@email.com',NULL),(10,15454,'Raquel','Prada',23,'F',556677843,'Calle Bolívar 25','raquel.prada@email.com',NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- ------------------ Dumping data for table `cuenta` ------------------
--

LOCK TABLES `cuenta` WRITE;
/*!40000 ALTER TABLE `cuenta` DISABLE KEYS */;
INSERT INTO `cuenta` VALUES (1,2,'Ahorro',100000.00,'Activa',NULL),(2,5,'Corriente',250000.00,'Activa',NULL),(3,4,'Corriente',14500.00,'Activa',NULL),(4,7,'Ahorro',1250000.00,'Activa',NULL),(5,1,'Corriente',6500.00,'Activa',NULL),(6,6,'Corriente',500000.00,'Activa',NULL),(7,3,'Corriente',1580000.00,'Activa',NULL),(8,5,'Ahorro',30000.00,'Activa',NULL),(9,2,'Ahorro',100000.00,'Activa',NULL),(10,7,'Ahorro',45000.00,'Activa',NULL),(11,3,'Corriente',115000.00,'Activa',NULL),(12,6,'Corriente',680000.00,'Activa',NULL),(13,4,'Ahorro',4000000.00,'Activa',NULL);
/*!40000 ALTER TABLE `cuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- ------------------ Dumping data for table `cuentacliente` ------------------
--

LOCK TABLES `cuentacliente` WRITE;
/*!40000 ALTER TABLE `cuentacliente` DISABLE KEYS */;
INSERT INTO `cuentacliente` VALUES (1,12,1,NULL),(2,1,3,NULL),(3,5,4,NULL),(4,3,8,NULL),(5,4,9,NULL),(6,8,7,NULL),(7,7,5,NULL),(8,2,2,NULL),(9,11,3,NULL),(10,5,6,NULL),(11,1,9,NULL),(12,6,10,NULL),(13,9,1,NULL),(14,9,6,NULL),(15,10,1,NULL),(16,11,4,NULL),(17,13,2,NULL);
/*!40000 ALTER TABLE `cuentacliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- ------------------ Dumping data for table `pagoprestamo` ------------------
--

LOCK TABLES `pagoprestamo` WRITE;
/*!40000 ALTER TABLE `pagoprestamo` DISABLE KEYS */;
INSERT INTO `pagoprestamo` VALUES (1,1,NULL,20000.00,'2023-02-02',NULL),(2,1,NULL,20000.00,'2023-03-02',NULL),(3,2,NULL,200000.00,'2023-03-15',NULL),(4,3,NULL,100000.00,'2023-03-20',NULL),(5,4,NULL,20000.00,'2023-03-25',NULL),(6,5,NULL,20000.00,'2023-04-01',NULL),(7,1,NULL,100000.00,'2023-04-01',NULL),(8,2,NULL,80000.00,'2023-04-15',NULL),(9,6,NULL,80000.00,'2023-04-15',NULL),(10,3,NULL,250000.00,'2023-04-20',NULL),(11,4,NULL,250000.00,'2023-04-25',NULL),(12,7,NULL,250000.00,'2023-04-28',NULL),(13,8,NULL,10000.00,'2023-05-01',NULL),(14,1,NULL,10000.00,'2023-05-01',NULL),(15,5,NULL,10000.00,'2023-05-01',NULL),(16,2,NULL,200000.00,'2023-05-15',NULL),(17,6,NULL,100000.00,'2023-05-15',NULL),(18,3,NULL,200000.00,'2023-05-20',NULL),(19,4,NULL,100000.00,'2023-05-25',NULL),(20,7,NULL,100000.00,'2023-05-28',NULL),(21,1,NULL,20000.00,'2023-06-01',NULL),(22,7,NULL,20000.00,'2023-06-01',NULL),(23,4,NULL,20000.00,'2023-06-01',NULL),(24,2,NULL,200000.00,'2023-06-15',NULL),(25,6,NULL,100000.00,'2023-06-15',NULL);
/*!40000 ALTER TABLE `pagoprestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- ------------------ Dumping data for table `prestamo` ------------------
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,5,6,150000.00,NULL,'2023-01-01','Pendiente',NULL),(2,3,12,2550000.00,NULL,'2023-02-15','Pendiente',NULL),(3,1,18,2000000.00,NULL,'2023-02-20','Pendiente',NULL),(4,10,24,180000.00,NULL,'2023-02-25','Pendiente',NULL),(5,7,6,700000.00,NULL,'2023-03-01','Pendiente',NULL),(6,8,12,1000000.00,NULL,'2023-03-15','Pendiente',NULL),(7,2,18,350000.00,NULL,'2023-03-28','Pendiente',NULL),(8,5,6,50000.00,NULL,'2023-04-01','Pendiente',NULL);
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- ------------------ Dumping data for table `transaccion` ------------------
--

LOCK TABLES `transaccion` WRITE;
/*!40000 ALTER TABLE `transaccion` DISABLE KEYS */;
INSERT INTO `transaccion` VALUES (1,3,NULL,NULL,NULL,150000.00,'Retiro',NULL),(2,6,NULL,NULL,NULL,100000.00,'Depósito',NULL),(3,1,NULL,NULL,NULL,250000.00,'Depósito',NULL),(4,5,NULL,NULL,NULL,300000.00,'Retiro',NULL),(5,10,NULL,NULL,NULL,50000.00,'Retiro',NULL),(6,2,NULL,NULL,NULL,150000.00,'Depósito',NULL),(7,4,NULL,NULL,NULL,200000.00,'Retiro',NULL),(8,6,NULL,NULL,NULL,500000.00,'Retiro',NULL),(9,6,NULL,NULL,NULL,70000.00,'Depósito',NULL),(10,11,NULL,NULL,NULL,180000.00,'Retiro',NULL);
/*!40000 ALTER TABLE `transaccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

