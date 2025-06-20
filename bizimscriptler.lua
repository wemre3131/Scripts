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
