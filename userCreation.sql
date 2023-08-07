-- -----------Creación de Usuarios----------- --
-- Creación del usuario 'user1' con contraseña 'mypassword1'.
 create user if not exists 'user1'@'localhost' identified by 'mypassword1'; 
 
-- Creación del usuario 'user2' con contraseña 'mypassword2'.
 create user if not exists 'user2'@'localhost' identified by 'mypassword2';
 
 -- ----------- Otorgamiento de permisos ----------- --
 -- Definiremos permiso al usuario 'user1' de sólo lectura en el schema 'sistema_bancario'.
 grant select on sistema_bancario.* to 'user1'@'localhost';
 
  -- Definiremos permiso al usuario 'user2' de lectura, inserción y actualización en el schema 'sistema_bancario'.
 grant select,insert,update on sistema_bancario.* to 'user2'@'localhost';
 
 -- Verificación de los permisos establecidos a cada usuario creado:
 use mysql;
 select * from db where User in ('user1','user2'); 
 