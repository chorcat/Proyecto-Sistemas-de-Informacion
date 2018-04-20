drop procedure if exists ConsultarDatos;

delimiter //
CREATE PROCEDURE ConsultarDatos()
BEGIN
	DECLARE aux INT;
	DECLARE ERROR_clienteNOregistrado VARCHAR(100);
   	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');
	SET aux=(SELECT COUNT(*) FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));
	IF aux>0 THEN	
		SELECT NombreUsuario, Contraseña, DatosPersonales, DatosBancarios from Clientes where Clientes.Id_Cliente=@CLIENTEACTUAL;
	ELSE
		SELECT ERROR_clienteNOregistrado as 'ERROR';
	END IF;
END//

delimiter ;
