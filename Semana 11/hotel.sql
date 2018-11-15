﻿CREATE DATABASE hotel;

CREATE TABLE tipo_servicio (
  nombre_servicio char(10) NOT NULL PRIMARY KEY
);

INSERT INTO tipo_servicio
  VALUES ('Comedor');

INSERT INTO tipo_servicio
  VALUES ('Lavanderia');

CREATE TABLE pais (
  pais char(20) NOT NULL PRIMARY KEY
);

INSERT INTO pais
  VALUES ('Alemania');

INSERT INTO pais
  VALUES ('España');

INSERT INTO pais
  VALUES ('Francia');

INSERT INTO pais
  VALUES ('Portugal');

CREATE TABLE cliente (
  identificacion char(12) NOT NULL,
  pais char(20) NOT NULL,
  nombre char(12) NOT NULL,
  apellido1 char(12) NOT NULL,
  apellido2 char(12),
  direccion char(30) NOT NULL,
  telefono char(12) NOT NULL,
  observaciones char(50),
  PRIMARY KEY (identificacion),
  FOREIGN KEY (pais) REFERENCES pais (pais)
);

INSERT INTO cliente
  VALUES ('12345', 'España', 'Felipe', 'Iglesias', 'López', 'Avda los castros, 44', '942344444', 'Buen cliente');

INSERT INTO cliente
  VALUES ('44444', 'España', 'Luis', 'García', 'García', 'Calle mayor, 67 ', '942456444', NULL);

INSERT INTO cliente
  VALUES ('456789', 'Francia', 'Ludovic', 'Giuly', 'Bourquin', '18 avenue alsacen cour', '37890194', NULL);

CREATE TABLE tipo_habitacion (
  categoria int NOT NULL,
  camas int NOT NULL,
  exterior char(2) NOT NULL CHECK (exterior IN ('si', 'no')),
  salon char(2) NOT NULL CHECK (salon IN ('si', 'no')),
  terraza char(2) NOT NULL CHECK (terraza IN ('si', 'no')),
  PRIMARY KEY (categoria)
);

INSERT INTO tipo_habitacion
  VALUES (1, 1, 'si', 'no', 'no');

INSERT INTO tipo_habitacion
  VALUES (2, 2, 'si', 'no', 'no');

INSERT INTO tipo_habitacion
  VALUES (3, 3, 'si', 'no', 'no');

INSERT INTO tipo_habitacion
  VALUES (4, 1, 'si', 'si', 'no');

CREATE TABLE habitacion (
  num_habitacion int NOT NULL,
  tipo_habitacion int NOT NULL,
  PRIMARY KEY (num_habitacion),
  FOREIGN KEY (tipo_habitacion) REFERENCES tipo_habitacion (categoria)
);

INSERT INTO habitacion
  VALUES (101, 1);

INSERT INTO habitacion
  VALUES (102, 1);

INSERT INTO habitacion
  VALUES (103, 1);

INSERT INTO habitacion
  VALUES (104, 2);

INSERT INTO habitacion
  VALUES (105, 2);

INSERT INTO habitacion
  VALUES (106, 3);

INSERT INTO habitacion
  VALUES (107, 4);

CREATE TABLE servicio (
  id_servicio int NOT NULL,
  nombre_servicio char(10) NOT NULL,
  descripcion char(30) NOT NULL,
  precio money NOT NULL,
  iva numeric(5, 2) NOT NULL,
  fecha date NOT NULL,
  PRIMARY KEY (id_servicio),
  FOREIGN KEY (nombre_servicio) REFERENCES tipo_servicio (nombre_servicio)
);

INSERT INTO servicio
  VALUES (1, 'Comedor', '1 menu del dia', 10, 7, '2009-01-01');

INSERT INTO servicio
  VALUES (2, 'Lavanderia', 'lavado de camisa', 2, 7, '2009-01-01');

INSERT INTO servicio
  VALUES (3, 'Lavanderia', 'lavado de pantalon', 1, 7, '2009-01-01');

CREATE TABLE temporada (
  temporada int NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_final date NOT NULL,
  tipo char(1) NOT NULL CHECK (tipo IN ('b', 'm', 'a')),
  PRIMARY KEY (temporada)
);


INSERT INTO temporada
  VALUES (1, '2009-01-01', '2009-03-31', 'b');

INSERT INTO temporada
  VALUES (2, '2009-04-01', '2009-05-31', 'm');

INSERT INTO temporada
  VALUES (3, '2009-06-01', '2009-08-31', 'a');

INSERT INTO temporada
  VALUES (4, '2009-09-01', '2009-10-31', 'm');

INSERT INTO temporada
  VALUES (5, '2009-11-01', '2009-12-31', 'b');

CREATE TABLE precio_habitacion (
  id_precio int NOT NULL,
  precio money NOT NULL,
  temporada int NOT NULL,
  tipo_habitacion int NOT NULL,
  PRIMARY KEY (id_precio),
  FOREIGN KEY (temporada) REFERENCES temporada (temporada),
  FOREIGN KEY (tipo_habitacion) REFERENCES tipo_habitacion (categoria)
);

INSERT INTO precio_habitacion
  VALUES (1, 30, 1, 1);

INSERT INTO precio_habitacion
  VALUES (2, 35, 2, 1);

INSERT INTO precio_habitacion
  VALUES (3, 40, 3, 1);

INSERT INTO precio_habitacion
  VALUES (4, 35, 4, 1);

INSERT INTO precio_habitacion
  VALUES (5, 30, 5, 1);

INSERT INTO precio_habitacion
  VALUES (6, 35, 1, 2);

INSERT INTO precio_habitacion
  VALUES (7, 40, 2, 2);

INSERT INTO precio_habitacion
  VALUES (8, 45, 3, 2);

INSERT INTO precio_habitacion
  VALUES (9, 40, 4, 2);

INSERT INTO precio_habitacion
  VALUES (10, 35, 5, 2);

INSERT INTO precio_habitacion
  VALUES (11, 40, 1, 3);

INSERT INTO precio_habitacion
  VALUES (12, 45, 2, 3);

INSERT INTO precio_habitacion
  VALUES (13, 50, 3, 3);

INSERT INTO precio_habitacion
  VALUES (14, 45, 4, 3);

INSERT INTO precio_habitacion
  VALUES (15, 40, 5, 3);

INSERT INTO precio_habitacion
  VALUES (16, 50, 1, 4);

INSERT INTO precio_habitacion
  VALUES (17, 55, 2, 4);

INSERT INTO precio_habitacion
  VALUES (18, 60, 3, 4);

INSERT INTO precio_habitacion
  VALUES (19, 55, 4, 4);

INSERT INTO precio_habitacion
  VALUES (20, 50, 5, 4);

CREATE TABLE reserva_habitacion (
  id_reserva int IDENTITY NOT NULL,
  fecha_entrada date NOT NULL,
  fecha_salida date NOT NULL,
  iva numeric(5, 2) NOT NULL,
  num_habitacion int NOT NULL,
  cliente char(12) NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (cliente) REFERENCES cliente (identificacion),
  FOREIGN KEY (num_habitacion) REFERENCES habitacion (num_habitacion)
);

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-15', '2009-03-25', 0.07, 101, '12345');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-15', '2009-03-25', 0.07, 102, '12345');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-02-16', '2009-02-21', 0.07, 103, '12345');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-16', '2009-03-21', 0.07, 104, '44444');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-16', '2009-03-21', 0.07, 105, '44444');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-16', '2009-03-21', 0.07, 106, '44444');

INSERT INTO reserva_habitacion (fecha_entrada,
fecha_salida,
iva,
num_habitacion,
cliente)
  VALUES ('2009-03-16', '2009-03-21', 0.07, 107, '44444');

CREATE TABLE gastos (
  id_gastos int IDENTITY NOT NULL,
  id_reserva int NOT NULL,
  id_servicio int NOT NULL,
  fecha datetime NOT NULL,
  cantidad int NOT NULL,
  precio money NOT NULL,
  PRIMARY KEY (id_gastos),
  FOREIGN KEY (id_reserva) REFERENCES reserva_habitacion (id_reserva),
  FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio)
);

/*Permite que el autoincremental,acepte valores ingresados a la columna id_gastos por medio de un insert*/
/*https://docs.microsoft.com/en-us/sql/t-sql/statements/set-identity-insert-transact-sql*/
SET IDENTITY_INSERT gastos ON;

INSERT INTO gastos (id_gastos,
id_reserva,
id_servicio,
fecha,
cantidad,
precio)
  VALUES (1, 1, 1, '2009-03-15 12:00', 1, 10);

INSERT INTO gastos (id_gastos,
id_reserva,
id_servicio,
fecha,
cantidad,
precio)
  VALUES (2, 1, 1, '2009-03-15 11:00', 1, 10);

INSERT INTO gastos (id_gastos,
id_reserva,
id_servicio,
fecha,
cantidad,
precio)
  VALUES (3, 4, 2, '2009-03-15 09:30', 1, 2);

/*Devolver al estado inicial el autoincrementador*/
SET IDENTITY_INSERT gastos OFF;