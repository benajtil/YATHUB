-- GUI Framework
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local TabsFrame = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")

-- GUI Properties
ScreenGui.Name = "CustomGUI"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 18

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.Text = "Custom Blox Fruit GUI"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = MainFrame
TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabsFrame.Size = UDim2.new(0.25, 0, 1, -40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BorderSizePixel = 0

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ContentFrame.Size = UDim2.new(0.75, 0, 1, -40)
ContentFrame.Position = UDim2.new(0.25, 0, 0, 40)
ContentFrame.BorderSizePixel = 0

-- Tabs
local Tabs = {"Farm", "Visual", "Config"}
local TabButtons = {}
local TabFrames = {}

for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Button"
    TabButton.Parent = TabsFrame
    TabButton.Text = tabName
    TabButton.Size = UDim2.new(1, 0, 0, 50)
    TabButton.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
    TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 16
    TabButtons[tabName] = TabButton

    local TabFrame = Instance.new("Frame")
    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = ContentFrame
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = (i == 1)
    TabFrames[tabName] = TabFrame

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(TabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
    end)
end

-- Close GUI Functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Auto Bounty, Beli, and Fragments (Config Tab)
local ConfigFrame = TabFrames["Config"]

-- Auto Bounty TextBox
local AutoBountyBox = Instance.new("TextBox", ConfigFrame)
AutoBountyBox.PlaceholderText = "Set Bounty"
AutoBountyBox.Size = UDim2.new(0.8, 0, 0, 40)
AutoBountyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
AutoBountyBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoBountyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBountyBox.Font = Enum.Font.Gotham
AutoBountyBox.TextSize = 14
AutoBountyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(AutoBountyBox.Text)
        if value then
            print("Auto Bounty set to:", value)
            -- Add logic to modify bounty in the game
        end
    end
end)

-- Auto Beli TextBox
local AutoBeliBox = Instance.new("TextBox", ConfigFrame)
AutoBeliBox.PlaceholderText = "Set Beli"
AutoBeliBox.Size = UDim2.new(0.8, 0, 0, 40)
AutoBeliBox.Position = UDim2.new(0.1, 0, 0.4, 0)
AutoBeliBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoBeliBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBeliBox.Font = Enum.Font.Gotham
AutoBeliBox.TextSize = 14
AutoBeliBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(AutoBeliBox.Text)
        if value then
            print("Auto Beli set to:", value)
            -- Add logic to modify Beli in the game
        end
    end
end)

-- Auto Fragments TextBox
local AutoFragmentsBox = Instance.new("TextBox", ConfigFrame)
AutoFragmentsBox.PlaceholderText = "Set Fragments"
AutoFragmentsBox.Size = UDim2.new(0.8, 0, 0, 40)
AutoFragmentsBox.Position = UDim2.new(0.1, 0, 0.6, 0)
AutoFragmentsBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoFragmentsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFragmentsBox.Font = Enum.Font.Gotham
AutoFragmentsBox.TextSize = 14
AutoFragmentsBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(AutoFragmentsBox.Text)
        if value then
            print("Auto Fragments set to:", value)
            -- Add logic to modify fragments in the game
        end
    end
end)

-- Unlock All Fruits Permanently (Visual Tab)
local UnlockButton = Instance.new("TextButton", TabFrames["Visual"])
UnlockButton.Text = "Unlock All Fruits Permanently"
UnlockButton.Size = UDim2.new(0.8, 0, 0, 40)
UnlockButton.Position = UDim2.new(0.1, 0, 0.2, 0)
UnlockButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
UnlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockButton.Font = Enum.Font.Gotham
UnlockButton.TextSize = 14

UnlockButton.MouseButton1Click:Connect(function()
    for _, fruit in pairs(game:GetService("ReplicatedStorage").Items.Fruits:GetChildren()) do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UnlockFruit", fruit.Name)
        print("Unlocked fruit:", fruit.Name)
    end
end)
