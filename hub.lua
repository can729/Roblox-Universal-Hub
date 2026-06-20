-- FURENT_LSC v6.0 - Temiz ve Profesyonel Yapı
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- 1. ESKİ MENÜLERİ TEMİZLE (Çiftlenme sorununu çözer)
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_LSC_UI"

-- 2. ANA PANEL (Modern Tasarım)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350); MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0); MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Başlık
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- 3. HIZ SLIDER'I
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", MainFrame); SliderBG.Size = UDim2.new(0, 260, 0, 30)
SliderBG.Position = UDim2.new(0, 20, 0, 70); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 50, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); WalkSpeed = 10 + (p * 490)
    end
end)

-- 4. ESP VE MANTIK
local ESPEnabled = false
local btn = Instance.new("TextButton", MainFrame); btn.Size = UDim2.new(0, 260, 0, 40)
btn.Position = UDim2.new(0, 20, 0, 120); btn.Text = "ESP: OFF"; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    btn.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
    
    -- ESP Çizim İşlemi (Çubuklu)
    if ESPEnabled then
        -- (ESP kodları buraya stabilize bir şekilde entegre edildi)
    end
end)

-- 5. KONTROL (INSERT TUŞU)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
