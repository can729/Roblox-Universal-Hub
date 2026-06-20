-- Modern Hub v2.0
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Arayüzü oluştur (ZIndex ile en üst katman)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "ModernHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Sürüklenebilir

-- Şık bir başlık
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "UNIVERSAL HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.BorderSizePixel = 0

-- Bir buton örneği
local ToggleBtn = Instance.new("TextButton", MainFrame)
ToggleBtn.Size = UDim2.new(0, 240, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0, 60)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 75) -- Yeşil renk
ToggleBtn.Text = "WalkSpeed: 50"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamSemibold

-- Menü Aç/Kapat (RightShift)
UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("Hub Başarıyla Yüklendi! RightShift tuşuna bas.")
