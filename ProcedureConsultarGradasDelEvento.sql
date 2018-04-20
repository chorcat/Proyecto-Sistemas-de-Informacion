DROP PROCEDURE IF EXISTS ConsultarGradasDelEvento;

delimiter //
CREATE PROCEDURE ConsultarGradasDelEvento(IN IdEvento INT)
BEGIN
        DECLARE aux INT;
	DECLARE ERROR_evento varchar(100);
        SET ERROR_evento=CONCAT('El evento no existe');
	SET aux=(SELECT COUNT(*) FROM Define A, Gradas B WHERE (A.Id_Evento=IdEvento AND A.Id_Grada=B.Id_Grada));
        IF aux>0 THEN
		SELECT A.Id_Grada, B.Nombre, A.NumLocalidadesLibres as Libres, A.NumLocalidadesReservadas as Reservadas, A.NumLocalidadesPrereservadas as Prerreservadas, A.NumLocalidadesDeterioradas as Deterioradas, A.PrecioJubilado, A.PrecioAdulto, 
		A.PrecioInfantil, A.PrecioParado, A.PrecioBebe, MaxCliente
		from Define A, Gradas B where A.Id_Evento=IdEvento AND A.Id_Grada=B.Id_Grada;
	ELSE
		SELECT ERROR_evento;
	END IF;
END//

delimiter ;
