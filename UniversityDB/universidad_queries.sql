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

-- -----------------------------------------------------------------------
-- 6. Returns a list of teachers together with the name of the department 
-- to which they are linked.
-- -----------------------------------------------------------------------
SELECT
p.apellido1 AS 'Apellido 1',
p.apellido2 AS 'Apellido 2',
p.nombre AS 'Nombre',
d.nombre AS 'Departamento'
FROM profesor
JOIN departamento d ON id_departamento = d.id
JOIN persona p ON id_profesor = p.id
WHERE p.tipo = 'profesor';

-- -----------------------------------------------------------------------
-- 7. Returns a list with the name of the subjects, start year and end year 
-- of the student's school year with NIF 26902806M.
-- -----------------------------------------------------------------------
SELECT 
asignatura.nombre AS 'Asignatura',
curso_escolar.anyo_inicio AS 'Año inicio',
curso_escolar.anyo_fin AS 'Año fin'
FROM persona
JOIN alumno_se_matricula_asignatura ON id = id_alumno
JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE persona.nif = '26902806M';

-- -------------------------------------------------------------------------
-- 8. Returns a list with the name of all the departments that have teachers 
-- who teach a subject in the Degree in Computer Engineering
-- -------------------------------------------------------------------------
SELECT DISTINCT
departamento.nombre AS 'Departamento'
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- -----------------------------------------------------------------------
-- 9. Returns a list with all the students who have enrolled in a subject 
-- during the 2018/2019 school year.
-- -----------------------------------------------------------------------
SELECT DISTINCT
persona.nombre AS 'Nombre',
persona.apellido1 AS 'Apellido 1',
persona.apellido2 AS 'Apellido 2'
FROM persona
JOIN alumno_se_matricula_asignatura ON persona.id = id_alumno
JOIN curso_escolar ON id_curso_escolar = curso_escolar.id
WHERE
curso_escolar.anyo_inicio = '2018' AND
curso_escolar.anyo_fin = '2019'; 












