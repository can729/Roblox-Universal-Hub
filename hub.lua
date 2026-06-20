-- FURENT_LSC v0.1 - Pet Simulator 99 Optimized
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım: Profesyonel ve Modern]
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "FURENT_LSC_UI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Köşe yuvarlatma efekti
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

-- [Değişkenler]
local WalkSpeed = 16
local ESPEnabled = false

-- [Fonksiyonlar]
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 240, 0, 40)
    btn.Position = UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(callback)
end

-- [Hız Mantığı]
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

-- [ESP Mantığı (Optimize)]
local function toggleESP()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest")) then
                local b = Instance.new("BoxHandleAdornment", obj)
                b.Name = "ESP_Box"
                b.Size = obj:GetExtentsSize()
                b.Adornee = obj
                b.Color3 = Color3.fromRGB(0, 255, 255) -- Cam göbeği
                b.AlwaysOnTop = true
                b.Transparency = 0.4
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "ESP_Box" then obj:Destroy() end
        end
    end
end

-- [Menü Oluşturma]
createButton("ESP: Toggle", 70, toggleESP)
createButton("Hız: 10 (Min)", 120, function() WalkSpeed = 10 end)
createButton("Hız: 75 (Max)", 170, function() WalkSpeed = 75 end)
createButton("Hız: Sıfırla (16)", 220, function() WalkSpeed = 16 end)

-- [Kapatma/Açma]
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
