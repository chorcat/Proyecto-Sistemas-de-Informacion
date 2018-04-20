\. reiniciar_4
\! echo "	PRUEBA 1:"
\! echo "	Un usuario registrado intenta hacer una reserva de 7 localidades en un evento con Id_evento=1 para una grada con MaxCliente=5."
\! echo "	RESULTADO: La Pre-reserva no se efectua y se muestra un mensaje de error."
call IniciarSesion('Adri','cambiame');
call ConsultarEventos();
call ConsultarGradasDelEvento(1);
call Prerreservar(1,2,2,1,3,1,0);
\! echo "	El mismo usuario intenta ahora reservar 3 localidades en un evento Id_Evento=2 con solo 1 localidad libre."
\! echo "	RESULTADO: La pre-reserva no se efectúa y se muestra un mensaje de error."
call ConsultarGradasDelEvento(2);
call Prerreservar(2,5,0,0,3,0,0);

