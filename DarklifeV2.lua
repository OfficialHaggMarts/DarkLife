local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Impulse | Darklife " .. Fluent.Version,
    SubTitle = "by xynx",
    TabWidth = 160,
    Size = UDim2.fromOffset(780, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightShift
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home"}),
    LocalPlayer = Window:AddTab({ Title = "LocalPlayer", Icon = "user-cog"}),
    Weapons = Window:AddTab({ Title = "Weapons", Icon = "swords" }),
    Teleports = Window:AddTab({ Title = "Teleports", Icon = "map" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "laptop" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

local Section = Tabs.Main:AddSection("AutoSteal")
Section:AddToggle("AutoStealCash", {Title = "Auto Steal Cash", Default = false})
Options.AutoStealCash:OnChanged(function()
    while Options.AutoStealCash.Value do
        task.wait()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            local originalPosition = humanoidRootPart.CFrame
            for _, v in pairs(game.Workspace.money_bags:GetDescendants()) do
                if v:IsA("Part") then
                    humanoidRootPart.CFrame = v.CFrame
                    task.wait(0.15)
                    humanoidRootPart.CFrame = originalPosition
                end
            end
        end
    end
end)

Section:AddToggle("AutoStealGunsArmor", {Title = "Auto Steal Guns & Armor", Default = false})
Options.AutoStealGunsArmor:OnChanged(function()
    shared["AutoStealGunsArmor"] = Options.AutoStealGunsArmor.Value
    while shared["AutoStealGunsArmor"] do
        task.wait()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            continue
        end

        local humanoidRootPart = character.HumanoidRootPart
        local originalPosition = humanoidRootPart.CFrame

        for _, weapon in pairs(game.Workspace.active_dropped_weapons:GetChildren()) do
            local mainPart = weapon:FindFirstChild("main")
            if mainPart then
                humanoidRootPart.CFrame = mainPart.CFrame
                Fluent:Notify({
                    Title = "Pickup Guns/Armor",
                    Content = ("Stole item: " .. weapon.Name .. " (numbers mean armor)"),
                    Duration = 5,
                })
                task.wait(0.15)
                weapon:Destroy()
                task.wait(0.25)
                humanoidRootPart.CFrame = originalPosition
            end
        end
    end
end)

local Section = Tabs.Main:AddSection("Credits")
Section:AddParagraph({
    Title = "All Credits to @notxynx for making the script.\nAnd thanks to the Impulse community for non stop support aswell <3",
    Content = ""

})

Section:AddParagraph({
    Title = "Discord: https://discord.gg/YAyNFhBfmK",
    Content = ""

})

local Section = Tabs.LocalPlayer:AddSection("Upgrades")
-- Lifsteal Upgrade 
Section:AddButton({
    Title = "Set Max Lifesteal Upgrade",
    Description = "Spoof Lifesteal Upgrade temporarily.",
    Callback = function()
        local player = game.Players.LocalPlayer
        local upgradelifesteal = game.Workspace:FindFirstChild(player.Name) and game.Workspace[player.Name]:FindFirstChild("Upgrade.Life Steal")

        if upgradelifesteal and upgradelifesteal:IsA("NumberValue") then
            upgradelifesteal.Value = 10 -- Change this to any desired value
            Fluent:Notify({
                Title = "Impulse",
                Content = "Set LifeSteal to Max",
                Duration = 5,
            })
        else
            Fluent:Notify({
                Title = "Impulse",
                Content = "Issue Modifying Lifesteal Upgrade!",
                Duration = 5,
            })
        end
    end
})

Section:AddButton({
    Title = "Set Max Dodge Upgrade",
    Description = "Spoof Dodge Upgrade temporarily.",
    Callback = function()
        local player = game.Players.LocalPlayer
        local upgradedodge = game.Workspace:FindFirstChild(player.Name) and game.Workspace[player.Name]:FindFirstChild("Upgrade.Dodge")

        if upgradedodge and upgradedodge:IsA("NumberValue") then
            upgradedodge.Value = 10 -- Change this to any desired value
            Fluent:Notify({
                Title = "Impulse",
                Content = "Set Dodge to Max",
                Duration = 5,
            })
        else
            Fluent:Notify({
                Title = "Impulse",
                Content = "Issue Modifying Dodge Upgrade!",
                Duration = 5,
            })
        end
    end
})

-- Run Upgrade Slider
local RunUpgradeSlider = Section:AddSlider("RunUpgradeSlider", {
    Title = "Spoof Run Upgrade",
    Description = "Spoof Run Upgrade to modify your speed temporarily.",
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local playerFolder = game.Workspace:FindFirstChild(player.Name)
        local upgradeRun = playerFolder and playerFolder:FindFirstChild("Upgrade.Run")

        if upgradeRun and upgradeRun:IsA("NumberValue") then
            upgradeRun.Value = Value
        else
            Fluent:Notify({
                Title = "Impulse",
                Content = "Issue Modifying Run Upgrade! (Upgrade.Run not found)",
                Duration = 5,
            })
        end
    end
})

RunUpgradeSlider:OnChanged(function(Value)
    local player = game.Players.LocalPlayer
    local playerFolder = game.Workspace:FindFirstChild(player.Name)
    local upgradeRun = playerFolder and playerFolder:FindFirstChild("Upgrade.Run")

    if upgradeRun and upgradeRun:IsA("NumberValue") then
        upgradeRun.Value = Value
    end
end)

-- Jump Upgrade Slider
local JumpUpgradeSlider = Section:AddSlider("JumpUpgradeSlider", {
    Title = "Spoof Jump Upgrade",
    Description = "Spoof Jump Upgrade to modify your speed temporarily.",
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 1,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local playerFolder = game.Workspace:FindFirstChild(player.Name)
        local upgradejump = playerFolder and playerFolder:FindFirstChild("Upgrade.Jump")

        if upgradejump and upgradejump:IsA("NumberValue") then
            upgradejump.Value = Value
        else
            Fluent:Notify({
                Title = "Impulse",
                Content = "Issue Modifying Jump Upgrade!",
                Duration = 5,
            })
        end
    end
})

JumpUpgradeSlider:OnChanged(function(Value)
    local player = game.Players.LocalPlayer
    local playerFolder = game.Workspace:FindFirstChild(player.Name)
    local upgradejump = playerFolder and playerFolder:FindFirstChild("Upgrade.Jump")

    if upgradejump and upgradejump:IsA("NumberValue") then
        upgradejump.Value = Value
    end
end)

local Section = Tabs.Teleports:AddSection("Deposits")
Section:AddToggle("AutoDeposit", {Title = "Auto Deposit", Description = "Automatically Teleports you to a Deposit circle every 0.5 seconds.", Default = false})
Options.AutoDeposit:OnChanged(function()
    while Options.AutoDeposit.Value do
        task.wait(0.5)
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character then
            player.Character.HumanoidRootPart.CFrame = game.Workspace.Deposit.Collider.CFrame + Vector3.new(0, 4.15, 0)
        end
    end
end)

Section:AddButton({
    Title = "Deposit (Teleport)",
    Description = "Teleports You to a Deposit button.",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Deposit.Collider.CFrame + Vector3.new(0,2.5,0)
    end,
 })

local Section = Tabs.Teleports:AddSection("Robbery")
Section:AddButton({
    Title = "Bank Vault",
    Description = "Teleport Inside Bank Vault.",
    Callback = function()
        local player = game.Players.LocalPlayer
if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
    player.Character.HumanoidRootPart.CFrame = CFrame.new(-455.298, 8.22707, 52.60)
   end
end
})

local Dropdown = Section:AddDropdown("JewelryFloors", {
    Title = "Teleport to Jewelry Floor",
    Description = "Select a floor to teleport to.",
    Values = {
        "First Floor",
        "Second Floor",
        "Third Floor"
    },
    Multi = false,
    Default = 1
})

local teleportLocations = {
    ["First Floor"] = CFrame.new(-197.908, 7.33396, 457.8),
    ["Second Floor"] = CFrame.new(-205.834, 22.1003, 440.817),
    ["Third Floor"] = CFrame.new(-209.924, 37.7826, 463.73)
}

Dropdown:OnChanged(function(Value)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = teleportLocations[Value]
    end
end)

local Section = Tabs.Teleports:AddSection("Stores")
-- Gun Stores!
local Dropdown = Section:AddDropdown("Gunstore", {
    Title = "Gun Stores",
    Description = "Select a Gun store to teleport to.",
    Values = {
        "Main",
        "Bank",
        "Warehouse",
        "Industrial",
        "Residential"
    },
    Multi = false,
    Default = 1
})

local teleportLocations = {
    ["Main"] = CFrame.new(-114.404, 4.73261, 42.3),
    ["Bank"] = CFrame.new(-273.36, 4.72951, -176.737),
    ["Warehouse"] = CFrame.new(17.9039, 2.69459, -353.),
    ["Industrial"] = CFrame.new(-262.908, 4.60432, 285.6),
    ["Residential"] = CFrame.new(14.9944, 4.35271, 131.5)
}

Dropdown:OnChanged(function(Value)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = teleportLocations[Value]
    end
end)

-- Food Stores!
local Dropdown = Section:AddDropdown("Foodstores", {
    Title = "Food Stores",
    Description = "Select a Food Store to teleport to.",
    Values = {
        "Bank",
        "Warehouse",
        "Jewelry"
    },
    Multi = false,
    Default = 1
})

local teleportLocations = {
    ["Bank"] = CFrame.new(-344.114, 2.77734, -208.),
    ["Warehouse"] = CFrame.new(-48.9842, 2.71458, -350.69),
    ["Jewelry"] = CFrame.new(-190.996, 2.78349, 411)
}

Dropdown:OnChanged(function(Value)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = teleportLocations[Value]
    end
end)

-- Weapons!
local Section = Tabs.Weapons:AddSection("Universal")
Section:AddButton({
    Title = "No Recoil", 
    Callback = function()

    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
            v.RecoilMin.Value = 0
            v.RecoilMax.Value = 0
        end
    end
end
})

Section:AddButton({Title = "Infinite Distance", Callback = function()
    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
            v.MaxDistance.Value = 100000000000
        end
    end
end})

Section:AddButton({Title = "Rapid Fire", Callback = function()
    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
            v.ShotCooldown.Value = 0
        end
    end
end})

Section:AddButton({Title = "TP Bullet", Callback = function()
    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
            v.BulletSpeed.Value = 1000000000
        end
    end
end})

Section:AddToggle("InfiniteAmmo", {Title = "Infinite Ammo + Infinite Damage", Default = false})
Options.InfiniteAmmo:OnChanged(function()
    while Options.InfiniteAmmo.Value do
        task.wait()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v.Name == "Configuration" then
                v.Parent.CurrentAmmo.Value = 1000000000
                v.HitDamage.Value = 10000000000000000000
            end
        end
    end
end)

local Section = Tabs.Weapons:AddSection("Rocket Launcher") 
Section:AddToggle("RocketLauncherOP", {Title = "Make Rocket Launcher Insanely OP", Default = false})
Options.RocketLauncherOP:OnChanged(function()
    while Options.RocketLauncherOP.Value do
        task.wait()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v.Name == "Configuration" and v.Parent.Name == "Rocket Launcher" then
                v.BulletSpeed.Value = 100000
                v.Parent.CurrentAmmo.Value = 1000
                v.RecoilMin.Value = 0
                v.RecoilMax.Value = 0
                v.ShotCooldown.Value = 0
            end
        end
    end
end)
-- Fly Script Loader
local Section = Tabs.LocalPlayer:AddSection("Fly Script")
Section:AddButton({
    Title = "Enable Flight", 
    Description = "Press X to Fly/Unfly",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficialHaggMarts/DarkLife/refs/heads/main/fly.lua"))()
end
})

local Section = Tabs.Misc:AddSection("Disable Bank Lasers")
Section:AddButton({
    Title = "Disable Bank Lasers",
    Description = "Bank lasers no longer cause ouchies.",
    Callback = function()

        local bank = game.Workspace:FindFirstChild("places") and game.Workspace.places:FindFirstChild("bank")

if bank then
    for _, child in pairs(bank:GetChildren()) do
        if child:IsA("Part") and child:FindFirstChild("Script") and child:FindFirstChild("TouchInterest") then
            child:Destroy()
        end
    end
else
    Fluent:Notify({
        Title = "Impulse",
        Content = ("Issue Disabling Bank Lasers!"),
        Duration = 5,
    })
   end
end
})

-- Finalize
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Impulse")
SaveManager:SetFolder("ImpulseHub/Darklife")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Fluent:Notify({Title = "Impulse", Content = "Impulse-Hub loaded successfully", Duration = 8})
SaveManager:LoadAutoloadConfig()
