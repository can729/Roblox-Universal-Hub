-- FURENT_LSC v12.0 - Premium & Full Stable
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- 1. ESKİ MENÜLERİ TEMİZLE
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

-- 2. ANA ARAYÜZ
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 350); Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Main.BorderSizePixel = 3
Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.Active = true; Main.Draggable = true

-- Başlık ve Kırmızı Çizgi
local Title = Instance.new("TextLabel", Main); Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "FURENT_LSC"; Title.TextColor3 = Color3.fromRGB(0,0,0); Title.BackgroundTransparency = 1
local Line = Instance.new("Frame", Title); Line.Size = UDim2.new(0.8, 0, 0, 2)
Line.Position = UDim2.new(0.1, 0, 1, 0); Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0); Line.BorderSizePixel = 0

-- Yağmur Efekti
local RainContainer = Instance.new("Folder", Main); RainContainer.Name = "Rain"
for i = 1, 30 do
    local drop = Instance.new("Frame", RainContainer); drop.Size = UDim2.new(0, 1, 0, 10)
    drop.BackgroundColor3 = Color3.fromRGB(200, 200, 200); drop.Position = UDim2.new(math.random(), 0, -0.1, 0)
    RunService.RenderStepped:Connect(function()
        drop.Position = drop.Position + UDim2.new(0, 0, 0.01, 0)
        if drop.Position.Y.Scale > 1 then drop.Position = UDim2.new(math.random(), 0, -0.1, 0) end
    end)
end

-- Hız Kontrolü (İsimli)
local SpeedLabel = Instance.new("TextLabel", Main); SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 50); SpeedLabel.Text = "Hız Ayarı (Speed)"
SpeedLabel.TextColor3 = Color3.fromRGB(0,0,0); SpeedLabel.BackgroundTransparency = 1
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 260, 0, 20)
SliderBG.Position = UDim2.new(0, 20, 0, 75); SliderBG.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local WalkSpeed = 16
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); WalkSpeed = 10 + (p * 490)
    end
end)

-- ESP Butonu
local ESP_Active = false
local btn = Instance.new("TextButton", Main); btn.Size = UDim2.new(0, 260, 0, 40)
btn.Position = UDim2.new(0, 20, 0, 120); btn.Text = "ESP: OFF"; btn.TextColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
btn.MouseButton1Click:Connect(function() 
    ESP_Active = not ESP_Active; btn.Text = ESP_Active and "ESP: ON" or "ESP: OFF"
end)

-- 3. BAĞIMSIZ DÖNGÜLER
-- Hız Döngüsü
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

-- ESP Döngüsü (Pet Sim 99 için Kutu ESP)
RunService.RenderStepped:Connect(function()
    if ESP_Active then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Egg") or obj.Name:find("Chest") or obj.Name:find("Coin")) then
                if not obj:FindFirstChild("ESP_Box") then
                    local b = Instance.new("BoxHandleAdornment", obj)
                    b.Name = "ESP_Box"; b.Size = obj:GetExtentsSize(); b.Adornee = obj
                    b.Color3 = Color3.fromRGB(255, 0, 0); b.AlwaysOnTop = true
                end
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "ESP_Box" then obj:Destroy() end
        end
    end
end)

-- Aç/Kapat
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end
end)
