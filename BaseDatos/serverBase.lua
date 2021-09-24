local db = dbConnect("sqlite", "BaseDatos/datosUsuario.db")

function ComprobarUsuario(sourcePlayer)
	cuenta = getPlayerAccount (sourcePlayer)
	local resultado = dbPoll(dbQuery(db, "SELECT * FROM Usuarios WHERE account_name=?", cuenta),-1)
	comprobado = false
	if #resultado == 0 then
		valorCompro = true
	else
		valorCompro = false
	end
	return valorCompro
end
addEvent( "ComprobarUsuario", true)
addEventHandler( "ComprobarUsuario", getRootElement(), ComprobarUsuario)

function AgregarUsuario(id_usuario, nombre, edad, sexo, id_skin)
	nombrecuenta = obtenerNombreCuenta(id_usuario)
	dbExec (db,"INSERT INTO Usuarios(acount_name, nombre, edad, sexo, id_skin) VALUES(?,?,?,?,?)", nombrecuenta, nombre, edad, sexo, id_skin)
	setElementPosition(id_usuario,-2379.021484375, -578.27734375, 132.11170959473, true)
	setElementModel(id_usuario,id_skin)
	setElementData(id_usuario,"NombrePersonaje",nombre)
	setElementData(id_usuario,"EdadPersonaje",edad)
	setElementData(id_usuario,"SexoPersonaje",sexo)
	setElementData(id_usuario,"IdSkinPersonaje",id_skin)
	modificarDataIdUsuario(id_usuario)
end
addEvent( "AgregarUsuario", true)
addEventHandler( "AgregarUsuario", getRootElement(), AgregarUsuario)

function modificarDataIdUsuario(id_usuario)
	nombrecuenta = obtenerNombreCuenta(id_usuario)
	local resultado = dbPoll(dbQuery(db, "SELECT * FROM Usuarios WHERE acount_name=?", nombrecuenta),-1)
	for i, _ in ipairs (resultado) do
		id_pers = resultado[i].id_usu
	end
	setElementData(id_usuario, "IdPersonaje", id_pers)
end

function obtenerPersonajes(sourcePlayer)
	nombre_cuenta = obtenerNombreCuenta(sourcePlayer)
	local check = dbQuery( db, "SELECT * FROM Usuarios where acount_name=?",nombre_cuenta )
	local results = dbPoll( check, -1 )
	if ( type( results ) == "table" and #results == 0 or not results )  then triggerClientEvent (sourcePlayer, "MostrarPanelSeleccionJugador", sourcePlayer) return end
end
addEvent( "obtenerPersonajes", true ) 
addEventHandler( "obtenerPersonajes", root, obtenerPersonajes )

function obtenerNombreCuenta(id_usuario)
	cuenta = getPlayerAccount ( id_usuario )
	nombre_cuenta = getAccountName (cuenta)
	return nombre_cuenta
end