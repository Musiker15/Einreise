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
            local playerCoords = GetEntityCoords(playerPed)

            for k,v in pairs (Config.TPBackIn) do
                local coords = vector3(v.x, v.y, v.z)
                local distance = #(playerCoords - coords)
                
                if distance > Config.TPDisctance then
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

    for k,v in pairs (Config.Einreise) do
        SetEntityCoords(playerPed, v.x, v.y, v.z, false, false, false, true)
    end
end)

if Config.Marker.enable and not Config.Admin.enable then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)

            if Config.text3d.enable then
                local pos = Config.text3d.coords
                local dist = #(plyCoords - pos)
            
                if dist <= 10 then
                    ESX.Game.Utils.DrawText3D(pos, Translation[Config.Locale]['3dtext_noadmin'], Config.text3d.size)
                end
            end
            
            for k,v in pairs (Config.Marker.coords) do
                local coords = vector3(v.x, v.y, v.z)
                local position = vector3(v.x, v.y, v.z + 1.0)
                local distance = #(plyCoords - coords)
                
                if distance <= 30 then
                    DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                end

                if distance <= 10 then
                    ESX.Game.Utils.DrawText3D(position, Translation[Config.Locale]['einreisen'], Config.text3d.size)
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    if Config.Admin.enable then
        local playerPed = PlayerPedId()
        local xPlayer = ESX.IsPlayerLoaded(playerPed)
        local aGroup = 'user'
        Citizen.Wait(1000) -- Please Do Not Touch!
        
        if xPlayer then
            ESX.TriggerServerCallback('einreise:getGroup', function(adminGroup)
                for k, group in pairs(Config.Admin.admins) do
                    if group == adminGroup then
                        aGroup = adminGroup
                    end
                end
            end)

            Citizen.CreateThread(function()
                while true do
                    Wait(0)
                    local plyCoords = GetEntityCoords(playerPed)
        
                    if aGroup ~= 'user' then
                        if Config.text3d.enable then
                            local pos = Config.text3d.coords
                            local dist = #(plyCoords - pos)
                    
                            if dist <= 10 then
                                ESX.Game.Utils.DrawText3D(pos, Translation[Config.Locale]['3dtext_admin'], Config.text3d.size)
                            end
                        end
        
                        if Config.Marker.enable then
                            for k,v in pairs (Config.Marker.coords) do
                                local position = vector3(v.x, v.y, v.z + 1.0)
                                local coords = vector3(v.x, v.y, v.z)
                                local distance = #(plyCoords - coords)
                                
                                if distance <= 30 then
                                    DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                                end
        
                                if distance <= 10 then
                                    ESX.Game.Utils.DrawText3D(position, Translation[Config.Locale]['einreisen'], Config.text3d.size)
                                end
        
                                if distance <= 1.5 then
                                    if IsControlJustPressed(1, 38) then -- "E"
                                        TriggerServerEvent('einreise:markertp')
                                    end
                                end
                            end
                        end
                    else
                        if Config.text3d.enable then
                            local pos = Config.text3d.coords
                            local dist = #(plyCoords - pos)
                    
                            if dist <= 10 then
                                ESX.Game.Utils.DrawText3D(pos, Translation[Config.Locale]['3dtext_noadmin'], Config.text3d.size)
                            end
                        end
        
                        if Config.Admin.noAdminMarker then
                            for k,v in pairs (Config.Marker.coords) do
                                local position = vector3(v.x, v.y, v.z + 1.0)
                                local coords = vector3(v.x, v.y, v.z)
                                local distance = #(plyCoords - coords)
                                
                                if distance <= 30 then
                                    DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                                end
        
                                if distance <= 10 then
                                    ESX.Game.Utils.DrawText3D(position, Translation[Config.Locale]['einreisen'], Config.text3d.size)
                                end
        
                                if distance <= 1.5 then
                                    if IsControlJustPressed(1, 38) then -- "E"
                                        TriggerServerEvent('einreise:markertp')
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            debug('xPlayer not found')
        end
    end
end)

--[[ local aGroup = 'user'
if Config.Admin.enable then
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            ESX.TriggerServerCallback('einreise:getGroup', function(adminGroup)
                for k, group in pairs(Config.Admin.admins) do
                    if group == adminGroup then
                        aGroup = adminGroup
                    end
                end
            end)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            local playerPed = PlayerPedId()
            local plyCoords = GetEntityCoords(playerPed)

            debug('aGroup:')
            debug(aGroup)

            if aGroup ~= 'user' then
                --debug('hasGroup')
                if Config.text3d.enable then
                    local pos = Config.text3d.coords
                    local dist = #(plyCoords - pos)
            
                    if dist <= 10 then
                        ESX.Game.Utils.DrawText3D(pos, Translation[Config.Locale]['3dtext_admin'], Config.text3d.size)
                    end
                end

                if Config.Marker.enable then
                    for k,v in pairs (Config.Marker.coords) do
                        local position = vector3(v.x, v.y, v.z + 1.0)
                        local coords = vector3(v.x, v.y, v.z)
                        local distance = #(plyCoords - coords)
                        
                        if distance <= 30 then
                            DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                        end

                        if distance <= 10 then
                            ESX.Game.Utils.DrawText3D(position, Translation[Config.Locale]['einreisen'], Config.text3d.size)
                        end

                        if distance <= 1.5 then
                            if IsControlJustPressed(1, 38) then -- "E"
                                TriggerServerEvent('einreise:markertp')
                            end
                        end
                    end
                end
            else
                --debug('not hasGroup')
                if Config.text3d.enable then
                    local pos = Config.text3d.coords
                    local dist = #(plyCoords - pos)
            
                    if dist <= 10 then
                        ESX.Game.Utils.DrawText3D(pos, Translation[Config.Locale]['3dtext_noadmin'], Config.text3d.size)
                    end
                end

                if Config.Admin.noAdminMarker then
                    for k,v in pairs (Config.Marker.coords) do
                        local position = vector3(v.x, v.y, v.z + 1.0)
                        local coords = vector3(v.x, v.y, v.z)
                        local distance = #(plyCoords - coords)
                        
                        if distance <= 30 then
                            DrawMarker(1, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.201, 1.2001, 0.2001, 0, 0, 255, 200, 0, 0, 0, 0)
                        end

                        if distance <= 10 then
                            ESX.Game.Utils.DrawText3D(position, Translation[Config.Locale]['einreisen'], Config.text3d.size)
                        end

                        if distance <= 1.5 then
                            if IsControlJustPressed(1, 38) then -- "E"
                                TriggerServerEvent('einreise:markertp')
                            end
                        end
                    end
                end
            end
        end
    end)
end ]]

function debug(msg)
	if Config.Debug then
		print(msg)
	end
end