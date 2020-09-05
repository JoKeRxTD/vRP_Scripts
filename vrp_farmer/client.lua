
--[[
Custom Drug Script (Weed) V1.0 
Credits - Dynamic_eG#0001
Discord: https://discord.gg/mw4uMJp
/////License/////
Do not reupload/re release any part of this script without my permission
]]
vRP = Proxy.getInterface("vRP") 
x, y, z = 2210.900390625,5577.88671875,52.898094177246                                     -- coords for the field


timplagradinarit = 10      -- planting time in  seconds
timplacules =  10            -- harvesting time in seconds
 
       
local plantsObject = GetHashKey("bkr_prop_weed_med_01a")         -- the plant
local plants = {}

caciula = false 

RegisterNetEvent('EGC:farmWeed')
AddEventHandler('EGC:farmWeed', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
     local player = GetPlayerPed(-1)
     local coord = GetEntityCoords(player)  
       if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, x, y, z-1.7, true)) < 40.0 then   
         TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
        vRP.notify({"Processing wait " ..timplagradinarit.. " Seconds"})
		  TriggerEvent('pogressBar:drawBar', 10000, 'You are garther your seeds')
         Citizen.Wait(timplagradinarit * 1000)     -- time for planting
         ClearPedTasksImmediately(player)   
          TriggerServerEvent('EGC:plantSeeds', player)  
             end      
end)

RegisterNetEvent('EGC:processSeeds')
AddEventHandler('EGC:processSeeds', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
     local player = GetPlayerPed(-1)
     local coord = GetEntityCoords(player)  
       if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, x, y, z-1.7, true)) < 40.0 then   
         TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
        vRP.notify({"Processing wait " ..timplagradinarit.. " Seconds"})
		TriggerEvent('pogressBar:drawBar', 10000, 'You are watering your seeds')
         Citizen.Wait(timplagradinarit * 1000)     -- time for planting
         RequestModel(plantsObject)
         plants[#plants+1] = CreateObject(plantsObject, coord.x, coord.y, coord.z-3.2, false, false, true)
         vRP.notify({"You Pick for a while " ..timplacules.. " Seconds"})
		  TriggerEvent('pogressBar:drawBar', 10000, 'You Pick the Plant')
          Citizen.Wait(timplagradinarit * 1000)     -- time for planting  
             for i,v in pairs (plants) do 
           
          DeleteObject(plants[i])
          plants[i] = nil
          TriggerServerEvent('EGC:processSeeds', player)
          ClearPedTasksImmediately(player)   
             end
       else
        vRP.notify({"You can only grow on the farm"})
        end
end)

 
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
  local player = GetPlayerPed(-1)
  local coord = GetEntityCoords(player) 
  if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, 2879.5114746094,4489.646484375,48.19352722168, true)) < 5.0 then    
    Draw3DText(2879.5114746094,4489.646484375,48.19352722168-0.8,"~w~Press ~r~[~r~E~r~] ~w~to sell Weed",0.1,0.1)
    DrawMarker(27, 2879.5114746094,4489.646484375,47.21352722168,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50,false, true, 2, nil, nil, true )
    if(IsControlJustReleased(1, 51))then
      TriggerServerEvent('EGC:payCheck')
    end
  end
 end
end)


Citizen.CreateThread(function()
    while true do 
      Citizen.Wait(0) 
      local player = GetPlayerPed(-1)
      local coord = GetEntityCoords(player)
      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, x, y, z-1.7, true)) < 10.0 then   
        Draw3DText(x, y, z-0.8,"~w~Press ~r~[~r~E~r~] ~w~to process weed",0.1,0.1)
        DrawMarker(27, x, y, z,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 2, 250, 0, 50, false, true, 2, nil, nil, true ) 
        if(IsControlJustReleased(1, 51))then
          TriggerServerEvent('EGC:takeSeed')
        end
      end
    end
end)

Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0) 
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player)
    if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z,2191.9892578125,5595.2192382813,53.772525787354 , true)) < 5.0 then   
      Draw3DText(2191.9892578125,5595.2192382813,53.772525787354-0.8,"~w~Press ~r~[~r~E~r~] ~w~to farm seeds",0.1,0.1)
      DrawMarker(27, 2191.9892578125,5595.2192382813,53.772525787354,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 153, 250, 50, false, true, 2, nil, nil, true ) 
      if(IsControlJustReleased(1, 51))then
        TriggerEvent('EGC:farmWeed')
      end 
    end
  end
end)

function startUI(time, text) 
	SendNUIMessage({
		type = "ui",
		display = true,
		time = time,
		text = text
	})
end
                                                                                                      

function Draw3DText(x,y,z,textInput,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
end