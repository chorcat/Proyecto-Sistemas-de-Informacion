\. reiniciar
\! echo "	PRUEBA 2:"
\! echo "	En el sistema se encuentran 3 eventos, 2 de ellos abiertos y 1 cerrado.Un cliente no registrado en el sistema consulta los eventos disponibles."
\! echo "	RESULTADO: Se mostrarán los 2 eventos abiertos."
call ConsultarEventosDisponibles();
\! echo "	A continuación, consulta el historial de eventos."
\! echo "	RESULTADO: Se muestran los 3 eventos del sistema."
call ConsultarEventos();
