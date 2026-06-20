-- FURENT_LSC v14.0 - Tam Optimize Edilmiş Sürüm
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- 1. TEMİZLİK
if CoreGui:FindFirstChild("FURENT_LSC_UI") then CoreGui.FURENT_LSC_UI:Destroy() end

-- 2. ARAYÜZ
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui); Main.Size = UDim2.new(0, 250, 0, 300); Main.Position = UDim2.new(0.5, -125, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Main.BorderSizePixel = 2; Main.BorderColor3 = Color3.fromRGB(255, 0, 0)
Main.Active = true; Main.Draggable = true

local Title = Instance.new("TextLabel", Main); Title.Size = UDim2.new(1, 0, 0, 30); Title.Text = "FURENT_LSC"
Title.TextColor3 = Color3.fromRGB(0,0,0); Title.BackgroundTransparency = 1; Title.Font = Enum.Font.GothamBold

-- 3. HIZ (Sadece değiştiğinde güncelle)
local WalkSpeed = 16
local SliderBG = Instance.new("Frame", Main); SliderBG.Size = UDim2.new(0, 200, 0, 20); SliderBG.Position = UDim2.new(0, 25, 0, 50)
SliderBG.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
SliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local p = math.clamp((input.Position.X - SliderBG.AbsolutePosition.X) / SliderBG.AbsoluteSize.X, 0, 1)
        WalkSpeed = 10 + (p * 490)
    end
end)

-- 4. ESP (Optimizasyon: Saniyede 1 kez tarar, kasma yapmaz)
local ESPOn = false
local ESPBtn = Instance.new("TextButton", Main); ESPBtn.Size = UDim2.new(0, 200, 0, 30); ESPBtn.Position = UDim2.new(0, 25, 0, 90)
ESPBtn.Text = "ESP: OFF"; ESPBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 220); ESPBtn.TextColor3 = Color3.fromRGB(0,0,0)
ESPBtn.MouseButton1Click:Connect(function() ESPOn = not ESPOn; ESPBtn.Text = ESPOn and "ESP: ON" or "ESP: OFF" end)

-- [PERFORMANS DÖNGÜSÜ]
task.spawn(function()
    while true do
        if ESPOn then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and (obj.Name:find("Egg") or obj.Name:find("Chest") or obj.Name:find("Coin")) and not obj:FindFirstChild("FURENT_Box") then
                    local b = Instance.new("BoxHandleAdornment", obj); b.Name = "FURENT_Box"
                    b.Adornee = obj; b.Size = obj:GetExtentsSize(); b.Color3 = Color3.fromRGB(255, 0, 0); b.AlwaysOnTop = true
                end
            end
        else
            for _, obj in pairs(workspace:GetDescendants()) do if obj.Name == "FURENT_Box" then obj:Destroy() end end
        end
        task.wait(1) -- Saniyede 1 kez tarar, kasma biter.
    end
end)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then Main.Visible = not Main.Visible end
end)
