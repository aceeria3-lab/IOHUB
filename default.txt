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

    UIAPI.createCustomButton("Info", "Book Supported", "Show what Book/Chapter Available", function()
        local player = game:GetService("Players").LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")
        local tweenService = game:GetService("TweenService")
        
        local availableBooks = {
            "• Rage Book 3 Chapter 1",
            "• Jealousy Book 2 Chapter 4",
            "• Jealousy Book 2 Chapter 3",
            "• Control All Chapter",
        }
        
        local combinedText = table.concat(availableBooks, "\n")
        
        -- SMART SIZE ADJUSTMENT
        local baseHeight = 110
        local heightPerBook = 20
        local dynamicHeight = baseHeight + (#availableBooks * heightPerBook)
        
        -- I-minimize ang main menu gamit ang UIAPI function
        UIAPI.minimizeMenu()
        
        -- Burado ang lumang central UI kung meron man
        if playerGui:FindFirstChild("IOHUB_CenterMenu") then
            playerGui.IOHUB_CenterMenu:Destroy()
        end
        
        -- CREATING THE CENTRAL UI WINDOW
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "IOHUB_CenterMenu"
        screenGui.ResetOnSpawn = false
        screenGui.DisplayOrder = 99999 
        
        local mainFrameCenter = Instance.new("Frame")
        mainFrameCenter.Name = "MainFrameCenter"
        mainFrameCenter.Size = UDim2.new(0, 340, 0, dynamicHeight)
        mainFrameCenter.Position = UDim2.new(0.5, -170, 0.5, -(dynamicHeight / 2))
        mainFrameCenter.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        mainFrameCenter.BackgroundTransparency = 0.05
        mainFrameCenter.BorderSizePixel = 0
        mainFrameCenter.Parent = screenGui
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 10)
        uiCorner.Parent = mainFrameCenter
        
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Color = Color3.fromRGB(60, 60, 60)
        uiStroke.Thickness = 1.5
        uiStroke.Parent = mainFrameCenter
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, 0, 0, 40)
        titleLabel.Position = UDim2.new(0, 0, 0, 8)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "Book Supported"
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 20
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Parent = mainFrameCenter
        
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, -30, 1, -55)
        contentLabel.Position = UDim2.new(0, 15, 0, 50)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = combinedText
        contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        contentLabel.TextSize = 14
        contentLabel.Font = Enum.Font.GothamMedium
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextYAlignment = Enum.TextYAlignment.Top
        contentLabel.Parent = mainFrameCenter
        
        screenGui.Parent = playerGui
        
        -- AUTOMATIC FADE OUT AT RE-OPEN NG MAIN GUI
        task.spawn(function()
            task.wait(2.7)
            
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local fadeFrame = tweenService:Create(mainFrameCenter, tweenInfo, {BackgroundTransparency = 1})
            local fadeTitle = tweenService:Create(titleLabel, tweenInfo, {TextTransparency = 1})
            local fadeContent = tweenService:Create(contentLabel, tweenInfo, {TextTransparency = 1})
            local fadeStroke = tweenService:Create(uiStroke, tweenInfo, {Transparency = 1})
            
            fadeFrame:Play()
            fadeTitle:Play()
            fadeContent:Play()
            fadeStroke:Play()
            
            task.wait(0.3)
            screenGui:Destroy()
            
            -- I-bukas ulit ang main menu gamit ang UIAPI function
            UIAPI.openMenu()
        end)
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
