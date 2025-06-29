-- Simple UI Framework Replacement for Rayfield
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local StarterGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- Clean existing GUI if present
if StarterGui:FindFirstChild("SimpleHub") then
    StarterGui.SimpleHub:Destroy()
end

-- Create UI container
local ScreenGui = Instance.new("ScreenGui", StarterGui)
ScreenGui.Name = "SimpleHub"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 500)
Frame.Position = UDim2.new(0.5, -200, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

local function createLabel(text)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -20, 0, 25)
	lbl.Text = "  " .. text
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 16
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = Frame
	return lbl
end

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.BorderSizePixel = 0

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		pcall(callback)
	end)
	btn.Parent = Frame
end

-- === MAIN TAB ===
createLabel("Main Scripts")
createButton("Infinite Yield", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)
createButton("Azure Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
end)
createButton("FE Emote", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"))()
end)
createButton("Air Hub Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/AirHub.lua"))()
end)

-- === GAME SCRIPTS TAB ===
createLabel("Game Scripts")
createButton("MM2 Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.18/yarhm.lua"))()
end)
createButton("Arsenal Script", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/G6Ubkkuv"))()
end)
createButton("Bedwars Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)
createButton("Blox Fruit Script", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end)
createButton("Grow a Garden Script", function()
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Loader/LoaderV1.lua"))()
end)
createButton("Bee Swarm GUI", function()
	local obj = game:GetObjects("rbxassetid://4384103988")[1]
	if obj then obj.Parent = Player.PlayerGui end
end)
createButton("Forsaken Script", function()
	loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
end)

-- === FUN SCRIPTS TAB ===
createLabel("Fun Scripts")
createButton("Jerk off R6", function()
	loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)
createButton("Jerk off R15", function()
	loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)
createButton("Fling ALL", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/wemre3131/Scripts/refs/heads/main/Fling"))()
end)

-- === INFECTIOUS SMILE ===
createLabel("Infectious Smile")
for _,tool in ipairs({"Bat","Bottle","Branch","Katana","Spear","Chain","Hatchet","Knife"}) do
	createButton("No "..tool.." Cooldown", function()
		local char = Player.Character
		if char and char:FindFirstChild(tool) then
			local cd = char[tool]:FindFirstChild("Cooldown")
			if cd then cd.Value = 0 end
		end
	end)
end

-- === FORSAKEN ===
createLabel("Forsaken")
createButton("Infinite Stamina", function()
	require(game.ReplicatedStorage.Systems.Character.Game.Sprinting).StaminaLossDisabled = true
end)
