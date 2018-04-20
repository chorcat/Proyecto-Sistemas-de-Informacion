DROP PROCEDURE IF EXISTS BorradoAuto;
DELIMITER //
CREATE PROCEDURE BorradoAuto()
BEGIN

DECLARE finished int DEFAULT 0;
DECLARE idReserva INT;
DECLARE reservado BOOLEAN;
DECLARE tiempoAnul INT;
DECLARE hinsercion DATETIME;
DECLARE curs CURSOR FOR (SELECT Id_Reserva,Reservada,Tiempo_anul,HoraInsercion FROM Reservas,Eventos WHERE Eventos.Id_Evento=Reservas.Id_Evento);

declare continue handler for not found set finished=1;

open curs;

bucle: REPEAT
       fetch curs into idReserva,reservado,tiempoAnul,hinsercion;
       if(finished=1) then LEAVE bucle;
       end if;
       IF ((NOW() > (hinsercion + INTERVAL tiempoAnul MINUTE)) AND reservado=FALSE) THEN
       	  SET @aux=CONCAT('DELETE FROM Reservas WHERE Id_Reserva=',idReserva);
   	  PREPARE variable from @aux;
   	  EXECUTE variable;
       END if;
       UNTIL finished=1 end REPEAT;

close curs;

END//
DELIMITER ;
