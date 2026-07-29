USE tienda;
-- -----------------------------------------------------------------
-- 1. List the name of all products that exist in the product table.
-- -----------------------------------------------------------------
SELECT producto.nombre
FROM producto;
-- -----------------------------------------------------------------
-- 2. List the name and prices of all products in the product table.
-- -----------------------------------------------------------------
SELECT 
producto.nombre,
producto.precio
FROM producto;
-- ----------------------------------------------
-- 3. List all the columns of the product table.
-- ----------------------------------------------
SELECT 
producto.codigo,
producto.nombre,
producto.precio,
producto.codigo_fabricante
FROM producto;
-- -----------------------------------------------------------------
-- 4. List the name of the products, the price in euros and the  
-- price in american dollars with an exchange rate of 1€ = 1$.
-- -----------------------------------------------------------------
SELECT 
producto.nombre,
producto.precio AS 'precio_eur',
(producto.precio * 1) AS 'precio_usd'
FROM producto;
-- -----------------------------------------------------------------
-- 5. List the name of the products, the price in euros and the 
-- price in dollars, with an exchange rate of 1 to 1.1 Euro to Dollar.
-- ------------------------------------------------------------------
SELECT 
producto.nombre AS 'nom del producte',
producto.precio AS 'euros',
ROUND((producto.precio * 1.1), 2) AS 'dòlars'
FROM producto;
-- -----------------------------------------------------------------
-- 6. Lists the names and prices of all products in the 
-- product table, converting the names to uppercase.
-- -----------------------------------------------------------------
SELECT 
UPPER
(producto.nombre) AS 'nombre',
producto.precio
FROM producto;
-- -----------------------------------------------------------------
-- 7. Lists the names and prices of products 
-- in the producto table, converting the names to lowercase.
-- -----------------------------------------------------------------
SELECT 
LOWER
(producto.nombre) AS 'nombre',
producto.precio
FROM producto;
-- -----------------------------------------------------------------
-- 8. Lists the name of all manufacturers in one column, and in 
-- another column capitalizes the first two characters of the 
-- manufacturer's name.
-- -----------------------------------------------------------------
SELECT nombre,
UPPER(LEFT(nombre, 2)) AS 'iniciales'
FROM fabricante;
-- -----------------------------------------------------------------
-- 9. List product names and prices, rounding the price value.
-- -----------------------------------------------------------------
SELECT nombre,
ROUND(precio, 0) AS 'precio'
FROM producto;
-- -----------------------------------------------------------------
-- 10. Lists the names and prices of all products  in the product 
-- table, truncating the price value to show it without any decimal 
-- digits.
-- -----------------------------------------------------------------
SELECT nombre,
TRUNCATE(precio, 0) AS 'precio truncado'
FROM producto;
-- -----------------------------------------------------------------
-- 11. Displays a list of the manufacturer codes that appear in the 
-- product table, including possible repetitions.
-- -----------------------------------------------------------------
SELECT codigo_fabricante AS 'codigo_fabricante'
FROM producto
ORDER BY codigo_fabricante;
-- -----------------------------------------------------------------
-- 12. Lists the code of manufacturers who have products in the 
-- product table, eliminating repeated codes.
-- -----------------------------------------------------------------
SELECT DISTINCT codigo_fabricante AS 'codigo_fabricante'
FROM producto
ORDER BY codigo_fabricante;
-- --------------------------------------------------
-- 13. List names of manufacturers in ascending order
-- --------------------------------------------------
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;
-- ---------------------------------------------------
-- 13. List names of manufacturers in descending order
-- ---------------------------------------------------
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;
-- ------------------------------------------------------------
-- 15. Lists the names and prices of products sorted firstly by 
-- name in ascending order and, secondly, by price descending
-- order.
-- ------------------------------------------------------------
SELECT 
producto.nombre,
producto.precio
FROM producto
ORDER BY 
nombre ASC, 
precio DESC;

-- ------------------------------------------------------------------
-- 16. Returns a list with the first 5 rows of the manufacturer table.
-- ------------------------------------------------------------------
SELECT 
fabricante.codigo,
fabricante.nombre
FROM fabricante
LIMIT 5;
-- -----------------------------------------------------------
-- 17. Returns a list with 2 rows from the fourth row of the 
-- manufacturer table. The fourth row must also be included in 
-- the answer.
-- -----------------------------------------------------------
SELECT
fabricante.codigo,
fabricante.nombre
FROM fabricante
LIMIT 3, 2;
-- ---------------------------------------------------------------
-- 18. List the name and price of the cheapest product. (Uses only 
-- the ORDER BY and LIMIT clauses).
-- --------------------------------------------------------------- 
SELECT nombre,
precio
FROM producto
ORDER BY precio ASC
LIMIT 1;
-- ----------------------------------------------------------
-- 19. List the name and price of the most expensive product. 
-- (Uses only the ORDER BY and LIMIT clauses).
-- ----------------------------------------------------------
SELECT producto.nombre,
producto.precio
FROM producto
ORDER BY producto.precio DESC
LIMIT 1;
-- -----------------------------------------------------------
-- 20. List the name of all products of the manufacturer whose 
-- manufacturer code is equal to 2.
-- -----------------------------------------------------------
SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;
-- ------------------------------------------------------------------
-- 21. Returns a list with the product name, price and manufacturer 
-- name of all products in the database.
-- ------------------------------------------------------------------
SELECT producto.nombre,
precio,
fabricante.nombre AS 'nombre del fabricante'
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- ------------------------------------------------------------------
-- 22. List all products with name, price and manufacturer name, 
-- sorted alphabetically.
-- ------------------------------------------------------------------
SELECT 
producto.nombre,
producto.precio,
fabricante.nombre AS 'nombre del fabricante'
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre;
-- --------------------------------------------------------------------
-- 23. Returns a list with the product code, product name, manufacturer 
-- code and manufacturer name (manager number), of all  products in 
-- the database.
-- --------------------------------------------------------------------
SELECT 
producto.codigo,
producto.nombre,
codigo_fabricante AS 'codigo fabricante',
fabricante.nombre AS 'nombre fabricante'
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo;

-- --------------------------------------------------------------
-- 24. Returns the name, price and name of the manufacturer, the 
-- cheapest product.
-- --------------------------------------------------------------
SELECT
p.nombre,
p.precio,
f.nombre AS 'fabricant'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
ORDER BY precio ASC
LIMIT 1;

-- --------------------------------------------------------------
-- 25. Returns the name of the product, the price and the name of 
-- the manufacturer, of the most expensive product.
-- --------------------------------------------------------------
SELECT
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
ORDER BY precio DESC
LIMIT 1;

-- --------------------------------------------------------------
-- 26. Retorna una llista amb nom i preu de tots els productes 
-- del fabricant Lenovo.
-- --------------------------------------------------------------
SELECT
p.nombre,
p.precio
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- --------------------------------------------------------------
-- 27. Returns a list with name and price of all products of the 
-- manufacturer Crucial that have a price greater than 200€
-- --------------------------------------------------------------
SELECT 
producto.nombre,
producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE 
fabricante.nombre = 'Crucial' AND
precio > 200;

-- ---------------------------------------------------------------
-- 28. Returns a list with name, price and manufacturer name of all 
-- products from Asus, Hewlett-Packard and Seagate manufacturers. 
-- ---------------------------------------------------------------
SELECT 
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE 
f.nombre = 'Asus' OR 
f.nombre = 'Hewlett-Packard' OR 
f.nombre = 'Seagate';
-- ---------------------------------------------------------------
-- 29. Returns a list with name, price and manufacturer name of all 
-- products from Asus, Hewlett-Packard and Seagate manufacturers, 
-- using the IN operator.
-- ---------------------------------------------------------------
SELECT 
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE 
f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- -------------------------------------------------------------------
-- 30. Returns a list with the name, price and manufacturer name 
-- of the products, where the manufacturer name ends in the letter 'e'.
-- -------------------------------------------------------------------
SELECT
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e'; 

-- ---------------------------------------------------------------------
-- 31. Returns a list with the product name, price and manufacturer name, 
-- for all those products whose manufacturers contain the letter 'w' in 
-- their name.
-- ---------------------------------------------------------------------
SELECT
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- -------------------------------------------------------------------------------
-- 32. Returns a list with the name of the product, price and the name of 
-- the manufacturer, for all products with a price equal to or greater than a 180. 
-- Reesults sorted, first by the price in descending order and then by the product 
-- name in ascending order.
-- --------------------------------------------------------------------------------
SELECT
p.nombre,
p.precio,
f.nombre AS 'fabricante'
FROM producto p
JOIN fabricante f ON codigo_fabricante = f.codigo
WHERE precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- ---------------------------------------------------------------------
-- 33. Returns a list with the code and name of manufacturer, only those 
-- manufacturers who have associated products in the database.
-- ---------------------------------------------------------------------
SELECT DISTINCT
f.codigo,
f.nombre
FROM producto
JOIN fabricante f ON codigo_fabricante = f.codigo;

-- ---------------------------------------------------------------------
-- 34. Returns a list of all the manufacturers that exist in the database, 
-- along with the products that each of them has. It also includes the
-- manufacturers that don't have any product in the database.
-- ---------------------------------------------------------------------
SELECT
f.nombre AS 'fabricante',
p.nombre AS 'producto'
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- --------------------------------------------------------
-- 35. Returns a list where only the names of manufacturers 
-- that do not have any associated products appear.
-- --------------------------------------------------------
SELECT
f.nombre AS 'fabricante'
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.nombre IS NULL;

-- --------------------------------------------------------
-- 36. Returns all products from the manufacturer Lenovo. 
-- (No inner JOIN).
-- --------------------------------------------------------
SELECT
producto.codigo,
producto.nombre,
producto.precio,
producto.codigo_fabricante
FROM producto
WHERE codigo_fabricante = (
SELECT codigo
FROM fabricante
WHERE nombre = 'Lenovo'
);

-- --------------------------------------------------------------------------------
-- 37. Returns all data of products that have the same price as the most expensive 
-- product of the manufacturer Lenovo. (No INNER JOIN).
-- --------------------------------------------------------------------------------
SELECT
producto.codigo,
producto.nombre,
producto.precio,
producto.codigo_fabricante
FROM producto
WHERE precio = (
SELECT MAX(precio)
FROM producto
WHERE codigo_fabricante = (
SELECT codigo
FROM fabricante
WHERE nombre = 'Lenovo'
)
);

-- -------------------------------------------------------------------------
-- 38. List the name of the most expensive product from manufacturer Lenovo.
-- -------------------------------------------------------------------------
SELECT producto.nombre
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio DESC
LIMIT 1;

-- -----------------------------------------------------------
-- 39. List the name of the cheapest product from manufacturer 
-- Hewlett-Packard.
-- -----------------------------------------------------------
SELECT producto.nombre
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY producto.precio ASC
LIMIT 1;
-- ---------------------------------------------------------------
-- 40. Returns all products in the database that have a greater or 
-- equal price to the most expensive product of the manufacturer 
-- Lenovo.
-- ---------------------------------------------------------------
SELECT 
producto.codigo,
producto.nombre,
producto.precio,
producto.codigo_fabricante
FROM producto
WHERE precio > (
SELECT producto.precio
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio ASC
LIMIT 1
);

-- ------------------------------------------------------------
-- 41. List all Asus products that have a higher price than the 
-- average price of all their products.
-- ------------------------------------------------------------
SELECT 
producto.codigo,
producto.nombre,
producto.precio,
producto.codigo_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus'
AND producto.precio > (
SELECT AVG (producto.precio)
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus'
);