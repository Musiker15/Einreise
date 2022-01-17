ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local xPlayerz = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local steamname = GetPlayerName(source)
    
    MySQL.Async.fetchAll('SELECT neu FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayerz.identifier}, function(result)
        if result[1] then
            local resultfrommysql = json.encode(result[1].neu)
            local resultfrommysql2 = result[1].neu

            if resultfrommysql2 == "1" then
                for i=1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    local group = xPlayer.getGroup()

                    if group == "mod" or group == "admin" or group == "superadmin" then
                        TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", _U('notification_header'), "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
                    end
                end
                TriggerClientEvent("isneu", source, true)
            elseif result[1].neu == "0" then
                TriggerClientEvent("isneu", source, false)
            end
        end
    end)
end)

RegisterCommand("einreise", function(source, args)
    local einreiseID = table.concat(args, " ")
    local xPlayer = ESX.GetPlayerFromId(source)
    local zPlayer = ESX.GetPlayerFromId(einreiseID)
    local group = xPlayer.getGroup()

    if group == "mod" or group == "admin" or group == "superadmin" then
        TriggerClientEvent('notifications', einreiseID, "#40fdfe", _U('notification_header'), _U('welcome'))
        TriggerClientEvent('notifications', source, "#40fdfe", _U('notification_header'), _U('admin_success'))
        TriggerClientEvent('flughafentp', zPlayer.source)
        TriggerClientEvent("isneu", einreiseID, false) -- er darf wieder herumlaufen
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = zPlayer.identifier
        })
    else
        TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", _U('notification_header'), _U('no_rights'))
    end
end)

RegisterCommand("rein", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)
    local group = xPlayer.getGroup()

    if xPlayer then    
        if group == "mod" or group == "admin" or group == "superadmin" then
            if xTarget then
		        TriggerClientEvent("rein:teleport", xTarget.source, Config.Position)
		        TriggerClientEvent('notifications', xTarget.source, "#40fdfe", _U('notification_header'), _U('rein'))
            else
		        TriggerClientEvent('notifications', xPlayer.source, "#ff0000", _U('notification_header'), _U('no_id'))
            end
        else
		    TriggerClientEvent('notifications', xPlayer.source, "#ff0000", _U('notification_header'), _U('no_rights'))
        end
    end
end, false)

RegisterCommand("raus", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)
    local group = xPlayer.getGroup()

    if xPlayer then    
        if group == "mod" or group == "admin" or group == "superadmin" then
            if xTarget then
		        TriggerClientEvent("rein:teleport", xTarget.source, Config.Position2)
		        TriggerClientEvent('notifications', xTarget.source, "#40fdfe", _U('notification_header'), _U('raus'))
            else
		        TriggerClientEvent('notifications',xPlayer.source, "#ff0000", _U('notification_header'), _U('no_id'))
            end
        else
            TriggerClientEvent('notifications', xPlayer.source, "#ff0000", _U('notification_header'), _U('no_rights'))
        end
    end
end, false)

---- Marker ----
RegisterNetEvent('einreise:markertp')
AddEventHandler('einreise:markertp', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        TriggerClientEvent("notifications", xPlayer.source, "#40fdfe", _U('notification_header'), _U('welcome'))
        TriggerClientEvent('flughafenmarkertp', xPlayer.source)
        TriggerClientEvent("isneu", xPlayer.source, false) -- er darf wieder herumlaufen
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = xPlayer.identifier
        })
    end
end)

ESX.RegisterServerCallback('einreise:getGroup', function(source, cb)
    --[[local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
	cb(group or 'user')]]

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local group = xPlayer.getGroup()
    
        cb(group or 'user')
    end
end)

ESX.RegisterServerCallback('einreise:getCommand', function(source, cb)
    local result = false
	cb(result)
end)

---- GitHub Updater ----
function GetCurrentVersion()
    return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

local CurrentVersion = GetCurrentVersion()
local resourceName = "^4["..GetCurrentResourceName().."]^0"

if Config.VersionChecker then    
    PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/Einreise/main/VERSION', function(Error, NewestVersion, Header)
        print("###############################")
        if CurrentVersion == NewestVersion then
	        print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
        elseif CurrentVersion ~= NewestVersion then
            print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
	        print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/Einreise/releases/tag/v'.. NewestVersion .. '^0')
        end
	    print("###############################")
    end)
else
    print("###############################")
	print(resourceName .. '^2 ✓ Resource loaded^0')
	print("###############################")
end