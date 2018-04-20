DROP PROCEDURE IF EXISTS Registrarse;

delimiter //
CREATE PROCEDURE Registrarse(IN Usuario VARCHAR(20),IN Pass VARCHAR(20),IN DPersonales VARCHAR(100),IN DBancarios VARCHAR(100))
BEGIN
	DECLARE aux INT;
	DECLARE ERROR_usuario VARCHAR(100);
	DECLARE OK VARCHAR(100);
	SET OK=CONCAT('Se ha registrado con éxito');
        SET ERROR_usuario=CONCAT('Nombre de usuario en uso');
	SET aux=(SELECT COUNT(*) FROM Clientes A WHERE A.NombreUsuario=Usuario);
        IF aux>0 THEN
		SELECT ERROR_usuario AS 'ERROR';
	ELSE
		INSERT INTO Clientes(DatosPersonales, DatosBancarios, NombreUsuario, Contraseña) VALUES (DPersonales,DBancarios,Usuario,Pass);
		SELECT OK as 'REGISTRADO';
	END IF;
END//

delimiter ;
