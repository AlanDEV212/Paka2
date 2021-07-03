resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Vangelico Robbery'

version '2.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'config.lua',
	'client/187_jubiler_cl.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'config.lua',
	'server/187_jubiler_sv.lua'
}

dependencies {
	'es_extended'
}
