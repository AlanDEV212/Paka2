Config = {}
Config.Locale = 'en'

Config.RequiredCopsRob = 6
Config.RequiredCopsSell = 0
Config.MinJewels = 0
Config.MaxJewels = 5
Config.MaxWindows = 1
Config.MaxDoors = 1
Config.SecBetwNextRob = 2700 -- 45 minutes
Config.MaxJewelsSell = 20
Config.PriceForOneJewel = 500
Config.EnableMarker = true
Config.NeedBag = false

Config.Borsoni = {40, 41, 44, 45}

Stores = {
	["Bank Pacific"] = {
		position = { ['x'] = 262.16, ['y'] = 224.56, ['z'] = 101.68 },       
		nameofstore = "Bank Pacific",
		lastrobbed = 0
	},
}

Config.SmallBanks = {
    [1] = {
        ["label"] = "Bank Pacific",
        ["coords"] = {
            ["x"] = 253.28,
            ["y"] = 228.4,
            ["z"] = 101.68,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("v_ilev_bk_vaultdoor"),
        ["heading"] = {
            closed = 160.00001,
            open = 70.00001,
        },
        ["camId"] = 21,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = 258.6,  
                y = 218.36,
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = 260.8, 
                y = 217.6, 
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = 259.44, 
                y = 213.8, 
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = 257.16, 
                y = 214.56,
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = 263.76,
                y = 216.44, 
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = 265.8,
                y = 215.8, 
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = 264.32, 
                y = 212.0,
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = 262.52, 
                y = 212.64,
                z = 101.68, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },  
}