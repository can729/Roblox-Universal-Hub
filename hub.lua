-- FURENT_LSC v8.0 - Pet Sim 99 Egg & Chest ESP
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Eski UI'ı temizle
if LocalPlayer.PlayerGui:FindFirstChild("FURENT_LSC_UI") then LocalPlayer.PlayerGui.FURENT_LSC_UI:Destroy() end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 300); Main.Position = UDim2.new(0.5, -125, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Hız Slider
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 210, 0, 20)
SliderBG.Position = UDim2.new(0, 20, 0, 60); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); WalkSpeed = 10 + (p * 490)
    end
end)

-- ESP Mantığı (Yumurtalar ve Kasalar için)
local ESPEnabled = false
local function updateESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Yumurta ve Kasa filtreleme
        if obj:IsA("Model") and (obj.Name:find("Egg") or obj.Name:find("Chest") or obj.Name:find("Coin")) then
            if ESPEnabled and not obj:FindFirstChild("ESP_Box") then
                local b = Instance.new("BoxHandleAdornment", obj)
                b.Name = "ESP_Box"; b.Size = obj:GetExtentsSize(); b.Adornee = obj
                b.Color3 = Color3.fromRGB(255, 255, 0); b.AlwaysOnTop = true; b.Transparency = 0.5
            elseif not ESPEnabled and obj:FindFirstChild("ESP_Box") then
                obj.ESP_Box:Destroy()
            end
        end
    end
end

-- Buton
local btn = Instance.new("TextButton", Main); btn.Size = UDim2.new(0, 210, 0, 40)
btn.Position = UDim2.new(0, 20, 0, 100); btn.Text = "ESP: OFF"; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.TextColor3 = Color3.new(1,1,1); btn.MouseButton1Click:Connect(function() 
    ESPEnabled = not ESPEnabled; btn.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"
end)

-- Ana Döngü
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
    if ESPEnabled then updateESP() end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then Main.Visible = not Main.Visible end
end)
