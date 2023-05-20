ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)




ESX.RegisterUsableItem('joint', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('joint', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_overdose:onJoint', source)
end)

ESX.RegisterUsableItem('heroine', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('heroine', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', -500)
	TriggerClientEvent('OurStoryMorphine:inject', source)
	TriggerClientEvent('esx_overdose:onHeroin', source)
	
end)

ESX.RegisterUsableItem('metafetamin', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('metafetamin', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('esx_overdose:onMeth', source)
end)

ESX.RegisterUsableItem('kokain', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('kokain', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 499000)
	TriggerClientEvent('esx_overdose:onCoke', source)
end)

ESX.RegisterUsableItem('lsd', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lsd', 1)
	
	TriggerClientEvent('esx_status:add', _source, 'drug', 499000)
	TriggerClientEvent('esx_overdose:onLcd', source)
	TriggerClientEvent('acidtrip:heroine', source)
end)


-- ESX.RegisterUsableItem('ketamine', function(target)
--     local xPlayer = ESX.GetPlayerFromId(target)

--     xPlayer.removeInventoryItem('ketamine', 1)
-- 	TriggerClientEvent('esx_overdose:onKetamine', target)
-- 	TriggerClientEvent('esx_status:add', target, 'drug', 499000)
-- end)

