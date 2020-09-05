
--[[
Custom Drug Script (Weed) V1.0 
Credits - Dynamic_eG#0001
Discord: https://discord.gg/mw4uMJp
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_farmer") 
vRP = Proxy.getInterface("vRP")  

vRP.defInventoryItem({"weed_seeds", "Weed Seeds", "High end Weed Seed!", function(args) end, 0.05})  

RegisterNetEvent('EGC:takeSeed')
AddEventHandler('EGC:takeSeed', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
    local thePlayer = source
	local user_id = vRP.getUserId({thePlayer}) 
    if vRP.tryGetInventoryItem({user_id, "weed_seeds", 1, false}) then           
          TriggerClientEvent('EGC:farmWeed', thePlayer)  
          
   else 
    vRPclient.notify(thePlayer, {"~b~You clearly have no seeds!"})  
   end
end)

amount = 100           -- the cost for 1 plant seed

-- RegisterServerEvent('EGC:buySeeds')
-- AddEventHandler('EGC:buySeeds',function()
--     --! Debug
--     --print("[Debug] This Event was triggered!")
--     --! Function
--     local thePlayer = source
--     local user_id = vRP.getUserId({thePlayer})
--     local money =  vRP.getMoney({user_id})
--       if user_id ~= nil then 
--         vRP.prompt({thePlayer, "How many seeds do you want?", "", function(player,cat) 
--             cat = tonumber(cat)  
--               if (cat > 0) then 
--                 local cost = cat *amount 
--                 if (money >= cost) then 
--                     vRP.tryPayment({user_id, cost}) 
--                     vRP.giveInventoryItem({user_id,"weed_seeds",cat,true})
--                     vRPclient.notify(thePlayer,{"You payed £"..cost})
--                 else 
--                     vRPclient.notify(thePlayer,{"You don't have enough money"})
--                 end
--             else  
--                 vRPclient.notify(thePlayer,{"You can't buy negative quantities"})
--             end
--         end})
--     end

-- end)

RegisterServerEvent('EGC:plantSeeds')
AddEventHandler('EGC:plantSeeds', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
     local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
   if user_id ~= nil then 
    vRP.giveInventoryItem({user_id, "weed_seeds", 1, true}) 
   end

end)

RegisterServerEvent('EGC:processSeeds')
AddEventHandler('EGC:processSeeds', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
     local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
   if user_id ~= nil then 
    vRP.giveInventoryItem({user_id, "weed", 1, true}) 
   end

end) 
 
cost = 3000     -- the cost to sell 1 weed

RegisterServerEvent('EGC:payCheck') 
AddEventHandler('EGC:payCheck', function()
    --! Debug
    --print("[Debug] This Event was triggered!")
    --! Function
     local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
 local weed = vRP.getInventoryItemAmount({user_id,"weed"}) 
 local paycheck =  cost * weed  
   if vRP.tryGetInventoryItem({user_id, "weed", weed, true}) then           
          vRP.giveMoney({user_id, paycheck})
          vRPclient.notify(thePlayer, {"~b~You recived: £"..paycheck})  
          
   else 
    vRPclient.notify(thePlayer, {"~b~You don't have any weed"})  
   end
end) 

