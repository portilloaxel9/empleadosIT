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
    insert into Rol (nombre_rol) value ("Project Manager");
	insert into Rol (nombre_rol) value ("Developer");
	insert into Rol (nombre_rol) value ("Tester");

	insert into Cliente (nombre_cliente) values ("Google");
	insert into Cliente (nombre_cliente) values ("Apple");
	insert into Cliente (nombre_cliente) values ("Microsoft");
	insert into Cliente (nombre_cliente) values ("Lenovo");

	insert into Proyecto (cliente, nombre_proyecto) values ((select id_cliente from cliente where nombre_cliente = "Google"), "Google Analytics");
	insert into Proyecto (cliente, nombre_proyecto) values ((select id_cliente from cliente where nombre_cliente = "Google"), "Google Components 2022");
	insert into Proyecto (cliente, nombre_proyecto) values ((select id_cliente from cliente where nombre_cliente = "Apple"), "Apple TV Implementation");
	insert into Proyecto (cliente, nombre_proyecto) values ((select id_cliente from cliente where nombre_cliente = "Microsoft"), "Microsoft Components");

	insert into Empleado (rol, proyecto, horas_dia, horas_semana, horas_mes, nombre_empleado) values (1, (select id_proyecto from proyecto where nombre_proyecto = "Google Analytics"), NULL, NULL, NULL, "Enzo Figueroa");
	insert into Empleado (rol, proyecto, horas_dia, horas_semana, horas_mes, nombre_empleado) values (2, (select id_proyecto from proyecto where nombre_proyecto = "Apple TV Implementation"), NULL, NULL, NULL, "Camila Galarza");
	insert into Empleado (rol, proyecto, horas_dia, horas_semana, horas_mes, nombre_empleado) values (3, (select id_proyecto from proyecto where nombre_proyecto = "Google Analytics"),	NULL, NULL, NULL, "Pablo Gonzáles");
	insert into Empleado (rol, proyecto, horas_dia, horas_semana, horas_mes, nombre_empleado) values (2, (select id_proyecto from proyecto where nombre_proyecto = "Google Components 2022"), NULL, NULL, NULL, "Cristian Lazzaro");
END; $$