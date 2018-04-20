drop procedure if exists ModificarDatos;

delimiter //
CREATE PROCEDURE ModificarDatos(IN Usuario VARCHAR(20),IN Pass VARCHAR(20),IN DPersonales VARCHAR(100),IN DBancarios VARCHAR(100))
BEGIN
	DECLARE aux1,aux2 INT;
	DECLARE nuClienteActual VARCHAR(100);
	DECLARE ERROR_clienteNOregistrado VARCHAR(100);
	DECLARE ERROR_usuario VARCHAR(100);
	DECLARE OK VARCHAR(100);
	SET OK=CONCAT('Datos modificados con éxito');
	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');
	SET ERROR_usuario=CONCAT('Nombre de usuario en uso');
	SET aux1=(SELECT COUNT(*) FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));
        SET aux2=(SELECT COUNT(*) FROM Clientes A WHERE A.NombreUsuario=Usuario);
	SET nuClienteActual=(SELECT NombreUsuario FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));

        IF aux1>0 THEN
		IF (aux2>0 AND Usuario!=nuClienteActual) THEN
			SELECT ERROR_usuario AS 'ERROR';
		ELSE
			UPDATE Clientes SET DatosPersonales=DPersonales, DatosBancarios=DBancarios, NombreUsuario=Usuario, Contraseña=Pass WHERE Id_Cliente=@CLIENTEACTUAL;
			SELECT OK AS 'MODIFICACIÓN';
		END IF;
	ELSE
		SELECT ERROR_clienteNOregistrado;
	END IF;
END//

delimiter ;
