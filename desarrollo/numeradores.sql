SET foreign_key_checks = 0;
ALTER TABLE Rol MODIFY COLUMN id_rol INT NOT NULL;

ALTER TABLE Cliente MODIFY COLUMN id_cliente INT NOT NULL;

ALTER TABLE Proyecto MODIFY COLUMN id_proyecto INT NOT NULL;

ALTER TABLE Empleado MODIFY COLUMN id_empleado INT NOT NULL;

/*CREO LA TABLA NUMERADOR PARA ALMACENAR EL VALOR DEL SIGUIENTE ID DE LAS DIFERENTES TABLAS*/
create table Numerador (
	tabla varchar(255) NOT NULL,
    siguiente int NOT NULL,
    unique key (tabla)
);

/*INSERTO EL VALOR 1 QUE SERÁ EL PRIMER VALOR PARA EL ID DE TODAS LAS TABLAS*/
INSERT INTO Numerador Values ('Rol', 1);
INSERT INTO Numerador Values ('Cliente', 1);
INSERT INTO Numerador Values ('Proyecto', 1);
INSERT INTO Numerador Values ('Empleado', 1);

/*CREO LOS DIFERENTES TRIGGERS PARA CADA TABLA PARA QUE CUANDO OCURRA UN INSERT PUEDA PONER EL ID CORRECTO EN LA FILA*/
DELIMITER $$
CREATE TRIGGER autoincrement_rol 
/*USO 'BEFORE' PORQUE LA COLUMNA ID ES NOT NULL, NECESITA UN VALOR ANTES DE INSERTARSE LA FILA*/
BEFORE INSERT ON Rol
FOR EACH ROW
BEGIN 
    /*SETEO EL ID CON EL VALOR SIGUIENTE DE LA TABLA NUMERADOR, EN ESTE CASO BUSCO 'ROL'*/
   SET NEW.id_rol = (SELECT siguiente FROM Numerador WHERE tabla = 'Rol');
    /*ACTUALIZO EL VALOR SIGUIENTE DE LA TABLA ROL CON EL NÚMERO QUE LE SIGUE*/
   UPDATE Numerador
   SET siguiente = siguiente + 1
   WHERE tabla = 'Rol';
END; $$

DELIMITER $$
CREATE TRIGGER autoincrement_cliente 
BEFORE INSERT ON Cliente
FOR EACH ROW
BEGIN 
   SET NEW.id_cliente = (SELECT siguiente FROM Numerador WHERE tabla = 'Cliente');
   UPDATE Numerador
   SET siguiente = siguiente + 1
   WHERE tabla = 'Cliente';
END; $$

DELIMITER $$
CREATE TRIGGER autoincrement_proyecto 
BEFORE INSERT ON Proyecto
FOR EACH ROW
BEGIN 
   SET NEW.id_proyecto = (SELECT siguiente FROM Numerador WHERE tabla = 'Proyecto');
   UPDATE Numerador
   SET siguiente = siguiente + 1
   WHERE tabla = 'Proyecto';
END; $$

DELIMITER $$
CREATE TRIGGER autoincrement_empleado 
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN 
   SET NEW.id_empleado = (SELECT siguiente FROM Numerador WHERE tabla = 'Empleado');
   UPDATE Numerador
   SET siguiente = siguiente + 1
   WHERE tabla = 'Empleado';
END; $$
