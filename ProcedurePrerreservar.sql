DROP PROCEDURE IF EXISTS Prerreservar;
DELIMITER //
CREATE PROCEDURE Prerreservar(IN idEvento INT, IN idGrada INT, IN NumEntradasJubilado INT, IN NumEntradasAdulto INT, 
		IN NumEntradasInfantil INT, IN NumEntradasParado INT, IN NumEntradasBebe INT)
BEGIN
	DECLARE transaccionOK BOOLEAN DEFAULT TRUE;
	DECLARE aux2,total,totalPrerreserva,maximo,yaReservadas INT;
	DECLARE es VARCHAR(8);
	DECLARE ERROR_max, ERROR_cero, ERROR_estado, ERROR_clienteNOregistrado, ERROR_libres, ERROR_existe VARCHAR(100);
	DECLARE OK VARCHAR(100);
	DECLARE nuClienteActual VARCHAR(100);
	DECLARE aux varchar(500);
	DECLARE libres INT;
	DECLARE prereservadas INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET transaccionOK = FALSE;
	CALL BorradoAuto();
	CALL FinalizadoAuto();
	SET aux2=(SELECT COUNT(*) FROM Clientes A WHERE A.Id_Cliente=@CLIENTEACTUAL);
	SET nuClienteActual=(SELECT NombreUsuario FROM Clientes WHERE (Id_Cliente=@CLIENTEACTUAL));
	SET maximo=(SELECT maxCliente FROM Define WHERE (Id_Evento=idEvento AND Id_Grada=idGrada));
	SET yaReservadas=(SELECT SUM(Reservas.NumEntradasJubilado + Reservas.NumEntradasAdulto + Reservas.NumEntradasInfantil + Reservas.NumEntradasParado + Reservas.NumEntradasBebe) FROM Reservas WHERE (Id_Cliente=@CLIENTEACTUAL AND Id_Evento=idEvento AND Id_Grada=idGrada));
	IF (yaReservadas IS NULL) THEN
	   SET yaReservadas=0;
	END IF;
	SET totalPrerreserva=NumEntradasJubilado + NumEntradasAdulto + NumEntradasInfantil + NumEntradasParado + NumEntradasBebe;
	SET total=totalPrerreserva+yaReservadas;
	SET es=(SELECT Estado FROM Eventos WHERE Id_Evento=idEvento);
	SET libres=(SELECT NumLocalidadesLibres FROM Define WHERE (Id_Grada=idGrada AND Id_Evento=idEvento));
	SET prereservadas=(SELECT NumLocalidadesPrereservadas FROM Define WHERE (Id_Grada=idGrada AND Id_Evento=idEvento));
	SET libres=libres - totalPrerreserva;
	SET prereservadas=prereservadas + totalPrerreserva;
	SET ERROR_existe=CONCAT('El evento ',idEvento,' no tiene asociada la grada ',idGrada);
	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');	
	SET ERROR_estado=CONCAT('Lo sentimos ',nuClienteActual,', no se puede hacer ninguna reserva para este evento dado que no está abierto');
	SET ERROR_max=CONCAT('Lo sentimos ',nuClienteActual,', no puedes reservar más de ',maximo,' localidades para esta grada de este evento');
	SET ERROR_libres=CONCAT('Lo sentimos ',nuClienteActual,', solo quedan ',(totalPrerreserva+libres),' localidades libres para esta grada de este evento');
	SET ERROR_cero=CONCAT('Lo sentimos ',nuClienteActual,', debes reservar alguna localidad');
	SET OK=CONCAT('Su reserva se ha realizado con éxito');

	IF aux2>0 THEN
	      IF es!='Abierto' THEN SELECT ERROR_estado AS 'ERROR';
	      ELSEIF total > maximo THEN SELECT ERROR_max AS 'ERROR';
	      ELSEIF totalPrerreserva = 0 THEN SELECT ERROR_cero AS 'ERROR';
	      ELSEIF libres < 0 THEN SELECT ERROR_libres AS 'ERROR';
	      ELSE
			SET autocommit=0;
			START TRANSACTION;
			SET @aux=CONCAT('INSERT INTO Reservas(Id_Cliente, Id_Evento, Id_Grada, NumEntradasJubilado, NumEntradasAdulto, NumEntradasInfantil, NumEntradasParado, NumEntradasBebe, Reservada) VALUES(',@CLIENTEACTUAL,', ',idEvento,', ',idGrada,', ',NumEntradasJubilado,', ',NumEntradasAdulto,', ',NumEntradasInfantil,', ',NumEntradasParado,', ',NumEntradasBebe,', FALSE)');
			PREPARE variable FROM @aux;
			EXECUTE variable;
			SET @aux=CONCAT('UPDATE Define SET NumLocalidadesPrereservadas=',prereservadas,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			PREPARE variable FROM @aux;
			EXECUTE variable;
			SET @aux=CONCAT('UPDATE Define SET NumLocalidadesLibres=',libres,' WHERE (Id_Evento=',idEvento,' AND Id_Grada=',idGrada,')');
			PREPARE variable FROM @aux;
			EXECUTE variable;
			IF(transaccionOK=TRUE) THEN
			   SELECT OK AS 'PRERRESERVA';
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
