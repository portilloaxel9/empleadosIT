create table Rol (
	id_rol int NOT NULL,
    nombre_rol varchar(255) NOT NULL,
    primary key (id_rol)
);

create table Cliente (
	id_cliente int NOT NULL,
	nombre_cliente varchar(255),
    primary key (id_cliente),
    index(nombre_cliente)
);

create table Proyecto (
	id_proyecto int NOT NULL,
    cliente int NOT NULL,
    nombre_proyecto varchar(255),
    primary key (id_proyecto),
    foreign key (cliente) references Cliente(id_cliente)
);

create table Empleado (
	id_empleado int NOT NULL,
    rol int NOT NULL,
    proyecto int,
    horas_dia int,
    horas_semana int,
    horas_mes int,
    nombre_empleado varchar(255),
    primary key (id_empleado),
	foreign key (rol) references Rol(id_rol),
	foreign key (proyecto) references Proyecto(id_proyecto),
    index(nombre_empleado)
);

create table historial_cliente (
	nombre_cliente varchar(255),
    fecha_inicio date
);

create table historial_empleado (
	nombre_empleado varchar(255),
    rol int,
    proyecto int,
    horas_dia int,
    fecha date
);