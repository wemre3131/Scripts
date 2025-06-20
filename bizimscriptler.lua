local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("bizim scriptler", "Sentinel")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Scripts")

MainSection:NewButton("Infinite Yield", "Admin commands GUI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

MainSection:NewButton("MM2 Script", "Murder Mystery 2 script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)

MainSection:NewButton("Arsenal Script", "Arsenal", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)

MainSection:NewButton("Fling ALL Script", "Fling all", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

MainSection:NewButton("Air Hub Script", "Air Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

MainSection:NewButton("Jerk off R6 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

MainSection:NewButton("Jerk off R15 Script", "Jerk Off", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

MainSection:NewButton("Azure Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)

MainSection:NewButton("Blox Fruit Script", "Azure", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:NewButton("Blox Fruit Script", "Blox Fruits", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)

MainSection:NewButton("Grow a Garden Script", "GAG", function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)

MainSection:NewButton("Forsaken Script", "Forsaken", function()
    loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

MainSection:NewButton("Bedwars Script", "Kill Aura and More" , function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)

MainSection:NewButton("Bee Swarm Simulator", "Auto Farm and Auto Find!" , function()
    loadstring(game:GetObjects("rbxassetid://4384103988")[0X1].Source)("Pepsi Swarm")
end)

local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player")

PlayerSection:NewSlider("Walkspeed", "Change's your speed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("Jumppower", "Make's you jump High", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("TP Tool", "Click to Teleport" , function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Tp tool(Equip to Click TP)"
    tool.Activated:connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        pos = CFrame.new(pos.X, pos.Y, pos.Z)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

PlayerSection:NewButton("Noclip", "Walk threw Walls" , function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KcZxW1Sp"))()
end)

PlayerSection:NewButton("R15 To R6 (FE)", "Change's animation" , function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua'), true))()
end)

-- Fly Script with Slider
local FlySpeed = 80
local flying = false

PlayerSection:NewSlider("Fly Speed", "Adjust fly speed (toggle with F)", 300, 0, function(speed)
    FlySpeed = speed
end)

PlayerSection:NewButton("Enable Fly (F to toggle)", "Fly with WASD", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local uis = game:GetService("UserInputService")
    local runService = game:GetService("RunService")

    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.P = 1e4
    bv.Velocity = Vector3.zero

    local bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 1e4
    bg.CFrame = hrp.CFrame

    local control = {F = false, B = false, L = false, R = false}

    uis.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.F then
            flying = not flying
            if flying then
                bv.Parent = hrp
                bg.Parent = hrp
            else
                bv.Parent = nil
                bg.Parent = nil
            end
        end
        if input.KeyCode == Enum.KeyCode.W then control.F = true end
        if input.KeyCode == Enum.KeyCode.S then control.B = true end
        if input.KeyCode == Enum.KeyCode.A then control.L = true end
        if input.KeyCode == Enum.KeyCode.D then control.R = true end
    end)

    uis.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then control.F = false end
        if input.KeyCode == Enum.KeyCode.S then control.B = false end
        if input.KeyCode == Enum.KeyCode.A then control.L = false end
        if input.KeyCode == Enum.KeyCode.D then control.R = false end
    end)

    runService.Heartbeat:Connect(function()
        if flying then
            local move = Vector3.zero
            if control.F then move += workspace.CurrentCamera.CFrame.LookVector end
            if control.B then move -= workspace.CurrentCamera.CFrame.LookVector end
            if control.L then move -= workspace.CurrentCamera.CFrame.RightVector end
            if control.R then move += workspace.CurrentCamera.CFrame.RightVector end
            bv.Velocity = move.Unit * FlySpeed
            bg.CFrame = workspace.CurrentCamera.CFrame
        end
    end)
end)

MainSection:NewButton("FE Emote", "All Emotes Keybind Open Is Comma" , function()
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)
