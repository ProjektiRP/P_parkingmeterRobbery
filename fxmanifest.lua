fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Projekti'
description 'PROJEKTI - PARKING METER ROBBERY'
version '1.0.3'

client_scripts {
    'src/c_*.lua',

}

server_scripts {
    'src/s_*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
