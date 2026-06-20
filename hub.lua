-- FURENT_LSC v5.0 - Premium Visuals
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım: Premium]
local ScreenGui = Instance.new("ScreenGui", PlayerGui); ScreenGui.Name = "FURENT_LSC_UI"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400); MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Kırmızı kenar
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- [Kar Yağışı Efekti]
local SnowContainer = Instance.new("Frame", MainFrame)
SnowContainer.Size = UDim2.new(1, 0, 1, 0); SnowContainer.BackgroundTransparency = 1
local function CreateSnow()
    local flake = Instance.new("Frame", SnowContainer)
    flake.Size = UDim2.new(0, 3, 0, 3); flake.BackgroundColor3 = Color3.new(1,1,1)
    flake.Position = UDim2.new(math.random(), 0, -0.1, 0)
    flake.BorderSizePixel = 0
    RunService.RenderStepped:Connect(function()
        flake.Position = flake.Position + UDim2.new(0, 0, 0.002, 0)
        if flake.Position.Y.Scale > 1 then flake.Position = UDim2.new(math.random(), 0, -0.1, 0) end
    end)
end
for i = 1, 20 do CreateSnow() end

-- [Menü Başlığı]
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- [Hız Ayarı (Slider)]
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", MainFrame); SliderBG.Size = UDim2.new(0, 260, 0, 20)
SliderBG.Position = UDim2.new(0, 20, 0, 80); SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 50, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); WalkSpeed = 10 + (p * 490)
    end
end)

-- [ESP & Hız Loop]
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

-- [Kontrol: Insert Tuşu]
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
