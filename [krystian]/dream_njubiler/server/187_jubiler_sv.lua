local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

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

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	--[[for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end]]
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('pNotify:SendNotification', source, {text = 'Napad anulowany ' ..Stores[robb].nameofstore, type = 'success', layout = 'centerRight'})
--		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	--[[for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end]]
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('pNotify:SendNotification', source, {text = 'Napad zakończony ' ..Stores[robb].nameofstore, type = 'success', layout = 'centerRight'})
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

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

	local source = source
	siema = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then
			TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Jubiler został niedawno obrabowany, odczekaj ' ..(Config.SecBetwNextRob - (os.time() - store.lastrobbed)).. ' sekund', type = 'success', layout = 'centerRight'})
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
					TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end]]

			TriggerClientEvent('pNotify:SendNotification', source, {text = 'Zacząłeś napad na ' ..store.nameofstore, type = 'success', layout = 'centerRight'})
--			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
--			TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
			TriggerClientEvent('playSound', -1)
--			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
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
		TriggerClientEvent('stopSound', -1)

		local xPlayers = ESX.GetPlayers()
		--[[for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
			   TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled'))
			   TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		   end
		end]]
	end
end)

RegisterServerEvent('sstop')
AddEventHandler('sstop', function()
	TriggerClientEvent('stopSound', -1)
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

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function(work, ilosc2)

	local xPlayer = ESX.GetPlayerFromId(source)
	local identifiers = getIdentifiers(source)
	local discordID = "\n**Discord:** <@" .. identifiers.discord .. ">"

	if work then
		local ilosc = math.random(1, 2)
		xPlayer.addInventoryItem('jewels', ilosc)
		sendToDiscord('DREAM_NAPAD_JUBILER','[' .. source .. '] ' .. GetPlayerName(source) .. '\n**Hex:** ' .. GetPlayerIdentifier(source) .. ''.. discordID ..'\nWyciągnięte kryształy: ``' .. ilosc ..'``\nSzyba: '..ilosc2..'/20', 12745742)
		ilosc = 0
	else
		sendToDiscord('DREAM_NAPAD_JUBILER_HACKER','[' .. source .. '] ' .. GetPlayerName(source) .. '\n**Hex:** ' .. GetPlayerIdentifier(source) .. ''.. discordID ..'\nAktywował trigger', 12745742)
	end
end)


ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(CopsConnected)
end)

