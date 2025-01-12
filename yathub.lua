-- Blox Fruits Script with Enhanced Features
-- Disclaimer: Use at your own risk! This script is for educational purposes only.

-- Dependencies
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/minhhau207/SilverHub/main/obfuscated-3788.lua"))()

-- GUI Setup
local main = library.xova()

local tabMain = main.create("Main")
local tabVisual = main.create("Visual")
local tabFarm = main.create("Farm")
local tabTeleport = main.create("Teleport")
local tabAdmin = main.create("Admin")

-- Global Settings
_G.Settings = {
    AutoFarm = false,
    AutoCollectFruit = false,
    RainFruit = false,
    AutoFarmNearest = false,
    AutoFarmQuest = false,
    SelectedSea = "First Sea",
    AdminOnlySkills = true
}

-- Helper Functions
local function notify(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Blox Fruits Script",
        Text = message,
        Duration = 5
    })
end

local function teleportTo(position)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

local function collectFruits()
    for _, fruit in pairs(workspace:GetDescendants()) do
        if fruit.Name:lower():find("fruit") and fruit:IsA("Model") then
            teleportTo(fruit.PrimaryPart.Position)
            wait(0.5)
            notify("Collected a fruit!")
        end
    end
end

-- Main Tab
local mainPage = tabMain.xovapage(1)
mainPage.Label({ Title = "Main Features" })

mainPage.Toggle({
    Title = "Auto Farm",
    Default = _G.Settings.AutoFarm,
    callback = function(state)
        _G.Settings.AutoFarm = state
        notify("Auto Farm " .. (state and "Enabled" or "Disabled"))
    end
})

mainPage.Toggle({
    Title = "Auto Collect Fruits",
    Default = _G.Settings.AutoCollectFruit,
    callback = function(state)
        _G.Settings.AutoCollectFruit = state
        notify("Auto Collect Fruits " .. (state and "Enabled" or "Disabled"))
        if state then
            collectFruits()
        end
    end
})

mainPage.Dropdown({
    Title = "Select Sea",
    Item = {"First Sea", "Second Sea", "Third Sea"},
    callback = function(value)
        _G.Settings.SelectedSea = value
        notify("Switched to " .. value)
    end
})

-- Visual Tab
local visualPage = tabVisual.xovapage(1)
visualPage.Label({ Title = "Visual Features" })

visualPage.Toggle({
    Title = "Rain Fruit",
    Default = _G.Settings.RainFruit,
    callback = function(state)
        _G.Settings.RainFruit = state
        notify("Rain Fruit " .. (state and "Enabled" or "Disabled"))
        if state then
            while _G.Settings.RainFruit do
                local fruit = Instance.new("Part", workspace)
                fruit.Size = Vector3.new(2, 2, 2)
                fruit.BrickColor = BrickColor.new("Bright yellow")
                fruit.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 50, 0)
                fruit.Anchored = true
                wait(0.5)
                fruit:Destroy()
            end
        end
    end
})

-- Farming Tab
local farmPage = tabFarm.xovapage(1)
farmPage.Label({ Title = "Farming Options" })

farmPage.Toggle({
    Title = "Auto Farm Nearest",
    Default = _G.Settings.AutoFarmNearest,
    callback = function(state)
        _G.Settings.AutoFarmNearest = state
        notify("Auto Farm Nearest " .. (state and "Enabled" or "Disabled"))
    end
})

farmPage.Toggle({
    Title = "Auto Farm with Quest",
    Default = _G.Settings.AutoFarmQuest,
    callback = function(state)
        _G.Settings.AutoFarmQuest = state
        notify("Auto Farm with Quest " .. (state and "Enabled" or "Disabled"))
    end
})

-- Admin Tab
local adminPage = tabAdmin.xovapage(1)
adminPage.Label({ Title = "Admin Skills" })

adminPage.Toggle({
    Title = "Enable Admin Skills",
    Default = _G.Settings.AdminOnlySkills,
    callback = function(state)
        _G.Settings.AdminOnlySkills = state
        notify("Admin Skills " .. (state and "Enabled" or "Disabled"))
    end
})

adminPage.Button({
    Title = "Teleport to Sky Island",
    callback = function()
        teleportTo(Vector3.new(0, 1000, 0))
        notify("Teleported to Sky Island")
    end
})

adminPage.Button({
    Title = "Summon Lightning Effect",
    callback = function()
        local lightning = Instance.new("Part", workspace)
        lightning.Size = Vector3.new(1, 1, 1)
        lightning.BrickColor = BrickColor.new("Bright blue")
        lightning.Anchored = true
        lightning.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
        wait(0.2)
        lightning:Destroy()
        notify("Summoned Lightning")
    end
})

-- Script Initialization
notify("Blox Fruits Script Loaded!")
