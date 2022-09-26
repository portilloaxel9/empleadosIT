DELIMITER $$
CREATE PROCEDURE `ListarInformacionEmpleado`(
	IN empleado VARCHAR(255)
)
BEGIN
	SELECT 
		nombre_empleado AS 'Empleado',
		nombre_rol AS 'Rol',
		nombre_proyecto AS 'Proyecto asignado',
		nombre_cliente AS 'Cliente',
        horas_dia AS 'Horas x día',
        horas_semana AS 'Horas x semana'
	FROM 
		Empleado AS e
	INNER JOIN
		Rol AS r ON r.id_rol = e.rol
	INNER JOIN 
		Proyecto AS p ON p.id_proyecto = e.proyecto
	INNER JOIN
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE 
		e.nombre_empleado = empleado;
END; $$

DELIMITER $$
CREATE PROCEDURE `ListarInformacionCliente`(
	IN cliente VARCHAR(255)
)
BEGIN
	SELECT 
		nombre_cliente AS 'Cliente',
        COUNT(id_proyecto) AS 'Cantidad de proyectos'
	FROM 
		Cliente AS c
	INNER JOIN
		Proyecto AS p ON p.cliente = c.id_cliente
	WHERE 
		c.nombre_cliente = cliente
	GROUP BY nombre_cliente;
END; $$
    
DELIMITER $$
CREATE PROCEDURE `ListarHorasPorDiaCliente`(
	IN cliente VARCHAR(255)
)
BEGIN
	SELECT 
		nombre_cliente AS 'Cliente',
		SUM(horas_dia) AS 'Horas x día',
		id_proyecto AS 'N° de Proyecto'
	FROM 
		Empleado AS e
	INNER JOIN 
		Proyecto AS p ON p.id_proyecto = e.proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE cliente = c.nombre_cliente;
END; $$
    
DELIMITER $$
CREATE PROCEDURE `ListarHorasPorDiaProyecto`(
	IN proyecto INT
)
BEGIN
	SELECT 
		nombre_proyecto AS 'Proyecto',
		SUM(horas_dia) AS 'Horas x día',
		id_proyecto AS 'N° de proyecto',
		nombre_cliente AS 'Cliente'
	FROM 
		Proyecto AS p
	INNER JOIN 
		Empleado AS e ON e.proyecto = p.id_proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE proyecto = p.id_proyecto;
END; $$

DELIMITER $$
CREATE PROCEDURE `ListarHorasPorSemanaCliente`(
	IN cliente VARCHAR(255)
)
BEGIN
	SELECT 
		nombre_cliente AS 'Cliente',
		SUM(horas_semana) AS 'Horas x semana',
		id_proyecto AS 'N° de Proyecto'
	FROM 
		Empleado AS e
	INNER JOIN 
		Proyecto AS p ON p.id_proyecto = e.proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE 
		cliente = c.nombre_cliente;
END; $$
    
DELIMITER $$
CREATE PROCEDURE `ListarHorasPorSemanaProyecto`(
	IN proyecto INT
)
BEGIN
	SELECT 
		nombre_proyecto AS 'Proyecto',
		SUM(horas_semana) AS 'Horas x semana',
		id_proyecto AS 'N° de proyecto',
		nombre_cliente AS 'Cliente'
	FROM 
		Proyecto AS p
	INNER JOIN 
		Empleado AS e ON e.proyecto = p.id_proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE 
		proyecto = p.id_proyecto;
END; $$
    
DELIMITER $$
CREATE PROCEDURE `ListarHorasPorMesCliente`(
	IN cliente VARCHAR(255)
)
BEGIN
	SELECT 
		nombre_cliente AS 'Cliente',
		SUM(horas_mes) AS 'Horas x mes',
		id_proyecto AS 'N° de Proyecto',
		SUM(horas_mes)*12.50 AS 'Liquidacion Total en $USD' 
	FROM 
		Empleado AS e
	INNER JOIN 
		Proyecto AS p ON p.id_proyecto = e.proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE 
		cliente = c.nombre_cliente;
END; $$
    
DELIMITER $$
CREATE PROCEDURE `ListarHorasPorMesProyecto`(
	IN proyecto INT
)
BEGIN
	SELECT 
		nombre_proyecto AS 'Proyecto',
		SUM(horas_mes) AS 'Horas x mes',
		id_proyecto AS 'N° de proyecto',
		nombre_cliente AS 'Cliente'
	FROM 
		Proyecto AS p
	INNER JOIN 
		Empleado AS e ON e.proyecto = p.id_proyecto
	INNER JOIN 
		Cliente AS c ON c.id_cliente = p.cliente
	WHERE 
		proyecto = p.id_proyecto;
END; $$

DELIMITER $$
CREATE PROCEDURE `CargarHorasDia`(
    IN id INT,
    IN rol INT,
    IN proyecto INT,
    IN cantidad_horas INT
)
BEGIN
	UPDATE Empleado
    SET horas_dia = cantidad_horas, horas_semana = IFNULL(horas_semana, 0) + cantidad_horas, proyecto = proyecto, rol = rol
    WHERE id_empleado = id;
END; $$

DELIMITER $$
CREATE PROCEDURE `iniciar_empleadosIT`(
)
BEGIN
    insert into Rol value (1, "Project Manager");
	insert into Rol value (2, "Developer");
	insert into Rol value (3, "Tester");

	insert into Cliente values (1, "Google");
	insert into Cliente values (2, "Apple");
	insert into Cliente values (3, "Microsoft");
	insert into Cliente values (4, "Lenovo");

	insert into Proyecto values (6708, 1, "Google Analytics");
	insert into Proyecto values (6428, 1, "Google Components 2022");
	insert into Proyecto values (9342, 2, "Apple TV Implementation");
	insert into Proyecto values (1060, 3, "Microsoft Components");

	insert into Empleado values (001, 1, 6708, NULL, NULL, NULL, "Enzo Figueroa");
	insert into Empleado values (002, 2, 9342, NULL, NULL, NULL, "Camila Galarza");
	insert into Empleado values (003, 3, 1060,	NULL, NULL, NULL, "Pablo Gonzáles");
	insert into Empleado values (004, 2, 6708, NULL, NULL, NULL, "Cristian Lazzaro");
	insert into Empleado values (005, 2, 9342,	NULL, NULL, NULL, "Federico Sanz");
	insert into Empleado values (006, 2, 9342, NULL, NULL, NULL, "Pedro Berra");
	insert into Empleado values (007, 3, 1060, NULL, NULL, NULL, "Susana Galerna");
	insert into Empleado values (008, 2, 6708, NULL, NULL, NULL, "Gabriel Silva");
END; $$