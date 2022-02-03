local ventanaActiva = false
SkinsH = {
        [1]={1},
        [2]={2},
        [3]={7}
}
SkinsM = {
        [1]={11},
        [2]={12},
        [3]={13}
}

local sx,sy = guiGetScreenSize()
local px,py = 1440,900
local x,y =  (sx/px), (sy/py)

function MostrarPanelSeleccionJugador()
	if ventanaActiva == false then
                toggleHud(false)
                ventanaActiva = true
                Sexo = "Sin Definir"
                skin_change = 1
                ped = createPed(2,209.58984375, -33.81640625, 1001.9296875,120)
                setElementDimension(ped,100)
                setElementInterior(ped,1)
                setElementDimension(localPlayer,100)
                setElementInterior(localPlayer,1)
                panelPrincipal = guiCreateStaticImage(x*956, y*115, x*372, y*597, "/Botones/PanelReg.png", false)
                Camb_Nombre = guiCreateEdit(x*30, y*185, x*311, y*38, "", false, panelPrincipal)
                bh_1 = guiCreateStaticImage(x*90, y*368, x*80, y*80, "/Botones/Hombre1.png", false, panelPrincipal)
                bm_1 = guiCreateStaticImage(x*195, y*368, x*80, y*80, "/Botones/Mujer1.png", false, panelPrincipal)
                change_s_izq = guiCreateStaticImage(x*108, y*475, x*39, y*40, "/Botones/Next4.png", false, panelPrincipal)
                change_s_der = guiCreateStaticImage(x*226, y*476, x*39, y*39, "/Botones/Next1.png", false, panelPrincipal)
                Camb_Edad = guiCreateEdit(x*30, y*277, x*311, y*38, "", false, panelPrincipal)
                BotonAceptar = guiCreateStaticImage(x*108, y*534, x*157, y*36, "/Botones/Aceptar1.png", false, panelPrincipal)  
                setCameraMatrix(207.57014465332, -35.351779937744, 1002.7646484375, 294.76565551758, 6.8229169845581, 977.90026855469)  
                showCursor(true)
                addEventHandler("onClientGUIClick", bh_1, function()
                        guiStaticImageLoadImage ( bh_1, "Botones/Hombre2.png")
                        guiStaticImageLoadImage ( bm_1, "Botones/Mujer1.png")
                        Sexo = "Masculino"
                        mostrarSkins(Sexo,ped)
                end, false)
                addEventHandler("onClientGUIClick", bm_1, function()
                        guiStaticImageLoadImage ( bh_1, "/Botones/Hombre1.png")
                        guiStaticImageLoadImage ( bm_1, "/Botones/Mujer2.png")
                        Sexo = "Femenino"
                        mostrarSkins(Sexo,ped)
                end, false)
                addEventHandler("onClientGUIClick", change_s_izq, function()
                        if Sexo ~= "Sin Definir" then
                                guiStaticImageLoadImage ( change_s_izq, "/Botones/Next3.png")
                                setTimer ( function()
                                        guiStaticImageLoadImage ( change_s_izq, "/Botones/Next4.png")
                                end, 200, 1 )
                                skin_change = cambiarSkin(Sexo,ped,"Restar", skin_change)
                        else
                                outputChatBox("[Server]#ffffffSelecciona un sexo primero", 255,0,0,true)  
                        end
                end, false)
                addEventHandler("onClientGUIClick", change_s_der, function()
                        if Sexo ~= "Sin Definir" then
                        guiStaticImageLoadImage ( change_s_der, "/Botones/Next2.png")
                        setTimer ( function()
                                guiStaticImageLoadImage ( change_s_der, "/Botones/Next1.png")
                        end, 200, 1 )
                        skin_change = cambiarSkin(Sexo,ped,"Sumar", skin_change)
                        else
                                outputChatBox("[Server]#ffffffSelecciona un sexo primero", 255,0,0,true)  
                        end
                end, false)
                addEventHandler("onClientGUIClick", BotonAceptar, function ()
                        if guiGetText(Camb_Nombre) ~= "" then
                                if guiGetText(Camb_Edad) ~= "" then
                                        guiStaticImageLoadImage ( BotonAceptar, "/Botones/Aceptar2.png")
                                        toggleHud(true)
                                        setCameraTarget (getLocalPlayer())
                                        setElementDimension(localPlayer,0)
                                        setElementInterior(localPlayer,0)
                                        showCursor(false)
                                        triggerServerEvent("AgregarUsuario",getLocalPlayer(),getLocalPlayer(),guiGetText(Camb_Nombre), guiGetText(Camb_Edad), Sexo, getElementModel(ped))
                                        destroyElement(panelPrincipal)
                                        else
                                        outputChatBox("[Server]#ffffffTiene que colocar una edad", 255,0,0,true)
                                end
                        else
                                outputChatBox("[Server]#ffffffTiene que colocar un nombre", 255,0,0,true)
                        end
                end, false)
	else
        outputChatBox("[Server]#ffffffTienes ya una ventana abierta", 255,0,0,true)
    end
end

addEvent( "MostrarPanelSeleccionJugador", true )
addEventHandler( "MostrarPanelSeleccionJugador", root, MostrarPanelSeleccionJugador)

function toggleHud(valor)
        setPlayerHudComponentVisible( "all", valor )
end

function mostrarSkins(Sexo,ped)
        if Sexo == "Masculino" then
                id_skin = SkinsH[1][1]
                setElementModel(ped,id_skin)
        else
                id_skin = SkinsM[1][1]
                setElementModel(ped,id_skin)
        end     
end

function cambiarSkin(Sexo,ped,valor,valEmpz)
        if Sexo == "Masculino" then
                empz = getModifiSkin(SkinsH,valEmpz,valor)
                id_skin = SkinsH[empz][1]
        else    
                empz = getModifiSkin(SkinsM,valEmpz,valor)
                id_skin = SkinsM[empz][1]
        end
        setElementModel(ped,id_skin)
        return empz
end

function getModifiSkin(arreglo,empz,valor)
        cantidad = getCantObjetos (arreglo)
        if (valor == "Restar") then
                if (empz ~= 1) then
                        empz = empz - 1
                end
        end
        if (valor == "Sumar") then
                if (empz ~= cantidad) then
                        empz = empz + 1
                end      
        end
        return empz
end

function getCantObjetos(resultados)
        cantidad = 0
        for i, _ in ipairs (resultados) do
                cantidad = cantidad + 1
        end
        return cantidad
end