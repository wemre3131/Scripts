-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "bizim scriptler",
    LoadingTitle = "bizim scriptler",
    LoadingSubtitle = "by bizim",
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false,
})

-- Core Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Notification Function
local function Notify(title, text, duration)
    Rayfield:Notify({
        Title = title,
        Content = text,
        Duration = duration or 3,
        Image = 4483362458,
    })
end

-- ========== INFINITE YIELD FLIGHT SYSTEM ==========
local IYflySpeed = 50
local IYflyKey = Enum.KeyCode.V
local IYflyDebounce = false
local IYflyToggled = false
local IYflyBv, IYflyGyro, IYflyConnection

local function IYenableFlight()
    if not LocalPlayer.Character then return end
    
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart or IYflyToggled then return end
    
    IYflyToggled = true
    IYflyBv = Instance.new("BodyVelocity", rootPart)
    IYflyBv.Velocity = Vector3.new(0, 0.1, 0)
    IYflyBv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    IYflyBv.P = 9e9
    
    IYflyGyro = Instance.new("BodyGyro", rootPart)
    IYflyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    IYflyGyro.P = 9e9
    IYflyGyro.CFrame = rootPart.CFrame
    
    humanoid.PlatformStand = true
    
    local camera = workspace.CurrentCamera
    local last = Vector3.new()
    
    IYflyConnection = RunService.Heartbeat:Connect(function()
        if not IYflyToggled or not LocalPlayer.Character then
            return
        end
        
        local direction = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit * IYflySpeed
            last = direction
        else
            direction = last * 0.9
            if math.abs(direction.X) < 0.1 and math.abs(direction.Z) < 0.1 then
                direction = Vector3.new(0, 0, 0)
                last = direction
            end
        end
        
        IYflyBv.Velocity = Vector3.new(direction.X, 0, direction.Z)
        IYflyGyro.CFrame = CFrame.new(rootPart.Position, rootPart.Position + camera.CFrame.LookVector)
    end)
    
    Notify("Flight", "Enabled (V to toggle)")
end

local function IYdisableFlight()
    if not IYflyToggled then return end
    
    IYflyToggled = false
    if IYflyBv then IYflyBv:Destroy() end
    if IYflyGyro then IYflyGyro:Destroy() end
    if IYflyConnection then IYflyConnection:Disconnect() end
    
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.PlatformStand = false end
    
    Notify("Flight", "Disabled")
end

local function IYtoggleFlight()
    if IYflyDebounce then return end
    IYflyDebounce = true
    
    if IYflyToggled then
        IYdisableFlight()
    else
        IYenableFlight()
    end
    
    task.wait(0.2)
    IYflyDebounce = false
end

-- Connect key press
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == IYflyKey then
        IYtoggleFlight()
    end
end)

-- Character added event to reset flight
LocalPlayer.CharacterAdded:Connect(function()
    IYdisableFlight()
end)

-- ========== SCRIPT LOADER ==========
local function LoadScript(url, name)
    local success, err = pcall(function()
        local content = game:HttpGet(url, true)
        loadstring(content)()
        Notify("Script Loaded", name or "Script")
    end)
    if not success then
        Notify("Error", "Failed to load "..(name or "script"), 5)
        warn("Script Error ("..name.."): "..err)
    end
end

-- ========== PLAYER UTILITIES ==========
local function GetHumanoid()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function ToggleNoclip()
    local noclip = false
    local conn
    
    local function ToggleState()
        noclip = not noclip
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not noclip
                end
            end
        end
        Notify("Noclip", noclip and "Enabled" or "Disabled")
    end
    
    if not conn then
        conn = RunService.Stepped:Connect(function()
            if noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    ToggleState()
end

-- ========== COMBAT FEATURES ==========
-- Hitbox Expander
local hitboxSize = 5
local hitboxEnabled = false
local hitboxConnections = {}

local function ToggleHitbox()
    hitboxEnabled = not hitboxEnabled
    
    if hitboxEnabled then
        Notify("Hitbox Expander", "Enabled")
        
        local function expandHitbox(character)
            if character == LocalPlayer.Character then return end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            
            -- Create hitbox part
            local hitbox = Instance.new("Part")
            hitbox.Name = "HitboxExpander"
            hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            hitbox.Transparency = 0.7
            hitbox.Color = Color3.fromRGB(255, 0, 0)
            hitbox.CanCollide = false
            hitbox.Anchored = true
            hitbox.CFrame = rootPart.CFrame
            hitbox.Parent = workspace
            
            -- Weld to character
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = hitbox
            weld.C0 = CFrame.new()
            weld.Parent = hitbox
            
            -- Store for removal
            hitboxConnections[character] = hitbox
            
            -- Cleanup when character dies
            humanoid.Died:Once(function()
                if hitbox and hitbox.Parent then
                    hitbox:Destroy()
                end
                hitboxConnections[character] = nil
            end)
        end
        
        -- Apply to existing players
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                expandHitbox(player.Character)
            end
        end
        
        -- Apply to new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if hitboxEnabled then
                    expandHitbox(character)
                end
            end)
        end)
    else
        -- Remove all hitboxes
        for _, hitbox in pairs(hitboxConnections) do
            if hitbox and hitbox.Parent then
                hitbox:Destroy()
            end
        end
        table.clear(hitboxConnections)
        Notify("Hitbox Expander", "Disabled")
    end
end

-- Invisible Fling
local flingEnabled = false
local flingForce = 10000
local originalTransparency = {}
local flingParts = {}

local function ToggleInvisibleFling()
    flingEnabled = not flingEnabled
    
    if flingEnabled then
        Notify("Invisible Fling", "Enabled - Click on players to fling")
        
        -- Save original transparency and make character invisible
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    originalTransparency[part] = part.Transparency
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end
        end
        
        -- Create fling parts
        local rootPart = GetRootPart()
        if rootPart then
            local flingPart = Instance.new("Part")
            flingPart.Size = Vector3.new(5, 5, 5)
            flingPart.Transparency = 1
            flingPart.CanCollide = false
            flingPart.Anchored = false
            flingPart.CFrame = rootPart.CFrame
            flingPart.Parent = workspace
            
            local velocity = Instance.new("BodyVelocity", flingPart)
            velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            velocity.Velocity = Vector3.new(0, 0, 0)
            
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = flingPart
            weld.C0 = CFrame.new()
            weld.Parent = flingPart
            
            flingParts[#flingParts + 1] = flingPart
        end
        
        -- Mouse click to fling
        Mouse.Button1Down:Connect(function()
            if not flingEnabled then return end
            
            local target = Mouse.Target
            if target then
                local model = target:FindFirstAncestorOfClass("Model")
                if model then
                    local humanoid = model:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.RootPart then
                        -- Apply fling force
                        humanoid.RootPart.Velocity = Vector3.new(
                            math.random(-flingForce, flingForce),
                            math.random(flingForce/2, flingForce),
                            math.random(-flingForce, flingForce)
                        )
                        Notify("Fling", "Flinging "..(model.Name or "target"))
                    end
                end
            end
        end)
    else
        -- Restore original transparency
        for part, transparency in pairs(originalTransparency) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        table.clear(originalTransparency)
        
        -- Remove fling parts
        for _, part in ipairs(flingParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        table.clear(flingParts)
        
        Notify("Invisible Fling", "Disabled")
    end
end

-- Spinbot
local spinbotEnabled = false
local spinbotSpeed = 20
local spinbotConnection

local function ToggleSpinbot()
    spinbotEnabled = not spinbotEnabled
    
    if spinbotEnabled then
        Notify("Spinbot", "Enabled")
        local rootPart = GetRootPart()
        if not rootPart then return end
        
        spinbotConnection = RunService.Heartbeat:Connect(function()
            if spinbotEnabled and rootPart then
                rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinbotSpeed), 0)
            end
        end)
    else
        if spinbotConnection then
            spinbotConnection:Disconnect()
            spinbotConnection = nil
        end
        Notify("Spinbot", "Disabled")
    end
end

-- Auto Clicker
local autoClickerEnabled = false
local clickInterval = 0.1
local autoClickerConnection

local function ToggleAutoClicker()
    autoClickerEnabled = not autoClickerEnabled
    
    if autoClickerEnabled then
        Notify("Auto Clicker", "Enabled")
        autoClickerConnection = RunService.Heartbeat:Connect(function()
            if autoClickerEnabled then
                mouse1click()
                wait(clickInterval)
            end
        end)
    else
        if autoClickerConnection then
            autoClickerConnection:Disconnect()
            autoClickerConnection = nil
        end
        Notify("Auto Clicker", "Disabled")
    end
end

-- Kill Aura
local killAuraEnabled = false
local killAuraRange = 25
local killAuraConnection

local function ToggleKillAura()
    killAuraEnabled = not killAuraEnabled
    
    if killAuraEnabled then
        Notify("Kill Aura", "Enabled")
        killAuraConnection = RunService.Heartbeat:Connect(function()
            if not killAuraEnabled then return end
            local rootPart = GetRootPart()
            if not rootPart then return end
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    
                    if targetRoot and humanoid and humanoid.Health > 0 then
                        local distance = (rootPart.Position - targetRoot.Position).Magnitude
                        if distance <= killAuraRange then
                            -- Simulate damage
                            humanoid:TakeDamage(25)
                        end
                    end
                end
            end
        end)
    else
        if killAuraConnection then
            killAuraConnection:Disconnect()
            killAuraConnection = nil
        end
        Notify("Kill Aura", "Disabled")
    end
end

-- ========== ESP SYSTEM ==========
local espEnabled = false
local espCache = {}

local function ToggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillTransparency = 0.8
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                highlight.Parent = player.Character
                espCache[player] = highlight
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                if espEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.FillTransparency = 0.8
                    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                    highlight.Parent = character
                    espCache[player] = highlight
                end
            end)
        end)
        Notify("ESP", "Enabled")
    else
        for player, highlight in pairs(espCache) do
            highlight:Destroy()
        end
        table.clear(espCache)
        Notify("ESP", "Disabled")
    end
end

-- ========== SERVER FUNCTIONS ==========
local function ServerHop()
    Notify("Server Hop", "Finding new server...")
    
    local servers = {}
    local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100")
    for _, server in ipairs(HttpService:JSONDecode(req).data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end
    
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
    else
        Notify("Server Hop", "No servers found!", 5)
    end
end

local function Rejoin()
    Notify("Rejoin", "Rejoining server...")
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

-- ========== ANTI-AFK SYSTEM ==========
local antiAfkEnabled = true
local antiAfkConnection

local function ToggleAntiAFK()
    antiAfkEnabled = not antiAfkEnabled
    
    if antiAfkEnabled then
        antiAfkConnection = LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
        Notify("Anti-AFK", "Enabled")
    else
        if antiAfkConnection then
            antiAfkConnection:Disconnect()
            antiAfkConnection = nil
        end
        Notify("Anti-AFK", "Disabled")
    end
end

-- Initialize Anti-AFK
antiAfkConnection = LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- ========== CREATE UI ==========
-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)
local MainSection = MainTab:CreateSection("Scripts")

-- Script Buttons
local scripts = {
    {"Infinite Yield", "Admin commands GUI", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {"MM2 Script", "Murder Mystery 2 script", "https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"},
    {"Arsenal Script", "Arsenal", "https://pastebin.com/raw/G6Ubkkuv"},
    {"Fling ALL Script", "Fling all", "https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"},
    {"Air Hub Script", "Air Hub", "https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"},
    {"Jerk off R6 Script", "Jerk Off", "https://pastefy.app/wa3v2Vgm/raw"},
    {"Jerk off R15 Script", "Jerk Off", "https://pastefy.app/YZoglOyJ/raw"},
    {"Azure Script", "Azure", "https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"},
    {"Blox Fruit Script", "Blox Fruits", "https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"},
    {"Grow a Garden Script", "GAG", "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"},
    {"Forsaken Script", "Forsaken", "https://rifton.top/loader.lua"},
    {"Bedwars Script", "Kill Aura and More", "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"},
    {"FE Emote", "All Emotes Keybind Open is Comma", "https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"}
}

for _, script in ipairs(scripts) do
    MainSection:CreateButton({
        Name = script[1],
        Callback = function()
            LoadScript(script[3], script[1])
        end,
        Description = script[2]
    })
end

-- Special case for Bee Swarm
MainSection:CreateButton({
    Name = "Bee Swarm Simulator",
    Callback = function()
        pcall(function()
            local objects = game:GetObjects("rbxassetid://4384103988")
            if #objects > 0 then
                objects[1].Source("Pepsi Swarm")
                Notify("Script Loaded", "Bee Swarm Simulator")
            end
        end)
    end,
    Description = "Auto Farm and Auto Find!"
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)
local PlayerSection = PlayerTab:CreateSection("Movement")

-- Player Controls
PlayerSection:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(s)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.WalkSpeed = s
        end
    end,
    Description = "Change your speed"
})

PlayerSection:CreateSlider({
    Name = "Jumppower",
    Range = {50, 500},
    Increment = 1,
    Suffix = "power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(s)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.JumpPower = s
        end
    end,
    Description = "Change jump height"
})

PlayerSection:CreateButton({
    Name = "TP Tool",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Tp tool(Equip to Click TP)"
        tool.Activated:Connect(function()
            local pos = Mouse.Hit + Vector3.new(0, 2.5, 0)
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
            end
        end)
        tool.Parent = LocalPlayer.Backpack
        Notify("TP Tool", "Added to backpack")
    end,
    Description = "Click to teleport"
})

PlayerSection:CreateButton({
    Name = "Noclip",
    Callback = ToggleNoclip,
    Description = "Walk through walls"
})

PlayerSection:CreateButton({
    Name = "R15 To R6 (FE)",
    Callback = function()
        LoadScript("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", "R15 to R6")
    end,
    Description = "Change animation"
})

PlayerSection:CreateButton({
    Name = "Fly (V to toggle)",
    Callback = IYtoggleFlight,
    Description = "Toggle flight mode"
})

PlayerSection:CreateSlider({
    Name = "Fly Speed",
    Range = {20, 300},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = 50,
    Flag = "FlySpeed",
    Callback = function(val)
        IYflySpeed = val
    end,
    Description = "Adjust fly speed"
})

-- Combat Section
local CombatSection = PlayerTab:CreateSection("Combat")

CombatSection:CreateButton({
    Name = "Hitbox Expander",
    Callback = ToggleHitbox,
    Description = "Make player hitboxes larger"
})

CombatSection:CreateSlider({
    Name = "Hitbox Size",
    Range = {2, 15},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 5,
    Flag = "HitboxSize",
    Callback = function(val)
        hitboxSize = val
    end,
    Description = "Set hitbox expansion size"
})

CombatSection:CreateButton({
    Name = "Invisible Fling",
    Callback = ToggleInvisibleFling,
    Description = "Become invisible and fling players"
})

CombatSection:CreateSlider({
    Name = "Fling Force",
    Range = {5000, 25000},
    Increment = 100,
    Suffix = "force",
    CurrentValue = 10000,
    Flag = "FlingForce",
    Callback = function(val)
        flingForce = val
    end,
    Description = "Set fling power"
})

CombatSection:CreateButton({
    Name = "Spinbot",
    Callback = ToggleSpinbot,
    Description = "Spin rapidly to avoid attacks"
})

CombatSection:CreateSlider({
    Name = "Spin Speed",
    Range = {5, 50},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = 20,
    Flag = "SpinSpeed",
    Callback = function(val)
        spinbotSpeed = val
    end,
    Description = "Set rotation speed"
})

CombatSection:CreateButton({
    Name = "Auto Clicker",
    Callback = ToggleAutoClicker,
    Description = "Automatically click mouse"
})

CombatSection:CreateSlider({
    Name = "Click Interval",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "seconds",
    CurrentValue = 0.1,
    Flag = "ClickInterval",
    Callback = function(val)
        clickInterval = val
    end,
    Description = "Set click frequency"
})

CombatSection:CreateButton({
    Name = "Kill Aura",
    Callback = ToggleKillAura,
    Description = "Automatically damage nearby players"
})

CombatSection:CreateSlider({
    Name = "Kill Aura Range",
    Range = {5, 50},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 25,
    Flag = "KillAuraRange",
    Callback = function(val)
        killAuraRange = val
    end,
    Description = "Set attack distance"
})

-- Utility Section
local UtilitySection = PlayerTab:CreateSection("Utility")

UtilitySection:CreateButton({
    Name = "ESP Toggle",
    Callback = ToggleESP,
    Description = "See players through walls"
})

UtilitySection:CreateButton({
    Name = "Server Hop",
    Callback = ServerHop,
    Description = "Join a new server"
})

UtilitySection:CreateButton({
    Name = "Rejoin",
    Callback = Rejoin,
    Description = "Rejoin current server"
})

UtilitySection:CreateButton({
    Name = "Anti-AFK Toggle",
    Callback = ToggleAntiAFK,
    Description = "Prevent being kicked for idling"
})

-- Infectious Smile Tab
local InfectiousTab = Window:CreateTab("Infectious Smile", 4483362458)
local InfectiousSmileSection = InfectiousTab:CreateSection("Infectious Smile")

local tools = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}

for _, tool in ipairs(tools) do
    InfectiousSmileSection:CreateButton({
        Name = "No "..tool.." Cooldown",
        Callback = function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(tool) then
                    local cooldown = LocalPlayer.Character[tool]:FindFirstChild("Cooldown")
                    if cooldown then
                        cooldown.Value = 0
                        Notify("Cooldown Removed", tool)
                    end
                end
            end)
        end,
        Description = "Removes cooldown when holding "..tool
    })
end

Notify("Script Loaded", "bizim scriptler is ready!", 5)
