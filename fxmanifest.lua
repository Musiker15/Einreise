fx_version 'adamant'
games { 'gta5' }

author 'Craniax - edited by Musiker15'
description 'Einreise Script'
version '3.3'

shared_scripts {
    'config.lua',
    'translation.lua',
}

client_scripts {
	'client.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}