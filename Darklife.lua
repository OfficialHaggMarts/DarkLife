for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
 end
 
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 
local Window = Rayfield:CreateWindow({
    Name = "Dark Life Script",
    LoadingTitle = "Dark Life Script",
    LoadingSubtitle = "Made by xynx",
 })
 
Rayfield:Notify({
    Title = "Welcome.",
    Content = "Script made by xynx -- https://discord.gg/5Hu5ezG8AF",
    Duration = 5,
})
 
local Main = Window:CreateTab("Main")
local Gun = Window:CreateTab("Gun")
 
local Tab1 = Main:CreateSection("Auto-Steal")
 
local Toggle = Main:CreateToggle({
    Name = "Auto Steal Cash",
    CurrentValue = false,
    Flag = "AP",
    Callback = function(AP)
        shared["AP"] = AP
        while shared["AP"] do
            task.wait()
            if not shared["AP"] then
                break
            end
            
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                continue
            end
            
            local humanoidRootPart = character.HumanoidRootPart
            local originalPosition = humanoidRootPart.CFrame -- Save original position
            
            -- Iterate through all money bags
            for _, v in pairs(game.Workspace.money_bags:GetDescendants()) do
                if v:IsA("Part") then
                    -- Teleport to the money bag
                    humanoidRootPart.CFrame = v.CFrame
                    
                    task.wait(0.25) -- Wait for pickup
                    
                    -- Teleport back to the original position
                    humanoidRootPart.CFrame = originalPosition
                end
            end
        end
    end,
})
 
 local Toggle = Main:CreateToggle({
    Name = "Auto Steal Printers (Broken)",
    CurrentValue = false,
    Flag = "ASP",
    Callback = function(ASP)
        shared["ASP"] = ASP
        while shared["ASP"] do
          task.wait(0.05)
          if not shared["ASP"] then
              break
          end
          for i,v in pairs(game.Workspace.houses:GetDescendants()) do
            if v.Name == "IsActive" and v.Value == true then
                local LP = v
                for i,v in pairs(LP.Parent:GetDescendants()) do
                    if v.Name == "Display" then
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        fireproximityprompt(v.ProximityPrompt)
                        LP.Value = false
                    end
                end
                wait(0.15)
                v.Value = true
            end
        end
          end
    end,
 })
 
local Toggle = Main:CreateToggle({
    Name = "Auto Steal Guns & Armor",
    CurrentValue = false,
    Flag = "APG",
    Callback = function(APG)
        shared["APG"] = APG
        while shared["APG"] do
            task.wait()
            if not shared["APG"] then
                break
            end
            
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                continue
            end
            
            local humanoidRootPart = character.HumanoidRootPart
            local originalPosition = humanoidRootPart.CFrame -- Save original position
            
            -- Iterate through children of active_dropped_weapons
            for _, weapon in pairs(game.Workspace.active_dropped_weapons:GetChildren()) do
                local mainPart = weapon:FindFirstChild("main") -- Check for "main" child
                
                if mainPart then
                    -- Teleport to the weapon
                    humanoidRootPart.CFrame = mainPart.CFrame
                    
                    Rayfield:Notify({
                        Title = "Pickup Guns/Armor",
                        Content = ("Stole item: " .. weapon.Name .. " (numbers mean armor)"),
                        Duration = 5,
                    })
                    
                    task.wait(0.15) -- Wait for pickup
                    
                    weapon:Destroy() -- Destroy the whole weapon model after teleporting
                    
                    task.wait(0.25) -- Small delay before teleporting back
                    
                    -- Teleport back to the original position
                    humanoidRootPart.CFrame = originalPosition
                end
            end
        end
    end,
})

 local Tab1 = Main:CreateSection("Deposit")
 
 local Button = Main:CreateButton({
    Name = "Deposit (Teleport)",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Deposit.Collider.CFrame + Vector3.new(0,2.5,0)
    end,
 })
 
 local Toggle = Main:CreateToggle({
    Name = "Auto Deposit",
    CurrentValue = false,
    Flag = "ADEPO",
    Callback = function(ADEPO)
        shared["ADEPO"] = ADEPO
        while shared["ADEPO"] do
          task.wait(0.5)
          if not shared["ADEPO"] then
              break
          end
          game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Deposit.Collider.CFrame + Vector3.new(0,4.15,0)
          end
    end,
 })
 
 local Tab1 = Gun:CreateSection("Change Stats")
 
 local Button = Gun:CreateButton({
    Name = "No Recoil",
    Callback = function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.RecoilMin.Value = 0
           v.RecoilMax.Value = 0
        end
    end
    end,
 })
 
 local Button = Gun:CreateButton({
    Name = "No Spread",
    Callback = function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.MaxSpread.Value = 0
        end
    end
    end,
 })
 
 local Button = Gun:CreateButton({
    Name = "Inf Distance",
    Callback = function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.MaxDistance.Value = 100000000000
        end
    end
    end,
 })
 
 local Button = Gun:CreateButton({
    Name = "Faster Shoot",
    Callback = function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.ShotCooldown.Value = 0
        end
    end
    end,
 })
 
 local Button = Gun:CreateButton({
    Name = "Faster Bullet",
    Callback = function()
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.BulletSpeed.Value = 1000000000
        end
    end
    end,
 })
 
 local Toggle = Gun:CreateToggle({
    Name = "Infinite Ammo + Infinite Damage",
    CurrentValue = false,
    Flag = "INFAMMO",
    Callback = function(INFAMMO)
        shared["INFAMMO"] = INFAMMO
        while shared["INFAMMO"] do
          task.wait()
          if not shared["INFAMMO"] then
              break
          end
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "Configuration" then
           v.Parent.CurrentAmmo.Value = 1000000000
		   v.HitDamage.Value = 10000000000000000000
        end
    end
          end
    end,
 })
 
  local Tab1 = Gun:CreateSection("Change Guns")
 
   local Toggle = Gun:CreateToggle({
    Name = "Make Rocket Launcher Insanely OP",
    CurrentValue = false,
    Flag = "MRL",
    Callback = function(MRL)
        shared["MRL"] = MRL
        while shared["MRL"] do
          task.wait()
          if not shared["MRL"] then
              break
          end
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
              if v.Name == "Configuration" and v.Parent.Name == "Rocket Launcher" then
               v.BulletSpeed.Value = 100000
			   v.Parent.CurrentAmmo.Value = 1000
			   v.RecoilMin.Value = 0
               v.RecoilMax.Value = 0
               v.ShotCooldown.Value = 0
             end
            end
          end
    end,
 })
