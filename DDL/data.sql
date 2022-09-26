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