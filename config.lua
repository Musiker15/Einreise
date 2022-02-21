Config = {}
----------------------------------------------------------------
Config.Locale = 'de'
Config.VersionChecker = true
Config.Debug = false
----------------------------------------------------------------
Config.Einreise = {
    {x = -1042.46, y = -2745.62, z = 21.36}
}
Config.Position = {
    vector3(-1082.14, -2826.92, 27.71)
}
Config.Position2 = {
    vector3(-1042.46, -2745.62, 21.36)
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
----------------------------------------------------------------
-- Experimental // Command not working right now
-- EnableAdmin have to be false if EnableCommand = true
Config.EnableCommand = false -- Set false if you using 'Config.EnableAdmin = true'
Config.SetMarker = 'seteinreise'
Config.DelMarker = 'deleinreise'
