DELIMITER $$
CREATE TRIGGER historial_cliente 
AFTER INSERT ON Cliente
FOR EACH ROW
BEGIN 
   INSERT INTO historial_cliente(nombre_cliente, fecha_inicio)
   VALUES (NEW.nombre_cliente, CURDATE());
END; $$

drop trigger historial_empleado;

DELIMITER $$
CREATE TRIGGER historial_empleado
AFTER UPDATE ON Empleado
FOR EACH ROW
BEGIN 
   INSERT INTO historial_empleado(nombre_empleado, rol, proyecto, horas_dia, fecha)
   VALUES (NEW.nombre_empleado, NEW.rol, NEW.proyecto, NEW.horas_dia, CURDATE());
END; $$