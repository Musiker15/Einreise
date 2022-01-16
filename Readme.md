# Einreise
FiveM Script - Einreise

## Commands
* `/einreise ID` - Personen einreisen lassen *(Fall, wenn jemand die Einreise besteht)*
* `/rein ID` - Um in das Einreise Amt gelangen *(Einreise Amt betreten)*
* `/raus ID` - Um wieder ins Roleplay zu gelangen *(Einreise Amt verlassen)*

## Config
```lua
Config = {}
Config.Locale = 'de'
Config.VersionChecker = false

Config.Einreise = {
    {x = -1042.46, y = -2745.62, z = 21.36}
}
Config.Position = {
    vector3(-1082.14, -2826.92, 27.71)
}
Config.Position2 = {
    vector3(-1042.46, -2745.62, 21.36)
}

Config.EnableMarker = true 
Config.MarkerCoords = { -- Set the position of the marker. You can set multiple markers
    {x = -1065.74, y = -2798.57, z = 26.71}
}
Config.Draw3DText = true
```

## Requirements
* ESX 1.2 (https://github.com/esx-framework/es_extended/releases/tag/v1-final)

## License
**GNU General Public License v3.0**