USE tienda;
-- -----------------------------------------------------------------
-- 1. List the name of all products that exist in the product table.
-- -----------------------------------------------------------------
SELECT producto.nombre AS Nombre 
FROM producto;
-- -----------------------------------------------------------------
-- 2. List the name and prices of all products in the product table.
-- -----------------------------------------------------------------
SELECT 
producto.nombre AS Nombre,
producto.precio AS Precio
FROM producto;
-- ----------------------------------------------
-- 3. List all the columns of the product table.
-- ----------------------------------------------
SELECT *
FROM producto;
-- -----------------------------------------------------------------
-- 4. List the name of the products, the price in euros and the  
-- price in american dollars with an exchange rate of 1€ = 1$.
-- -----------------------------------------------------------------
SELECT 
producto.nombre AS Nombre,
producto.precio AS 'Precio (€)',
(producto.precio * 1) AS 'Precio ($)'
FROM producto;
-- -----------------------------------------------------------------
-- 5. List the name of the products, the price in euros and the 
-- price in dollars, with an exchange rate of 1 to 1.1 Euro to Dollar.
-- ------------------------------------------------------------------
SELECT 
producto.nombre AS Nombre,
producto.precio AS 'Precio (€)',
ROUND((producto.precio * 1.1), 2) AS 'Precio ($)'
FROM producto;
-- -----------------------------------------------------------------
-- 6. Lists the names and prices of all products in the 
-- product table, converting the names to uppercase.
-- -----------------------------------------------------------------
SELECT 
UPPER
(producto.nombre) AS Producto,
producto.precio
FROM producto;
-- -----------------------------------------------------------------
-- 7. Lists the names and prices of products 
-- in the producto table, converting the names to lowercase.
-- -----------------------------------------------------------------
SELECT 
LOWER
(producto.nombre) AS Producto,
producto.precio
FROM producto;
-- -----------------------------------------------------------------
-- 8. Lists the name of all manufacturers in one column, and in 
-- another column capitalizes the first two characters of the 
-- manufacturer's name.
-- -----------------------------------------------------------------
SELECT nombre AS Nombre,
UPPER(LEFT(nombre, 2)) AS 'Initial'
FROM fabricante;
-- -----------------------------------------------------------------
-- 9. List product names and prices, rounding the price value.
-- -----------------------------------------------------------------
SELECT nombre as Nombre,
ROUND(precio, 0) AS 'Precio redeado'
FROM producto;
-- -----------------------------------------------------------------
-- 10. Lists the names and prices of all products  in the product 
-- table, truncating the price value to show it without any decimal 
-- digits.
-- -----------------------------------------------------------------
SELECT nombre as Nombre,
TRUNCATE(precio, 0) AS 'Precio truncado'
FROM producto;
-- -----------------------------------------------------------------
-- 11. Displays a list of the manufacturer codes that appear in the 
-- product table, including possible repetitions.
-- -----------------------------------------------------------------
SELECT codigo AS 'Código del fabricante'
FROM producto;
-- -----------------------------------------------------------------
-- 12. Lists the code of manufacturers who have products in the 
-- product table, eliminating repeated codes.
-- -----------------------------------------------------------------
SELECT DISTINCT codigo AS 'Código del fabricante'
FROM producto;
-- --------------------------------------------------
-- 13. List names of manufacturers in ascending order
-- --------------------------------------------------
SELECT nombre as 'Nombre del fabricante (↑)'
FROM fabricante
ORDER BY nombre ASC;
-- ---------------------------------------------------
-- 13. List names of manufacturers in descending order
-- ---------------------------------------------------
SELECT nombre as 'Nombre del fabricante (↓)'
FROM fabricante
ORDER BY nombre DESC;
-- ------------------------------------------------------------
-- 15. Lists the names and prices of products sorted firstly by 
-- name in ascending order and, secondly, by price descending
-- order.
-- ------------------------------------------------------------
SELECT 
nombre as 'Producto',
precio as 'Precio'
FROM producto
ORDER BY 
nombre ASC, 
precio DESC;

-- ------------------------------------------------------------------
-- 16. Returns a list with the first 5 rows of the manufacturer table.
-- ------------------------------------------------------------------
SELECT *
FROM fabricante
LIMIT 5;
-- -----------------------------------------------------------
-- 17. Returns a list with 2 rows from the fourth row of the 
-- manufacturer table. The fourth row must also be included in 
-- the answer.
-- -----------------------------------------------------------
SELECT *
FROM fabricante
LIMIT 3, 2;
-- ---------------------------------------------------------------
-- 18. List the name and price of the cheapest product. (Uses only 
-- the ORDER BY and LIMIT clauses).
-- --------------------------------------------------------------- 
SELECT nombre AS 'Producto mas económico',
precio
FROM producto
ORDER BY precio ASC
LIMIT 1;
-- ----------------------------------------------------------
-- 19. List the name and price of the most expensive product. 
-- (Uses only the ORDER BY and LIMIT clauses).
-- ----------------------------------------------------------
SELECT nombre AS 'Producto mas caro', 
precio
FROM producto
ORDER BY precio DESC
LIMIT 1;
-- -----------------------------------------------------------
-- 20. List the name of all products of the manufacturer whose 
-- manufacturer code is equal to 2.
-- -----------------------------------------------------------
SELECT nombre AS 'Productos Código 2'
FROM producto
WHERE codigo_fabricante = 2;
-- ------------------------------------------------------------------
-- 21. Returns a list with the product name, price and manufacturer 
-- name of all products in the database.
-- ------------------------------------------------------------------
SELECT producto.nombre AS 'Producto',
precio AS 'Precio',
fabricante.nombre AS 'Nombre fabricante'
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- ------------------------------------------------------------------
-- 22. List all products with name, price and manufacturer name, 
-- sorted alphabetically.
-- ------------------------------------------------------------------
SELECT 
producto.nombre AS 'Producto',
precio AS 'Precio',
fabricante.nombre AS 'Fabricante'
FROM producto
JOIN fabricante ON codigo_fabricante = fabricante.codigo
ORDER BY producto.nombre;






