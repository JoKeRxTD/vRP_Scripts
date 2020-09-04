
fx_version 'bodacious'
games { 'gta5' }

author 'Dynamic_UK'
description 'Blips'
version '1.0.0'

description 'Dynamic_eG#0001 // Custom Drug Script'
--ui_page 'ui/index.html'

dependency 'vrp'

client_scripts{ 
  'lib/Tunnel.lua',
  'lib/Proxy.lua',
  'client.lua'
}

server_scripts{ 
  '@vrp/lib/utils.lua', 
  'server.lua'
}

files {
    'h.html'
}