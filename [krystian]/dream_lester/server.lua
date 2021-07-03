ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


RegisterServerEvent('esx_pawnshop:buyFixkit')
AddEventHandler('esx_pawnshop:buyFixkit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 8006) then
		xPlayer.removeMoney(8006)
		
		xPlayer.addInventoryItem('fixkit', 1)
		
		notification("***")
	else
		notification("***")
	end		
end)

RegisterServerEvent('esx_pawnshop:selljewels')
AddEventHandler('esx_pawnshop:selljewels', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local jewels = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "jewels" then
			jewels = item.count
		end
	end
    
    if jewels > 0 then
        xPlayer.removeInventoryItem('jewels', 1)
		xPlayer.addAccountMoney('black_money', 7175)
    else 
		TriggerClientEvent('pNotify:SendNotification', xPlayer.source, {text = 'Nie masz tego przedmiotu w ekwipunku!', type = 'success', layout = 'centerRight'})
    end
end)

RegisterServerEvent('esx_pawnshop:selldiamond')
AddEventHandler('esx_pawnshop:selldiamond', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local diamond = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "diament" then
			diamond = item.count
		end
	end
    
    if diamond > 0 then
        xPlayer.removeInventoryItem('diament', 1)
        xPlayer.addAccountMoney('black_money', 0)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie masz tego przedmiotu w ekwipunku!')
    end
end)

RegisterServerEvent('esx_pawnshop:selldocuments')
AddEventHandler('esx_pawnshop:selldocuments', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local documents = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "dokumenty" then
			documents = item.count
		end
	end
    
    if documents > 0 then
        xPlayer.removeInventoryItem('dokumenty', 1)
        xPlayer.addAccountMoney('black_money', 0)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie masz tego przedmiotu w ekwipunku!')
    end
end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end