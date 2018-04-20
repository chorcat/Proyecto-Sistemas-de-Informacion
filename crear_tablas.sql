Drop table if exists Reservas;
Drop table if exists Define;
Drop table if exists Gradas;
Drop table if exists Eventos;
Drop table if exists Clientes;
Drop table if exists Participa;
Drop table if exists Espectaculos;
Drop table if exists Participantes;
Drop table if exists Recintos;
-- -----------------------------------------------------
-- Table mydb.Espectáculos
-- -----------------------------------------------------

CREATE TABLE  Espectaculos(Id_Espectaculo INT NOT NULL AUTO_INCREMENT,Descripcion VARCHAR(100) NOT NULL,
PRIMARY KEY (Id_Espectaculo)
  );
-- -----------------------------------------------------
-- Table mydb.Eventos
-- -----------------------------------------------------

CREATE TABLE Eventos(
  Id_Evento INT NOT NULL AUTO_INCREMENT,
  Fecha DATETIME NOT NULL,
  Tiempo_anul INT NOT NULL,
  Tiempo_penal INT NOT NULL,
  Penalizacion FLOAT NOT NULL,
  Estado ENUM('Abierto','Cerrado','Finalizado') NOT NULL DEFAULT 'Abierto',
  Id_Espectaculo INT NOT NULL,
  PRIMARY KEY (Id_Evento),
    FOREIGN KEY (Id_Espectaculo)
    REFERENCES Espectaculos (Id_Espectaculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
        );
-- -----------------------------------------------------
-- Table mydb.Participantes
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Participantes (
  Id_Participante INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(20) NOT NULL,
  PRIMARY KEY (Id_Participante)
  );
-- -----------------------------------------------------
-- Table mydb.Participa
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Participa (
  Id_Espectaculo INT NOT NULL,
  Id_Participante INT NOT NULL,
  Rol VARCHAR(30) NULL,
  PRIMARY KEY (Id_Espectaculo, Id_Participante),
    FOREIGN KEY (Id_Participante)
    REFERENCES Participantes (Id_Participante)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (Id_Espectaculo)
    REFERENCES Espectaculos (Id_Espectaculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table mydb.Clientes
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Clientes (
  Id_Cliente INT NOT NULL AUTO_INCREMENT,
  DatosPersonales VARCHAR(100) NOT NULL,
  DatosBancarios VARCHAR(100) NOT NULL,
  NombreUsuario VARCHAR(20) NULL,
  Contraseña VARCHAR(20) NOT NULL,
  PRIMARY KEY (Id_Cliente)
  );
-- -----------------------------------------------------
-- Table mydb.Recintos
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Recintos (
  Id_Recinto INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (Id_Recinto)
  );
-- -----------------------------------------------------
-- Table mydb.Gradas
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Gradas (
  Id_Grada INT NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(30) NULL,
  NumLocalidades INT NULL,
  Id_Recinto INT NOT NULL,
  PRIMARY KEY (Id_Grada),
      FOREIGN KEY (Id_Recinto)
    REFERENCES Recintos (Id_Recinto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
        );
-- -----------------------------------------------------
-- Table mydb.Define
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Define (
  Id_Evento INT NOT NULL,
  Id_Grada INT NOT NULL,
  PrecioJubilado FLOAT NULL,
  PrecioAdulto FLOAT NULL,
  PrecioInfantil FLOAT NULL,
  PrecioParado FLOAT NULL,
  PrecioBebe FLOAT NULL,
  NumLocalidadesLibres INT NULL DEFAULT NULL,
  NumLocalidadesReservadas INT NULL DEFAULT NULL,
  NumLocalidadesPrereservadas INT NULL DEFAULT NULL,
  NumLocalidadesDeterioradas INT NULL DEFAULT NULL,
  MaxCliente INT NOT NULL,
  PRIMARY KEY (Id_Evento, Id_Grada),
    FOREIGN KEY (Id_Evento)
    REFERENCES Eventos (Id_Evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (Id_Grada)
    REFERENCES Gradas (Id_Grada)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
        );
-- -----------------------------------------------------
-- Table mydb.Reserva
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Reservas (
  Id_Reserva INT NOT NULL AUTO_INCREMENT,
  Id_Cliente INT NOT NULL,
  HoraInsercion TIMESTAMP DEFAULT NOW(),
  Id_Evento INT NOT NULL,
  Id_Grada INT NOT NULL,
  NumEntradasJubilado INT NULL,
  NumEntradasAdulto INT NULL,
  NumEntradasInfantil INT NULL,
  NumEntradasParado INT NULL,
  NumEntradasBebe INT NULL,
  Reservada BOOLEAN NULL,
  PRIMARY KEY (Id_Reserva),
    FOREIGN KEY (Id_Cliente)
    REFERENCES Clientes (Id_Cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (Id_Grada , Id_Evento)
    REFERENCES Define (Id_Grada , Id_Evento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
        );

