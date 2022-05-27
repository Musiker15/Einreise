# Einreise
FiveM Script - Craniax Einreise edited by Musiker15

**Discord Support:** https://discord.gg/5hHSBRHvJE

## Commands
* `/einreise ID` - Personen einreisen lassen *(Fall, wenn jemand die Einreise besteht)*
* `/rein ID` - Um in das Einreise Amt gelangen *(Einreise Amt betreten)*
* `/raus ID` - Um wieder ins Roleplay zu gelangen *(Einreise Amt verlassen)*

## Config
```lua
Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = false
----------------------------------------------------------------
Config.Einreise = { -- Marker and /einreise command
    {x = -1042.46, y = -2745.62, z = 21.36}
}
Config.Position = { -- /rein command
    vector3(-1082.14, -2826.92, 27.71)
}
Config.Position2 = { -- /raus command
    vector3(-1042.46, -2745.62, 21.36)
}
----------------------------------------------------------------
Config.TPDisctance = 250 -- Set the max Distance between TPBackIn and player
Config.TPBackIn = { -- Position were the Player get teleported back if a player is not whitelisted
    {x = -1129.47, y = -2788.55, z = 27.71}
}
----------------------------------------------------------------
-- Without Marker enabled, Command and Admin won't work
-- EnableAdmin and EnableCommand have to be false if you only want the Marker
Config.EnableMarker = true -- Set false if you don't want the Marker
Config.MarkerCoords = { -- Set the position of the marker. You can set multiple markers
    {x = -1065.74, y = -2798.57, z = 26.71}
}
Config.Draw3DText = true
----------------------------------------------------------------
-- Requested when a player joins the server
-- EnableCommand have to be false if EnableAdmin = true
Config.EnableAdmin = false -- Set false if you using 'Config.EnableCommand = true'
```

## Requirements
* Notification (https://forum.cfx.re/t/release-standalone-notification-script/1464244)
* ESX 1.2 (v1-final)
* Should work with ESX Legacy too but I didn't test it.

## My other Scripts
* [[ESX] Armor Script - Usable Armor Vests](https://forum.cfx.re/t/release-esx-armor-script-usable-armor-vests-status-will-be-saved-in-database-and-restore-after-relog/4812243)
* [[ESX] Weapon Ammunition with Clips, Components & Tints](https://forum.cfx.re/t/release-esx-weapon-ammunition-with-clips-components-tints/4793783)
* [[ESX/QBCore] Simcard - Change your phonenumber](https://forum.cfx.re/t/release-esx-qbcore-usable-simcard/4847008)
* [[ESX] Shopsystem - NativeUI & Database Feature](https://forum.cfx.re/t/release-esx-msk-shopsystem-nativeui-database-feature/4853593)

## License
**GNU General Public License v3.0**
