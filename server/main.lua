ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- on player load check if they are in dataase
-- if not add them and 2 lines 1 for sniper and 1 for rifle
-- set both to not stored and no attachments

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

end)

