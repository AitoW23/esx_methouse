local holdingUp = false
local store = ""
local blipRobbery = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_customrob4:currentlyRobbing')
AddEventHandler('esx_customrob4:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
end)

RegisterNetEvent('esx_customrob4:killBlip')
AddEventHandler('esx_customrob4:killBlip', function()
	RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_customrob4:setBlip')
AddEventHandler('esx_customrob4:setBlip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 3)

	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_customrob4:tooFar')
AddEventHandler('esx_customrob4:tooFar', function()
	holdingUp, store = false, ''
	exports['mythic_notify']:DoCustomHudText('inform', _U('robbery_cancelled'))
end)

RegisterNetEvent('esx_customrob4:dead')
AddEventHandler('esx_customrob4:dead', function()
	holdingUp, store = false, ''
	exports['mythic_notify']:DoCustomHudText('inform', _U('death'))
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	holdingUp, store = false, ''
	TriggerServerEvent('esx_customrob4:tooFar', store)

	
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

RegisterNetEvent('esx_customrob4:robberyComplete')
AddEventHandler('esx_customrob4:robberyComplete', function(award)
	holdingUp, store = false, ''
	exports['mythic_notify']:DoHudText('success', 'Robbery complete')
end)

Citizen.CreateThread(function()
	laptop = CreateObject(-1769322543, 2445.29, 4984.78, 46.81, true, true, true)
	FreezeEntityPosition(laptop, true)
end)
Citizen.CreateThread(function()
	pallets = CreateObject(-5479653, 2446.62, 4987.1, 45.8, true, true, true)
	SetEntityHeading(pallets,GetEntityHeading(pallets)+45)
	FreezeEntityPosition(pallets, true)
end)

--[[ Citizen.CreateThread(function()
	pallets = CreateObject(-770054074, 2445.33, 4987.29, 45.71, true, true, true)
	FreezeEntityPosition(pallets, true)
	SetEntityHeading(pallets,GetEntityHeading(pallets)+55)
end) ]]

RegisterNetEvent('esx_customrob4:startTimer')
AddEventHandler('esx_customrob4:startTimer', function()
	local methped2 = GetHashKey('Oldman2Cutscene')
	local gun = GetHashKey('WEAPON_PISTOL')
	local timer = Stores[store].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		AddRelationshipGroup('Methhouse')

		Citizen.Wait(1000)


		RequestModel(-1728452752)
		RequestModel(1822107721)
		RequestModel(-264140789)
		RequestModel(1625728984)
		RequestModel(-681546704)
		RequestModel(539004493)
		RequestModel(1268862154) 
		Citizen.Wait(3000)
		methped1 = CreatePed(30, -1728452752, 2535.06, 4979.2, 44.66, 43.06, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1, 30)
		SetPedAsEnemy(methped1, true)
		SetPedRelationshipGroupHash(methped1, 'Methhouse')
		GiveWeaponToPed(methped1, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped1, GetPlayerPed(-1))
		SetPedAccuracy(methped1, 30)
		SetPedDropsWeaponsWhenDead(methped1, false)

		RequestModel(0x3BAD4184) --a_m_m_rurmeth_01
		RequestModel(0x3D0A5EB1) --ig_russiandrunk
		RequestModel(0x3F789426) --a_f_y_rurmeth_01
		RequestModel(0xAA699BB6)
		Citizen.Wait(3000)
			methpedtruck = CreateVehicle(0xAA699BB6, 2677.59, 4708.21, 38.16, 14.25, true, false)
			SetVehicleColours(methpedtruck, 2, 2)
			oke, Group = AddRelationshipGroup("Methhouse")
			methpedtruckdriver = CreatePedInsideVehicle(methpedtruck, 12, GetHashKey("a_m_m_rurmeth_01"), -1, true, false)
			Pheli1 = CreatePedInsideVehicle(methpedtruck, 12, GetHashKey("ig_russiandrunk"), 0, true, false)
            Pheli2 = CreatePedInsideVehicle(methpedtruck, 12, GetHashKey("a_f_y_rurmeth_01"), 1, true, false)
            Pheli3 = CreatePedInsideVehicle(methpedtruck, 12, GetHashKey("ig_russiandrunk"), 2, true, false)
			

			TaskVehicleGotoNavmesh(methpedtruckdriver, methpedtruck, 2474.4, 4950.79, 45.16, 30.0, 156, 5.0)
			SetPedRelationshipGroupHash(methpedtruckdriver, Group)                      SetPedRelationshipGroupHash(Pheli1, Group) -- Pheli1 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(methpedtruckdriver, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(Pheli1, false, Group)
			GiveWeaponToPed(methpedtruckdriver, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(Pheli1, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(methpedtruckdriver, 1, true)                         SetPedCombatAttributes(Pheli1, 1, true)
			SetPedCombatAttributes(methpedtruckdriver, 2, true)                         SetPedCombatAttributes(Pheli1, 2, true)
			SetPedCombatAttributes(methpedtruckdriver, 5, true)	                        SetPedCombatAttributes(Pheli1, 5, true)
			SetPedCombatAttributes(methpedtruckdriver, 16, true)                        SetPedCombatAttributes(Pheli1, 16, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver, 26, true) ]]                SetPedCombatAttributes(Pheli1, 26, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver, 46, true)  ]]               SetPedCombatAttributes(Pheli1, 46, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver, 52, true) ]]                SetPedCombatAttributes(Pheli1, 52, true)
			SetPedFleeAttributes(methpedtruckdriver, 0, 0)                              SetPedFleeAttributes(Pheli1, 0, 0)
			SetPedPathAvoidFire(methpedtruckdriver, 1)                                  SetPedPathAvoidFire(Pheli1, 1)
			SetPedAlertness(methpedtruckdriver,3)                                       SetPedAlertness(Pheli1,3)
			--[[ SetPedFiringPattern(methpedtruckdriver, 0xC6EE6B4C) ]]                         SetPedAccuracy(Pheli1, 30)
			SetPedAccuracy(methpedtruckdriver, 30)                                      --[[ SetPedFiringPattern(Pheli1, 0xC6EE6B4C) ]]
			SetPedArmour(methpedtruckdriver, 100)                                       SetPedArmour(Pheli1, 100)
			TaskCombatPed(methpedtruckdriver, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(methpedtruckdriver, GetPlayerPed(-1), 0, 16)
			--[[ TaskVehicleChase(methpedtruckdriver, GetPlayerPed(-1))   ]]            SetPedVehicleForcedSeatUsage(Pheli1, methpedtruck, 0, 1)
			--[[ SetTaskVehicleChaseBehaviorFlag(methpedtruckdriver, 262144, true) ]]
			SetDriverAbility(methpedtruckdriver, 1.0)
			--SetPedAsEnemy(methpedtruckdriver, true)                                   --SetPedAsEnemy(Pheli1, true)
			SetPedDropsWeaponsWhenDead(methpedtruckdriver, false)                       SetPedDropsWeaponsWhenDead(Pheli1, false)
			
			SetPedRelationshipGroupHash(Pheli2, Group)                      SetPedRelationshipGroupHash(Pheli3, Group) -- Pheli3 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(Pheli2, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(Pheli3, false, Group)
			GiveWeaponToPed(Pheli2, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(Pheli3, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(Pheli2, 1, true)                         SetPedCombatAttributes(Pheli3, 1, true)
			SetPedCombatAttributes(Pheli2, 2, true)                         SetPedCombatAttributes(Pheli3, 2, true)
			SetPedCombatAttributes(Pheli2, 5, true)	                        SetPedCombatAttributes(Pheli3, 5, true)
			SetPedCombatAttributes(Pheli2, 16, true)                        SetPedCombatAttributes(Pheli3, 16, true)
			SetPedCombatAttributes(Pheli2, 26, true)                        SetPedCombatAttributes(Pheli3, 26, true)
			SetPedCombatAttributes(Pheli2, 46, true)                        SetPedCombatAttributes(Pheli3, 46, true)
			SetPedCombatAttributes(Pheli2, 52, true)                        SetPedCombatAttributes(Pheli3, 52, true)
			SetPedFleeAttributes(Pheli2, 0, 0)                              SetPedFleeAttributes(Pheli3, 0, 0)
			SetPedPathAvoidFire(Pheli2, 1)                                  SetPedPathAvoidFire(Pheli3, 1)
			SetPedAlertness(Pheli2,3)                                       SetPedAlertness(Pheli3,3)
			--[[ SetPedFiringPattern(Pheli2, 0xC6EE6B4C)  ]]                        SetPedAccuracy(Pheli3, 30)
			SetPedAccuracy(Pheli2, 30)                                      --[[ SetPedFiringPattern(Pheli3, 0xC6EE6B4C) ]]
			SetPedArmour(Pheli2, 100)                                       SetPedArmour(Pheli3, 100)
			TaskCombatPed(Pheli2, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(Pheli2, GetPlayerPed(-1), 0, 16)
            SetPedVehicleForcedSeatUsage(Pheli2, methpedtruck, 0, 1)             SetPedVehicleForcedSeatUsage(Pheli3, methpedtruck, 0, 1)
            
			SetPedDropsWeaponsWhenDead(Pheli2, false)                       SetPedDropsWeaponsWhenDead(Pheli3, false)
			

			Citizen.Wait(10000)

			RequestModel(0x3BAD4184) --a_m_m_rurmeth_01
			RequestModel(0x3D0A5EB1) --ig_russiandrunk
			RequestModel(0x3F789426) --a_f_y_rurmeth_01
			RequestModel(0xAA699BB6)

			methtruck2 = CreateVehicle(0xAA699BB6, 2300.83, 4767.11, 37.8, 338.65, true, false)
			SetVehicleColours(methtruck2, 90, 90)
			oke, Group = AddRelationshipGroup("Methhouse")
			methpedtruckdriver2 = CreatePedInsideVehicle(methtruck2, 12, GetHashKey("a_m_m_rurmeth_01"), -1, true, false)
			methpedtruck2 = CreatePedInsideVehicle(methtruck2, 12, GetHashKey("ig_russiandrunk"), 0, true, false)
			methpedtruck3 = CreatePedInsideVehicle(methtruck2, 12, GetHashKey("a_f_y_rurmeth_01"), 1, true, false)
			methpedtruck4 = CreatePedInsideVehicle(methtruck2, 12, GetHashKey("ig_russiandrunk"), 2, true, false)


			TaskVehicleGotoNavmesh(methpedtruckdriver2, methtruck2, 2421.13, 4973.95, 46.04, 30.0, 156, 5.0)
			SetPedRelationshipGroupHash(methpedtruckdriver2, Group)                      SetPedRelationshipGroupHash(methpedtruck2, Group) -- methpedtruck2 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(methpedtruckdriver2, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(methpedtruck2, false, Group)
			GiveWeaponToPed(methpedtruckdriver2, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(methpedtruck2, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(methpedtruckdriver2, 1, true)                         SetPedCombatAttributes(methpedtruck2, 1, true)
			SetPedCombatAttributes(methpedtruckdriver2, 2, true)                         SetPedCombatAttributes(methpedtruck2, 2, true)
			SetPedCombatAttributes(methpedtruckdriver2, 5, true)	                        SetPedCombatAttributes(methpedtruck2, 5, true)
			SetPedCombatAttributes(methpedtruckdriver2, 16, true)                        SetPedCombatAttributes(methpedtruck2, 16, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver2, 26, true) ]]                SetPedCombatAttributes(methpedtruck2, 26, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver2, 46, true)  ]]               SetPedCombatAttributes(methpedtruck2, 46, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver2, 52, true) ]]                SetPedCombatAttributes(methpedtruck2, 52, true)
			SetPedFleeAttributes(methpedtruckdriver2, 0, 0)                              SetPedFleeAttributes(methpedtruck2, 0, 0)
			SetPedPathAvoidFire(methpedtruckdriver2, 1)                                  SetPedPathAvoidFire(methpedtruck2, 1)
			SetPedAlertness(methpedtruckdriver2,3)                                       SetPedAlertness(methpedtruck2,3)
			--[[ SetPedFiringPattern(methpedtruckdriver2, 0xC6EE6B4C) ]]                         SetPedAccuracy(methpedtruck2, 30)
			SetPedAccuracy(methpedtruckdriver2, 30)                                      --[[ SetPedFiringPattern(methpedtruck2, 0xC6EE6B4C) ]]
			SetPedArmour(methpedtruckdriver2, 100)                                       SetPedArmour(methpedtruck2, 100)
			TaskCombatPed(methpedtruckdriver2, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(methpedtruckdriver2, GetPlayerPed(-1), 0, 16)
			--[[ TaskVehicleChase(methpedtruckdriver2, GetPlayerPed(-1))   ]]            SetPedVehicleForcedSeatUsage(methpedtruck2, methpedtruck, 0, 1)
			--[[ SetTaskVehicleChaseBehaviorFlag(methpedtruckdriver2, 262144, true) ]]
			SetDriverAbility(methpedtruckdriver2, 1.0)
			--SetPedAsEnemy(methpedtruckdriver2, true)                                   --SetPedAsEnemy(methpedtruck2, true)
			SetPedDropsWeaponsWhenDead(methpedtruckdriver2, false)                       SetPedDropsWeaponsWhenDead(methpedtruck2, false)
				
			SetPedRelationshipGroupHash(methpedtruck3, Group)                      SetPedRelationshipGroupHash(methpedtruck4, Group) -- methpedtruck4 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(methpedtruck3, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(methpedtruck4, false, Group)
			GiveWeaponToPed(methpedtruck3, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(methpedtruck4, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(methpedtruck3, 1, true)                         SetPedCombatAttributes(methpedtruck4, 1, true)
			SetPedCombatAttributes(methpedtruck3, 2, true)                         SetPedCombatAttributes(methpedtruck4, 2, true)
			SetPedCombatAttributes(methpedtruck3, 5, true)	                        SetPedCombatAttributes(methpedtruck4, 5, true)
			SetPedCombatAttributes(methpedtruck3, 16, true)                        SetPedCombatAttributes(methpedtruck4, 16, true)
			SetPedCombatAttributes(methpedtruck3, 26, true)                        SetPedCombatAttributes(methpedtruck4, 26, true)
			SetPedCombatAttributes(methpedtruck3, 46, true)                        SetPedCombatAttributes(methpedtruck4, 46, true)
			SetPedCombatAttributes(methpedtruck3, 52, true)                        SetPedCombatAttributes(methpedtruck4, 52, true)
			SetPedFleeAttributes(methpedtruck3, 0, 0)                              SetPedFleeAttributes(methpedtruck4, 0, 0)
			SetPedPathAvoidFire(methpedtruck3, 1)                                  SetPedPathAvoidFire(methpedtruck4, 1)
			SetPedAlertness(methpedtruck3,3)                                       SetPedAlertness(methpedtruck4,3)
			--[[ SetPedFiringPattern(methpedtruck3, 0xC6EE6B4C) ]]                         SetPedAccuracy(methpedtruck4, 30)
			SetPedAccuracy(methpedtruck3, 30)                                      --[[ SetPedFiringPattern(methpedtruck4, 0xC6EE6B4C) ]]
			SetPedArmour(methpedtruck3, 100)                                       SetPedArmour(methpedtruck4, 100)
			TaskCombatPed(methpedtruck3, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(methpedtruck4, GetPlayerPed(-1), 0, 16)
			SetPedVehicleForcedSeatUsage(methpedtruck3, methtruck2, 0, 1)             SetPedVehicleForcedSeatUsage(methpedtruck4, methtruck2, 0, 1)
				
			SetPedDropsWeaponsWhenDead(methpedtruck3, false)                       SetPedDropsWeaponsWhenDead(methpedtruck4, false)


			Citizen.Wait(10000)

			RequestModel(0x3BAD4184) --a_m_m_rurmeth_01
			RequestModel(0x3D0A5EB1) --ig_russiandrunk
			RequestModel(0x3F789426) --a_f_y_rurmeth_01
			RequestModel(0xAA699BB6)

			methtruck3 = CreateVehicle(0xAA699BB6, 2234.3, 5146.72, 56.08, 226.97, true, false)
			oke, Group = AddRelationshipGroup("Methhouse")
			methpedtruckdriver3 = CreatePedInsideVehicle(methtruck3, 12, GetHashKey("a_m_m_rurmeth_01"), -1, true, false)
			methpedtruck5 = CreatePedInsideVehicle(methtruck3, 12, GetHashKey("ig_russiandrunk"), 0, true, false)
			methpedtruck6 = CreatePedInsideVehicle(methtruck3, 12, GetHashKey("a_f_y_rurmeth_01"), 1, true, false)
			methpedtruck7 = CreatePedInsideVehicle(methtruck3, 12, GetHashKey("ig_russiandrunk"), 2, true, false)


			TaskVehicleGotoNavmesh(methpedtruckdriver3, methtruck3, 2468.6, 5014.89, 45.54, 30.0, 156, 5.0)
			SetPedRelationshipGroupHash(methpedtruckdriver3, Group)                      SetPedRelationshipGroupHash(methpedtruck5, Group) -- methpedtruck5 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(methpedtruckdriver3, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(methpedtruck5, false, Group)
			GiveWeaponToPed(methpedtruckdriver3, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(methpedtruck5, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(methpedtruckdriver3, 1, true)                         SetPedCombatAttributes(methpedtruck5, 1, true)
			SetPedCombatAttributes(methpedtruckdriver3, 2, true)                         SetPedCombatAttributes(methpedtruck5, 2, true)
			SetPedCombatAttributes(methpedtruckdriver3, 5, true)	                        SetPedCombatAttributes(methpedtruck5, 5, true)
			SetPedCombatAttributes(methpedtruckdriver3, 16, true)                        SetPedCombatAttributes(methpedtruck5, 16, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver3, 26, true) ]]                SetPedCombatAttributes(methpedtruck5, 26, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver3, 46, true)  ]]               SetPedCombatAttributes(methpedtruck5, 46, true)
			--[[ SetPedCombatAttributes(methpedtruckdriver3, 52, true) ]]                SetPedCombatAttributes(methpedtruck5, 52, true)
			SetPedFleeAttributes(methpedtruckdriver3, 0, 0)                              SetPedFleeAttributes(methpedtruck5, 0, 0)
			SetPedPathAvoidFire(methpedtruckdriver3, 1)                                  SetPedPathAvoidFire(methpedtruck5, 1)
			SetPedAlertness(methpedtruckdriver3,3)                                       SetPedAlertness(methpedtruck5,3)
			--[[ SetPedFiringPattern(methpedtruckdriver3, 0xC6EE6B4C) ]]                         SetPedAccuracy(methpedtruck5, 30)
			SetPedAccuracy(methpedtruckdriver3, 30)                                      --[[ SetPedFiringPattern(methpedtruck5, 0xC6EE6B4C) ]]
			SetPedArmour(methpedtruckdriver3, 100)                                       SetPedArmour(methpedtruck5, 100)
			TaskCombatPed(methpedtruckdriver3, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(methpedtruckdriver5, GetPlayerPed(-1), 0, 16)
			--[[ TaskVehicleChase(methpedtruckdriver3, GetPlayerPed(-1))   ]]            SetPedVehicleForcedSeatUsage(methpedtruck5, methpedtruck, 0, 1)
			--[[ SetTaskVehicleChaseBehaviorFlag(methpedtruckdriver3, 262144, true) ]]
			SetDriverAbility(methpedtruckdriver3, 1.0)
			--SetPedAsEnemy(methpedtruckdriver3, true)                                   --SetPedAsEnemy(methpedtruck5, true)
			SetPedDropsWeaponsWhenDead(methpedtruckdriver3, false)                       SetPedDropsWeaponsWhenDead(methpedtruck5, false)
				
			SetPedRelationshipGroupHash(methpedtruck6, Group)                      SetPedRelationshipGroupHash(methpedtruck7, Group) -- methpedtruck7 now works, but he is kinda stupid :D
			SetEntityCanBeDamagedByRelationshipGroup(methpedtruck6, false, Group)  SetEntityCanBeDamagedByRelationshipGroup(methpedtruck7, false, Group)
			GiveWeaponToPed(methpedtruck6, "WEAPON_PISTOL", 400, false, true)      GiveWeaponToPed(methpedtruck7, "WEAPON_PISTOL", 400, false, true)
			SetPedCombatAttributes(methpedtruck6, 1, true)                         SetPedCombatAttributes(methpedtruck7, 1, true)
			SetPedCombatAttributes(methpedtruck6, 2, true)                         SetPedCombatAttributes(methpedtruck7, 2, true)
			SetPedCombatAttributes(methpedtruck6, 5, true)	                        SetPedCombatAttributes(methpedtruck7, 5, true)
			SetPedCombatAttributes(methpedtruck6, 16, true)                        SetPedCombatAttributes(methpedtruck7, 16, true)
			SetPedCombatAttributes(methpedtruck6, 26, true)                        SetPedCombatAttributes(methpedtruck7, 26, true)
			SetPedCombatAttributes(methpedtruck6, 46, true)                        SetPedCombatAttributes(methpedtruck7, 46, true)
			SetPedCombatAttributes(methpedtruck6, 52, true)                        SetPedCombatAttributes(methpedtruck7, 52, true)
			SetPedFleeAttributes(methpedtruck6, 0, 0)                              SetPedFleeAttributes(methpedtruck7, 0, 0)
			SetPedPathAvoidFire(methpedtruck6, 1)                                  SetPedPathAvoidFire(methpedtruck7, 1)
			SetPedAlertness(methpedtruck6,3)                                       SetPedAlertness(methpedtruck7,3)
			--[[ SetPedFiringPattern(methpedtruck6, 0xC6EE6B4C)  ]]                        SetPedAccuracy(methpedtruck7, 30)
			SetPedAccuracy(methpedtruck6, 30)                                      --[[ SetPedFiringPattern(methpedtruck7, 0xC6EE6B4C) ]]
			SetPedArmour(methpedtruck6, 100)                                       SetPedArmour(methpedtruck7, 100)
			TaskCombatPed(methpedtruck6, GetPlayerPed(-1), 0, 16)                  TaskCombatPed(methpedtruck7, GetPlayerPed(-1), 0, 16)
			SetPedVehicleForcedSeatUsage(methpedtruck6, methtruck3, 0, 1)        SetPedVehicleForcedSeatUsage(methpedtruck7, methtruck3, 0, 1)
				
			SetPedDropsWeaponsWhenDead(methpedtruck6, false)                       SetPedDropsWeaponsWhenDead(methpedtruck7, false)

			Citizen.Wait(30000)

		methped1a = CreatePed(30, -1728452752, 2436.4, 4967.12, 42.35, 114.06, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1a, 30)
		SetPedAsEnemy(methped1a, true)
		SetPedRelationshipGroupHash(methped1a, 'Methhouse')
		GiveWeaponToPed(methped1a, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped1a, GetPlayerPed(-1))
		SetPedAccuracy(methped1a, 30)
		SetPedDropsWeaponsWhenDead(methped1a, false)

		methped1b = CreatePed(30, -1728452752, 2451.98, 4973.41, 51.56, 331.32, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1b, 30)
		SetPedAsEnemy(methped1b, true)
		SetPedRelationshipGroupHash(methped1b, 'Methhouse')
		GiveWeaponToPed(methped1b, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped1b, GetPlayerPed(-1))
		SetPedAccuracy(methped1b, 30)
		SetPedDropsWeaponsWhenDead(methped1b, false)

		methped1c = CreatePed(30, -1728452752, 2441.28, 4976.22, 51.59, 272.65, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1c, 30)
		SetPedAsEnemy(methped1c, true)
		SetPedRelationshipGroupHash(methped1c, 'Methhouse')
		GiveWeaponToPed(methped1c, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped1c, GetPlayerPed(-1))
		SetPedAccuracy(methped1c, 30)
		SetPedDropsWeaponsWhenDead(methped1c, false)

 
		Citizen.Wait(10000)

		methped2 = CreatePed(30, 1822107721, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped2, 30)
		SetPedAsEnemy(methped2, true)
		SetPedRelationshipGroupHash(methped2, 'Methhouse')
		GiveWeaponToPed(methped2, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped2, GetPlayerPed(-1))
		SetPedAccuracy(methped2, 30)
		SetPedDropsWeaponsWhenDead(methped2, false)

		methped3 = CreatePed(30, -264140789, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped3, 30)
		SetPedAsEnemy(methped3, true)
		SetPedRelationshipGroupHash(methped3, 'Methhouse')
		GiveWeaponToPed(methped3, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped3, GetPlayerPed(-1))
		SetPedAccuracy(methped3, 30)
		SetPedDropsWeaponsWhenDead(methped3, false)

		Citizen.Wait(3000)

		methped4 = CreatePed(30, 1625728984, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped4, 30)
		SetPedAsEnemy(methped4, true)
		SetPedRelationshipGroupHash(methped4, 'Methhouse')
		GiveWeaponToPed(methped4, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped4, GetPlayerPed(-1))
		SetPedAccuracy(methped4, 30)
		SetPedDropsWeaponsWhenDead(methped4, false)

		methped5 = CreatePed(30, -681546704, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped5, 30)
		SetPedAsEnemy(methped5, true)
		SetPedRelationshipGroupHash(methped5, 'Methhouse')
		GiveWeaponToPed(methped5, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped5, GetPlayerPed(-1))
		SetPedAccuracy(methped5, 30)
		SetPedDropsWeaponsWhenDead(methped5, false)

		methped5 = CreatePed(30, -681546704, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped5, 30)
		SetPedAsEnemy(methped5, true)
		SetPedRelationshipGroupHash(methped5, 'Methhouse')
		GiveWeaponToPed(methped5, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped5, GetPlayerPed(-1))
		SetPedAccuracy(methped5, 30)
		SetPedDropsWeaponsWhenDead(methped5, false)

		methped6 = CreatePed(30, 539004493, 2394.88, 4948.41, 43.19, 303.12, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped6, 30)
		SetPedAsEnemy(methped6, true)
		SetPedRelationshipGroupHash(methped6, 'Methhouse')
		GiveWeaponToPed(methped6, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped6, GetPlayerPed(-1))
		SetPedAccuracy(methped6, 30)
		SetPedDropsWeaponsWhenDead(methped6, false)

		Citizen.Wait(10000)
		
		methped7 = CreatePed(30, 1268862154, 2414.08, 4993.49, 46.26, 223.41, true, false)
		SetPedArmour(methped7, 30)
		SetPedAsEnemy(methped7, true)
		SetPedRelationshipGroupHash(methped7, 'Methhouse')
		GiveWeaponToPed(methped7, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped7, GetPlayerPed(-1))
		SetPedAccuracy(methped7, 30)
		SetPedDropsWeaponsWhenDead(methped7, false)

		methped8 = CreatePed(30, -1728452752, 2434.99, 5012.65, 46.86, 240.58, true, false)
		SetPedArmour(methped8, 30)
		SetPedAsEnemy(methped8, true)
		SetPedRelationshipGroupHash(methped8, 'Methhouse')
		GiveWeaponToPed(methped8, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped8, GetPlayerPed(-1))
		SetPedAccuracy(methped8, 30)
		SetPedDropsWeaponsWhenDead(methped8, false)

		methped9 = CreatePed(30, 1822107721, 2426.33, 4955.6, 45.86, 28.3, true, false)
		SetPedArmour(methped9, 30)
		SetPedAsEnemy(methped9, true)
		SetPedRelationshipGroupHash(methped9, 'Methhouse')
		GiveWeaponToPed(methped9, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped9, GetPlayerPed(-1))
		SetPedAccuracy(methped9, 30)
		SetPedDropsWeaponsWhenDead(methped9, false)

		Citizen.Wait(10000)

		methped1a2 = CreatePed(30, -1728452752, 2436.4, 4967.12, 42.35, 114.06, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1a2, 30)
		SetPedAsEnemy(methped1a2, true)
		SetPedRelationshipGroupHash(methped1a2, 'Methhouse')
		GiveWeaponToPed(methped1a2, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped1a2, GetPlayerPed(-1))
		SetPedAccuracy(methped1a2, 30)
		SetPedDropsWeaponsWhenDead(methped1a2, false)

		methped1b2 = CreatePed(30, -1728452752, 2451.98, 4973.41, 51.56, 331.32, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1b2, 30)
		SetPedAsEnemy(methped1b2, true)
		SetPedRelationshipGroupHash(methped1b2, 'Methhouse')
		GiveWeaponToPed(methped1b2, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped1b2, GetPlayerPed(-1))
		SetPedAccuracy(methped1b2, 30)
		SetPedDropsWeaponsWhenDead(methped1b2, false)

		Citizen.Wait(10000)
		
		methped1c2 = CreatePed(30, -1728452752, 2441.28, 4976.22, 51.59, 272.65, true, false)
		--CreatePed(30, methped1, 583.54, -3117.87, 19.00, 88.00, true, false)
		SetPedArmour(methped1c2, 30)
		SetPedAsEnemy(methped1c2, true)
		SetPedRelationshipGroupHash(methped1c2, 'Methhouse')
		GiveWeaponToPed(methped1c2, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped1c2, GetPlayerPed(-1))
		SetPedAccuracy(methped1c2, 30)
		SetPedDropsWeaponsWhenDead(methped1c2, false)

		methped10 = CreatePed(30, -264140789, 2413.25, 4993.51, 46.28, 272.77, true, false)
		SetPedArmour(methped10, 30)
		SetPedAsEnemy(methped10, true)
		SetPedRelationshipGroupHash(methped10, 'Methhouse')
		GiveWeaponToPed(methped10, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped10, GetPlayerPed(-1))
		SetPedAccuracy(methped10, 30)
		SetPedDropsWeaponsWhenDead(methped10, false)

		Citizen.Wait(30000)

		methped11 = CreatePed(30, 1625728984, 2484.13, 4956.76, 44.91, 127.5, true, false)
		SetPedArmour(methped11, 30)
		SetPedAsEnemy(methped11, true)
		SetPedRelationshipGroupHash(methped11, 'Methhouse')
		GiveWeaponToPed(methped11, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped11, GetPlayerPed(-1))
		SetPedAccuracy(methped11, 30)
		SetPedDropsWeaponsWhenDead(methped11, false)

		methped12 = CreatePed(30, -681546704, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped12, 0)
		SetPedAsEnemy(methped12, true)
		SetPedRelationshipGroupHash(methped12, 'Methhouse')
		GiveWeaponToPed(methped12, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped12, GetPlayerPed(-1))
		SetPedAccuracy(methped12, 30)
		SetPedDropsWeaponsWhenDead(methped12, false)

		Citizen.Wait(10000)

		methped13 = CreatePed(30, 539004493, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped13, 30)
		SetPedAsEnemy(methped13, true)
		SetPedRelationshipGroupHash(methped13, 'Methhouse')
		GiveWeaponToPed(methped13, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped13, GetPlayerPed(-1))
		SetPedAccuracy(methped13, 30)
		SetPedDropsWeaponsWhenDead(methped13, false)

		methped14 = CreatePed(30, 1268862154, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped14, 30)
		SetPedAsEnemy(methped14, true)
		SetPedRelationshipGroupHash(methped14, 'Methhouse')
		GiveWeaponToPed(methped14, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped14, GetPlayerPed(-1))
		SetPedAccuracy(methped14, 30)
		SetPedDropsWeaponsWhenDead(methped14, false)

		Citizen.Wait(10000)

		methped15 = CreatePed(30, -1728452752, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped15, 0)
		SetPedAsEnemy(methped15, true)
		SetPedRelationshipGroupHash(methped15, 'Methhouse')
		GiveWeaponToPed(methped15, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped15, GetPlayerPed(-1))
		SetPedAccuracy(methped15, 30)
		SetPedDropsWeaponsWhenDead(methped15, false)

		methped16 = CreatePed(30, 1822107721, 2394.88, 4948.41, 43.19, 303.12, true, false)
		SetPedArmour(methped16, 30)
		SetPedAsEnemy(methped16, true)
		SetPedRelationshipGroupHash(methped16, 'Methhouse')
		GiveWeaponToPed(methped16, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped16, GetPlayerPed(-1))
		SetPedAccuracy(methped16, 30)
		SetPedDropsWeaponsWhenDead(methped16, false)

		Citizen.Wait(10000)

		methped17 = CreatePed(30, -264140789, 2414.08, 4993.49, 46.26, 223.41, true, false)
		SetPedArmour(methped17, 0)
		SetPedAsEnemy(methped17, true)
		SetPedRelationshipGroupHash(methped17, 'Methhouse')
		GiveWeaponToPed(methped17, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped17, GetPlayerPed(-1))
		SetPedAccuracy(methped17, 30)
		SetPedDropsWeaponsWhenDead(methped17, false)

		methped18 = CreatePed(30, 1625728984, 2434.99, 5012.65, 46.86, 240.58, true, false)
		SetPedArmour(methped18, 30)
		SetPedAsEnemy(methped18, true)
		SetPedRelationshipGroupHash(methped18, 'Methhouse')
		GiveWeaponToPed(methped18, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped18, GetPlayerPed(-1))
		SetPedAccuracy(methped18, 30)
		SetPedDropsWeaponsWhenDead(methped18, false)

		Citizen.Wait(10000)

		methped19 = CreatePed(30, -681546704, 2426.33, 4955.6, 45.86, 28.3, true, false)
		SetPedArmour(methped19, 30)
		SetPedAsEnemy(methped19, true)
		SetPedRelationshipGroupHash(methped19, 'Methhouse')
		GiveWeaponToPed(methped19, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped19, GetPlayerPed(-1))
		SetPedAccuracy(methped19, 30)
		SetPedDropsWeaponsWhenDead(methped19, false)

		methped20 = CreatePed(30, 539004493, 2413.25, 4993.51, 46.28, 272.77, true, false)
		SetPedArmour(methped20, 0)
		SetPedAsEnemy(methped20, true)
		SetPedRelationshipGroupHash(methped20, 'Methhouse')
		GiveWeaponToPed(methped20, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped20, GetPlayerPed(-1))
		SetPedAccuracy(methped20, 30)
		SetPedDropsWeaponsWhenDead(methped20, false)

		Citizen.Wait(30000)

		methped21 = CreatePed(30, 1268862154, 2484.13, 4956.76, 44.91, 127.5, true, false)
		SetPedArmour(methped21, 0)
		SetPedAsEnemy(methped21, true)
		SetPedRelationshipGroupHash(methped21, 'Methhouse')
		GiveWeaponToPed(methped21, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped21, GetPlayerPed(-1))
		SetPedAccuracy(methped21, 30)
		SetPedDropsWeaponsWhenDead(methped21, false)

		methped22 = CreatePed(30, -1728452752, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped22, 0)
		SetPedAsEnemy(methped22, true)
		SetPedRelationshipGroupHash(methped22, 'Methhouse')
		GiveWeaponToPed(methped22, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped22, GetPlayerPed(-1))
		SetPedAccuracy(methped22, 30)
		SetPedDropsWeaponsWhenDead(methped22, false)

		Citizen.Wait(10000)

		methped23 = CreatePed(30, 1822107721, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped23, 0)
		SetPedAsEnemy(methped23, true)
		SetPedRelationshipGroupHash(methped23, 'Methhouse')
		GiveWeaponToPed(methped23, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped23, GetPlayerPed(-1))
		SetPedAccuracy(methped23, 30)
		SetPedDropsWeaponsWhenDead(methped23, false)

		methped24 = CreatePed(30, -264140789, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped24, 0)
		SetPedAsEnemy(methped24, true)
		SetPedRelationshipGroupHash(methped24, 'Methhouse')
		GiveWeaponToPed(methped24, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped24, GetPlayerPed(-1))
		SetPedAccuracy(methped24, 30)
		SetPedDropsWeaponsWhenDead(methped24, false)

		Citizen.Wait(10000)

		methped25 = CreatePed(30, 1625728984, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped25, 0)
		SetPedAsEnemy(methped25, true)
		SetPedRelationshipGroupHash(methped25, 'Methhouse')
		GiveWeaponToPed(methped25, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped25, GetPlayerPed(-1))
		SetPedAccuracy(methped25, 30)
		SetPedDropsWeaponsWhenDead(methped25, false)

		methped26 = CreatePed(30, -681546704, 2394.88, 4948.41, 43.19, 303.12, true, false)
		SetPedArmour(methped26, 0)
		SetPedAsEnemy(methped26, true)
		SetPedRelationshipGroupHash(methped26, 'Methhouse')
		GiveWeaponToPed(methped26, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped26, GetPlayerPed(-1))
		SetPedAccuracy(methped26, 30)
		SetPedDropsWeaponsWhenDead(methped26, false)

		Citizen.Wait(10000)

		methped27 = CreatePed(30, 539004493, 2414.08, 4993.49, 46.26, 223.41, true, false)
		SetPedArmour(methped27, 0)
		SetPedAsEnemy(methped27, true)
		SetPedRelationshipGroupHash(methped27, 'Methhouse')
		GiveWeaponToPed(methped27, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped27, GetPlayerPed(-1))
		SetPedAccuracy(methped27, 30)
		SetPedDropsWeaponsWhenDead(methped27, false)

		methped28 = CreatePed(30, 1268862154, 2434.99, 5012.65, 46.86, 240.58, true, false)
		SetPedArmour(methped28, 0)
		SetPedAsEnemy(methped28, true)
		SetPedRelationshipGroupHash(methped28, 'Methhouse')
		GiveWeaponToPed(methped28, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped28, GetPlayerPed(-1))
		SetPedAccuracy(methped28, 30)
		SetPedDropsWeaponsWhenDead(methped28, false)

		Citizen.Wait(10000)

		methped29 = CreatePed(30, -1728452752, 2426.33, 4955.6, 45.86, 28.3, true, false)
		SetPedArmour(methped29, 0)
		SetPedAsEnemy(methped29, true)
		SetPedRelationshipGroupHash(methped29, 'Methhouse')
		GiveWeaponToPed(methped29, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped29, GetPlayerPed(-1))
		SetPedAccuracy(methped29, 30)
		SetPedDropsWeaponsWhenDead(methped29, false)

		methped30 = CreatePed(30, 1822107721, 2413.25, 4993.51, 46.28, 272.77, true, false)
		SetPedArmour(methped30, 0)
		SetPedAsEnemy(methped30, true)
		SetPedRelationshipGroupHash(methped30, 'Methhouse')
		GiveWeaponToPed(methped30, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped30, GetPlayerPed(-1))
		SetPedAccuracy(methped30, 30)
		SetPedDropsWeaponsWhenDead(methped30, false)

		Citizen.Wait(40000)

		methped31 = CreatePed(30, -264140789, 2484.13, 4956.76, 44.91, 127.5, true, false)
		SetPedArmour(methped31, 0)
		SetPedAsEnemy(methped31, true)
		SetPedRelationshipGroupHash(methped31, 'Methhouse')
		GiveWeaponToPed(methped31, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped31, GetPlayerPed(-1))
		SetPedAccuracy(methped31, 30)
		SetPedDropsWeaponsWhenDead(methped31, false)

		methped32 = CreatePed(30, 1625728984, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped32, 0)
		SetPedAsEnemy(methped32, true)
		SetPedRelationshipGroupHash(methped32, 'Methhouse')
		GiveWeaponToPed(methped32, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped32, GetPlayerPed(-1))
		SetPedAccuracy(methped32, 30)
		SetPedDropsWeaponsWhenDead(methped32, false)

		Citizen.Wait(10000)

		methped33 = CreatePed(30, -681546704, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped18, 0)
		SetPedAsEnemy(methped18, true)
		SetPedRelationshipGroupHash(methped18, 'Methhouse')
		GiveWeaponToPed(methped18, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped18, GetPlayerPed(-1))
		SetPedAccuracy(methped18, 30)
		SetPedDropsWeaponsWhenDead(methped18, false)

		methped34 = CreatePed(30, 539004493, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped34, 0)
		SetPedAsEnemy(methped34, true)
		SetPedRelationshipGroupHash(methped34, 'Methhouse')
		GiveWeaponToPed(methped34, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped34, GetPlayerPed(-1))
		SetPedAccuracy(methped34, 30)
		SetPedDropsWeaponsWhenDead(methped34, false)

		Citizen.Wait(10000)

		methped35 = CreatePed(30, 1268862154, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped35, 0)
		SetPedAsEnemy(methped35, true)
		SetPedRelationshipGroupHash(methped35, 'Methhouse')
		GiveWeaponToPed(methped35, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped35, GetPlayerPed(-1))
		SetPedAccuracy(methped35, 30)
		SetPedDropsWeaponsWhenDead(methped35, false)

		methped36 = CreatePed(30, -1728452752, 2394.88, 4948.41, 43.19, 303.12, true, false)
		SetPedArmour(methped36, 0)
		SetPedAsEnemy(methped36, true)
		SetPedRelationshipGroupHash(methped36, 'Methhouse')
		GiveWeaponToPed(methped36, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped36, GetPlayerPed(-1))
		SetPedAccuracy(methped36, 30)
		SetPedDropsWeaponsWhenDead(methped36, false)

		Citizen.Wait(10000)

		methped37 = CreatePed(30, 1822107721, 2414.08, 4993.49, 46.26, 223.41, true, false)
		SetPedArmour(methped37, 0)
		SetPedAsEnemy(methped37, true)
		SetPedRelationshipGroupHash(methped37, 'Methhouse')
		GiveWeaponToPed(methped37, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped37, GetPlayerPed(-1))
		SetPedAccuracy(methped37, 30)
		SetPedDropsWeaponsWhenDead(methped37, false)

		methped38 = CreatePed(30, -264140789, 2434.99, 5012.65, 46.86, 240.58, true, false)
		SetPedArmour(methped38, 0)
		SetPedAsEnemy(methped38, true)
		SetPedRelationshipGroupHash(methped38, 'Methhouse')
		GiveWeaponToPed(methped38, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped38, GetPlayerPed(-1))
		SetPedAccuracy(methped38, 30)
		SetPedDropsWeaponsWhenDead(methped38, false)

		Citizen.Wait(10000)

		methped39 = CreatePed(30, 1625728984, 2426.33, 4955.6, 45.86, 28.3, true, false)
		SetPedArmour(methped39, 0)
		SetPedAsEnemy(methped39, true)
		SetPedRelationshipGroupHash(methped39, 'Methhouse')
		GiveWeaponToPed(methped39, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped39, GetPlayerPed(-1))
		SetPedAccuracy(methped39, 30)
		SetPedDropsWeaponsWhenDead(methped39, false)

		methped40 = CreatePed(30, -681546704, 2413.25, 4993.51, 46.28, 272.77, true, false)
		SetPedArmour(methped40, 0)
		SetPedAsEnemy(methped40, true)
		SetPedRelationshipGroupHash(methped40, 'Methhouse')
		GiveWeaponToPed(methped40, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped40, GetPlayerPed(-1))
		SetPedAccuracy(methped40, 30)
		SetPedDropsWeaponsWhenDead(methped40, false)

		Citizen.Wait(50000)

		methped41 = CreatePed(30, 539004493, 2484.13, 4956.76, 44.91, 127.5, true, false)
		SetPedArmour(methped41, 0)
		SetPedAsEnemy(methped41, true)
		SetPedRelationshipGroupHash(methped41, 'Methhouse')
		GiveWeaponToPed(methped41, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		SetPedAccuracy(methped41, 30)
		SetPedDropsWeaponsWhenDead(methped41, false)

		methped42 = CreatePed(30, 1268862154, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped42, 0)
		SetPedAsEnemy(methped42, true)
		SetPedRelationshipGroupHash(methped42, 'Methhouse')
		GiveWeaponToPed(methped42, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		SetPedAccuracy(methped42, 30)
		SetPedDropsWeaponsWhenDead(methped42, false)

		Citizen.Wait(10000)

		methped43 = CreatePed(30, 1822107721, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped43, 0)
		SetPedAsEnemy(methped43, true)
		SetPedRelationshipGroupHash(methped43, 'Methhouse')
		GiveWeaponToPed(methped43, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		SetPedAccuracy(methped43, 30)
		SetPedDropsWeaponsWhenDead(methped43, false)

		methped44 = CreatePed(30, -264140789, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped44, 0)
		SetPedAsEnemy(methped44, true)
		SetPedRelationshipGroupHash(methped44, 'Methhouse')
		GiveWeaponToPed(methped44, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		SetPedAccuracy(methped44, 30)
		SetPedDropsWeaponsWhenDead(methped44, false)

		Citizen.Wait(10000)

		methped45 = CreatePed(30, 1625728984, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped45, 0)
		SetPedAsEnemy(methped45, true)
		SetPedRelationshipGroupHash(methped45, 'Methhouse')
		GiveWeaponToPed(methped45, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		SetPedAccuracy(methped45, 30)
		SetPedDropsWeaponsWhenDead(methped45, false)

		methped46 = CreatePed(30, -681546704, 2394.88, 4948.41, 43.19, 303.12, true, false)
		SetPedArmour(methped46, 0)
		SetPedAsEnemy(methped46, true)
		SetPedRelationshipGroupHash(methped46, 'Methhouse')
		GiveWeaponToPed(methped46, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		SetPedAccuracy(methped46, 30)
		SetPedDropsWeaponsWhenDead(methped46, false)

		Citizen.Wait(30000)

		methped47 = CreatePed(30, 539004493, 2484.13, 4956.76, 44.91, 127.5, true, false)
		SetPedArmour(methped47, 0)
		SetPedAsEnemy(methped47, true)
		SetPedRelationshipGroupHash(methped47, 'Methhouse')
		GiveWeaponToPed(methped47, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped47, GetPlayerPed(-1))
		SetPedAccuracy(methped47, 30)
		SetPedDropsWeaponsWhenDead(methped47, false)

		methped48 = CreatePed(30, 1268862154, 2497.06, 4968.69, 44.6, 63.27, true, false)
		SetPedArmour(methped48, 0)
		SetPedAsEnemy(methped48, true)
		SetPedRelationshipGroupHash(methped48, 'Methhouse')
		GiveWeaponToPed(methped48, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped48, GetPlayerPed(-1))
		SetPedAccuracy(methped48, 30)
		SetPedDropsWeaponsWhenDead(methped48, false)

		Citizen.Wait(10000)

		methped49 = CreatePed(30, -1728452752, 2489.02, 4961.25, 44.77, 107.78, true, false)
		SetPedArmour(methped49, 0)
		SetPedAsEnemy(methped49, true)
		SetPedRelationshipGroupHash(methped49, 'Methhouse')
		GiveWeaponToPed(methped49, GetHashKey('WEAPON_PISTOL'), 250, false, true)
		TaskCombatPed(methped49, GetPlayerPed(-1))
		SetPedAccuracy(methped49, 30)
		SetPedDropsWeaponsWhenDead(methped49, false)

		methped50 = CreatePed(30, 1822107721, 2485.38, 4941.94, 44.39, 48.34, true, false)
		SetPedArmour(methped50, 0)
		SetPedAsEnemy(methped50, true)
		SetPedRelationshipGroupHash(methped50, 'Methhouse')
		GiveWeaponToPed(methped50, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped50, GetPlayerPed(-1))
		SetPedAccuracy(methped50, 30)
		SetPedDropsWeaponsWhenDead(methped50, false)

		methped51 = CreatePed(30, 1268862154, 2430.69, 4925.07, 44.27, 339.74, true, false)
		SetPedArmour(methped51, 0)
		SetPedAsEnemy(methped51, true)
		SetPedRelationshipGroupHash(methped51, 'Methhouse')
		GiveWeaponToPed(methped51, GetHashKey('WEAPON_SAWNOFFSHOTGUN'), 250, false, true)
		TaskCombatPed(methped51, GetPlayerPed(-1))
		SetPedAccuracy(methped51, 30)
		SetPedDropsWeaponsWhenDead(methped51, false) 

		Citizen.Wait(30000)

		DeleteEntity(methped1)
		DeleteEntity(methped1a)
		DeleteEntity(methped1b)
		DeleteEntity(methped1c)
		DeleteEntity(methped2)
		DeleteEntity(methped3)
		DeleteEntity(methped4)
		DeleteEntity(methped5)
		DeleteEntity(methped6)
		DeleteEntity(methped7)
		DeleteEntity(methped8)
		DeleteEntity(methped9)
		DeleteEntity(methped1a2)
		DeleteEntity(methped1b2)
		DeleteEntity(methped1c2)
		DeleteEntity(methped10)
		DeleteEntity(methped11)
		DeleteEntity(methped12)
		DeleteEntity(methped13)
		DeleteEntity(methped14)
		DeleteEntity(methped15)
		DeleteEntity(methped16)
		DeleteEntity(methped17)
		DeleteEntity(methped18)
		DeleteEntity(methped19)
		DeleteEntity(methped20)
		DeleteEntity(methped21)
		DeleteEntity(methped22)
		DeleteEntity(methped23)
		DeleteEntity(methped24)
		DeleteEntity(methped25)
		DeleteEntity(methped26)
		DeleteEntity(methped27)
		DeleteEntity(methped28)
		DeleteEntity(methped30)
		DeleteEntity(methped30)
		DeleteEntity(methped31)
		DeleteEntity(methped32)
		DeleteEntity(methped33)
		DeleteEntity(methped34)
		DeleteEntity(methped35)
		DeleteEntity(methped36)
		DeleteEntity(methped37)
		DeleteEntity(methped38)
		DeleteEntity(methped39)
		DeleteEntity(methped40)
		DeleteEntity(methped41)
		DeleteEntity(methped42)
		DeleteEntity(methped43)
		DeleteEntity(methped44)
		DeleteEntity(methped45)
		DeleteEntity(methped46)
		DeleteEntity(methped47)
		DeleteEntity(methped48)
		DeleteEntity(methped49)
		DeleteEntity(methped50) 
		DeleteEntity(methped51)

		DeleteEntity(methpedtruckdriver) 
		DeleteEntity(Pheli1) 
		DeleteEntity(Pheli2) 
		DeleteEntity(Pheli3) 
		DeleteEntity(methpedtruckdriver2) 
		DeleteEntity(methpedtruck2) 
		DeleteEntity(methpedtruck3) 
		DeleteEntity(methpedtruck4) 
		DeleteEntity(methpedtruckdriver3) 
		DeleteEntity(methpedtruck5)
		DeleteEntity(methpedtruck6)
		DeleteEntity(methpedtruck7) 

		Citizen.Wait(100000)
		
		DeleteEntity(methpedtruck) 
		DeleteEntity(methtruck2) 
		DeleteEntity(methtruck3)
		


	end)

	Citizen.CreateThread(function()
		while holdingUp do
			Citizen.Wait(0)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
		end
	end)
end)

--[[ Citizen.CreateThread(function()
	for k,v in pairs(Stores) do
		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		SetBlipSprite(blip, 303)
		SetBlipScale(blip, 0.6)
		SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 1)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Methhouse Heist') 
		EndTextCommandSetBlipName(blip)
	end
end) ]] 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)
		local ped = PlayerPedId()

		for k,v in pairs(Stores) do
			local storePos = v.position
			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z)

			if distance < Config.Marker.DrawDistance then
				if not holdingUp then
					DrawMarker(Config.Marker.Type, storePos.x, storePos.y, storePos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if distance < 0.5 then
						ESX.ShowHelpNotification(_U('press_to_rob', v.nameOfStore))

						if IsControlJustReleased(0, 38) and IsPedArmed(ped, 6) and not IsEntityDead(ped) then
							TriggerServerEvent('esx_customrob4:robberyStarted', k)
						end
					end
				end
			end
		end

		if holdingUp then
			local storePos = Stores[store].position
			if Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z) > Config.MaxDistance then
				TriggerServerEvent('esx_customrob4:tooFar', store)
			end
		end
	end
end)
