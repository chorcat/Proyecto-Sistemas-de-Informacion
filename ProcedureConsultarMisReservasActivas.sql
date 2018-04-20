DROP PROCEDURE IF EXISTS ConsultarMisReservasActivas;

delimiter //
CREATE PROCEDURE ConsultarMisReservasActivas()
BEGIN
	DECLARE aux1,aux2 INT;
	DECLARE ERROR_Consulta VARCHAR(100);
	DECLARE ERROR_clienteNOregistrado VARCHAR(100);
	CALL BorradoAuto();
	CALL FinalizadoAuto();
	SET ERROR_Consulta=CONCAT('No tienes reservas activas');
	SET ERROR_clienteNOregistrado=CONCAT('Operación no permitida para clientes no registrados');
	SET aux1=(SELECT COUNT(*) FROM Reservas,Eventos WHERE Reservas.Id_Cliente=@CLIENTEACTUAL AND Reservas.Id_Evento=Eventos.Id_Evento AND Eventos.Estado='Abierto');
	SET aux2=(SELECT COUNT(*) FROM Clientes A WHERE A.Id_Cliente=@CLIENTEACTUAL);
        IF aux2>0 THEN
        	IF aux1>0 THEN
			SELECT Id_Reserva, Reservas.Id_Evento, Id_Grada, NumEntradasJubilado AS 'Jubilado', NumEntradasAdulto AS 'Adulto', NumEntradasInfantil AS 'Infantil', NumEntradasParado AS 'Parado', NumEntradasBebe AS 'Bebe', Reservada
			FROM Reservas,Eventos WHERE Reservas.Id_Cliente=@CLIENTEACTUAL AND Reservas.Id_Evento=Eventos.Id_Evento AND Eventos.Estado='Abierto';
		ELSE
			SELECT ERROR_Consulta AS 'ERROR';
		END IF;
	ELSE
		SELECT ERROR_clienteNOregistrado AS 'ERROR';
	END IF;
END//

delimiter ;
