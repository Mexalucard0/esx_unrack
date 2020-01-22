local PlayerData		= {}
ESX							   = nil
-- sniper flag and attachments
local sniperloaded = false
local sniperFlash = false

-- Rifle flag and attachments
local rifleloaded = false
local rifleScope = false
local rifleFlash = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

--rack Rifle
RegisterCommand("unrack1", function(source, args, rawCommand)
	if rifleloaded then
		local ped = PlayerPedId()
		local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
		local vehicleCoords = GetEntityCoords(closestVehicle)
		local weapon =	GetHashKey("WEAPON_CARBINERIFLE")
		local class = GetVehicleClass(closestVehicle)
		local job	=	PlayerData.job
		local grade = PlayerData.job.grade_name

		if job ~= nil and job.name == 'police' and grade ~= 'recruit' then
			if Distance < 2.0  and class == 18 and not IsPedInAnyVehicle(ped, false) then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "action_rifle_unrack",
					duration = 4000,
					label = "Unracking Rifle...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
				animation = {
					animDict = "missheistdockssetup1clipboard@idle_a",
					anim = "idle_a",
				},
				prop = {
					model = "prop_paper_bag_small",
				}
				}, function(status)
					if not status then
						GiveWeaponToPed(ped, weapon, 120, false, true)
					end
				end)
			end
		end
	else
		print("No rifle was racked")
	end
end, false)

--rack a sniper
RegisterCommand("unrack2", function(source, args, rawCommand)
	local ped = PlayerPedId()
	local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
	local vehicleCoords = GetEntityCoords(closestVehicle)
	local weapon =	GetHashKey("WEAPON_SNIPER")
	local class = GetVehicleClass(closestVehicle)
	local job	=	PlayerData.job
	local grade = PlayerData.job.grade_name

	if job ~= nil and job.name == 'police' and grade ~= 'recruit' then
		if Distance < 2.0  and class == 18 and not IsPedInAnyVehicle(ped, false) then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "action_sniper_unrack",
					duration = 4000,
					label = "Unracking Sniper...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missheistdockssetup1clipboard@idle_a",
						anim = "idle_a",
					},
					prop = {
						model = "prop_paper_bag_small",
					}
				}, function(status)
					if not status then
						sniperloaded = false
						GiveWeaponToPed(ped, weapon, 120, false, true)
					end
				end)
			
		end
	end
end, false)

RegisterCommand("rack1", function(source, args, rawCommand)
	local ped = PlayerPedId()
	local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
	local vehicleCoords = GetEntityCoords(closestVehicle)
	local weapon =	GetHashKey("WEAPON_CARBINERIFLE")
	local class = GetVehicleClass(closestVehicle)
	local job	=	PlayerData.job
	local grade = PlayerData.job.grade_name

	if job ~= nil and job.name == 'police' and grade ~= 'recruit' then
	if Distance < 2.0  and class == 18 and not IsPedInAnyVehicle(ped, false) then
		TriggerEvent("mythic_progbar:client:progress", {
			name = "action_rack_rifle",
			duration = 4000,
			label = "Racking Rifle",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = false,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "missheistdockssetup1clipboard@idle_a",
				anim = "idle_a",
			},
			prop = {
				model = "prop_paper_bag_small",
			}
		}, function(status)
			if not status then
				RemoveWeaponFromPed(ped, weapon)
			end
		end)
	end
end
end, false)

-- store sniper
RegisterCommand("rack2", function(source, args, rawCommand)
	local ped = PlayerPedId()
	local closestVehicle, Distance = ESX.Game.GetClosestVehicle()
	local vehicleCoords = GetEntityCoords(closestVehicle)
	local weapon =	GetHashKey("WEAPON_SNIPER")
	local class = GetVehicleClass(closestVehicle)
	local job	=	PlayerData.job
	local grade = PlayerData.job.grade_name

	if job ~= nil and job.name == 'police' and grade ~= 'recruit' then
		if Distance < 2.0  and class == 18 and not IsPedInAnyVehicle(ped, false) then
			if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SNIPER") then --does ped have sniper
				TriggerEvent("mythic_progbar:client:progress", {
					name = "action_rack_sniper",
					duration = 4000,
					label = "Racking Sniper",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "missheistdockssetup1clipboard@idle_a",
						anim = "idle_a",
					},
					prop = {
						model = "prop_paper_bag_small",
					}
				}, function(status)
					if not status then
						sniperloaded = true
						RemoveWeaponFromPed(ped, weapon)
					end
				end)
			end
		end
	end
end, false)
