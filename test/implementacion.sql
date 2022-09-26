use empleadosIT;

call iniciar_empleadosIT();

select *
from empleado;

select *
from historial_empleado;

call CargarHorasDia(2, 3, 1060, 8);
call CargarHorasDia(5, 3, 1060, 4);
call CargarHorasDia(2, 2, 9342, 6);
call CargarHorasDia(3, 3, 9342, 8);

Call ListarHorasPorDiaProyecto(9342);