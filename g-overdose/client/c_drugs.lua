ESX              = nil
local PlayerData = {}
local hasInjected = false
local morphineTimer = 0
local IsAlreadyDrug = false
local HighLevel     = -1

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

AddEventHandler('esx_status:loaded', function(status)
    TriggerEvent('esx_status:registerStatus', 'drug', 0, '#9ec617', 
        function(status)
            if status.val > 0 then
                return true
            else
                return false
            end
        end,
        function(status)
            status.remove(1500)
        end
    )

    Citizen.CreateThread(function()
        while true do
            Wait(1000)
            TriggerEvent('esx_status:getStatus', 'drug', function(status)
                if status.val > 0 then
                    local start = true
                    if IsAlreadyDrug then
                        start = false
                    end
                    local level = 0
                    if status.val <= 999999 then
                        level = 0
                    else
                        overdose()
                    end
                    if level ~= DrugLevel then
                    end
                    IsAlreadyDrug = true
                    DrugLevel     = level
                end
                if status.val == 0 then
                    if IsAlreadyDrug then
                        Normal()
                    end

                    IsAlreadyDrug = false
                    DrugLevel     = -1
                end
            end)
        end
    end)
end)
function Normal()
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrug(playerPed, false)
        SetPedMotionBlur(playerPed, false)
    end)
end

function overdose()
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
	
        SetEntityHealth(playerPed, 0)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrug(playerPed, false)
        SetPedMotionBlur(playerPed, false)
    end)
end





--SetPedMovementClipset(GetPlayerPed(-1), "move_m@quick", true)
RegisterNetEvent('g-bongo:use')
AddEventHandler('g-bongo:use', function()
    local playerPed = GetPlayerPed(-1)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Röker en bong",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@safehouse@bong",
            anim = "bong_stage4",
        },
        prop = {
            model = "prop_bong_01",
        }
    }, function(status)
        if not status then
          RequestAnimSet("move_m@drunk@slightlydrunk") 
          while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
          Citizen.Wait(0)
          end  
          Citizen.Wait(8000)
          ClearPedTasksImmediately(playerPed)
          SetPedMotionBlur(playerPed, true)
          SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
          SetPedIsDrunk(playerPed, true)
          AnimpostfxPlay("ChopVision", 10000001, true)
          ShakeGameplayCam("DRUNK_SHAKE", 1.0)
          TriggerEvent('inventory:removeItem', 'bong', 1)
      --vvvvvvvvvvvvvvvv
          Citizen.Wait(200000)
      --^^^^^^^^^^^^^^^^
      --Time of effect
      --  after wait stop all effects
          SetPedMoveRateOverride(PlayerId(),1.0)
          SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
          SetPedIsDrunk(GetPlayerPed(-1), false)		
          SetPedMotionBlur(playerPed, false)
          ResetPedMovementClipset(GetPlayerPed(-1))
          AnimpostfxStopAll()
          ShakeGameplayCam("DRUNK_SHAKE", 0.0)
          SetTimecycleModifierStrength(0.0)
        end
    end)
end)

RegisterNetEvent('g-overdose:onCoke')
AddEventHandler('g-overdose:onCoke', function()

    local playerPed = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
  
    RequestAnimSet("MOVE_M@QUICK") 
    
    while not HasAnimSetLoaded("MOVE_M@QUICK") do
        Citizen.Wait(0)
    end

    ESX.ShowNotification( 'Du tog en line Kokain')
    TaskPlayAnim(playerPed, 'missfbi3_party', 'snort_coke_b_male3', 8.0, -8, -1, 48, 0, 0, 0, 0)
    Citizen.Wait(11000)
    
   
    TriggerEvent('inventory:removeItem', 'kokain', 1)
    ClearPedTasksImmediately(playerPed)
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
    SetPedMoveRateOverride(PlayerId(),10.0)
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    -- SetPedIsDrug(playerPed, true)
    exports["gs-stress"]:decreaseStress(10)
    Citizen.Wait(200000)
-- after wait stop all 
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
    SetSwimMultiplierForPlayer(player, 1.0)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/2))
    SetEntityHealth(playerPed, newHealth)
end)

RegisterNetEvent('g-overdose:onJoint')
AddEventHandler('g-overdose:onJoint', function()
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(0)
    end    
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    exports['evrp_progressbar']:CreateProgressBar({text = 'Röker en joint...',time = 20000});
    Citizen.Wait(20000)
    TriggerEvent('inventory:removeItem', 'joint', 1) 
    exports["gs-stress"]:decreaseStress(10)
    ClearPedTasksImmediately(playerPed)
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)
    SetRunSprintMultiplierForPlayer(PlayerId(),-1.0)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)
    ESX.ShowNotification("Du känner dig lugnare efter rökt en joint")
    exports["evrp_skills"]:RemoveSkillLevel("Stamina", 4)
--Efekt time tex 200000 - 3,25 sekunder
    Citizen.Wait(800000)
--Time of effect
--  after wait stop all effects
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)
    Wait(520000)
    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
end)

RegisterNetEvent('g-items:UseTramadol')
AddEventHandler('g-items:UseTramadol', function()
    local playerPed = GetPlayerPed(-1)

  
    RequestAnimSet("move_m@drunk@slightlydrunk") 
    while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
    end    
    ESX.ShowNotification( 'Du tog en Tram, du känner dig lugnar och din stress går ner')
    -- TaskPlayAnim(playerPed, 'anim@amb@nightclub@peds@', 'missfbi3_party_snort_coke_b_male3', 8.0, -8, -1, 49, false, false, false)
    Citizen.Wait(3000)
    exports["gs-stress"]:decreaseStress(10)
    ClearPedTasksImmediately(playerPed)
    -- SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
    SetPedIsDrunk(playerPed, true)
	SetPedMoveRateOverride(PlayerId(),2.0)

    ShakeGameplayCam("DRUNK_SHAKE", 1.0)

    Citizen.Wait(800000)
-- after wait stop all 
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)


RegisterNetEvent('g-overdose:onHeroin')
AddEventHandler('g-overdose:onHeroin', function()
  local playerPed = GetPlayerPed(-1)
  local playerPed = PlayerPedId()
  
    RequestAnimSet("move_m@hobo@a") 
    while not HasAnimSetLoaded("move_m@hobo@a") do
      Citizen.Wait(0)
    end    
    ESX.ShowNotification( 'Du tog lite Heroin')
    Citizen.Wait(6000)
    TriggerEvent('inventory:removeItem', 'heroin', 1) -- Sänker din stress med 10
    ClearPedTasksImmediately(playerPed)
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hobo@a", true)
    SetPedIsDrunk(playerPed, true)
    SetTimecycleModifier("spectator6")
    AnimpostfxPlay("HeistCelebPass", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    exports["evrp_skills"]:RemoveSkillLevel("Stamina", 4)

    Citizen.Wait(800000)
--^^^^^^^^^^^^^^^^

    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(GetPlayerPed(-1), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(GetPlayerPed(-1))
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)

RegisterNetEvent('g-overdose:onMorphine')
AddEventHandler('g-overdose:onMorphine', function()
	prop_name = 'p_syringe_01_s'

	Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)

        RequestAnimSet("move_m@drunk@slightlydrunk") 
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
        end    
	
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)

		ESX.ShowNotification( 'Injicera Morfin')
        TriggerEvent('inventory:removeItem', 'morphine', 1) -- Sänker din stress med 10
        SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        SetPedIsDrunk(playerPed, true)
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)
		Citizen.Wait(1200)
		
		Citizen.Wait(4500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)


        AnimpostfxPlay("SuccessFranklin", 0, false)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        Citizen.Wait(450)
        SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
	    AnimpostfxStopAll()
	    SetEntityHealth(player, GetEntityMaxHealth(player))

        TriggerEvent('inventory:removeItem', 'Morfin', 1)
	    -- Citizen.Wait(500000) -- HOW LONG THE EFFECT LASTS (25 seconds)
        Citizen.Wait(25000) -- HOW LONG THE EFFECT LASTS (25 seconds)
--^^^^^^^^^^^^^^^^
--Time of effect
--  after wait stop all effects
        SetPedMoveRateOverride(PlayerId(),1.0)
        SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
        SetPedIsDrunk(GetPlayerPed(-1), false)		
        SetPedMotionBlur(playerPed, false)
        ResetPedMovementClipset(GetPlayerPed(-1))
        AnimpostfxStopAll()
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetTimecycleModifierStrength(0.0)
        ESX.ShowNotification( 'Morfin Stimulerande medel har tagits!')
    end)
end)




RegisterNetEvent('g-overdose:onAdrenaline')
AddEventHandler('g-overdose:onAdrenaline', function()
    prop_name = 'p_syringe_01_s'

	Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)

        RequestAnimSet("move_m@drunk@slightlydrunk") 
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
        end    
	
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)
		ESX.ShowNotification( 'Injicera Adrenaline')
        SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        SetPedIsDrunk(playerPed, true)
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)
        TriggerEvent('g-skadesystem:client:UseAdrenaline', 1)

        Citizen.Wait(1200)
		
		Citizen.Wait(2500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)
        -- SetPedIsDrug(playerPed, true)
    
	    AnimpostfxPlay("SuccessFranklin", 0, false)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
	    AnimpostfxStopAll()
	    SetPedArmour(player, 100)
	
	    Citizen.Wait(25000) -- HOW LONG THE EFFECT LASTS (25 seconds)
	
	    ESX.ShowNotification('Effekterna av den morfin stimulerande medlet har nu försvunnit.')
	    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        TriggerEvent('inventory:removeItem', 'adrenaline', 1)
    end)
end)

RegisterNetEvent('g-overdose:onMeldonin')
AddEventHandler('g-overdose:onMeldonin', function()
    local playerPed = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
	
	Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)

        RequestAnimSet("move_m@drunk@slightlydrunk") 
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
        end    
	
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)

		ESX.ShowNotification( 'Injicera Meldonin')

        SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        SetPedIsDrunk(playerPed, true)
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)
		Citizen.Wait(1200)
		
		Citizen.Wait(2500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)
        -- SetPedIsDrug(playerPed, true)
        ESX.ShowNotification( 'Meldonin Stimulerande medel har tagits!')
	    AnimpostfxPlay("SuccessFranklin", 0, false)
        StartScreenEffect('Dont_tazeme_bro', 0, true)
	    meldoninEffects = true
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        SetFlash(0, 0, 100, 10000, 100)
	    AnimpostfxStopAll()
	
	    Citizen.Wait(25000) -- HOW LONG THE EFFECT LASTS (25 seconds)
	
	-- SendNUIMessage({sound = "heartbeat", volume = 0.6}) 
	    meldoninEffects = false
	    ESX.ShowNotification('Effekterna av den adrenalinstimulerande medlet har nu försvunnit.')
	    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        StopScreenEffect('Dont_tazeme_bro')
        TriggerEvent('inventory:removeItem', 'meldonin', 1)
    end)
end)

RegisterNetEvent('g-overdose:onAnesthetic')
AddEventHandler('g-overdose:onAnesthetic', function()
    local playerPed = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
	
    Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)

        RequestAnimSet("move_m@drunk@slightlydrunk") 
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
        end    
	
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)
		ESX.ShowNotification( 'Injicera Anesthetic')
        SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        SetPedIsDrunk(playerPed, true)
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)
		Citizen.Wait(1200)
		-- SetPedIsDrug(playerPed, true)
		Citizen.Wait(2500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)

    
	    AnimpostfxPlay("SuccessFranklin", 0, false)
        ShakeGameplayCam("DRUNK_SHAKE", 0.3)
	    AnimpostfxStopAll()
	    SetPedArmour(player, 100)
	
	    Citizen.Wait(25000) -- HOW LONG THE EFFECT LASTS (25 seconds)
	
	    ESX.ShowNotification('Effekterna av den adrenalinstimulerande medlet har nu försvunnit.')
	    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        TriggerEvent('inventory:removeItem', 'anesthetic', 1)
    end)
end)

RegisterNetEvent('g-overdose:onKetamine')
AddEventHandler('g-overdose:onKetamine', function()
    local playerPed = GetPlayerPed(-1)
    local playerPed = PlayerPedId()
	
	Citizen.CreateThread(function()
        local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)

        RequestAnimSet("move_m@drunk@slightlydrunk") 
        while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
        end    
	
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)

		ESX.ShowNotification( 'Injicera Ketamine')
        exports["gs-stress"]:decreaseStress(10)
        TriggerEvent('inventory:removeItem', 'ketamine', 1)
        SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        SetPedIsDrunk(playerPed, true)
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)

		Citizen.Wait(1200)

		Citizen.Wait(4500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)
	
        Citizen.Wait(450)
        -- Citizen.Wait(2500) -- HOW LONG THE EFFECT LASTS (25 seconds)
	    AnimpostfxPlay("SuccessFranklin", 0, false)
	    ShakeGameplayCam("DRUNK_SHAKE", 0.3)
        -- IsAlreadyDrug(playerPed, true)
		ketEffects = true
	    disco = true
        SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        exports["evrp_skills"]:RemoveSkillLevel("Stamina", 4)
        -- Citizen.Wait(60000)
        Citizen.Wait(95000) -- HOW LONG THE EFFECT LASTS (25 seconds)
        local player = PlayerId()
        disco = false
	    AnimpostfxStopAll()
	    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
	    ketEffects = false
	    ESX.ShowNotification('Effekterna av ketamin har nu försvunnit.')

    end)

end)


function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

--Morphine
RegisterNetEvent('OurStoryMorphine:inject')
AddEventHandler('OurStoryMorphine:inject', function()
	prop_name = 'p_syringe_01_s'
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)
		AttachEntityToEntity(prop, playerPed, boneIndex, 0.14, 0.03, 0.02, -50.0, 130.0, -0, true, true, false, true, 1, true)
		loadAnimDict('mp_arresting')
		TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 49, 0, 0, 0, 0)
		ESX.ShowNotification( 'Injicera Heroin')
		SetPedMoveRateOverride(PlayerId(),0.5)
		SetRunSprintMultiplierForPlayer(PlayerId(),0.5)
		SetSwimMultiplierForPlayer(PlayerId(),0.5)
		Citizen.Wait(1200)
		Citizen.Wait(2500)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(prop)
		ClearAllPedProps(prop)
		ClearPedTasks(playerPed)
		if hasInjected == false then
			hasInjected = true
			while morphineTimer < 0 do -- 1800 seconds
				morphineTimer = morphineTimer + 1
			end
			if hasInjected == true then
				hasInjected = false
				ESX.ShowNotification( 'Din Heroin har tagit slut.')
				morphineTimer = 0
				SetPedMoveRateOverride(PlayerId(),10.0)
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
				SetSwimMultiplierForPlayer(PlayerId(),1.0)
			end
		else
			--exports['mythic_notify']:DoHudText('inform', 'You renew your morphine injection')
		end
	end)
end)
--Effect Functions (You can play around with this if you know what you're doing)
RegisterNetEvent('acidtrip:heroine')
AddEventHandler('acidtrip:heroine', function()
	local playerPed = GetPlayerPed(-1)
	DoAcid(20000)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if meldoninEffects == true then
        	SetPedMoveRateOverride(PlayerId(),10.0)
            SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
			RestorePlayerStamina(PlayerId(), 1.0)
        elseif meldoninEffects == false then
        	SetPedMoveRateOverride(PlayerId(),1.0)
            SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if ketEffects == true then
        	RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
	        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", 1.0)
        elseif ketEffects == false then
        	ResetPedMovementClipset(GetPlayerPed(-1))
	        ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	        ResetPedStrafeClipset(GetPlayerPed(-1))
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if disco == true then
        	AnimpostfxPlay("PPOrange", 0, false)
			Citizen.Wait(600)
			AnimpostfxStopAll()
            AnimpostfxPlay("PPGreen", 0, false)
			Citizen.Wait(600)
			AnimpostfxStopAll()
			AnimpostfxPlay("PPPink", 0, false)
			Citizen.Wait(600)
			AnimpostfxStopAll()
			AnimpostfxPlay("PPPurple", 0, false)
			Citizen.Wait(600)
			AnimpostfxStopAll()
	    elseif disco == false then
		
        end
    end
end)
---------------------------------------------------------------------------------------


