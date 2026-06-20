-- FURENT_LSC v12.0 - Premium & Robust
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Eski menüleri temizle
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

-- Ana Arayüz (Beyaz Arka Plan, Kırmızı Çerçeve)
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 400); Main.Position = UDim2.new(0.5, -150, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderSizePixel = 3; Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Başlık
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(0, 0, 0); Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1; Title.TextSize = 22

-- Hız Kontrolü (Slider)
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 260, 0, 30)
SliderBG.Position = UDim2.new(0, 20, 0, 70); SliderBG.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local pos = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0); WalkSpeed = 10 + (pos * 490)
    end
end)

-- ESP Toggle
local ESP_Active = false
local btn = Instance.new("TextButton", Main); btn.Size = UDim2.new(0, 260, 0, 45)
btn.Position = UDim2.new(0, 20, 0, 120); btn.Text = "ESP: OFF"; btn.TextColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
btn.MouseButton1Click:Connect(function() 
    ESP_Active = not ESP_Active; btn.Text = ESP_Active and "ESP: ON" or "ESP: OFF"
end)

-- Render Loop
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

-- GÜNCELLEME: Açma/Kapama Tuşu (RightControl daha garantidir)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)
