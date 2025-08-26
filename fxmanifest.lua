fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.6.2'

dependencies {
	'tgiann-core',
	'PolyZone', --https://github.com/mkafrin/PolyZone
}

ui_page 'ui/build/index.html'

files {
	'tattooList.json',
	'ui/animationIcon/**.*',
	'ui/build/**.*',
}

shared_scripts {
	'@ox_lib/init.lua',
	"configs/config.lua",
	"configs/configStores.lua",
	"configs/configClothingRoomsOutfits.lua",
	"configs/configHairOverlays.lua",
	"configs/configPedList.lua",
	"configs/blacklist/*.lua",
	"configs/clothelist/**/*.lua",
	"configs/clothingPrice/*.lua",
	"configs/tattoo/*.lua",
	"languages/*.lua",
	"shared/*.lua",
}

client_scripts {
	"client/*.lua",
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"server/*.lua",
}

escrow_ignore {
	"client/editable.lua",
	"configs/**/*.lua",
	"languages/*.lua",
	"server/webhooks.lua",
	"server/editable.lua"
}

dependency '/assetpacks'