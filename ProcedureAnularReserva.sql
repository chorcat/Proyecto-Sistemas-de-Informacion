DROP PROCEDURE IF EXISTS AnularReserva;
DELIMITER //
CREATE PROCEDURE AnularReserva(IN idReserva INT)
BEGIN
	DECLARE transaccionOK BOOLEAN DEFAULT TRUE;
	DECLARE aux1, aux2, localidades,idEvento,idGrada INT;
	DECLARE yaPagada BOOLEAN;
	DECLARE ERROR_clienteNOregistrado, ERROR_finalizado, ERROR_existe VARCHAR(100);
	DECLARE OK VARCHAR(100);
	DECLARE fechaEvento DATETIME;
	DECLARE tiempoPenalizacion INT;
	DECLARE porcentajePenalizacion FLOAT;
	DECLARE nuClienteActual VARCHAR(100);
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET transaccionOK = FALSE;
	
	CALL BorradoAuto();
	CALL FinalizadoAuto();
	SET aux1=(SELECT COUNT(*) FROM Reservas WHERE Id_Cliente=@CLIENTEACTUAL AND Id_Reserva=idReserva);
	SET aux2=(SELECT COUNT(*) FROM Clientes A WHERE A.Id_Cliente=@CLIENTEACTUAL);
	SET nuClienteActual=(SELECT NombreUsuario FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));
	SET yaPagada=(SELECT Reservada FROM Reservas WHERE (Id_Reserva=idReserva AND Id_Cliente=@CLIENTEACTUAL));
	SET localidades=(SELECT SUM(Reservas.NumEntradasJubilado + Reservas.NumEntradasAdulto + Reservas.NumEntradasInfantil + Reservas.NumEntradasParado + Reservas.NumEntradasBebe) FROM Reservas WHERE (Id_Cliente=@CLIENTEACTUAL AND Id_Reserva=idReserva));
	SET idGrada=(SELECT Id_Grada FROM Reservas WHERE Id_Reserva=idReserva AND Id_Cliente=@CLIENTEACTUAL);
	SET idEvento=(SELECT Id_Evento FROM Reservas WHERE Id_Reserva=idReserva AND Id_Cliente=@CLIENTEACTUAL);
	SET fechaEvento=(SELECT Fecha FROM Reservas,Eventos WHERE Id_Reserva=idReserva AND Eventos.Id_Evento=Reservas.Id_Evento);
	SET tiempoPenalizacion=(SELECT Tiempo_penal FROM Reservas,Eventos WHERE Id_Reserva=idReserva AND Eventos.Id_Evento=Reservas.Id_Evento);
	SET porcentajePenalizacion=(SELECT Penalizacion FROM Reservas,Eventos WHERE Id_Reserva=idReserva AND Eventos.Id_Evento=Reservas.Id_Evento);

	SET ERROR_existe=CONCAT('No existe la reserva ',idReserva);
	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');	
	SET ERROR_finalizado=CONCAT('Lo sentimos ',nuClienteActual,', el evento ya ha comenzado y no puedes anular tu reserva');
	SET OK=CONCAT('La anulación se ha realizado con éxito');

	IF aux2>0 THEN
	   IF aux1=0 THEN SET transaccionOK=FALSE;
	   END IF;
	      IF (NOW()>fechaEvento) THEN SELECT ERROR_finalizado AS 'ERROR';
	      ELSE
			SET autocommit=0;
			START TRANSACTION;

	                IF (yaPagada=FALSE) THEN
			   SET @aux=CONCAT('UPDATE Define SET NumLocalidadesPrereservadas=NumLocalidadesPrereservadas-',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			   SET @aux=CONCAT('UPDATE Define SET NumLocalidadesLibres=NumLocalidadesLibres+',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			   SET @aux=CONCAT('DELETE FROM Reservas WHERE Id_Reserva=',idReserva,' AND Id_Cliente=',@CLIENTEACTUAL);
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			ELSE
			   SET @aux=CONCAT('UPDATE Define SET NumLocalidadesReservadas=NumLocalidadesReservadas-',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			   SET @aux=CONCAT('UPDATE Define SET NumLocalidadesLibres=NumLocalidadesLibres+',localidades,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			   SET @aux=CONCAT('DELETE FROM Reservas WHERE Id_Reserva=',idReserva,' AND Id_Cliente=',@CLIENTEACTUAL);
			   PREPARE variable FROM @aux;
			   EXECUTE variable;
			   IF (NOW() > (fechaEvento - INTERVAL tiempoPenalizacion MINUTE)) THEN
			      SET OK=CONCAT(OK,'. Se ha aplicado una penalizacion del ',porcentajePenalizacion,'%');
			   END IF;
			END IF;

			IF(transaccionOK=TRUE) THEN
			   SELECT OK AS 'ANULACIÓN';
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
