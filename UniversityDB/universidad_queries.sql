USE universidad;
-- ----------------------------------------------------------------------------------------------------------
-- 1. Returns a list with the first surname, second surname and name of all students. The list must be sorted 
-- alphabetically from minor to major by first surname, second surname and first name.
-- ----------------------------------------------------------------------------------------------------------
SELECT 
apellido1,
apellido2,
nombre
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

-- -----------------------------------------------------------------------
-- 10. Returns a list with the names of all the teachers and departments 
-- they have linked. Also returns teachers with no department linked
-- -----------------------------------------------------------------------
SELECT
departamento.nombre AS 'Departamento',
persona.apellido1 AS 'Apellido 1',
persona.apellido2 AS 'Apellido 2',
persona.nombre AS 'Nombre'
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY 
departamento.nombre, 
persona.apellido1,
persona.apellido2;

-- -----------------------------------------------------------------------
-- 11. Returns a list of teachers who are not associated with a department.
-- -----------------------------------------------------------------------
SELECT
persona.apellido1 AS 'Apellido 1',
persona.apellido2 AS 'Apellido 2',
persona.nombre AS 'Nombre'
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.id IS NULL;

-- ----------------------------------------------------------------------
-- 12. Returns a list of departments that do not have associate teachers.
-- -----------------------------------------------------------------------
SELECT
departamento.nombre AS 'Departamento'
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_departamento IS NULL;

-- -----------------------------------------------------------------
-- 13. Returns a list with the teachers who do not teach any subject.
-- -----------------------------------------------------------------
SELECT
persona.apellido1 AS 'Apellido 1',
persona.apellido2 AS 'Apellido 2',
persona.nombre AS 'Nombre profesor'
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON  profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- --------------------------------------------------------------------
-- 14. Returns a list of subjects that do not have an assigned teacher.
-- --------------------------------------------------------------------
SELECT
asignatura.nombre AS 'Asignatura'
FROM asignatura
LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor
WHERE profesor.id_profesor IS NULL;

-- --------------------------------------------------------------------
-- 15. Returns a list of all departments that have not taught subjects 
-- in any school year.
-- --------------------------------------------------------------------
SELECT DISTINCT
departamento.nombre AS 'Departamento'
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id IS NULL;

-- ----------------------------------------------------
-- 16. Returns the total number of students that exist.
-- ----------------------------------------------------
SELECT COUNT(*) AS 'Total alumnos'
FROM persona
WHERE persona.tipo = 'alumno';

-- ----------------------------------------------
-- 17. Calcula quants alumnes van néixer en 1999.
-- ----------------------------------------------
SELECT COUNT(*) AS 'Alumnos nacidos en 1999'
FROM persona
WHERE
persona.tipo = 'alumno' AND
YEAR(persona.fecha_nacimiento) = 1999;

-- --------------------------------------------------------------
-- 18. Calculates how many teachers there are in each department.
-- --------------------------------------------------------------
SELECT 
departamento.nombre AS 'Departamento',
COUNT(profesor.id_profesor) AS 'Total profesores'
FROM profesor
JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre
ORDER BY COUNT(profesor.id_profesor) DESC;

-- --------------------------------------------------------------------------------
-- 19. Returns a list of all departments and the number of teachers in each of them. 
-- Takes into account departments that do not have associate teachers.
-- --------------------------------------------------------------------------------
SELECT 
departamento.nombre AS 'Departamento',
COUNT(profesor.id_profesor) AS 'Total profesores'
FROM profesor
RIGHT JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre
ORDER BY COUNT(profesor.id_profesor) DESC;

-- ---------------------------------------------------------------------------------------
-- 20. Returns a list with the name of all existing degrees in the database and the number 
-- of subjects each has. Keep in mind that there may be degrees that do not have associated 
-- subjects.
-- ---------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'Grado',
COUNT(asignatura.id) AS 'Total asignaturas (↓)'
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY COUNT(asignatura.id) DESC;

-- -------------------------------------------------------------------------------------------
-- 21. Returns a list with the name of all the existing degrees in the database and the number 
-- of subjects that each one has, of the degrees that have more than 40 associated subjects.
-- -------------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'Grado',
COUNT(asignatura.id) AS 'Total asignaturas'
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING COUNT(asignatura.id) > 40;

-- ------------------------------------------------------------------------------------------
-- 22. Returns a list that shows the name of the degrees and the sum of the total number of 
-- credits that exist for each type of subject. 
-- ------------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'Grado',
asignatura.tipo AS 'Tipo asignatura',
SUM(asignatura.creditos) AS 'Total créditos'
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo;

-- ----------------------------------------------------------------------------------
-- 23. Returns a list that shows how many students have enrolled in a subject in each 
-- of the school years. 
-- ----------------------------------------------------------------------------------
SELECT
curso_escolar.anyo_inicio AS 'Año inicio curso',
curso_escolar.anyo_fin AS 'Año fin curso',
asignatura.nombre AS 'Asignatura',
COUNT(persona.id) AS 'Alumnos'
FROM persona
JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
JOIN curso_escolar ON  alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
GROUP BY curso_escolar.id, asignatura.id;

-- --------------------------------------------------------------------
-- 24. Returns a list of the number of subjects taught by each teacher.
-- --------------------------------------------------------------------
SELECT
persona.id AS 'ID Profesor',
persona.nombre AS 'Nombre',
persona.apellido1 AS 'Primer apellido',
persona.apellido2 AS 'Segundo apellido',
COUNT(asignatura.id) AS 'Total asignaturas'
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
GROUP BY
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2
ORDER BY persona.id;

-- ---------------------------------------------
-- 25. Returns all data of the youngest student.
-- ---------------------------------------------
SELECT *
FROM persona
WHERE persona.tipo = 'alumno' 
ORDER BY YEAR (persona.fecha_nacimiento) DESC
LIMIT 1;

-- ----------------------------------------------------------------------
-- 26. Returns a list with the teachers who have an associated department 
-- and do not teach any subject.
-- ----------------------------------------------------------------------
SELECT
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE persona.tipo = 'profesor'
AND
asignatura.id IS NULL;


















