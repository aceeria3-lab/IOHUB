local currentId = game.PlaceId
local function boot(msg, url)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "IOHUB", Text = msg, Duration = 3})
    
    -- I-load ang main UI muna para lumitaw ang window, toggle button, at 'F' shortcut
    local success, UIAPI = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/main.lua"))()
    end)

    if success and UIAPI then
        -- Kunin at i-load ang partikular na script para sa game na ito, at ipasa ang UIAPI
        task.spawn(function()
            local gameScript = loadstring(game:HttpGet(url))
            if gameScript then
                gameScript(UIAPI) -- Ipinapasa natin ang UIAPI para magamit ng game script sa paggawa ng buttons!
            end
        end)
    else
        warn("IOHUB: Nabigong i-load ang main.lua UI framework.")
    end
end

-- Listahan ng lahat ng Control Place IDs
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
else 
    boot("Loading Default Loader...", "https://raw.githubusercontent.com/Moymoy21/IOHUB/refs/heads/main/main.txt")
end
