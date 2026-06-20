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

-- Pet Sim 99 Universal Hub v4.0
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [GUI Tasarım]
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "UniversalHub"
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true

-- [Özellik Durumları]
local States = {Speed = false, ItemESP = false}

-- [ESP Fonksiyonu - Pet Sim 99 için (Yerdeki itemleri işaretler)]
local function updateESP()
    -- Oyunun içindeki "Coins" veya "Collectibles" klasörlerini hedefler
    for _, item in pairs(workspace:GetDescendants()) do
        if item:IsA("Model") and (item.Name:find("Coin") or item.Name:find("Chest")) then
            if States.ItemESP and not item:FindFirstChild("ESP_Box") then
                local b = Instance.new("BoxHandleAdornment", item)
                b.Name = "ESP_Box"
                b.Size = item:GetExtentsSize()
                b.Adornee = item
                b.Color3 = Color3.fromRGB(255, 255, 0)
                b.AlwaysOnTop = true
                b.Transparency = 0.5
            elseif not States.ItemESP and item:FindFirstChild("ESP_Box") then
                item.ESP_Box:Destroy()
            end
        end
    end
end

-- [Buton Oluşturucu]
local function createButton(name, yPos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 230, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        callback()
        btn.Text = name .. ": " .. (States[name] and "ON" or "OFF")
    end)
end

-- [Mantık Motoru]
RunService.RenderStepped:Connect(function()
    if States.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
    if States.ItemESP then
        updateESP()
    end
end)

-- [Menüye Ekle]
createButton("Speed", 50, function() States.Speed = not States.Speed end)
createButton("ItemESP", 100, function() States.ItemESP = not States.ItemESP end)

-- [Kontrol]
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("Pet Sim 99 Hub Aktif!")
