
insert into Participantes(Nombre) values ('adrian');
insert into Participantes(Nombre) values ('martin');
insert into Participantes(Nombre) values ('pablo');
insert into Participantes(Nombre) values ('adrian');
insert into Participantes(Nombre) values ('jim');
insert into Recintos(Nombre) values ('Balaidos');
insert into Recintos(Nombre) values ('Coliseum A Coruna');
insert into Recintos(Nombre) values ('Teatro Afundacion de Vigo');
insert into Espectaculos(Descripcion) values ('Partido liga Adelante Celta-DeporB');
insert into Espectaculos(Descripcion) values ('Musical');
insert into Espectaculos(Descripcion) values ('Combate de boxeo');
insert into Eventos(Fecha, Tiempo_anul, Tiempo_penal, Penalizacion, Id_Espectaculo) values ('2015-05-7 20:45:00', 5, 2, 20, 1);
insert into Eventos(Fecha, Tiempo_anul, Tiempo_penal, Penalizacion, Id_Espectaculo, Estado) values ('2015-05-7 11:17:00', 2, 5, 20, 2, 'Cerrado');
insert into Eventos(Fecha, Tiempo_anul, Tiempo_penal, Penalizacion, Id_Espectaculo) values ('2015-05-7 13:30:00', 5, 1, 20, 3);
insert into Participa(Id_Espectaculo, Id_Participante, Rol) values (1, 1, 'jugador');
insert into Participa(Id_Espectaculo, Id_Participante, Rol) values (1, 2, 'jugador');
insert into Participa(Id_Espectaculo, Id_Participante, Rol) values (2, 3, 'tenor');
insert into Participa(Id_Espectaculo, Id_Participante, Rol) values (1, 4, 'entrenador');
insert into Participa(Id_Espectaculo, Id_Participante, Rol) values (3, 5, 'boxeador');
insert into Clientes(DatosPersonales, DatosBancarios, NombreUsuario, Contraseña) values ('misDatos','misDatosBancarios','Adri','cambiame');
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Rio Alto', 2000, 1);
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Tribuna', 100, 1);
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Gol', 5000, 1);
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Suelo', 2500, 2);
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Anfiteatro', 50, 3);
insert into Gradas(Nombre, NumLocalidades, Id_Recinto) values ('Normal', 150, 3);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (1, 1, 40, 70, 35, 30, 10, 5, 1800, 0, 0, 200);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (1, 2, 50, 80, 45, 40, 20, 5, 90, 0, 9, 1);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (1, 3, 20, 60, 25, 15, 2, 5, 5000, 0, 0, 0);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (2, 5, 50, 80, 45, 40, 20, 5, 50, 0, 0, 0);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (2, 6, 25, 40, 20, 20, 2.5, 5, 150, 0, 0, 0);
insert into Define(Id_Evento,Id_Grada, PrecioJubilado, PrecioAdulto, PrecioInfantil, PrecioParado, PrecioBebe, MaxCliente, NumLocalidadesLibres, NumLocalidadesPrereservadas, NumLocalidadesReservadas, NumLocalidadesDeterioradas) values (3, 4, 40, 70, 35, 30, 10, 20, 10, 0, 1890, 100);
insert into Reservas(Id_Cliente,Id_Evento,Id_Grada,NumEntradasJubilado,NumEntradasAdulto,NumEntradasInfantil,NumEntradasParado,NumEntradasBebe,Reservada) values (1,1,2,1,1,0,1,1,1);
insert into Reservas(Id_Cliente,Id_Evento,Id_Grada,NumEntradasJubilado,NumEntradasAdulto,NumEntradasInfantil,NumEntradasParado,NumEntradasBebe,Reservada) values (1,1,3,1,0,0,1,0,1);
