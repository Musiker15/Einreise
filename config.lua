Config = {}
Config.Locale = 'de'
Config.VersionChecker = true

Config.Einreise = {
    {x = -1042.46, y = -2745.62, z = 21.36}
}
Config.Position = {
    vector3(-1082.14, -2826.92, 27.71)
}
Config.Position2 = {
    vector3(-1042.46, -2745.62, 21.36)
}

-- Without Marker enabled, Command and Admin won't work!
Config.EnableMarker = true -- Enable 'Config.EnableAdmin' or 'Config.EnableCommand'
Config.MarkerCoords = { -- Set the position of the marker. You can set multiple marker
    {x = -1065.74, y = -2798.57, z = 26.71}
}
Config.Draw3DText = true

-- Command not working right now!
Config.EnableCommand = false -- Set false if you using 'Config.EnableAdmin = true'
Config.SetMarker = 'seteinreise'
Config.DelMarker = 'deleinreise'

-- Wird Abgefragt wenn ein Spieler auf den Server kommt
Config.EnableAdmin = false -- Set false if you using 'Config.EnableCommand = true'