return function(UIAPI)
    -- ====================================================================
    -- Creation of Tabs
    -- ====================================================================
    UIAPI.createSidebarTab("Play", "rbxassetid://10723345479", 1)
    UIAPI.createSidebarTab("Info", "rbxassetid://10723345479", 2)
    UIAPI.createSidebarTab("Settings", "rbxassetid://10723345479", 3)

    -- ====================================================================
    -- Client Tab Content (Info Section)
    -- ====================================================================
    UIAPI.createCustomButton("Info", "Discord", "Join to Our Discord Server", function()
        local link = "https://discord.gg"
        
        if setclipboard then
            setclipboard(link)
        elseif toclipboard then
            toclipboard(link)
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "IOHUB Link",
            Text = "🔗 Discord Invite link copied to clipboard!",
            Duration = 2
        })
    end)

    local playGroup = UIAPI.createDropdownSection("Info", "Book Supported")

UIAPI.createButton(playGroup, "Control All Chapter", "", function()
    
end)

UIAPI.createButton(playGroup, "Jelousy Book 2 Chapter 4", "", function()
    
end)

UIAPI.createButton(playGroup, "Jelousy Book 2 Chapter 3", "", function()
    
end)

UIAPI.createButton(playGroup, "Rage Chapter 1", "", function()
    
end)


    -- ====================================================================
    -- AUTO LOAD SAVED BUTTON
    -- ====================================================================
    UIAPI.createCustomButton("Play", "Auto Load Saved", "Auto Load Saved Game", function()
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local mimicSaveSync = replicatedStorage:FindFirstChild("MimicSaveSync")
        
        if mimicSaveSync and mimicSaveSync:IsA("RemoteEvent") then
            pcall(function()
                mimicSaveSync:FireServer(0, 1)
            end)
            
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "IOHUB",
                    Text = "Success",
                    Duration = 3,
                })
            end)
        else
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "IOHUB",
                    Text = "Not Found",
                    Duration = 3,
                })
            end)
        end
    end)

    -- ====================================================================
    -- SOLO & MULTIPLAYER LOBBY BUTTONS
    -- ====================================================================
    UIAPI.createCustomButton("Play", "Control Chapter 1 Solo (Nightmare)", "Create and Start Game", function()
        task.spawn(function()
            local lobbyRemote = game:GetService("ReplicatedStorage"):FindFirstChild("LobbyInterface") 
                and game.ReplicatedStorage.LobbyInterface:FindFirstChild("Networking") 
                and game.ReplicatedStorage.LobbyInterface.Networking:FindFirstChild("Lobby")
                
            if lobbyRemote then
                lobbyRemote:FireServer(
                    "RequestCreate",
                    {
                        ["Chapter"] = 1,
                        ["Mode"] = "Nightmare",
                        ["Book"] = "Control",
                    }
                )
                
                task.wait(0.1)
                lobbyRemote:FireServer("StartLobby")
                
                pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Solo Lobby", Text = "Naisimula na ang Solo Match!", Duration = 2}) end)
            else
                pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Error", Text = "Hindi mahanap ang Lobby Remote!", Duration = 2}) end)
            end
        end)
    end)

    -- ====================================================================
    -- SETTINGS BUTTONS
    -- ====================================================================
    UIAPI.createCustomButton("Settings", "DayTime/Morning", "Leave to the Darkness", function()
        local lighting = game:GetService("Lighting")
        
        pcall(function()
            lighting.ClockTime = 14
            lighting.Brightness = 3
            lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
            lighting.Ambient = Color3.fromRGB(150, 150, 150)
            lighting.GlobalShadows = false
            
            for _, child in ipairs(lighting:GetChildren()) do
                if child:IsA("Atmosphere") then
                    child.Density = 0
                    child.Haze = 0
                    child.Color = Color3.fromRGB(255, 255, 255)
                    child.Decay = Color3.fromRGB(255, 255, 255)
                elseif child:IsA("ColorCorrectionEffect") then
                    child.TintColor = Color3.fromRGB(255, 255, 255)
                    child.Saturation = 0.1
                    child.Contrast = 0.1
                elseif child:IsA("Sky") then
                    child.StarCount = 0
                elseif child:IsA("PointLight") or child:IsA("SpotLight") then
                    child.Brightness = 5
                    child.Range = 60
                end
            end
        end)
        
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Settings Updated",
                Text = "The DayTime Morning Activated",
                Duration = 2.5
            })
        end)
    end)

    -- Default active tab
    UIAPI.switchTab("Play")
end
