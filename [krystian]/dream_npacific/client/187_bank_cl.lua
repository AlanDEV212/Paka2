local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0 
local openRotte = 0 
local skrytkiRotte = 0
local skrytkicheck = 0

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local dist

        if ESX ~= nil then
            inRange = false

            for k, v in pairs(Config.SmallBanks) do
                dist = GetDistanceBetweenCoords(pos, Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"])
                if dist < 25 then
                    closestBank = k
                    inRange = true
                end
            end

            if not inRange then
                Citizen.Wait(2000)
                closestBank = nil
            end
        end

        Citizen.Wait(3)
    end
end)


function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('187_pacific:currentlyrobbing')
AddEventHandler('187_pacific:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('187_pacific:killblip')
AddEventHandler('187_pacific:killblip', function()
	
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('187_pacific:setblip')
AddEventHandler('187_pacific:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('187_pacific:toofarlocal')
AddEventHandler('187_pacific:toofarlocal', function(robb)
	holdingup = false
	TriggerEvent('pNotify:SendNotification', {text = 'Napad został przerwany', type = 'success', layout = 'centerRight'})
--	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('187_pacific:robberycomplete')
AddEventHandler('187_pacific:robberycomplete', function(robb)
	holdingup = false
	TriggerEvent('pNotify:SendNotification', {text = 'Napad zakończony, uciekaj!', type = 'success', layout = 'centerRight'})
--	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)




Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 134)
		SetBlipScale(blip, 0.5)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Napad na Bank Pacific')
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()
soundid2 = GetSoundId()

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.35, 0.35)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.185, 0.935)
end

local borsa = nil

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)

fjut = false
standrzwi = false
rstandrzwi = false
notka = false
incircle2 = false
work = false
siemaaa = 0 

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 25.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 16, 145, 204, 200, 0, 0, 0, 0)
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							TriggerEvent('pNotify:SendNotification', {text = 'Wciśnij [E] aby rozpocząć napad', type = 'success', layout = 'centerRight'})
						end
						incircle = true
						if IsControlJustPressed(0, 38) then
							if IsPedArmed(PlayerPedId(), 4) then
								if Config.NeedBag then
									if borsa == 40 or borsa == 41 or borsa == 44 or borsa == 45 then
										ESX.TriggerServerCallback('187_pacific:conteggio', function(CopsConnected)
											if CopsConnected >= Config.RequiredCopsRob then
												TriggerServerEvent('187_pacific:rob', k)
											else
												TriggerEvent('pNotify:SendNotification', {text = 'Musi być przynajmniej ' ..Config.RequiredCopsRob.. ' policjantów', type = 'success', layout = 'centerRight'})
											end
										end)		
									else
										TriggerEvent('pNotify:SendNotification', {text = 'Potrzebujesz torby, aby zrobić napad!', type = 'success', layout = 'centerRight'})
									end
								else
									ESX.TriggerServerCallback('187_pacific:conteggio', function(CopsConnected)
										if CopsConnected >= Config.RequiredCopsRob then
											TriggerServerEvent('187_pacific:rob', k)
											store2 = Stores[k]
											xx = v.position.x
											yy = v.position.y
											zz = v.position.z
											notka = true
										else
											TriggerEvent('pNotify:SendNotification', {text = 'Musi być przynajmniej ' ..Config.RequiredCopsRob.. ' policjantów', type = 'success', layout = 'centerRight'})
										end
									end)	
								end	
							else
								TriggerEvent("pNotify:SendNotification", {text = "Rabowanie bez dobrej giwery w łapie? co ty zwariowałeś...", type = "success", queue = "global", timeout = 5000, layout = "centerRight"})
							end
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end

		if holdingup then
				if notka then
					local data = {displayCode = '10-90', description = store2.nameofstore, isImportant = 0, recipientList = {'police'}, length = '15000', infoM = 'fas fa-university', info = "Ktoś aktywował alarm w banku.", blipSprite = 161, blipScale = 0.9, blipColour = 1}
					local dispatchData = {dispatchData = data, caller = "DYSPOZYTORNIA", coords = vector3(xx, yy, zz)}
					TriggerServerEvent('wf-alerts:svNotify', dispatchData)
					notka = false
				end
				if(GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], true) < 25.0) and not Config.SmallBanks[closestBank]["coords"]["open"] and Config.EnableMarker then 
					DrawMarker(20, Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 16, 145, 204, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], true) < 0.75) and not Config.SmallBanks[closestBank]["coords"]["open"] then 
					--DrawText3D(Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], '~w~[~g~E~w~] ' .. 'aby zhakować drzwi banku', 0.6)
					if (incircle == false) then
						TriggerEvent('pNotify:SendNotification', {text = 'Wciśnij [E] aby zhakować drzwi banku', type = 'success', layout = 'centerRight'})
					end
					incircle = true
					if IsControlJustPressed(0, 38) then
						ESX.TriggerServerCallback('187_pacific:getInvItem', function(has_hackerDevice)
						if has_hackerDevice then
							rapina = true
							animazione2 = true -- pętla w wątku sprawdzająca animacje
							SetEntityCoords(GetPlayerPed(-1), Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"]-0.95) --ustawia gracza na kordach
							SetEntityHeading(GetPlayerPed(-1), 0) -- ustawia gracza skierowanego w dane kordy
							Config.SmallBanks[closestBank]["coords"]["open"] = true -- dopisanie, ze marker zaliczony/znika
							PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADING", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0) --start hakowania sound
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
									RequestNamedPtfxAsset("scr_jewelheist")
								end
								while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
										Citizen.Wait(0)
								end
								SetPtfxAssetNextCall("scr_jewelheist")
								--StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "anim@heists@humane_labs@emp@hack_door" ) 
								TaskPlayAnim(GetPlayerPed(-1), "anim@heists@humane_labs@emp@hack_door", "hack_loop", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) -- start animacji 
								TriggerEvent("mt:missiontext", 'Hakowanie drzwi...', 8000) -- napis u dołu
								--DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(8000, 1)
								Citizen.Wait(8000)

								Skillbar = exports['lh-skillbar']:GetSkillbarObject()

										Skillbar.Start({
											duration = math.random(5500, 7000),
											pos = math.random(10, 80),
											width = math.random(10, 20),
										}, function()
											PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADED", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
											Citizen.Wait(1000)
											PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADING", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
											TriggerEvent("mt:missiontext", 'Hakowanie drzwi...', 8000)
											DrawSubtitleTimed(8000, 1)
											Citizen.Wait(8000)
								
											Skillbar.Start({
												duration = math.random(2500, 5000),
												pos = math.random(10, 60),
												width = math.random(8, 15),
											}, function()
												PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADED", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
												Citizen.Wait(1000)
												PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADING", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
												TriggerEvent("mt:missiontext", 'Hakowanie drzwi...', 8000)
												DrawSubtitleTimed(8000, 1)
												Citizen.Wait(8000)
									
												Skillbar.Start({
													duration = math.random(1000, 2000), -- prędkość im mniejsza tym szybciej
													pos = math.random(10, 40), --miejsce gdzie ma się losować kliknięcie im wyższa tym bardziej w lewo
													width = math.random(6, 10), --wielkość kliknięcia im większe tym większe 
												}, function()
													PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADED", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
													Citizen.Wait(1000)
													PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADING", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
													TriggerEvent("mt:missiontext", 'Hakowanie drzwi...', 8000)
													DrawSubtitleTimed(8000, 1)
													Citizen.Wait(8000)

													Skillbar.Start({
														duration = math.random(1000, 2000),
														pos = math.random(10, 40),
														width = math.random(6, 10),
													}, function()
														PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADED", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
														Citizen.Wait(1000)
														PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADING", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0)
														TriggerEvent("mt:missiontext", 'Hakowanie drzwi...', 5000)
														DrawSubtitleTimed(5000, 1)
														Citizen.Wait(5000)
														fjut = true
														ClearPedTasksImmediately(GetPlayerPed(-1))
														animazione2 = false -- pętla w wątku sprawdzająca animacje
														PlaySoundFromCoord(soundid2, "HACKING_DOWNLOADED", Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], "", 0, 0, 0) --koniec hakowania sound
														Citizen.Wait(1000)
														StopSound(soundid2) --stop sound
														TriggerServerEvent('187_pacific:drzwi', closestBank)
														rapina = false
														standrzwi = true
													end, function()
														ClearPedTasksImmediately(GetPlayerPed(-1))
														animazione2 = false
														Config.SmallBanks[closestBank]["coords"]["open"] = false
															ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_hackerDevice)
																if has_hackerDevice then 
																	TriggerEvent('pNotify:SendNotification', {text = 'Nie udało ci się, twoje Urządzenie Hackerskie nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
																else
																	TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
																end
															end, 'hackerDevice2', 1)
														StopSound(soundid2)
													end)

												end, function()
													ClearPedTasksImmediately(GetPlayerPed(-1))
													animazione2 = false
													Config.SmallBanks[closestBank]["coords"]["open"] = false
														ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_hackerDevice)
															if has_hackerDevice then 
																TriggerEvent('pNotify:SendNotification', {text = 'Nie udało ci się, twoje Urządzenie Hackerskie nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
															else
																TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
															end
														end, 'hackerDevice2', 1)
													StopSound(soundid2)
												end)
								
											end, function()
												ClearPedTasksImmediately(GetPlayerPed(-1))
												animazione2 = false
												Config.SmallBanks[closestBank]["coords"]["open"] = false
													ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_hackerDevice)
														if has_hackerDevice then 
															TriggerEvent('pNotify:SendNotification', {text = 'Nie udało ci się, twoje Urządzenie Hackerskie nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
														else
															TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
														end
													end, 'hackerDevice2', 1)
												StopSound(soundid2)
											end)
															
										end, function()
											ClearPedTasksImmediately(GetPlayerPed(-1))
											animazione2 = false
											Config.SmallBanks[closestBank]["coords"]["open"] = false
												ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_hackerDevice)
													if has_hackerDevice then 
														TriggerEvent('pNotify:SendNotification', {text = 'Nie udało ci się, twoje Urządzenie Hackerskie nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
													else
														TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
													end
												end, 'hackerDevice2', 1)
											StopSound(soundid2)
										end)
						else
							TriggerEvent('pNotify:SendNotification', {text = 'Nie posiadasz Urządzenia Hackerskiego poz.2!', type = 'success', layout = 'centerRight'})
						end
						end, 'hackerDevice2' , 1)
				end
			elseif(GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["coords"]["x"], Config.SmallBanks[closestBank]["coords"]["y"], Config.SmallBanks[closestBank]["coords"]["z"], true) > 0.75) and not Config.SmallBanks[closestBank]["coords"]["open"] then
				incircle = false
			end

			if fjut then
				
				drawTxt(0.3, 1.4, 0.30, 'Obrabowane skrytki' .. ' :~r~ ' .. skrytkiRotte .. '/' .. '8', 185, 185, 185, 255)
			   
				for i,v in pairs((Config.SmallBanks[closestBank]["lockers"])) do 
					if(GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["lockers"][i].x, Config.SmallBanks[closestBank]["lockers"][i].y, Config.SmallBanks[closestBank]["lockers"][i].z, true) < 2.0) and not Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] and Config.EnableMarker then 
						DrawMarker(20, Config.SmallBanks[closestBank]["lockers"][i].x, Config.SmallBanks[closestBank]["lockers"][i].y, Config.SmallBanks[closestBank]["lockers"][i].z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 16, 145, 204, 200, 1, 1, 0, 0)
					end
					if(GetDistanceBetweenCoords(pos, Config.SmallBanks[closestBank]["lockers"][i].x, Config.SmallBanks[closestBank]["lockers"][i].y, Config.SmallBanks[closestBank]["lockers"][i].z, true) < 0.75) and not Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] then 
						DrawText3D(Config.SmallBanks[closestBank]["lockers"][i].x, Config.SmallBanks[closestBank]["lockers"][i].y, Config.SmallBanks[closestBank]["lockers"][i].z, '~w~[~g~E~w~] ' .. 'aby otworzyć skrytkę', 0.6)
						if IsControlJustPressed(0, 38) then
							ESX.TriggerServerCallback('187_pacific:getInvItem', function(has_drill)
								if has_drill then
								local player    = GetPlayerPed(-1)
								FreezeEntityPosition(player, true)
								SetEntityCoords(GetPlayerPed(-1), Config.SmallBanks[closestBank]["lockers"][i].x, Config.SmallBanks[closestBank]["lockers"][i].y, Config.SmallBanks[closestBank]["lockers"][i].z-0.95)
								TriggerEvent("Drilling:Start",function(drillStatus)
									if (drillStatus == 1) then
										work = true
										Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = true
										skrytkiRotte = skrytkiRotte+1
										skrytkicheck = skrytkicheck+1
										FreezeEntityPosition(player, false)
										TriggerServerEvent('187_pacific:reset', work, skrytkiRotte)
										work = false
										if skrytkicheck == 8 then 
											TriggerEvent('pNotify:SendNotification', {text = 'To już wszystkie skrytki, obrabowałeś '..skrytkiRotte..' na 8, teraz uciekaj!', type = 'success', layout = 'centerRight'})
											for i,v in pairs((Config.SmallBanks[closestBank]["lockers"])) do 
											Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = false
												skrytkicheck = 0
												skrytkiRotte = 0
											end
											holdingup = false
											fjut = false
											TriggerServerEvent('187_pacific:sstop')
											TriggerServerEvent('187_pacific:endrob', store)
											Citizen.Wait(3000)
											TriggerEvent('pNotify:SendNotification', {text = 'Drzwi w banku zostaną zamknięte za 30 sekund, uważaj!', type = 'success', layout = 'centerRight'})
											Citizen.Wait(30000)
											TriggerServerEvent('187_pacific:rdrzwi')
										end
									elseif (drillStatus == 3) then
										Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = true
										skrytkicheck = skrytkicheck+1
										FreezeEntityPosition(player, false)
											ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_drill)
												if has_drill then 
													TriggerEvent('pNotify:SendNotification', {text = 'Rozjebałeś skrytkę, twoje Wiertło nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
												else
													TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
												end
											end, 'drill2', 1)
										if skrytkicheck == 8 then 
											TriggerEvent('pNotify:SendNotification', {text = 'To już wszystkie skrytki, obrabowałeś '..skrytkiRotte..' na 8, teraz uciekaj!', type = 'success', layout = 'centerRight'})
											for i,v in pairs((Config.SmallBanks[closestBank]["lockers"])) do 
												Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = false
												skrytkicheck = 0
												skrytkiRotte = 0
											end
											holdingup = false
											fjut = false
											TriggerServerEvent('187_pacific:sstop')
											TriggerServerEvent('187_pacific:endrob', store)
											Citizen.Wait(3000)
											TriggerEvent('pNotify:SendNotification', {text = 'Drzwi w banku zostaną zamknięte za 30 sekund, uważaj!', type = 'success', layout = 'centerRight'})
											Citizen.Wait(30000)
											TriggerServerEvent('187_pacific:rdrzwi')
										end
									elseif (drillStatus == 2) then
										Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = true
										skrytkicheck = skrytkicheck+1
										FreezeEntityPosition(player, false)
											ESX.TriggerServerCallback('187_pacific:removeInvItem', function(has_drill)
												if has_drill then 
													TriggerEvent('pNotify:SendNotification', {text = 'Rozjebałeś skrytkę, twoje Wiertło nie będzie już przydatne!', type = 'success', layout = 'centerRight'})
												else
													TriggerEvent('pNotify:SendNotification', {text = 'Nie buguj :_!', type = 'success', layout = 'centerRight'})
												end
											end, 'drill2', 1)
										if skrytkicheck == 8 then 
											TriggerEvent('pNotify:SendNotification', {text = 'To już wszystkie skrytki, obrabowałeś '..skrytkiRotte..' na 8, teraz uciekaj!', type = 'success', layout = 'centerRight'})
											for i,v in pairs((Config.SmallBanks[closestBank]["lockers"])) do 
												Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = false
												skrytkicheck = 0
												skrytkiRotte = 0
											end
											holdingup = false
											fjut = false
											TriggerServerEvent('187_pacific:sstop')
											TriggerServerEvent('187_pacific:endrob', store)
											Citizen.Wait(3000)
											TriggerEvent('pNotify:SendNotification', {text = 'Drzwi w banku zostaną zamknięte za 30 sekund, uważaj!', type = 'success', layout = 'centerRight'})
											Citizen.Wait(30000)
											TriggerServerEvent('187_pacific:rdrzwi')
										end
									end
								end)
							else
								TriggerEvent('pNotify:SendNotification', {text = 'Nie posiadasz Wiertła poz.2!', type = 'success', layout = 'centerRight'})
							end
							end, 'drill2' , 1)
						end
				end
			end
		end


			--#########################################################################################################################################################--

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos2.x, pos2.y, pos2.z, true) > 20.0 ) then
				TriggerServerEvent('187_pacific:toofar', store)
				holdingup = false
				fjut = false
				for i,v in pairs(Config.SmallBanks[closestBank]["coords"]) do 
					Config.SmallBanks[closestBank]["coords"]["open"] = false
				end
				for i,v in pairs((Config.SmallBanks[closestBank]["lockers"])) do 
					Config.SmallBanks[closestBank]["lockers"][i]["isOpened"] = false
				end
				TriggerEvent('pNotify:SendNotification', {text = 'Napad przerwany na '..store..'!', type = 'success', layout = 'centerRight'})
				TriggerServerEvent('187_pacific:sstop')
				rstandrzwi = true
				StopSound(soundid2)
				Citizen.Wait(3000)
					if standrzwi then 
						TriggerEvent('pNotify:SendNotification', {text = 'Drzwi w banku zostaną zamknięte za 30 sekund, uważaj!', type = 'success', layout = 'centerRight'})
					end
			end

		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()			
	while true do
		Citizen.Wait(0)
		if rapina then
			DisableControlAction(0, 73, true)
		end
		if rstandrzwi then
			Citizen.Wait(30000)
			TriggerServerEvent('187_pacific:rdrzwi')
		end

	end
end)


RegisterNetEvent('187_pacific:stopSound')
AddEventHandler('187_pacific:stopSound', function()
    StopSound(soundid)
end)

RegisterNetEvent('187_pacific:notificationns')
AddEventHandler('187_pacific:notificationns', function()
    TriggerServerEvent('187_pacific:rdrzwi')
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        for k, v in pairs(Config.SmallBanks) do
			local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
			if not Config.SmallBanks[k]["isOpened"] then
				SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
			else
				SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
			end
		end
	end
end)

RegisterNetEvent('187_pacific:drzwi')
AddEventHandler('187_pacific:drzwi', function(bankId)
		local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
		local timeOut = 10
		local entHeading = Config.SmallBanks[bankId]["heading"].closed
	
		if object ~= 0 then
			Citizen.CreateThread(function()
				while true do
	
					if entHeading ~= Config.SmallBanks[bankId]["heading"].open then
						SetEntityHeading(object, entHeading - 10)
						entHeading = entHeading - 0.5
					else
						break
					end
	
					Citizen.Wait(10)
				end
			end)
		end
end)

RegisterNetEvent('187_pacific:rdrzwi')
AddEventHandler('187_pacific:rdrzwi', function()
    for k, v in pairs(Config.SmallBanks) do
        local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]["isOpened"] then
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
        else
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
        end
    end
end)


Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		elseif animzione2 == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@humane_labs@emp@hack_door', 'hack_loop', 3) then
				TaskPlayAnim(PlayerPedId(), 'anim@heists@humane_labs@emp@hack_door', 'hack_loop', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)



