drop procedure if exists Desconectarse;

delimiter //
CREATE PROCEDURE Desconectarse()
BEGIN
	DECLARE aux INT;
	DECLARE ERROR_clienteNOregistrado VARCHAR(100);
	DECLARE OK VARCHAR(100);
	SET OK=CONCAT('Se ha desconectado con éxito');
	SET ERROR_clienteNOregistrado=CONCAT('No hay ningún usuario con la sesión iniciada');
	SET aux=(SELECT COUNT(*) FROM Clientes A WHERE A.Id_Cliente=@CLIENTEACTUAL);
        IF aux>0 THEN
	   SELECT OK as 'DESCONEXIÓN';
	   SET @CLIENTEACTUAL=NULL;
	ELSE
	   SELECT ERROR_clienteNOregistrado as 'ERROR';
	END IF;
END//

delimiter ;
