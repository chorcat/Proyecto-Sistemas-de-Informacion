DROP PROCEDURE IF EXISTS ConsultarEventosDisponibles;

delimiter //
CREATE PROCEDURE ConsultarEventosDisponibles()
BEGIN
CALL FinalizadoAuto();
SELECT DISTINCT Eventos.Id_Evento, Fecha,  Estado, Recintos.Nombre AS Recinto, Eventos.Id_Espectaculo
FROM Eventos,Espectaculos,Define,Gradas,Recintos
WHERE (Eventos.Id_Espectaculo=Espectaculos.Id_Espectaculo AND Estado='Abierto' AND Eventos.Id_Evento=Define.Id_Evento AND Define.Id_Grada=Gradas.Id_Grada AND Gradas.Id_Recinto=Recintos.Id_Recinto)
UNION
SELECT DISTINCT Eventos.Id_Evento, Fecha,  Estado, NULL AS Recinto, Eventos.Id_Espectaculo
FROM Espectaculos, Eventos
LEFT JOIN Define
ON Eventos.Id_Evento=Define.Id_Evento
WHERE (Eventos.Id_Espectaculo=Espectaculos.Id_Espectaculo AND Estado='Abierto' AND Define.Id_Evento IS NULL);

SELECT DISTINCT Eventos.Id_Espectaculo, Descripcion, Rol, Participantes.Id_Participante, Nombre
FROM Eventos,Espectaculos, Participa, Participantes
WHERE (Eventos.Id_Espectaculo=Espectaculos.Id_Espectaculo AND Estado='Abierto' AND Estado='Abierto' AND Espectaculos.Id_Espectaculo=Participa.Id_Espectaculo AND Participa.Id_Participante=Participantes.Id_Participante);
END//

delimiter ;
