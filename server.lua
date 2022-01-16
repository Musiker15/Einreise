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
                        if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" then
                            TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
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

    if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        TriggerClientEvent('notifications', einreiseID, "#ff0000", "Du bist nun freigeschaltet")
        TriggerClientEvent('notifications', source, "#ff0000", "Du hast eine Person erfolgreich freigeschaltet")
        TriggerClientEvent('flughafentp', zPlayer.source)
        TriggerClientEvent("isneu", einreiseID, false) -- er darf wieder herumlaufen
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = zPlayer.identifier
        })
    else
        TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Keine Rechte")
    end
end)

RegisterCommand("rein", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)

    if xPlayer then    
        if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if xTarget then
		TriggerClientEvent("rein:teleport", xTarget.source, Config.Position)
		TriggerClientEvent('notifications', xTarget.source, "#ff0000", "Du befindest dich nun im Einreiseamt")
            else
		TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Ungültige ID")
            end
        else
		TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Keine Rechte")
        end
    end
end, false)

RegisterCommand("raus", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)            
    local targetSource = args[1]
    local xTarget = ESX.GetPlayerFromId(targetSource)

    if xPlayer then    
        if xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "guide" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if xTarget then
		TriggerClientEvent("rein:teleport", xTarget.source, Config.Position2)
		TriggerClientEvent('notifications', xTarget.source, "#ff0000", "Du hast das Einreiseamt verlassen")
            else
		TriggerClientEvent('notifications',xPlayer.source, "#ff0000", "Ungültige ID")
            end
        else
        TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Keine Rechte")
        end
    end
end, false)

TriggerEvent('es:addCommand', 'stats', function(source, args, user)
        TriggerClientEvent("notifications", source, "#ff0000", "Du bist " .. user.getGroup())
end)

---- Marker ----

ESX.RegisterServerCallback('einreise:getCommand', function(source, cb)
    local result = false
	cb(result)
end)

ESX.RegisterServerCallback('einreise:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getGroup() or 'user')
end)

RegisterNetEvent('einreise:markertp')
AddEventHandler('einreise:markertp', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        --TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Du bist nun freigeschaltet")
        TriggerClientEvent("notifications", "#40fdfe", "Einreise", "Willkommen in Los Santos")
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
    local resourceName = "^2["..GetCurrentResourceName().."]^0"
    
    PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/Einreise/main/VERSION', function(Error, NewestVersion, Header)
        print("###############################")
        if CurrentVersion == NewestVersion then
            print(resourceName .. ' Resource is Up to Date.')
            print('Current Version: ^2' .. CurrentVersion .. '^0')
        elseif CurrentVersion ~= NewestVersion then
            print(resourceName .. ' Resource Outdated. Please Update!')
            print('Current Version: ^1' .. CurrentVersion .. '^0')
            print('Newest Version: ^2' .. NewestVersion .. '^0')
            print('Download Newest Version here: https://github.com/Musiker15/Einreise/releases')
        end
        print("###############################")
    end)
end