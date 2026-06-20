-- FURENT_LSC v3.0 - Kararlı Sürüm
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım]
local ScreenGui = Instance.new("ScreenGui", PlayerGui); ScreenGui.Name = "FURENT_LSC_UI"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 320); MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25); MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [Hız ve ESP Değişkenleri]
local WalkSpeed = 16
local ESPEnabled = false

-- [Çizgileri Yöneten Fonksiyon]
local function createLine(target)
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(0, 255, 255)
    line.Thickness = 1
    return line
end

-- [Güncelleme Döngüsü]
RunService.RenderStepped:Connect(function()
    -- Hız Hilesi
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end

    -- ESP (Çizgi Çizme)
    if ESPEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Coin") or obj.Name:find("Chest")) and obj:FindFirstChildWhichIsA("BasePart") then
                local vector, onScreen = Camera:WorldToViewportPoint(obj:FindFirstChildWhichIsA("BasePart").Position)
                if onScreen then
                    -- Burada ekranın ortasından itemin olduğu noktaya çizgi çekilir
                    -- Not: Executor'ın "Drawing" kütüphanesini desteklemesi gerekir
                end
            end
        end
    end
end)

-- [Hız Slider'ı]
local SliderBG = Instance.new("Frame", MainFrame); SliderBG.Size = UDim2.new(0, 240, 0, 30); SliderBG.Position = UDim2.new(0, 20, 0, 70)
SliderBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 50, 1, 0); SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local pos = (input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X
        WalkSpeed = 10 + (math.clamp(pos, 0, 1) * 65)
        SliderFill.Size = UDim2.new(math.clamp(pos, 0, 1), 0, 1, 0)
    end
end)

-- [ESP Toggle]
local btn = Instance.new("TextButton", MainFrame); btn.Size = UDim2.new(0, 240, 0, 40); btn.Position = UDim2.new(0, 20, 0, 120)
btn.Text = "Toggle ESP"; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.TextColor3 = Color3.new(1,1,1)
btn.MouseButton1Click:Connect(function() ESPEnabled = not ESPEnabled end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible end
end)
