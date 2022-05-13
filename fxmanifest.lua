fx_version 'adamant'
game'gta5'

author 'Gdany#2835'
description 'Advanced RP chat for Roleplay servers'
version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'lang.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'lang.lua',
	'config.lua',
	'server.lua'
}

dependency 'es_extended'