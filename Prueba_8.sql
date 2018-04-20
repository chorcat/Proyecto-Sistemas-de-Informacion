\. reiniciar_3
\! echo "	PRUEBA 8:"
\! echo "	Un usuario registrado tiene una reserva ya pagada de 4 localidades para el evento con Id_Evento=1 y en la grada"
\! echo "	con Id_Grada =2, y otra reserva también pagada de 2 localidades para el evento con Id_Evento=1 y en la grada con Id_Grada=3."
\! echo "	Realiza una anulación de la reserva para la Id_Grada =2. Consulta su reservas activas."
\! echo "	RESULTADO: Se mostrará una reserva para el evento Id_Evento=1 y para la grada Id_Grada=3."
call IniciarSesion('Adri','cambiame');
call ConsultarMisReservas();
call AnularReserva(1);
call ConsultarMisReservasActivas();
