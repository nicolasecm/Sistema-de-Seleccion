addEventHandler("onPlayerLogin", root, 
function ()
	setElementData (source, "Cuenta", getAccountName(getPlayerAccount(source)))
	setTimer (function (source)
		local idP = getElementData(source, "IdPersonaje")
		local nP = getElementData(source, "NombrePersonaje")
		local eP = getElementData(source, "EdadPersonaje")
		local sP = getElementData(source, "SexoPersonaje")
		local idSP = getElementData(source, "IdSkinPersonaje")
		if idP and tonumber(idP) ~= nil then else
			setElementData  (source, "IdPersonaje", 0)
		end
		if nP == nil then 
			setElementData  (source, "NombrePersonaje", "")
		end
		if eP and tonumber(eP) ~= nil then else
			setElementData  (source, "EdadPersonaje", 0)
		end
		if sP == nil then 
			setElementData  (source, "SexoPersonaje", "")
		end
		if idSP and tonumber(idSP) ~= nil then else
			setElementData  (source, "IdSkinPersonaje", 0)
		end
	end, 1000, 1, source)
end)

function playerLoginFre (thePreviousAccount, theCurrentAccount, autoLogin)
  if  not (isGuestAccount (getPlayerAccount (source))) then
    local accountData = getAccountData (theCurrentAccount, "funmodev2-money")
    if (accountData) then
		local IdPersonaje = getAccountData(theCurrentAccount,"IdPersonaje")
		setElementData(source,"IdPersonaje",IdPersonaje)
		local NombrePersonaje = getAccountData(theCurrentAccount,"NombrePersonaje")
		setElementData(source,"NombrePersonaje",NombrePersonaje)
		local EdadPersonaje = getAccountData(theCurrentAccount,"EdadPersonaje")
		setElementData(source,"EdadPersonaje",EdadPersonaje)
		local SexoPersonaje = getAccountData(theCurrentAccount,"SexoPersonaje")
		setElementData(source,"SexoPersonaje",SexoPersonaje)
		local IdSkinPersonaje = getAccountData(theCurrentAccount,"IdSkinPersonaje")
		setElementData(source,"IdSkinPersonaje",IdSkinPersonaje)
	else
    end   
  end
end
addEventHandler ("onPlayerLogin", getRootElement(), playerLoginFre)

function onLogout ()
	kickPlayer (source, nil, "Logging out is disallowed.")
end
addEventHandler ("onPlayerLogout", getRootElement(), onLogout)

function onQuitFre (quitType, reason, responsibleElement)
  if not (isGuestAccount (getPlayerAccount (source))) then
    account = getPlayerAccount (source)
    if (account) then
		setAccountData (account, "funmodev2-money", tostring (getPlayerMoney (source)))
		local IdPersonaje = getElementData(source,"IdPersonaje")
		setAccountData (account,"IdPersonaje",IdPersonaje)
		local NombrePersonaje = getElementData(source,"NombrePersonaje")
		setAccountData (account,"NombrePersonaje",NombrePersonaje)
		local EdadPersonaje = getElementData(source,"EdadPersonaje")
		setAccountData (account,"EdadPersonaje",EdadPersonaje)
		local SexoPersonaje = getElementData(source,"SexoPersonaje")
		setAccountData (account,"SexoPersonaje",SexoPersonaje)
		local IdSkinPersonaje = getElementData(source,"IdSkinPersonaje")
		setAccountData (account,"IdSkinPersonaje",IdSkinPersonaje)
	end
  end
end
addEventHandler ("onPlayerQuit", getRootElement(), onQuitFre)