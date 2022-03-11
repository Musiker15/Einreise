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
----------------------------------------------------------------
-- Experimental // Command not working right now
-- EnableAdmin have to be false if EnableCommand = true
Config.EnableCommand = false -- Set false if you using 'Config.EnableAdmin = true'
Config.SetMarker = 'seteinreise'
Config.DelMarker = 'deleinreise'
