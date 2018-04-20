\. reiniciar
\! echo "	PRUEBA 9:"
\! echo "	En la BD tenemos un evento con Id_Evento=1 con una grada asociada con Id_Grada=2 y con localidades libres."
\! echo "	Un usuario con Id_Cliente=2 y con sesión iniciada se desconecta. Ahora intenta realizar una prerreserva de una localidad"
\! echo "	adulto de la grada con Id_Grada=2 del evento con Id_Evento=1."
\! echo "	Resultado: La pre-reserva no se efectúa y se muestra un mensaje de error."
call IniciarSesion('Pablo','cambiame');
call ConsultarGradasDelEvento(1);
call Desconectarse();
call Prerreservar(1,2,0,1,0,0,0);
