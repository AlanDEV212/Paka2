Config = {}
Config.Locale = 'en'

Config.RequiredCopsRob = 5
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
	["Bank Alta"] = {
		position = { ['x'] = 309.96, ['y'] = -282.84, ['z'] = 54.16 },       
		nameofstore = "Bank Alta",
		lastrobbed = 0
	},
	["Bank Legion Square"] = {
		position = { ['x'] = 145.36, ['y'] = -1044.6, ['z'] = 29.36 },       
		nameofstore = "Bank Legion Square",
		lastrobbed = 0
	},
    ["Bank Burton"] = {
		position = { ['x'] = -354.88, ['y'] = -53.84, ['z'] = 49.04 },       
		nameofstore = "Bank Burton",
		lastrobbed = 0
	},
    ["Bank Rockford Hills"] = {
		position = { ['x'] = -1212.84, ['y'] = -336.56, ['z'] = 37.84 },       
		nameofstore = "Bank Rockford Hills",
		lastrobbed = 0
	},
    ["Bank Banham Canyon"] = {
		position = { ['x'] = -2957.48, ['y'] = 479.88, ['z'] = 15.72 },       
		nameofstore = "Bank Banham Canyon",
		lastrobbed = 0
	},
}


Config.SmallBanks = {
    [1] = {
        ["label"] = "Alta",
        ["coords"] = {
            ["x"] = 311.15,
            ["y"] = -284.49,
            ["z"] = 54.16,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("v_ilev_gb_vauldr"),
        ["heading"] = {
            closed = 250.0,
            open = 160.0,
        },
        ["camId"] = 21,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = 311.16, 
                y = -287.71, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = 311.86, 
                y = -286.21, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = 313.39, 
                y = -289.15, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = 311.7, 
                y = -288.45, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = 314.23, 
                y = -288.77, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = 314.83, 
                y = -287.33, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = 315.24, 
                y = -284.85, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = 314.08, 
                y = -283.38, 
                z = 54.14, 
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },
    [2] = {
        ["label"] = "Legion Square",
        ["coords"] = {
            ["x"] = 146.92,
            ["y"] = -1046.11,
            ["z"] = 29.36,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("v_ilev_gb_vauldr"),
        ["heading"] = {
            closed = 250.0,
            open = 160.0,
        },
        ["camId"] = 22,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = 149.84, 
                y = -1044.9, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = 151.16, 
                y = -1046.64, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = 147.16, 
                y = -1047.72, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = 146.54, 
                y = -1049.28, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = 146.88, 
                y = -1050.33, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = 150.0, 
                y = -1050.67, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = 149.47, 
                y = -1051.28, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = 150.58, 
                y = -1049.09, 
                z = 29.34,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },
    [3] = {
        ["label"] = "Burton",
        ["coords"] = {
            ["x"] = -353.82,
            ["y"] = -55.37,
            ["z"] = 49.03,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("v_ilev_gb_vauldr"),
        ["heading"] = {
            closed = 250.0,
            open = 160.0,
        },
        ["camId"] = 23,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = -350.99, 
                y = -54.13, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = -349.53, 
                y = -55.77, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = -353.54, 
                y = -56.94, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = -354.09, 
                y = -58.55, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = -353.81, 
                y = -59.48, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = -349.8, 
                y = -58.3, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = -351.14, 
                y = -60.37, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = -350.4, 
                y = -59.92, 
                z = 49.01,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },
    [4] = {
        ["label"] = "Bank Rockford Hills",
        ["coords"] = {
            ["x"] = -1210.77,
            ["y"] = -336.57,
            ["z"] = 37.78,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("v_ilev_gb_vauldr"),
        ["heading"] = {
            closed = 296.863,
            open = 206.863,
        },
        ["camId"] = 24,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = -1209.68, 
                y = -333.65, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = -1207.46, 
                y = -333.77, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = -1209.45, 
                y = -337.47, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = -1208.65, 
                y = -339.06, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = -1207.75, 
                y = -339.42, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = -1205.28,
                y = -338.14, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = -1205.08, 
                y = -337.28, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = -1205.92, 
                y = -335.75, 
                z = 37.75,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },
    [5] = {
        ["label"] = "Bank Banham Canyon",
        ["coords"] = {
            ["x"] = -2956.55,
            ["y"] = 481.74,
            ["z"] = 15.69,
            ["open"] = false,
        },
        ["alarm"] = true,
        ["object"] = GetHashKey("hei_prop_heist_sec_door"),
        ["heading"] = {
            closed = 357.542,
            open = 267.542,
        },
        ["camId"] = 25,
        ["isOpened"] = false,
        ["lockers"] = {
            [1] = {
                x = -2958.54, 
                y = 484.1, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [2] = {
                x = -2957.3, 
                y = 485.95, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [3] = {
                x = -2955.09, 
                y = 482.43, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [4] = {
                x = -2953.26, 
                y = 482.42, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [5] = {
                x = -2952.63, 
                y = 483.09, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [6] = {
                x = -2952.45, 
                y = 485.66, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [7] = {
                x = -2953.13, 
                y = 486.26, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
            [8] = {
                x = -2954.98, 
                y = 486.37, 
                z = 15.67,
                ["isBusy"] = false,
                ["isOpened"] = false,
            },
        },
    },
}