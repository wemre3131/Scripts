-- Load Pepsi's UI Library
local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Window = Library:CreateWindow("bizim scriptler")

-- Core Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- Notification Function
local function Notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
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
    for _, server in ipairs(game:GetService("HttpService"):JSONDecode(req).data) do
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
local MainTab = Window:AddTab("Main")
local MainSection = MainTab:AddSection("Scripts")

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
    MainSection:AddButton({
        Text = script[1],
        Description = script[2],
        Callback = function()
            LoadScript(script[3], script[1])
        end
    })
end

-- Special case for Bee Swarm
MainSection:AddButton({
    Text = "Bee Swarm Simulator",
    Description = "Auto Farm and Auto Find!",
    Callback = function()
        pcall(function()
            local objects = game:GetObjects("rbxassetid://4384103988")
            if #objects > 0 then
                objects[1].Source("Pepsi Swarm")
                Notify("Script Loaded", "Bee Swarm Simulator")
            end
        end)
    end
})

-- Player Tab
local PlayerTab = Window:AddTab("Player")
local PlayerSection = PlayerTab:AddSection("Player")

-- Player Controls
PlayerSection:AddSlider({
    Text = "Walkspeed",
    Description = "Change your speed",
    Min = 16,
    Max = 500,
    Default = 16,
    Callback = function(s)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.WalkSpeed = s
        end
    end
})

PlayerSection:AddSlider({
    Text = "Jumppower",
    Description = "Change jump height",
    Min = 50,
    Max = 500,
    Default = 50,
    Callback = function(s)
        local humanoid = GetHumanoid()
        if humanoid then
            humanoid.JumpPower = s
        end
    end
})

PlayerSection:AddButton({
    Text = "TP Tool",
    Description = "Click to teleport",
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
    end
})

PlayerSection:AddButton({
    Text = "Noclip",
    Description = "Walk through walls",
    Callback = ToggleNoclip
})

PlayerSection:AddButton({
    Text = "R15 To R6 (FE)",
    Description = "Change animation",
    Callback = function()
        LoadScript("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", "R15 to R6")
    end
})

PlayerSection:AddButton({
    Text = "Fly (V to toggle)",
    Description = "Toggle flight mode",
    Callback = IYtoggleFlight
})

PlayerSection:AddSlider({
    Text = "Fly Speed",
    Description = "Adjust fly speed",
    Min = 20,
    Max = 300,
    Default = 50,
    Callback = function(val)
        IYflySpeed = val
    end
})

PlayerSection:AddButton({
    Text = "ESP Toggle",
    Description = "See players through walls",
    Callback = ToggleESP
})

PlayerSection:AddButton({
    Text = "Server Hop",
    Description = "Join a new server",
    Callback = ServerHop
})

PlayerSection:AddButton({
    Text = "Rejoin",
    Description = "Rejoin current server",
    Callback = Rejoin
})

PlayerSection:AddButton({
    Text = "Anti-AFK Toggle",
    Description = "Prevent being kicked for idling",
    Callback = ToggleAntiAFK
})

-- Infectious Smile Tab
local InfectiousTab = Window:AddTab("Infectious Smile")
local InfectiousSmileSection = InfectiousTab:AddSection("Infectious Smile")

local tools = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}

for _, tool in ipairs(tools) do
    InfectiousSmileSection:AddButton({
        Text = "No "..tool.." Cooldown",
        Description = "Removes cooldown when holding "..tool,
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
        end
    })
end

Notify("Script Loaded", "bizim scriptler is ready!", 5)
