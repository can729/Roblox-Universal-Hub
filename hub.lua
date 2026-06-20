-- FURENT_LSC v1.0 - Stabilized Edition
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] TEMİZLİK
if CoreGui:FindFirstChild("FURENT_PRO_UI") then CoreGui.FURENT_PRO_UI:Destroy() end

-- [2] ANA ARAYÜZ
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_PRO_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 680, 0, 480); Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- [3] DÜZELTİLMİŞ KAR EFEKTİ (Menüye Sabitlendi)
local SnowContainer = Instance.new("Frame", Main)
SnowContainer.Size = UDim2.new(1, 0, 1, 0); SnowContainer.BackgroundTransparency = 1; SnowContainer.ZIndex = 1
local SnowEnabled = true

for i = 1, 30 do
    local flake = Instance.new("Frame", SnowContainer)
    flake.Size = UDim2.new(0, 3, 0, 3); flake.BackgroundColor3 = Color3.new(1,1,1)
    flake.Position = UDim2.new(math.random(), 0, -0.1, 0)
    flake.ZIndex = 1; Instance.new("UICorner", flake).CornerRadius = UDim.new(1, 0)
    
    task.spawn(function()
        while true do
            if SnowEnabled then
                flake.Position = flake.Position + UDim2.new(0, 0, 0.005, 0)
                if flake.Position.Y.Scale > 1 then flake.Position = UDim2.new(math.random(), 0, -0.1, 0) end
            end
            task.wait(0.05)
        end
    end)
end

-- [4] GÜVENLİ AUTO CLICKER (Bağımsız Çalışır)
local AutoTapOn = false
local function StartAutoClicker()
    task.spawn(function()
        while AutoTapOn do
            VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2, 0, false, game, 1)
            task.wait(0.001)
        end
    end)
end

-- [5] MENÜ MOTORU (Sekmeler ve Butonlar)
local Sidebar = Instance.new("Frame", Main); Sidebar.Size = UDim2.new(0, 160, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Sidebar.ZIndex = 2
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
local TabContainer = Instance.new("Frame", Main); TabContainer.Size = UDim2.new(1, -170, 1, -20); TabContainer.Position = UDim2.new(0, 170, 0, 10); TabContainer.BackgroundTransparency = 1; TabContainer.ZIndex = 2

local function CreateTab(name, yPos, isActive)
    local TabBtn = Instance.new("TextButton", Sidebar); TabBtn.Size = UDim2.new(0, 140, 0, 35); TabBtn.Position = UDim2.new(0, 10, 0, yPos); TabBtn.Text = name; TabBtn.ZIndex = 2
    local Page = Instance.new("ScrollingFrame", TabContainer); Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = isActive; Page.ZIndex = 2
    local Layout = Instance.new("UIListLayout", Page); Layout.Padding = UDim.new(0, 5)
    TabBtn.MouseButton1Click:Connect(function() 
        for _, p in pairs(TabContainer:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        Page.Visible = true 
    end)
    return Page
end

local TabAuto = CreateTab("⚡ AutoFarm", 70, true)

-- [6] DÜZELTİLMİŞ AUTO CLICKER TOGGLE
local ToggleBtn = Instance.new("TextButton", TabAuto); ToggleBtn.Size = UDim2.new(1, -10, 0, 40); ToggleBtn.Text = "Auto Clicker: OFF"
ToggleBtn.MouseButton1Click:Connect(function()
    AutoTapOn = not AutoTapOn
    ToggleBtn.Text = AutoTapOn and "Auto Clicker: ON" or "Auto Clicker: OFF"
    if AutoTapOn then StartAutoClicker() end
end)

-- [7] MENÜ KONTROLÜ
local MenuKeybind = Enum.KeyCode.RightControl
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == MenuKeybind then Main.Visible = not Main.Visible end
end)
