local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local old = playerGui:FindFirstChild("So7zaDevGui")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "So7zaDevGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

local function new(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local main = new("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(250, 320),
    Position = UDim2.new(0, 15, 0.5, -160),
    BackgroundColor3 = Color3.fromRGB(12, 15, 20),
    BorderSizePixel = 0,
}, gui)

new("UICorner", {CornerRadius = UDim.new(0, 12)}, main)
new("UIStroke", {Color = Color3.fromRGB(80, 150, 255), Thickness = 1.2}, main)

local top = new("Frame", {
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Color3.fromRGB(32, 120, 255),
    BorderSizePixel = 0,
}, main)
new("UICorner", {CornerRadius = UDim.new(0, 12)}, top)

new("TextLabel", {
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "So7zaDev",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local closeBtn = new("TextButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(1, -36, 0.5, -15),
    BackgroundColor3 = Color3.fromRGB(60, 65, 75),
    BorderSizePixel = 0,
    Text = "X",
    TextColor3 = Color3.fromRGB(255,255,255),
    Font = Enum.Font.GothamBold,
    TextSize = 14,
}, top)
new("UICorner", {CornerRadius = UDim.new(0, 8)}, closeBtn)
closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

local status = new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),
    Position = UDim2.fromOffset(10, 60),
    BackgroundColor3 = Color3.fromRGB(18, 22, 30),
    BorderSizePixel = 0,
    Text = "PRONTO",
    TextColor3 = Color3.fromRGB(120, 220, 120),
    Font = Enum.Font.GothamSemibold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
}, main)
new("UICorner", {CornerRadius = UDim.new(0, 6)}, status)

local function addToggle(name, y, callback)
    local btn = new("TextButton", {
        Size = UDim2.new(1, -20, 0, 32),
        Position = UDim2.fromOffset(10, y),
        BackgroundColor3 = Color3.fromRGB(30, 38, 52),
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
    }, main)
    new("UICorner", {CornerRadius = UDim.new(0, 8)}, btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local flyEnabled = false
local noclipEnabled = false
local autoCuraEnabled = false
local antiafkEnabled = true

local flyButton = addToggle("Fly", 90, function()
    flyEnabled = not flyEnabled
    flyButton.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
    flyButton.BackgroundColor3 = flyEnabled and Color3.fromRGB(48, 160, 92) or Color3.fromRGB(30, 38, 52)
    if flyEnabled then
        status.Text = "FLY ATIVADO"
    else
        status.Text = "FLY DESATIVADO"
    end
end)

local noclipButton = addToggle("Noclip", 130, function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(48, 160, 92) or Color3.fromRGB(30, 38, 52)
    if noclipEnabled then
        status.Text = "NOCLIP ATIVADO"
    else
        status.Text = "NOCLIP DESATIVADO"
    end
end)

local curaButton = addToggle("Auto Cura", 170, function()
    autoCuraEnabled = not autoCuraEnabled
    curaButton.Text = autoCuraEnabled and "Auto Cura: ON" or "Auto Cura: OFF"
    curaButton.BackgroundColor3 = autoCuraEnabled and Color3.fromRGB(48, 160, 92) or Color3.fromRGB(30, 38, 52)
    if autoCuraEnabled then
        status.Text = "AUTO CURA ATIVADO"
    else
        status.Text = "AUTO CURA DESATIVADO"
    end
end)

local antiafkButton = addToggle("Anti-AFK", 210, function()
    antiafkEnabled = not antiafkEnabled
    antiafkButton.Text = antiafkEnabled and "Anti-AFK: ON" or "Anti-AFK: OFF"
    antiafkButton.BackgroundColor3 = antiafkEnabled and Color3.fromRGB(48, 160, 92) or Color3.fromRGB(30, 38, 52)
    if antiafkEnabled then
        status.Text = "ANTI-AFK ATIVADO"
    else
        status.Text = "ANTI-AFK DESATIVADO"
    end
end)

local labelInfo = new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 45),
    Position = UDim2.fromOffset(10, 250),
    BackgroundColor3 = Color3.fromRGB(18, 22, 30),
    BorderSizePixel = 0,
    Text = "Funções: Fly, Noclip, Auto Cura, Anti-AFK",
    TextColor3 = Color3.fromRGB(170, 180, 210),
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Center,
}, main)
new("UICorner", {CornerRadius = UDim.new(0, 8)}, labelInfo)

local root = function()
    local char = player.Character
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function setNoclip(value)
    local char = player.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not value
        end
    end
end

local function flyLoop()
    while flyEnabled do
        local r = root()
        if r then
            local camera = workspace.CurrentCamera
            if camera then
                local move = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    move = move + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    move = move - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    move = move + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    move = move - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    move = move + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    move = move - Vector3.new(0, 1, 0)
                end
                if move.Magnitude > 0 then
                    r.CFrame = r.CFrame + move.Unit * 8
                end
            end
        end
        task.wait(0.03)
    end
end

local function antiAfkLoop()
    while antiafkEnabled do
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        end
        task.wait(20)
    end
end

local function autoCuraLoop()
    while autoCuraEnabled do
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < 50 then
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local medkit = backpack:FindFirstChild("MedKit") or backpack:FindFirstChild("Medkit") or backpack:FindFirstChild("Kit Médico")
                if medkit then
                    local remote = medkit:FindFirstChildOfClass("RemoteEvent")
                    if remote then
                        remote:FireServer()
                    end
                end
            end
        end
        task.wait(0.5)
    end
end

local function updateLoop()
    while true do
        setNoclip(noclipEnabled)
        if flyEnabled then
            status.Text = "FLY ATIVADO"
        elseif noclipEnabled then
            status.Text = "NOCLIP ATIVADO"
        elseif autoCuraEnabled then
            status.Text = "AUTO CURA ATIVADO"
        elseif antiafkEnabled then
            status.Text = "ANTI-AFK ATIVADO"
        else
            status.Text = "PRONTO"
        end
        task.wait(0.2)
    end
end

task.spawn(flyLoop)
task.spawn(antiAfkLoop)
task.spawn(autoCuraLoop)
task.spawn(updateLoop)

print("So7zaDev carregado")
