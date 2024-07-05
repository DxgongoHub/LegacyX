local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "LegacyX Hub",
    SubTitle = "General Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "เมนูหลัก", Icon = "activity" }),
    Popular = Window:AddTab({ Title = "สคริปเสริม", Icon = "tag" }),
    Settings = Window:AddTab({ Title = "การตั้งค่า", Icon = "settings" }),
    Credit = Window:AddTab({ Title = "เครดิต", Icon = "copyright" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "LegacyX Hub",
        Content = "กด F1 เพื่อย่อหน้าต่างเมนูสคริปนะครับ",
        SubContent = "ขอให้ใช้สคิปให้สนุกนะคับ", -- Optional
        Duration = 8 -- Set to nil to make the notification not disappear
    })

Tabs.Credit:AddParagraph({
        Title = "Discord",
        Content = "pathomphong_123"
    })


    Tabs.Main:AddParagraph({
        Title = "LegacyX Hub",
        Content = "Updated 5/7/2024"
    })

    Tabs.Popular:AddButton({
        Title = "Infinite Yield",
        Description = "สคริปที่ใช้ได้แทบทุกอย่าง",
        Callback = function()
            Window:Dialog({
                Title = "Infinite Yield",
                Content = "ต้องการรันสคริป?",
                Buttons = {
                    {
                        Title = "ใช่",
                        Callback = function()
                            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
                        end
                    },
                    {
                        Title = "ไม่",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })
        
    local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Walk Speed",
        Description = "ปรับความเร็วในการวิ่ง ความเร็วปกติ = 16",
        Default = 16,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
        end
    })

    Slider:SetValue(16)

  local Slider = Tabs.Main:AddSlider("Slider", {
        Title = "Jump Power",
        Description = "ปรับความสูงตอนกระโดด ความสูงปกติ = 50",
        Default = 32,
        Min = 1,
        Max = 200,
        Rounding = 1,
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
        end
    })

    Slider:SetValue(50)

    Tabs.Main:AddButton({
        Title = "Full Brightness",
        Description = "ความสว่างสูงสุด",
        Callback = function()
            Window:Dialog({
                Title = "Full Brightness",
                Content = "แนะนำให้เปิดในแมพที่มืดๆ",
                Buttons = {
                    {
                        Title = "ใช่",
                        Callback = function()
                            pcall(function()
    local lighting = game:GetService("Lighting");
    lighting.Ambient = Color3.fromRGB(255, 255, 255);
    lighting.Brightness = 1;
    lighting.FogEnd = 1e10;
    for i, v in pairs(lighting:GetDescendants()) do
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false;
        end;
    end;
    lighting.Changed:Connect(function()
        lighting.Ambient = Color3.fromRGB(255, 255, 255);
        lighting.Brightness = 1;
        lighting.FogEnd = 1e10;
    end);
    spawn(function()
        local character = game:GetService("Players").LocalPlayer.Character;
        while wait() do
            repeat wait() until character ~= nil;
            if not character.HumanoidRootPart:FindFirstChildWhichIsA("PointLight") then
                local headlight = Instance.new("PointLight", character.HumanoidRootPart);
                headlight.Brightness = 1;
                headlight.Range = 60;
            end;
        end;
    end);
end)
                        end
                    },
                    {
                        Title = "ไม่",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })
end

    Tabs.Main:AddButton({
        Title = "Rejoin Server",
        Description = "เข้าเซิฟใหม่อีกรอบ",
        Callback = function()
            Window:Dialog({
                Title = "Rejoin/รีจอยเซิฟเวอร์",
                Content = "ยืนยันที่จะรีจอยเซิฟเวอร์ไหม?",
                Buttons = {
                    {
                        Title = "ใช่",
                        Callback = function()
                            local ts = game:GetService("TeleportService")

local p = game:GetService("Players").LocalPlayer



ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
                        end
                    },
                    {
                        Title = "ไม่",
                        Callback = function()
                            print("Cancelled the dialog.")
                        end
                    }
                }
            })
        end
    })



local Players = game:GetService("Players")

-- Get a list of all player names
local playerNames = {}
for _, player in pairs(Players:GetPlayers()) do
    table.insert(playerNames, player.Name)
end

local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
    Title = "เทเลพอร์ตไปหาผู้เล่นอื่น",
    Values = playerNames,
    Multi = false,
    Default = 1,
})

Dropdown:SetValue(playerNames[1]) -- Set default value to the first player in the list

Dropdown:OnChanged(function(Value)
    local selectedPlayer = Players:FindFirstChild(Value)
    
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local localPlayer = Players.LocalPlayer
        if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
        else
            warn("Local player's HumanoidRootPart not found!")
        end
    else
        warn("Selected player's HumanoidRootPart not found!")
    end
end)



-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Success!",
    Content = "โหลดสคริปเรียบร้อย!!",
    Duration = 3
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
