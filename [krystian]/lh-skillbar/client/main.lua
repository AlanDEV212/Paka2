Skillbar = {}
Skillbar.Data = {}


Skillbar.Data = {
    Active = false,
    Data = {},
}
successCb = nil
failCb = nil

-- NUI Callback's

RegisterNUICallback('Check', function(data, cb)
    if successCb ~= nil then
        Skillbar.Data.Active = false
        TriggerEvent('progressbar:client:ToggleBusyness', false)
        if data.success then
            successCb()
        else
            failCb()
            SendNUIMessage({
                action = "stop"
            })
        end
    end
end)

Skillbar.Start = function(data, success, fail)
    if not Skillbar.Data.Active then
        Skillbar.Data.Active = true
        if success ~= nil then
            successCb = success
        end
        if fail ~= nil then
            failCb = fail
        end
        Skillbar.Data.Data = data

        SendNUIMessage({
            action = "start",
            duration = data.duration,
            pos = data.pos,
            width = data.width,
        })
        TriggerEvent('progressbar:client:ToggleBusyness', true)
    else
        TriggerEvent('notification', 'You are already doing something...', 2)
    end
end

Skillbar.Repeat = function(data)
    Skillbar.Data.Active = true
    Skillbar.Data.Data = data
    Citizen.CreateThread(function()
        Wait(500)
        SendNUIMessage({
            action = "start",
            duration = Skillbar.Data.Data.duration,
            pos = Skillbar.Data.Data.pos,
            width = Skillbar.Data.Data.width,
        }) 
    end)
end

Citizen.CreateThread(function()
    while true do
        if Skillbar.Data.Active then
            if IsControlJustPressed(0, 38) then
                SendNUIMessage({
                    action = "check",
                    data = Skillbar.Data.Data,
                })
            end
        end
        Citizen.Wait(1)
    end
end)

function GetSkillbarObject()
    return Skillbar
end

RegisterCommand('skill', function()

    Skillbar.Start({
        duration = math.random(500, 2000), -- prędkość im mniejsza tym szybciej
        pos = math.random(10, 80), --miejsce gdzie ma się losować kliknięcie im wyższa tym bardziej w lewo
		width = math.random(6, 10),
    }, function()
        print('yes')
    end, function()
        print('no')
    end)
end)