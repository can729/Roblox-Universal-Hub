-- Modern Universal Hub v3.0
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım]
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "UniversalHub"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "UNIVERSAL HUB - PRO"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- [Özellik Durumları]
local States = {Speed = false, ESP = false}

-- [Helper Fonksiyon: Buton Oluşturucu]
local function createButton(name, yPos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        callback()
        btn.Text = name .. ": " .. (States[name] and "ON" or "OFF")
    end)
end

-- [Mantık Motoru]
RunService.RenderStepped:Connect(function()
    -- Speed Hack
    if States.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

-- [ESP Modülü]
local function toggleESP(state)
    States.ESP = state
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if state then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "ESP_Highlight"
                h.FillColor = Color3.fromRGB(255, 0, 0)
            else
                if p.Character:FindFirstChild("ESP_Highlight") then
                    p.Character.ESP_Highlight:Destroy()
                end
            end
        end
    end
end

-- [Menüye Özellik Ekle]
createButton("Speed", 50, function() States.Speed = not States.Speed end)
createButton("ESP", 100, function() toggleESP(not States.ESP) end)

-- [Kontrol]
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("Hub başarıyla yüklendi!")
