-- FURENT_LSC v9.0 - Advanced ESP Modules
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- UI Temizleme ve Başlatma
if LocalPlayer.PlayerGui:FindFirstChild("FURENT_LSC_UI") then LocalPlayer.PlayerGui.FURENT_LSC_UI:Destroy() end
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui); ScreenGui.Name = "FURENT_LSC_UI"
local Main = Instance.new("Frame", ScreenGui); Main.Size = UDim2.new(0, 300, 0, 400); Main.Position = UDim2.new(0.5, -150, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.BorderSizePixel = 2

-- Sekme Yönetimi
local ESPBox = Instance.new("TextButton", Main); ESPBox.Size = UDim2.new(0, 280, 0, 40); ESPBox.Position = UDim2.new(0, 10, 0, 50)
ESPBox.Text = "ESP: Box/Tracer (OFF)"; ESPBox.BackgroundColor3 = Color3.fromRGB(40,40,40)

local ESP_Active = false
ESPBox.MouseButton1Click:Connect(function()
    ESP_Active = not ESP_Active
    ESPBox.Text = ESP_Active and "ESP: ON" or "ESP: OFF"
end)

-- Çizim Fonksiyonu (Drawing API)
local function DrawESP(player)
    local box = Drawing.new("Square"); box.Visible = false; box.Filled = false
    local line = Drawing.new("Line"); line.Visible = false; line.Color = Color3.fromRGB(0, 255, 255)
    
    RunService.RenderStepped:Connect(function()
        if ESP_Active and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                box.Visible = true; box.Position = Vector2.new(pos.X - 50, pos.Y - 50)
                box.Size = Vector2.new(100, 100)
                
                line.Visible = true; line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                line.To = Vector2.new(pos.X, pos.Y)
            else
                box.Visible = false; line.Visible = false
            end
        else
            box.Visible = false; line.Visible = false
        end
    end)
end

-- Tüm oyunculara uygula
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then DrawESP(p) end
end
Players.PlayerAdded:Connect(DrawESP)
