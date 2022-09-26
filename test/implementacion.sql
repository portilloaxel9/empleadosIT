use empleadosIT;

call iniciar_empleadosIT();

select *
from Empleado;

select *
from historial_empleado;

select *
from Numerador;

call CargarHorasDia(4, 3, 1, 8);
call CargarHorasDia(3, 3, 1, 8);

Call ListarHorasPorDiaProyecto(1);