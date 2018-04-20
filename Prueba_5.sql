\. reiniciar
\! echo "	PRUEBA 5:"
\! echo "	Un usuario registrado sin ninguna reserva activa, realiza una pre-reserva de 3 localidades, 2 de ellas adulto y 1 infantil para el evento"
\! echo "	con Id_Evento=1 y para la grada con Id_Grada=2. El usuario consulta sus reservas activas."
\! echo "	RESULTADO: Se muestra una reserva para el evento con Id_Evento=1 con las 3 localidades e indicando que no está pagada."
call IniciarSesion('Adri','cambiame');
call Prerreservar(1,2,0,2,1,0,0);
call ConsultarGradasDelEvento(1);
call ConsultarMisReservasActivas();
\! echo "	El mismo usuario realiza el pago y consulta nuevamente sus prereservas activas."
\! echo "	RESULTADO: Se muestra de nuevo la reserva para el evento anterior pero indicando que está pagada."
call PagarReserva(1);
call ConsultarGradasDelEvento(1);
call ConsultarMisReservasActivas();
