DROP DATABASE IF EXISTS instituto;
CREATE DATABASE instituto CHARACTER SET utf8mb4;
USE instituto;

CREATE TABLE alumno (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	apellido1 VARCHAR(100) NOT NULL,
	apellido2 VARCHAR(100),
	fecha_nacimiento DATE NOT NULL,
	es_repetidor ENUM('sí', 'no') NOT NULL,
	teléfono CHAR(9)
);
INSERT INTO alumno VALUES(1, 'María', 'Sánchez', 'Pérez', '1990/12/01', 'no', NULL);
INSERT INTO alumno VALUES(2, 'Juan', 'Sáez', 'Vega', '1998/04/02', 'no', 618253876);
INSERT INTO alumno VALUES(3, 'Pepe', 'Ramírez', 'Gea', '1988/01/03', 'no', NULL);
INSERT INTO alumno VALUES(4, 'Lucía', 'Sánchez', 'Ortega', '1993/06/13', 'sí', 678516294);
INSERT INTO alumno VALUES(5, 'Paco', 'Martínez', 'López', '1995/11/24', 'no', 692735409);
INSERT INTO alumno VALUES(6, 'Irene', 'Gutiérrez', 'Sánchez', '1991/03/28', 'sí', NULL);
INSERT INTO alumno VALUES(7, 'Cristina', 'Fernández', 'Ramírez', '1996/09/17', 'no', 628349590);
INSERT INTO alumno VALUES(8, 'Antonio', 'Carretero', 'Ortega', '1994/05/20', 'sí', 612345633);
INSERT INTO alumno VALUES(9, 'Manuel', 'Domínguez', 'Hernández', '1999/07/08', 'no', NULL);
INSERT INTO alumno VALUES(10, 'Daniel', 'Moreno', 'Ruiz', '1998/02/03', 'no', NULL);

/* 1. Obtener el nombre y los apellidos de todos los alumnos en una única columna en minúscula.
2. Obtener el nombre y los apellidos de todos los alumnos en una única columna en mayúscula.
3. Obtener el nombre y los apellidos de todos los alumnos en una única columna. Cuando el segundo
apellido de un alumno sea NULL se devolverá el nombre y el primer apellido concatenados en
mayúscula, y cuando no lo sea, se devolverá el nombre completo concatenado tal y como aparece en la
tabla. */

-- 1
SELECT LOWER (CONCAT_WS (" ", nombre, apellido1, apellido2)) AS nombre_completo
FROM alumno;

-- 2
SELECT UPPER (CONCAT_WS (" ", nombre, apellido1, apellido2)) AS nombre_completo
FROM alumno;

-- 3
SELECT UPPER(CONCAT_WS (" ", nombre, apellido1)) AS nombre_completo
FROM alumno
WHERE apellido2 IS NULL;

-- primera forma de buscar con dos apellidos
SELECT nombre
FROM alumno
WHERE apellido1 = 'Sánchez' OR apellido1 = 'Martinez';
-- segunda forma
SELECT nombre
FROM alumno
WHERE apellido1 IN ('Sanchez', 'Martinez', 'Perez');

SELECT nombre, fecha_nacimiento
FROM alumno
WHERE fecha_nacimiento BETWEEN '1997-01-01' AND '1998-12-31';
-- apellidos que empiecen por S
SELECT nombre, apellido1
FROM alumno
WHERE apellido1 LIKE 'S%';

-- 7
SELECT * FROM alumno WHERE id = 1;
-- 8
SELECT * FROM alumno WHERE teléfono = 692735409;
-- 9
SELECT  nombre, apellido1, apellido2 FROM alumno WHERE es_repetidor = 'sí';
-- 10
SELECT  nombre, apellido1, apellido2 FROM alumno WHERE es_repetidor = 'no';
-- 11 
SELECT nombre, apellido1, apellido2 FROM alumno WHERE fecha_nacimiento <= '1993/01/01';
-- 12 
SELECT  nombre, apellido1, apellido2 FROM alumno WHERE fecha_nacimiento >= '1994/01/01';
-- 13
SELECT  nombre, apellido1, apellido2 FROM alumno WHERE fecha_nacimiento >= '1994/01/01' AND es_repetidor = 'no';
-- 14
SELECT  nombre, apellido1, apellido2 FROM alumno WHERE year (fecha_nacimiento) = '1998';
-- 15
SELECT * FROM alumno WHERE YEAR (fecha_nacimiento) <> '1998';
SELECT * FROM alumno WHERE fecha_nacimiento NOT BETWEEN '1998-01-01' AND '1998-12-31';
-- 16
SELECT * FROM alumno WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-12-31';
-- 17
SELECT * FROM alumno WHERE fecha_nacimiento NOT BETWEEN '1998-01-01' AND '1998-05-31';
-- 18
SELECT nombre AS 'nombre', REVERSE(nombre) AS 'nombre invertido' FROM alumno;
-- 19
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS NombreCompleto,
REVERSE (CONCAT_WS(' ', nombre, apellido1, apellido2)) AS NombreCompletoInvertido FROM alumno;
-- 20
SELECT UPPER(CONCAT_WS(' ', nombre, apellido1, apellido2)) AS 'Mayúsculas',
		LOWER (CONCAT_WS(' ', nombre, apellido1, apellido2)) AS 'Minúsculas' FROM alumno;
-- 21
SELECT CONCAT_WS(' ', nombre, apellido1, apellido2) AS 'nombre completo',
	CHAR_LENGTH(CONCAT_WS(' ', nombre, apellido1, apellido2)) AS 'Nº de caracterres',
    LENGTH(CONCAT_WS(' ', nombre, apellido1, apellido2)) AS 'Nº de bytes' FROM alumno;
-- 22
SELECT CONCAT_WS(' ', nombre, apellido1, apellido2) AS nombre_completo,
		LOWER(CONCAT(nombre, ' ', SUBSTRING_INDEX(apellido1, apellido2, ' ', 1), '@iescamp.es')) AS correo_electronico FROM alumno;
-- 23
SELECT CONCAT_WS(' ', nombre, apellido1, apellido2) AS nombre_completo,
		LOWER(CONCAT(nombre, ' ', SUBSTRING_INDEX(apellido1, apellido2, ' ', 1)), YEAR (fecha_nacimiento)) AS contraseña FROM alumno;
-- 24
SELECT fecha_nacimiento as 'Fecha de nacimiento',
		DAYNAME (fecha_nacimiento) as 'Nombre del día de la semana',
		DAY(fecha_nacimiento) AS 'Día',
		MONTNAME (fecha_nacimiento) as 'Nombre del mes',
        MONTH(fecha_nacimiento) AS 'Mes',
        YEAR(fecha_nacimiento) AS 'Año'
        FROM alumno;
-- 25 usando las funciones del 26
SELECT fecha_nacimiento AS 'Fecha de nacimiento',
		DAYNAME (fecha_nacimiento) as 'Nombre del día de la semana',
        MONTNAME (fecha_nacimiento) as 'Nombre del mes'
        FROM alumno;
-- 25 usando las funciones del 27
SELECT fecha_nacimiento AS 'Fecha de nacimiento',
		DATE_FORMAT (fecha_nacimiento, '%W') as 'Nombre del día de la semana',
        DATE_FORMAT (fecha_nacimiento, '%M') as 'Nombre del mes'
        FROM alumno;
-- 28
SELECT fecha_nacimiento AS 'Fecha de nacimiento',
		DATEDIFF(NOW(), fecha_nacimiento) AS 'Días entre fecha actual y la fecha de nacimiento'
		FROM alumno;
-- 29
SELECT fecha_nacimiento AS 'Fecha de nacimiento',
		TRUNCATE (DATEDIFF(NOW(), fecha_nacimiento)/365.25, 0) AS 'edad'
		FROM alumno;