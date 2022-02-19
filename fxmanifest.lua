fx_version 'adamant'
games { 'gta5' }

author 'Craniax - edited by Musiker15'
description 'Einreise Script'
version '3.1'

shared_scripts {
    '@es_extended/locale.lua',
	'locales/*.lua',
    'config.lua',
}

client_scripts {
	'client.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}