local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('187_pacific:OpenVaultDoorSV')
AddEventHandler('187_pacific:OpenVaultDoorSV', function(heading,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('187_pacific:OpenVaultDoorCL', -1,heading,amount)
end)

ESX.RegisterServerCallback('187_pacific:getInvItem',function(source,cb,item,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then cb(true) else cb(false) end
end)

ESX.RegisterServerCallback('187_pacific:removeInvItem',function(source,cb,item,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then xPlayer.removeInventoryItem(item, 1); cb(true) else cb(false) end
end)


function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(2 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('187_pacific:toofar')
AddEventHandler('187_pacific:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		--[[if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			Citizen.Wait(2000)
			TriggerClientEvent('187_banki:killblip', xPlayers[i])
		end]]
	end
	if(robbers[source])then
		TriggerClientEvent('187_pacific:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('pNotify:SendNotification', source, {text = 'Napad anulowany ' ..Stores[robb].nameofstore, type = 'success', layout = 'centerRight'})
--		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('187_pacific:endrob')
AddEventHandler('187_pacific:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		--[[if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], 'Bank został obrabowany')
			TriggerClientEvent('187_banki:killblip', xPlayers[i])
		end]]
	end
	if(robbers[source])then
		TriggerClientEvent('187_pacific:robberycomplete', source)
		robbers[source] = nil
		Citizen.Wait(2000)
		TriggerClientEvent('pNotify:SendNotification', source, {text = 'Napad zakończony na bank', type = 'success', layout = 'centerRight'})
--		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)


Nczas = 0

RegisterServerEvent('187_napady:time')
AddEventHandler('187_napady:time', function()
	ema = os.time()
	Czaskrystian(ema)
end)

function Czaskrystian(krystiano)
	Nczas = krystiano
end

RegisterServerEvent('187_pacific:rob')
AddEventHandler('187_pacific:rob', function(robb)

	local source = source
	siema = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then
			TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Pacific został niedawno obrabowany, odczekaj ' ..(Config.SecBetwNextRob - (os.time() - store.lastrobbed)).. ' sekund', type = 'success', layout = 'centerRight'})
			rob = false
			return
		elseif (os.time() - Nczas) < Config.SecBetwNextRob and Nczas ~= 0 then 
            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Niedawno był napad odczekaj, ' ..(Config.SecBetwNextRob - (os.time() - Nczas)).. ' sekund', type = 'success', layout = 'centerRight'})
			rob = false
			return
		end

		if rob == false then

			rob = true
			--[[for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
					TriggerClientEvent('187_banki:setblip', xPlayers[i], Stores[robb].position)
				end
			end]]

			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Zacząłeś napad na ' ..store.nameofstore, type = 'success', layout = 'centerRight'})
--			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
--			TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
--			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent('187_pacific:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
			TriggerEvent('187_napady:time')
		else
			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Napad w toku', type = 'success', layout = 'centerRight'})
--			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

AddEventHandler('playerDropped', function()
	if siema == source and rob == true then
		TriggerClientEvent('187_pacific:stopSound', -1)

		local xPlayers = ESX.GetPlayers()
		TriggerClientEvent('187_pacific:notificationns')
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			--[[if xPlayer.job.name == 'police' then
			   TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled'))
			   Citizen.Wait(2000)
			   TriggerClientEvent('187_banki:killblip', xPlayers[i])
		   end]]
		end
	end
end)

RegisterServerEvent('187_pacific:sstop')
AddEventHandler('187_pacific:sstop', function()
	TriggerClientEvent('187_pacific:stopSound', -1)
end)

RegisterNetEvent('187_pacific:drzwi')
AddEventHandler('187_pacific:drzwi', function(id)
    TriggerClientEvent('187_pacific:drzwi', -1, id)
end)

RegisterNetEvent('187_pacific:rdrzwi')
AddEventHandler('187_pacific:rdrzwi', function(object)
    TriggerClientEvent('187_pacific:rdrzwi', -1, object)
end)

function sendToDiscord (name,message,color)
	local DiscordWebHook = 'https://discord.com/api/webhooks/828237176751652865/jpfuOXbVw_HfdXH7Dn8WyZQiuMZdu7mmuVLzPFY3YSFMJGpoMYZaKYNlwAeDWj7GAP8j'
	local date = os.date('*t')
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
  
local embeds = {
  {
	  ["description"]=message,
	  ["type"]="rich",
	  ["color"] =color,
	  ["footer"]=  {
		  ["text"]= "" ..date.."",
	 },
  }
}
  
if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function getIdentifiers(player)
    local identifiers = {}
    for i = 0, GetNumPlayerIdentifiers(player) - 1 do
        local raw = GetPlayerIdentifier(player, i)
        local tag, value = raw:match("^([^:]+):(.+)$")
        if tag and value then
            identifiers[tag] = value
        end
    end
    return identifiers
end

RegisterNetEvent('187_pacific:reset')
AddEventHandler('187_pacific:reset', function(work, ilosc)
	local identifiers = getIdentifiers(source)
	local discordID = "\n**Discord:** <@" .. identifiers.discord .. ">"
		if work then 
			kaska = math.random(42382, 84765)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.addAccountMoney('black_money', kaska)
			TriggerClientEvent('pNotify:SendNotification', source,  {text = 'Obrabowałeś skrytkę! Wyciągając: $'..kaska, type = 'success', layout = 'centerRight'})
			sendToDiscord('DREAM_NAPAD_PACIFIC','[' .. source .. '] ' .. GetPlayerName(source) .. '\n**Hex:** ' .. GetPlayerIdentifier(source) .. ''.. discordID ..'\nZarobione pieniądze: ``' .. kaska ..'$``\nSkrytka: '..ilosc..'/8', 12745742)
			kaska = 0
		else
			sendToDiscord('DREAM_NAPAD_PACIFIC_HACKER','[' .. source .. '] ' .. GetPlayerName(source) .. '\n**Hex:** ' .. GetPlayerIdentifier(source) .. ''.. discordID ..'\nAktywował trigger', 12745742)
		end
end)

ESX.RegisterServerCallback('187_pacific:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(CopsConnected)
end)

