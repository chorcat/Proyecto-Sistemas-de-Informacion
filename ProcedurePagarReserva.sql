DROP PROCEDURE IF EXISTS PagarReserva;
DELIMITER //
CREATE PROCEDURE PagarReserva(IN idReserva INT)
BEGIN
	DECLARE transaccionOK BOOLEAN DEFAULT TRUE;
	DECLARE aux1, aux2, localidades,idEvento,idGrada INT;
	DECLARE yaPagada BOOLEAN;
	DECLARE ERROR_clienteNOregistrado, ERROR_pagada, ERROR_existe VARCHAR(100);
	DECLARE OK VARCHAR(100);
	DECLARE nuClienteActual VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET transaccionOK = FALSE;
	
	CALL BorradoAuto();	
	SET aux1=(SELECT COUNT(*) FROM Reservas WHERE Id_Cliente=@CLIENTEACTUAL AND Id_Reserva=idReserva);
	SET aux2=(SELECT COUNT(*) FROM Clientes A WHERE A.Id_Cliente=@CLIENTEACTUAL);
	SET nuClienteActual=(SELECT NombreUsuario FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));
	SET yaPagada=(SELECT Reservada FROM Reservas WHERE (Id_Reserva=idReserva AND Id_Cliente=@CLIENTEACTUAL));
	SET localidades=(SELECT SUM(Reservas.NumEntradasJubilado + Reservas.NumEntradasAdulto + Reservas.NumEntradasInfantil + Reservas.NumEntradasParado + Reservas.NumEntradasBebe) FROM Reservas WHERE (Id_Cliente=@CLIENTEACTUAL AND Id_Reserva=idReserva));
	SET idGrada=(SELECT Id_Grada FROM Reservas WHERE Id_Reserva=idReserva);
	SET idEvento=(SELECT Id_Evento FROM Reservas WHERE Id_Reserva=idReserva);
	
	SET ERROR_existe=CONCAT('No existe la reserva ',idReserva);
	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');	
	SET ERROR_pagada=CONCAT('Lo sentimos ',nuClienteActual,', esa reserva ya ha sido pagada');
	SET OK=CONCAT('El pago se ha realizado con éxito');

	IF aux2>0 THEN
	   IF aux1=0 THEN SET transaccionOK=FALSE;
	   END IF;
	      IF (yaPagada=TRUE) THEN SELECT ERROR_pagada AS 'ERROR';
	      ELSE
			SET autocommit=0;
			START TRANSACTION;
			SET @aux=CONCAT('UPDATE Reservas SET Reservada=TRUE WHERE Id_Cliente=',@CLIENTEACTUAL,' AND Id_Reserva=',idReserva);
			PREPARE variable FROM @aux;
			EXECUTE variable;
			SET @aux=CONCAT('UPDATE Define SET NumLocalidadesReservadas=NumLocalidadesReservadas+',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			PREPARE variable FROM @aux;
			EXECUTE variable;
			SET @aux=CONCAT('UPDATE Define SET NumLocalidadesPrereservadas=NumLocalidadesPrereservadas-',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			PREPARE variable FROM @aux;
			EXECUTE variable;
			IF(transaccionOK=TRUE) THEN
			   SELECT OK AS 'PAGO';
			   COMMIT;
			ELSE
			   SELECT ERROR_existe AS 'ERROR';			
			   ROLLBACK;
			END IF;
			SET autocommit=1;
	END IF;
	ELSE
		SELECT ERROR_clienteNOregistrado AS 'ERROR';
	END IF;
END//
DELIMITER ;
