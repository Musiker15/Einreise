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
                            TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", "Einreise", "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
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
        TriggerClientEvent('notifications', einreiseID, "#40fdfe", "Einreise", "Willkommen in Los Santos")
        TriggerClientEvent('notifications', source, "#40fdfe", "Einreise", "Du hast eine Person erfolgreich freigeschaltet")
        TriggerClientEvent('flughafentp', zPlayer.source)
        TriggerClientEvent("isneu", einreiseID, false) -- er darf wieder herumlaufen
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = zPlayer.identifier
        })
    else
        TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", "Keine Rechte")
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
		        TriggerClientEvent('notifications', xTarget.source, "#40fdfe", "Einreise", "Du befindest dich nun im Einreiseamt")
            else
		        TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", "Einreise", "Ungültige ID")
            end
        else
		    TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", "Einreise", "Keine Rechte")
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
		        TriggerClientEvent('notifications', xTarget.source, "#40fdfe", "Einreise", "Du hast das Einreiseamt verlassen")
            else
		        TriggerClientEvent('notifications',xPlayer.source, "#40fdfe", "Einreise", "Ungültige ID")
            end
        else
            TriggerClientEvent('notifications', xPlayer.source, "#40fdfe", "Einreise", "Keine Rechte")
        end
    end
end, false)

TriggerEvent('es:addCommand', 'stats', function(source, args, user)
    TriggerClientEvent("notifications", source, "#40fdfe", "Einreise", "Du bist " .. user.getGroup())
end)

---- Marker ----

ESX.RegisterServerCallback('einreise:getCommand', function(source, cb)
    local result = false
	cb(result)
end)

ESX.RegisterServerCallback('einreise:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
	cb(group or 'user')
end)

RegisterNetEvent('einreise:markertp')
AddEventHandler('einreise:markertp', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        TriggerClientEvent("notifications", xPlayer.source, "#40fdfe", "Einreise", "Willkommen in Los Santos")
        TriggerClientEvent('flughafenmarkertp', xPlayer.source)
        TriggerClientEvent("isneu", xPlayer.source, false) -- er darf wieder herumlaufen
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = xPlayer.identifier
        })
    end
end)

---- GitHub Updater ----
if Config.VersionChecker then
    function GetCurrentVersion()
        return GetResourceMetadata( GetCurrentResourceName(), "version" )
    end
    
    local CurrentVersion = GetCurrentVersion()
    local resourceName = "^4["..GetCurrentResourceName().."]^0"
    
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
end