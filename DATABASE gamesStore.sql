CREATE DATABASE gamesStore;

CREATE TABLE tienda(
id_tienda INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
nombre VARCHAR (100) NOT NULL,
direccion VARCHAR (100) NOT NULL,
numero_trabajadores VARCHAR (100) NOT NULL
);
CREATE TABLE producto(
id_producto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
nombre VARCHAR (100) NOT NULL,
categoria VARCHAR (100) NOT NULL,
precio INT NOT NULL
);
CREATE TABLE asesor(
id_asesor INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
id_tienda INT NOT NULL,
FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda),
nombre VARCHAR (100),
apellido VARCHAR (100),
edad INT NOT NULL
);
CREATE TABLE cliente (
id_cliente INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
id_asesor INT NOT NULL,
FOREIGN KEY (id_asesor) REFERENCES asesor (id_asesor),
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR (100) NOT NULL,
telefono INT NOT NULL,
direccion VARCHAR(100)
);

CREATE TABLE cliente_producto (
id_cliente_producto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
id_cliente INT NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
id_producto INT NOT NULL,
FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

USE gamesStore;
INSERT INTO tienda  VALUES ('digipay','cra 83 #20-50',2),('screendust','cra 27b-10',3),('highGame','crea 31a #2-16',1);
USE gamesStore;
INSERT INTO producto VALUES ('the witcher 3','aventura',156000),('GTA5','accion',230000),('Zelda','aventura',96000),('the last of us','suspenso',235000),('god of war','accion-aventura',355000),('bioshock','accion',260000);
USE gamesStore
INSERT INTO asesor  VALUES (2,'simon','restrepo',24),(2,'andres','cataño',32),(2,'carolina','montoya',22),(3,'samuel','acevedo torres',31),(1,'andrea','maldonado',19),(1,'isabela','restrepo',25);
USE gamesStore;
INSERT INTO cliente VALUES (5,'Elena','mendeoza',315264978,'cra 71-32'),(6,'andres','marleno',154632895,'cra 32'),(2,'mateo','cardona',345829164,'cra 29b'),(3,'abril','cardona',347695812,'cra 13a'),(1,'laura','caro',312649587,'crea 29 7-30');
USE gamesStore;
INSERT INTO cliente_producto VALUES (5,4),(5,5),(4,2),(3,1),(3,2),(3,3),(2,1),(1,4);



CREATE PROCEDURE informacion_asesor
AS
begin	
SELECT cliente.id_cliente,cliente.nombre,asesor.id_asesor,asesor.nombre,asesor.id_tienda FROM asesor,cliente
WHERE asesor.id_asesor=cliente.id_asesor 
END


CREATE PROCEDURE informacion_tienda_asesor
AS
begin	
SELECT tienda.nombre,tienda.direccion,tienda.numero_trabajadores,asesor.id_asesor,asesor.nombre,asesor.apellido,asesor.edad FROM tienda,asesor
WHERE tienda.id_tienda=asesor.id_tienda
END


CREATE PROCEDURE informacion_ganancia_total
AS
begin	
SELECT cliente_producto.id_cliente_producto,cliente.nombre,producto.id_producto,producto.nombre,producto.categoria,producto.precio,
SUM(SUM(producto.precio)) over (order by cliente_producto.id_cliente_producto ASC) AS total_acumulado 
FROM cliente,producto,cliente_producto
WHERE producto.id_producto=cliente_producto.id_producto AND cliente.id_cliente=cliente_producto.id_cliente
GROUP BY cliente_producto.id_cliente_producto,cliente.nombre,producto.id_producto,producto.nombre,producto.categoria,producto.precio
END