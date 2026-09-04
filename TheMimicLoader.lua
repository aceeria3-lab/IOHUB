local currentId = game.PlaceId

local function boot(msg, url)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "IOHUB", Text = msg, Duration = 3})
    
    -- 1. I-load ang purong GUI mula sa main.lua
    local success, UIAPI = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/aceeria3-lab/IOHUB/refs/heads/main/UISetup.lua"))()
    end)

    -- 2. Kung pumasok ang UI, i-load ang kaukulang script base sa Place ID
    if success and UIAPI then
        task.spawn(function()
            local gameScriptFunc = loadstring(game:HttpGet(url))
            if gameScriptFunc then
                local scriptSuccess, gameScript = pcall(gameScriptFunc)
                if scriptSuccess and type(gameScript) == "function" then
                    gameScript(UIAPI)
                end
            end
        end)
    else
        warn("IOHUB: Nabigong i-load ang main.lua GUI.")
    end
end

-- Listahan ng Control Place IDs
local controlIds = {
    6296321810, 6301638949, 6373539583, 7251865082, 7251866503, 
    7251867155, 7251867574, 6485055338, 6485055836, 6485056556, 
    6688734180, 6688734313, 6688734395, 6479231833, 6480994221, 
    6406571212, 6425178683, 6472459099, 6682163754, 6682164423, 
    7265396387, 7265396805, 7265397072, 7265397848, 7618863566
}

if currentId == 128715637193371 then 
    boot("Rage Book 3 Chapter 1", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/b3c1.txt")

elseif currentId == 96354063422506 then 
    boot("Jelousy Book 2 Chapter 4", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/b2c4v2.txt")
    
elseif currentId == 15962819441 then 
    boot("Jelousy Book 2 Chapter 3", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/b2c3.txt")
    
elseif table.find(controlIds, currentId) then
    boot("Control Book All Chapters", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/control.txt")

-- =========================================================================
-- KUNG HINDI NADE-DETECT ANG PLACE ID (Dito mapupunta ang Default Buttons)
-- =========================================================================
else 
    boot("Loading Default Hub...", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/default.txt")
end
