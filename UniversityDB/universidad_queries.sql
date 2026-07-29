USE universidad;
-- ----------------------------------------------------------------------------------------------------------
-- 1. Returns a list with the first surname, second surname and name of all students. The list must be sorted 
-- alphabetically from minor to major by first surname, second surname and first name.
-- ----------------------------------------------------------------------------------------------------------
SELECT 
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
WHERE persona.tipo = 'alumno'
ORDER BY persona.apellido1 ASC;
-- ----------------------------------------------------------------------------------------------------
-- 2. Returns the name and two surnames of students who have not registered their phone number at the 
-- database.
-- ----------------------------------------------------------------------------------------------------
SELECT
nombre,
apellido1,
apellido2
FROM persona 
WHERE 
persona.tipo = 'alumno'
AND
telefono IS NULL;

-- -----------------------------------------------------------------------------------------
-- 3. Returns the list of students born in 1999. (id, number, apellido1, apellido2, date)
-- -----------------------------------------------------------------------------------------
SELECT
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2,
fecha_nacimiento
FROM persona1
WHERE YEAR(fecha_nacimiento) = 1999;

-- ---------------------------------------------------------------------------------
-- 4. Returns the list of teachers who have not registered their phone number in the 
-- database and their NIF ends in K.
-- ---------------------------------------------------------------------------------
SELECT 
p.nombre,
p.apellido1,
p.apellido2,
p.nif
FROM persona p
WHERE p.tipo = 'profesor' AND
p.telefono IS NULL AND
p.nif LIKE '%K';

-- -----------------------------------------------------------------------
-- 5. Returns the list of the subjects given in the first semester, in the 
-- third year of the degree that has the identifier 7.
-- -----------------------------------------------------------------------
SELECT
a.id,
a.nombre,
a.cuatrimestre,
a.curso,
a.id_grado
FROM asignatura a
WHERE a.cuatrimestre = 1 
AND a.curso = 3
AND a.id_grado = 7;

-- -----------------------------------------------------------------------
-- 6. Returns a list of teachers together with the name of the department 
-- to which they are linked.
-- -----------------------------------------------------------------------
SELECT
p.apellido1,
p.apellido2,
p.nombre,
d.nombre AS 'departamento'
FROM persona p
JOIN profesor ON p.id = profesor.id_profesor
JOIN departamento d ON id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY p.apellido1 ASC;

-- -----------------------------------------------------------------------
-- 7. Returns a list with the name of the subjects, start year and end year 
-- of the student's school year with NIF 26902806M.
-- -----------------------------------------------------------------------
SELECT 
asignatura.nombre,
curso_escolar.anyo_inicio,
curso_escolar.anyo_fin
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
departamento.nombre
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
persona.nombre,
persona.apellido1,
persona.apellido2
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
departamento.nombre AS 'departamento',
persona.apellido1,
persona.apellido2,
persona.nombre
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
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.id IS NULL;

-- ----------------------------------------------------------------------
-- 12. Returns a list of departments that do not have associate teachers.
-- -----------------------------------------------------------------------
SELECT
departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_departamento IS NULL;

-- -----------------------------------------------------------------
-- 13. Returns a list with the teachers who do not teach any subject.
-- -----------------------------------------------------------------
SELECT
persona.apellido1,
persona.apellido2,
persona.nombre
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON  profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- --------------------------------------------------------------------
-- 14. Returns a list of subjects that do not have an assigned teacher.
-- --------------------------------------------------------------------
SELECT
asignatura.id,
asignatura.nombre
FROM asignatura
LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor
WHERE profesor.id_profesor IS NULL;

-- --------------------------------------------------------------------
-- 15. Returns a list of all departments that have not taught subjects 
-- in any school year.
-- --------------------------------------------------------------------
SELECT DISTINCT
departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id IS NULL
GROUP BY departamento.nombre;

-- ----------------------------------------------------
-- 16. Returns the total number of students that exist.
-- ----------------------------------------------------
SELECT COUNT(persona.id) AS 'total'
FROM persona
WHERE persona.tipo = 'alumno';

-- ---------------------------------------------------
-- 17. Calculates how many students were born in 1999.
-- ---------------------------------------------------
SELECT COUNT(persona.id) AS 'total'
FROM persona
WHERE
persona.tipo = 'alumno' AND
YEAR(persona.fecha_nacimiento) = 1999;

-- --------------------------------------------------------------
-- 18. Calculates how many teachers there are in each department.
-- --------------------------------------------------------------
SELECT 
departamento.nombre AS 'departamento',
COUNT(profesor.id_profesor) AS 'total'
FROM profesor
JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre
ORDER BY COUNT(profesor.id_profesor) DESC;

-- --------------------------------------------------------------------------------
-- 19. Returns a list of all departments and the number of teachers in each of them. 
-- Takes into account departments that do not have associate teachers.
-- --------------------------------------------------------------------------------
SELECT 
departamento.nombre AS 'departamento',
COUNT(profesor.id_profesor) AS 'total'
FROM profesor
RIGHT JOIN departamento ON profesor.id_departamento = departamento.id
GROUP BY departamento.nombre;
-- ---------------------------------------------------------------------------------------
-- 20. Returns a list with the name of all existing degrees in the database and the number 
-- of subjects each has. Keep in mind that there may be degrees that do not have associated 
-- subjects.
-- ---------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'grau',
COUNT(asignatura.id) AS 'total'
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY COUNT(asignatura.id) DESC;

-- -------------------------------------------------------------------------------------------
-- 21. Returns a list with the name of all the existing degrees in the database and the number 
-- of subjects that each one has, of the degrees that have more than 40 associated subjects.
-- -------------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'grau',
COUNT(asignatura.id) AS 'total'
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING COUNT(asignatura.id) > 40;

-- ------------------------------------------------------------------------------------------
-- 22. Returns a list that shows the name of the degrees and the sum of the total number of 
-- credits that exist for each type of subject. 
-- ------------------------------------------------------------------------------------------
SELECT
grado.nombre AS 'grau',
asignatura.tipo,
SUM(asignatura.creditos) AS 'total_creditos'
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo;

-- ----------------------------------------------------------------------------------
-- 23. Returns a list that shows how many students have enrolled in a subject in each 
-- of the school years. 
-- ----------------------------------------------------------------------------------
SELECT DISTINCT
curso_escolar.anyo_inicio,
COUNT(am.id_alumno) AS 'total'
FROM alumno_se_matricula_asignatura am
JOIN curso_escolar ON  am.id_curso_escolar = curso_escolar.id
JOIN asignatura ON am.id_asignatura = asignatura.id
GROUP BY 
curso_escolar.anyo_inicio, 
curso_escolar.anyo_fin,
asignatura.nombre;

-- --------------------------------------------------------------------
-- 24. Returns a list of the number of subjects taught by each teacher.
-- --------------------------------------------------------------------
SELECT
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2,
COUNT(asignatura.id) AS 'total'
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
GROUP BY
persona.id,
persona.nombre,
persona.apellido1,
persona.apellido2
ORDER BY COUNT(asignatura.id) DESC;

-- ---------------------------------------------
-- 25. Returns all data of the youngest student.
-- ---------------------------------------------
SELECT
p.id,
p.nif,
p.nombre,
p.apellido1,
p.apellido2,
p.ciudad,
p.direccion,
p.telefono,
p.fecha_nacimiento,
p.sexo,
p.tipo
FROM persona p
WHERE p.tipo = 'alumno' 
ORDER BY YEAR (p.fecha_nacimiento) DESC
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
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE persona.tipo = 'profesor'
AND
asignatura.id IS NULL;