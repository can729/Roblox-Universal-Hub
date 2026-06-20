-- FURENT_LSC v13.0 - Kusursuz ve Stabil Yapı
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- [1] KUSURSUZ TEMİZLİK: Herhangi bir kalıntı bırakma
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

-- [2] ARAYÜZ (Modern Tasarım)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 350); Main.Position = UDim2.new(0.5, -150, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Main.BorderSizePixel = 0
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Kırmızı Kenarlık (Dış çerçeve)
local Border = Instance.new("Frame", Main)
Border.Size = UDim2.new(1, 4, 1, 4); Border.Position = UDim2.new(0, -2, 0, -2)
Border.BackgroundColor3 = Color3.fromRGB(255, 0, 0); Border.ZIndex = 0
Instance.new("UICorner", Border).CornerRadius = UDim.new(0, 12)

-- Başlık
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(0, 0, 0); Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1; Title.TextSize = 20

-- [3] HIZ SİSTEMİ (Bağımsız)
local SpeedVal = 16
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 260, 0, 25)
SliderBG.Position = UDim2.new(0, 20, 0, 60); SliderBG.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
local SliderFill = Instance.new("Frame", SliderBG); SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(p, 0, 1, 0); SpeedVal = 10 + (p * 490)
    end
end)

-- [4] ESP SİSTEMİ (Bağımsız)
local ESPOn = false
local ESPBtn = Instance.new("TextButton", Main); ESPBtn.Size = UDim2.new(0, 260, 0, 40)
ESPBtn.Position = UDim2.new(0, 20, 0, 100); ESPBtn.Text = "ESP: OFF"
ESPBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220); ESPBtn.TextColor3 = Color3.fromRGB(0,0,0)
ESPBtn.MouseButton1Click:Connect(function() 
    ESPOn = not ESPOn; ESPBtn.Text = ESPOn and "ESP: ON" or "ESP: OFF"
end)

-- [5] TEK BİR DÖNGÜDE İŞLEME
RunService.RenderStepped:Connect(function()
    -- Hız
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = SpeedVal
    end
    -- ESP
    if ESPOn then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:find("Egg") or obj.Name:find("Chest") or obj.Name:find("Coin")) then
                if not obj:FindFirstChild("FURENT_Box") then
                    local b = Instance.new("BoxHandleAdornment", obj); b.Name = "FURENT_Box"
                    b.Adornee = obj; b.Size = obj:GetExtentsSize(); b.Color3 = Color3.fromRGB(255, 0, 0); b.AlwaysOnTop = true
                end
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do if obj.Name == "FURENT_Box" then obj:Destroy() end end
    end
end)

-- [6] AÇ/KAPAT
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end
end)
