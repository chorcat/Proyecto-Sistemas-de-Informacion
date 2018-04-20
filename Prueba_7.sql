\. reiniciar_2
\! echo "	PRUEBA 7:"
\! echo "	Un usuario registrado realiza una anulación sobre una reserva que ya tiene pagada del evento con Id_Evento=1, el"
\! echo "	estado de dicho evento es “Finalizado”."
\! echo "	Resultado: Se muestra un error indicando que no es posible la anulación."
call IniciarSesion('Adri','cambiame');
call ConsultarMisReservas();
call ConsultarEventos();
call AnularReserva(1);
call ConsultarMisReservas();
