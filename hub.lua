-- Roblox Ultimate Hub (Eğitim Amaçlı)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI Oluşturma
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Draggable = true
MainFrame.Visible = false

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Universal Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Özellik Değişkenleri
local Toggles = {Speed = false, Noclip = false, Fly = false}

-- Fonksiyonlar
local function createToggle(name, yPos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 230, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = name .. ": OFF"
    btn.MouseButton1Click:Connect(function()
        callback()
        btn.Text = name .. ": " .. (Toggles[name] and "ON" or "OFF")
    end)
end

-- Mantık Motoru
RunService.Stepped:Connect(function()
    pcall(function()
        if Toggles.Noclip and LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
        if Toggles.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
        end
    end)
end)

-- Arayüz Kontrolü
UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    elseif input.KeyCode == Enum.KeyCode.Escape then
        MainFrame.Visible = false
    end
end)

-- Özellik Ekleme
createToggle("Speed", 40, function() Toggles.Speed = not Toggles.Speed end)
createToggle("Noclip", 80, function() Toggles.Noclip = not Toggles.Noclip end)

print("Hub Başarıyla Yüklendi.")
