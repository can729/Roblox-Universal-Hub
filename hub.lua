-- FURENT_LSC v11.0 - Premium Edition
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- 1. TEMİZLİK: Önceki menüyü temizle
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

-- 2. ARAYÜZ OLUŞTURMA
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 400); Main.Position = UDim2.new(0.5, -150, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Main.BorderSizePixel = 3
Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(0, 0, 0); Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- 3. HIZ SLIDER
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 260, 0, 25)
SliderBG.Position = UDim2.new(0, 20, 0, 60); SliderBG.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); WalkSpeed = 10 + (p * 490)
    end
end)

-- 4. ESP TOGGLE
local ESP_Active = false
local btn = Instance.new("TextButton", Main); btn.Size = UDim2.new(0, 260, 0, 40)
btn.Position = UDim2.new(0, 20, 0, 100); btn.Text = "ESP: OFF"; btn.TextColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
btn.MouseButton1Click:Connect(function() 
    ESP_Active = not ESP_Active; btn.Text = ESP_Active and "ESP: ON" or "ESP: OFF"
end)

-- 5. RENDERING DÖNGÜSÜ
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

-- 6. INSERT TUŞU ATAMASI
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        Main.Visible = not Main.Visible
    end
end)
