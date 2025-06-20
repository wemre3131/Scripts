-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("bizim scriptler", "Sentinel")

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

-- ========== MAIN TAB ==========
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Scripts")

-- Safe Script Loader
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
    MainSection:NewButton(script[1], script[2], function()
        LoadScript(script[3], script[1])
    end)
end

-- Special case for Bee Swarm
MainSection:NewButton("Bee Swarm Simulator", "Auto Farm and Auto Find!", function()
    pcall(function()
        local objects = game:GetObjects("rbxassetid://4384103988")
        if #objects > 0 then
            objects[1].Source("Pepsi Swarm")
            Notify("Script Loaded", "Bee Swarm Simulator")
        end
    end)
end)

-- ========== PLAYER TAB ==========
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")

-- Movement Controls
local flySpeed = 50
local flying = false
local bv, bg, flyConn
local flyingDir = {w=false, a=false, s=false, d=false}
local originalWalkspeed = 16
local originalJumppower = 50

-- Get Humanoid safely
local function GetHumanoid()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

-- Fly System
local function ToggleFly()
    flying = not flying
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if flying then
        bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bg = Instance.new("BodyGyro", hrp)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        
        flyConn = RunService.Heartbeat:Connect(function()
            local camCF = workspace.CurrentCamera.CFrame
            local moveVec = Vector3.new()
            if flyingDir.w then moveVec += camCF.LookVector end
            if flyingDir.s then moveVec -= camCF.LookVector end
            if flyingDir.a then moveVec -= camCF.RightVector end
            if flyingDir.d then moveVec += camCF.RightVector end
            
            bv.Velocity = moveVec.Unit * flySpeed
            bg.CFrame = camCF
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
    Notify("Fly", flying and "Enabled" or "Disabled")
end

-- Input Handling for Fly
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then flyingDir.w = true end
    if input.KeyCode == Enum.KeyCode.A then flyingDir.a = true end
    if input.KeyCode == Enum.KeyCode.S then flyingDir.s = true end
    if input.KeyCode == Enum.KeyCode.D then flyingDir.d = true end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then flyingDir.w = false end
    if input.KeyCode == Enum.KeyCode.A then flyingDir.a = false end
    if input.KeyCode == Enum.KeyCode.S then flyingDir.s = false end
    if input.KeyCode == Enum.KeyCode.D then flyingDir.d = false end
end)

-- Player Controls
PlayerSection:NewSlider("Walkspeed", "Change your speed", 500, 16, function(s)
    local humanoid = GetHumanoid()
    if humanoid then
        originalWalkspeed = s
        humanoid.WalkSpeed = s
    end
end)

PlayerSection:NewSlider("Jumppower", "Change jump height", 500, 50, function(s)
    local humanoid = GetHumanoid()
    if humanoid then
        originalJumppower = s
        humanoid.JumpPower = s
    end
end)

PlayerSection:NewButton("TP Tool", "Click to teleport", function()
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
end)

PlayerSection:NewButton("Noclip", "Walk through walls", function()
    local noclip = false
    local conn
    
    local function ToggleNoclip()
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
    
    ToggleNoclip()
end)

PlayerSection:NewButton("R15 To R6 (FE)", "Change animation", function()
    LoadScript("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", "R15 to R6")
end)

PlayerSection:NewButton("Fly (V to toggle)", "Toggle flight mode", function()
    ToggleFly()
end)

PlayerSection:NewSlider("Fly Speed", "Adjust fly speed", 300, 50, function(val)
    flySpeed = val
end)

-- ====== NEW FEATURES ======
-- ESP System
local espEnabled = false
local espCache = {}

PlayerSection:NewButton("ESP Toggle", "See players through walls", function()
    espEnabled = not espEnabled
    
    if espEnabled then
        -- Create ESP for existing players
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillTransparency = 0.8
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                highlight.Parent = player.Character
                espCache[player] = highlight
            end
        end
        
        -- Connect to new players
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
        -- Remove all ESP
        for player, highlight in pairs(espCache) do
            highlight:Destroy()
        end
        table.clear(espCache)
        Notify("ESP", "Disabled")
    end
end)

-- Server Functions
PlayerSection:NewButton("Server Hop", "Join a new server", function()
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
end)

PlayerSection:NewButton("Rejoin", "Rejoin current server", function()
    Notify("Rejoin", "Rejoining server...")
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- Anti-AFK System
local antiAfkEnabled = false
local antiAfkConnection

PlayerSection:NewButton("Anti-AFK Toggle", "Prevent being kicked for idling", function()
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
end)

-- ========== INFECTIOUS SMILE TAB ==========
local InfectiousTab = Window:NewTab("Infectious Smile")
local InfectiousSmileSection = InfectiousTab:NewSection("Infectious Smile")

local tools = {"Bat", "Bottle", "Branch", "Katana", "Spear", "Chain", "Hatchet", "Knife"}

for _, tool in ipairs(tools) do
    InfectiousSmileSection:NewButton("No "..tool.." Cooldown", "Removes cooldown when holding "..tool, function()
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(tool) then
                local cooldown = LocalPlayer.Character[tool]:FindFirstChild("Cooldown")
                if cooldown then
                    cooldown.Value = 0
                    Notify("Cooldown Removed", tool)
                end
            end
        end)
    end)
end

-- Initialize Anti-AFK by default
antiAfkConnection = LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
antiAfkEnabled = true

Notify("Script Loaded", "bizim scriptler is ready!", 5)
