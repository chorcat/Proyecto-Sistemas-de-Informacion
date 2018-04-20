drop procedure if exists IniciarSesion;

delimiter //
CREATE PROCEDURE IniciarSesion(IN usuar VARCHAR(20),IN contr VARCHAR(20))
BEGIN
	DECLARE aux INT;
	DECLARE ERROR_login VARCHAR(100);
	DECLARE SESION_INICIADA VARCHAR(100);
        DECLARE ERROR_already_logged VARCHAR(100);
	SET ERROR_already_logged=CONCAT('Ya hay un usuario con la sesión iniciada. Por favor cierre una sesión antes de iniciar otra');
	SET ERROR_login=CONCAT('El usuario o la contraseña son incorrectos');
	SET SESION_INICIADA=CONCAT('El usuario ',usuar,' ha iniciado sesión correctamente');
	SET aux=(SELECT COUNT(*) FROM Clientes A WHERE (usuar=A.NombreUsuario AND contr=A.Contraseña));
	IF @CLIENTEACTUAL IS NULL THEN
	        IF aux>0 THEN
			SET @CLIENTEACTUAL=(SELECT Id_Cliente from Clientes C where usuar=C.NombreUsuario AND contr=C.Contraseña);
			SELECT SESION_INICIADA;
		ELSE
			SELECT ERROR_login as 'ERROR';
		END IF;
	ELSE
		SELECT ERROR_already_logged as 'ERROR';
	END IF;
	
END//

delimiter ;
