ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    Citizen.Wait(0)
	end
end)

local isneu = false

RegisterNetEvent("isneu") 
AddEventHandler("isneu", function(neu)
    isneu = neu
end)

RegisterNetEvent("flughafentp") 
AddEventHandler("flughafentp", function(einreiseID)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    for k,v in pairs (Config.Einreise) do
        SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isneu then
            local playerPed = PlayerPedId()

            for k,v in pairs (Config.Einreise) do
                if GetDistanceBetweenCoords(GetEntityCoords(playerPed), v.x, v.y, v.z, true) < 250 then
                else
                    SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
                end
            end
        end
    end
end)

RegisterNetEvent("rein:teleport")
AddEventHandler("rein:teleport", function(coords)
    local x, y, z = table.unpack(coords)

    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, true)
end)

Citizen.CreateThread(function()
  SetDeepOceanScaler(0.0)
end)

---- Marker ----
RegisterNetEvent("flughafenmarkertp") 
AddEventHandler("flughafenmarkertp", function(xPlayer)
    local playerPed = PlayerPedId()
    local currentPos = GetEntityCoords(playerPed)

    for k,v in pairs (Config.Einreise) do
        SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    if Config.EnableMarker and Config.EnableAdmin then
        ESX.TriggerServerCallback('einreise:getGroup', function(Group)
            if Group ~= nil and (Group == 'mod' or Group == 'admin' or Group == 'superadmin') then
                return true
            end
        end)
        if true then
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local playerPed = PlayerPedId()
                    local plyCoords = GetEntityCoords(playerPed)

                    if Config.Draw3DText then
                        local distance = Vdist(plyCoords, -1082.56, -2827.46, 27.71)
            
                        if distance <= 10 then
                            DrawText3D(-1082.56, -2827.46, 27.71, _U('3dtext_admin'))
                        end
                    end
                end
            end)
        else
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local playerPed = PlayerPedId()
                    local plyCoords = GetEntityCoords(playerPed)

                    if Config.Draw3DText then
                        local distance2 = Vdist(plyCoords, -1082.56, -2827.46, 27.71)
            
                        if distance2 <= 10 then
                            DrawText3D(-1082.56, -2827.46, 27.71, _U('3dtext_noadmin'))
                        end
                    end

                    for k,v in pairs (Config.MarkerCoords) do
                        local distance = Vdist(plyCoords, v.x, v.y, v.z)
                        
                        if distance <= 30 then
                            DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                        end
                        if distance <= 10 then
                            DrawText3D(v.x, v.y, v.z + 1.0, _U('einreisen'))
                        end
                        if distance <= 1.5 then
                            if IsControlJustPressed(1, 38) then -- "E"
                                TriggerServerEvent('einreise:markertp')
                            end
                        end
                    end
                end
            end)
        end
    end
end)

if Config.EnableMarker and not Config.EnableAdmin then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)

            if Config.EnableCommand then
                RegisterCommand(Config.SetCommand, function()
                    TriggerEvent('einreise:setmarker')
                end)
            
                RegisterCommand(Config.DelCommand, function()
                    TriggerEvent('einreise:delMarker')
                end)
            else
                if Config.Draw3DText then
                    local distance2 = Vdist(plyCoords, -1082.56, -2827.46, 27.71)
                
                    if distance2 <= 10 then
                        DrawText3D(-1082.56, -2827.46, 27.71, _U('3dtext_noadmin'))
                    end
                end
                
                for k,v in pairs (Config.MarkerCoords) do
                    local distance = Vdist(plyCoords, v.x, v.y, v.z)
                    
                    if distance <= 30 then
                        DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                    end
                    if distance <= 10 then
                        DrawText3D(v.x, v.y, v.z + 1.0, _U('einreisen'))
                    end
                    if distance <= 1.5 then
                        if IsControlJustPressed(1, 38) then -- "E"
                            TriggerServerEvent('einreise:markertp')
                        end
                    end
                end
            end
        end
    end)
end

RegisterNetEvent("einreise:delMarker") 
AddEventHandler("einreise:delMarker", function(result)
    ESX.TriggerServerCallback('einreise:getMarker', function(result)
        
    end)
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.25, 0.25)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end