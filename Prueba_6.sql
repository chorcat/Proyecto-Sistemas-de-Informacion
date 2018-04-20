\. reiniciar
\! echo "Un usuario registrado sin ninguna reserva activa realiza una prerreserva de 2 localidades para el evento con Id_Evento=3 y para la grada con Id_Grada=4."
\! echo "Dicho evento tiene como Tiempo_anul, 1 minuto. Pasado el minuto el usuario consulta sus reservas activas."
\! echo "Resultado: No se mostrarán ninguna reserva activa."
call IniciarSesion('Adri','cambiame');
call Prerreservar(3,4,0,1,0,1,0);
call ConsultarMisReservasActivas();
do sleep(65);
call ConsultarMisReservasActivas();
