USE universidad;
-- ----------------------------------------------------------------------------------------------------------
-- 1. Returns a list with the first surname, second surname and name of all students. The list must be sorted 
-- alphabetically from minor to major by first surname, second surname and first name.
-- ----------------------------------------------------------------------------------------------------------
SELECT 
apellido1 AS 'Apellido 1',
apellido2 AS 'Apellido 2',
nombre AS 'Nombre'
FROM persona;
-- ----------------------------------------------------------------------------------------------------
-- 2. Returns the name and two surnames of students who have not registered their phone number at the 
-- database.
-- ----------------------------------------------------------------------------------------------------
SELECT
nombre AS 'Nombre',
apellido1 AS 'Apellido 1',
apellido2 AS 'Apellido 2'
FROM persona 
WHERE telefono IS NULL;

-- -----------------------------------------------------------------------------------------
-- 3. Returns the list of students born in 1999. (id, number, apellido1, apellido2, date)
-- -----------------------------------------------------------------------------------------
SELECT
nombre AS 'Nombre',
apellido1 AS 'Apellido 1',
apellido2 AS 'Apellido 2',
nif AS 'NIF',
fecha_nacimiento AS 'Fecha Nacimiento'
FROM persona
WHERE YEAR(fecha_nacimiento) = 1999;

-- ---------------------------------------------------------------------------------
-- 4. Returns the list of teachers who have not registered their phone number in the 
-- database and their NIF ends in K.
-- ---------------------------------------------------------------------------------
SELECT 
nombre AS 'Nombre',
apellido1 AS 'Apellido'
FROM persona
WHERE tipo = 'profesor' AND
telefono IS NULL;

-- -----------------------------------------------------------------------
-- 5. Returns the list of the subjects given in the first semester, in the 
-- third year of the degree that has the identifier 7.
-- -----------------------------------------------------------------------
SELECT
nombre AS 'Asignatura'
FROM asignatura
WHERE cuatrimestre = 1;

