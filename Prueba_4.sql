\. reiniciar
\! echo "	PRUEBA 4:"
\! echo "	Un usuario se registra en el sistema con el nombre “Lendoiro”, contraseña “Playa”, número teléfono “981787878” "
\! echo "	y número de tarjeta master-card “2121 2121 2121 2121”."
call Registrarse('Lendoiro','Playa','telefono: 981787878','tarjeta: master-card 2121 2121 2121 2121');
\! echo "	El usuario anterior inicia sesión con el nombre “Lendoiro” y contraseña “Playa”."
call IniciarSesion('Lendoiro','Playa');
\! echo "	El usuario “Lendoiro” modifica su contraseña para que sea “Celta”."
call ModificarDatos('Lendoiro','Celta','telefono: 981787878','tarjeta: master-card 2121 2121 2121 2121');
\! echo "	El usuario consulta sus datos."
\! echo "	RESULTADO: Se muestra por pantalla “Lendoiro” , “Celta”, “telefono: 981787878” y “tarjeta: master-card 2121 2121 2121 2121”."
call ConsultarDatos();
