
--TriggerClientEvent('Radiant_Drunk:GetDrunk', source)
-- Use that to trigger from server side
ESX              = nil
local drunkDriving 	 		 = false
local level					 = -1
local drunk					 = false
local timing				 = false
local PlayerData = {}

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

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterNetEvent('g-drunk:GetDrunk') --- Main function to call
AddEventHandler('g-drunk:GetDrunk', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1

	TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	Citizen.Wait(10000)
	
	ClearPedTasksImmediately(playerPed)

	

	
  	if level == 0 then
	  anim = "move_m@drunk@slightlydrunk"
	  shake = 0.5
	  setPlayerDrunk(anim, shake)
	  ESX.ShowNotification("Du är salongsberusad")

  	elseif level >= 1 then
	  anim = "move_m@drunk@moderatedrunk"
	  shake = 1.0
	  setPlayerDrunk(anim, shake)
	  ESX.ShowNotification("Du börjar blir full")

  	elseif level >= 2 then
	  anim = "move_m@drunk@verydrunk"
	  shake = 2.0
	  setPlayerDrunk(anim, shake)
	  ESX.ShowNotification("Du kan knappt gå")

  	end
--   TriggerEvent('inventory:removeItem', 'vodka', 1)

  
  	if not drunk then
	  drunk = true
	  timer()
	  Citizen.CreateThread(function()
		  local PlayerPed = PlayerPedId()
		  drunkDriving = true 

		  while drunkDriving do
			  Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
			  if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
				  local vehicle = GetVehiclePedIsIn(PlayerPed, false)
				  if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
					  local class = GetVehicleClass(vehicle)
					  
					  if class ~= 15 or 16 or 21 or 13 then
						  local whatToFuckThemWith = fuckDrunkDriver()
						  TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
					  end
				  end
			  end
		  end
	  end)
  	end
end)




RegisterNetEvent('g-drunk:vodka') --- Main function to call
AddEventHandler('g-drunk:vodka', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'vodka', 1)

	
	if not drunk then

		drunk = true
		timer()
		

		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)

		


RegisterNetEvent('g-drunk:whisky') --- Main function to call
AddEventHandler('g-drunk:whisky', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'whisky', 1)

	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:redbullvodka') --- Main function to call
AddEventHandler('g-drunk:redbullvodka', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end

	TriggerEvent('inventory:removeItem', 'redbullvodka', 1)

	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:arboga') --- Main function to call
AddEventHandler('g-drunk:arboga', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end

	TriggerEvent('inventory:removeItem', 'arboga', 1)

	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:norrland') --- Main function to call
AddEventHandler('g-drunk:norrland', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'norrland', 1)

	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:champange') --- Main function to call
AddEventHandler('g-drunk:champange', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'champange', 1)

	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:vittvin') --- Main function to call
AddEventHandler('g-drunk:vittvin', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end

	TriggerEvent('inventory:removeItem', 'vittvin', 1)
	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)

RegisterNetEvent('g-drunk:kung') --- Main function to call
AddEventHandler('g-drunk:kung', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'kung', 1)

	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)
RegisterNetEvent('g-drunk:rottvin') --- Main function to call
AddEventHandler('g-drunk:rottvin', function()
	local playerPed = GetPlayerPed(-1)
	level = level + 1



	  TaskPlayAnim(playerPed, 'amb@world_human_drinking@beer@male@idle_a', 'idle_c', 8.0, -8, -1, 49, false, false, false)
	  exports['evrp_progressbar']:CreateProgressBar({text = 'Dricker',time = 9000});
	  Citizen.Wait(10000)
	  ClearPedTasksImmediately(playerPed)
	  
	if level == 0 then
		anim = "move_m@drunk@slightlydrunk"
		shake = 0.5
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du är salongsberusad")

	elseif level >= 1 then
		anim = "move_m@drunk@moderatedrunk"
		shake = 1.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du börjar blir full")

	elseif level >= 2 then
		anim = "move_m@drunk@verydrunk"
		shake = 2.0
		setPlayerDrunk(anim, shake)
		ESX.ShowNotification("Du kan knappt gå")

	end
	TriggerEvent('inventory:removeItem', 'rottvin', 1)
	
	if not drunk then
		drunk = true
		timer()
		Citizen.CreateThread(function()
			local PlayerPed = PlayerPedId()
			drunkDriving = true 

			while drunkDriving do
				Citizen.Wait(Config.Fuckage) -- How often you want to fuck with the driver
				if IsPedInAnyVehicle(PlayerPed, false) or IsPedInAnyVehicle(PlayerPed, false) == 0 then
					local vehicle = GetVehiclePedIsIn(PlayerPed, false)
					if GetPedInVehicleSeat(vehicle, -1) == PlayerPed then
						local class = GetVehicleClass(vehicle)
						
						if class ~= 15 or 16 or 21 or 13 then
							local whatToFuckThemWith = fuckDrunkDriver()
							TaskVehicleTempAction(PlayerPed, vehicle, whatToFuckThemWith.interaction, whatToFuckThemWith.time) 
						end
					end
				end
			end
		end)
	end
end)

function fuckDrunkDriver()
	-- local shitFuckDamn = math.random(1, #Config.RandomVehicleInteraction)
	-- return Config.RandomVehicleInteraction[shitFuckDamn]
	math.randomseed(GetGameTimer())
	local random = math.random(1, 100)
	local interaction = nil
	local time = 0

	if random <= 10 then
		interaction = 27
		time = 10000
	elseif random <= 20 then
		interaction = 28
		time = 10000
	elseif random <= 30 then
		interaction = 29
		time = 10000
	elseif random <= 40 then
		interaction = 30
		time = 10000


	elseif random <= 50 then
		interaction = 31
		time = 10000

	end
end

	


function setPlayerDrunk(anim, shake)
	local PlayerPed = PlayerPedId()

	RequestAnimSet(anim)
      
	while not HasAnimSetLoaded(anim) do
		Citizen.Wait(100)
	end

	SetPedMovementClipset(PlayerPed, anim, true)
	ShakeGameplayCam("DRUNK_SHAKE", shake)
	SetPedMotionBlur(PlayerPed, true)
	SetPedIsDrunk(PlayerPed, true)

end

--Five Minutes of drunk (does not stack)
function timer()
	local timer = 300
	Citizen.CreateThread( function()
		if not timing then 
			timing = true
			while timer ~= 0 do
				Wait(5000) --- update timer every 5 seconds
				timer = timer - 5
				if timer == 0 then
					Sober()
					return
				end
			end
		end
	end)
end

-- Return to reality
function Sober()

	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		level = -1
		timing = false
		drunk = false
		drunkDriving = false
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)
		ClearPedSecondaryTask(playerPed)
		ShakeGameplayCam("DRUNK_SHAKE", 0.0)
		StopScreenEffect('Rampage')
	end)
end

--Uncomment this stuff to test out the script with /drink and /sober

RegisterCommand("sober",function(source, args)
	Sober()
end)

-- RegisterCommand("drink",function(source, args)
-- 	TriggerEvent('g-drunk:GetDrunk')
-- end)
