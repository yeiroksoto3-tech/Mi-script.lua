-- Script de Velocidad para Delta Executor
-- Panel GUI con controles de velocidad

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Variables de velocidad
local speedValue = 50
local maxSpeed = 200
local minSpeed = 0
local speedIncrement = 5
local isSpeedEnabled = true

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Agregar UICorner para esquinas redondeadas
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 10)
cornerRadius.Parent = mainFrame

-- Titulo
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "⚡ SPEED CONTROLLER"
titleLabel.BorderSizePixel = 0
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Label de velocidad actual
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 50)
speedLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedLabel.TextColor3 = Color3.fromRGB(0, 200, 100)
speedLabel.TextSize = 16
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Velocidad: " .. speedValue
speedLabel.BorderSizePixel = 0
speedLabel.Parent = mainFrame

local speedLabelCorner = Instance.new("UICorner")
speedLabelCorner.CornerRadius = UDim.new(0, 5)
speedLabelCorner.Parent = speedLabel

-- Botón Aumentar
local increaseButton = Instance.new("TextButton")
increaseButton.Name = "IncreaseButton"
increaseButton.Size = UDim2.new(0, 70, 0, 35)
increaseButton.Position = UDim2.new(0, 10, 0, 150)
increaseButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
increaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
increaseButton.TextSize = 14
increaseButton.Font = Enum.Font.GothamBold
increaseButton.Text = "➕ +5"
increaseButton.BorderSizePixel = 0
increaseButton.Parent = mainFrame

local increaseCorner = Instance.new("UICorner")
increaseCorner.CornerRadius = UDim.new(0, 5)
increaseCorner.Parent = increaseButton

-- Botón Disminuir
local decreaseButton = Instance.new("TextButton")
decreaseButton.Name = "DecreaseButton"
decreaseButton.Size = UDim2.new(0, 70, 0, 35)
decreaseButton.Position = UDim2.new(0, 90, 0, 150)
decreaseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
decreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
decreaseButton.TextSize = 14
decreaseButton.Font = Enum.Font.GothamBold
decreaseButton.Text = "➖ -5"
decreaseButton.BorderSizePixel = 0
decreaseButton.Parent = mainFrame

local decreaseCorner = Instance.new("UICorner")
decreaseCorner.CornerRadius = UDim.new(0, 5)
decreaseCorner.Parent = decreaseButton

-- Botón Toggle (Activar/Desactivar)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 35)
toggleButton.Position = UDim2.new(0, 170, 0, 150)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 12
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "🟢 ACTIVADO"
toggleButton.BorderSizePixel = 0
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 5)
toggleCorner.Parent = toggleButton

-- Función para aumentar velocidad
local function increaseSpeed()
if speedValue < maxSpeed then
speedValue = speedValue + speedIncrement
speedLabel.Text = "Velocidad: " .. speedValue
end
end

-- Función para disminuir velocidad
local function decreaseSpeed()
if speedValue > minSpeed then
speedValue = speedValue - speedIncrement
speedLabel.Text = "Velocidad: " .. speedValue
end
end

-- Función para toggle
local function toggleSpeed()
isSpeedEnabled = not isSpeedEnabled
if isSpeedEnabled then
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
toggleButton.Text = "🟢 ACTIVADO"
else
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleButton.Text = "🔴 DESACTIVADO"
end
end

-- Conectar botones
increaseButton.MouseButton1Click:Connect(increaseSpeed)
decreaseButton.MouseButton1Click:Connect(decreaseSpeed)
toggleButton.MouseButton1Click:Connect(toggleSpeed)

-- Efecto hover en botones
local function addHoverEffect(button)
local originalColor = button.BackgroundColor3
button.MouseEnter:Connect(function()
button.BackgroundColor3 = button.BackgroundColor3:lerp(Color3.fromRGB(255, 255, 255), 0.2)
end)
button.MouseLeave:Connect(function()
button.BackgroundColor3 = originalColor
end)
end

addHoverEffect(increaseButton)
addHoverEffect(decreaseButton)
addHoverEffect(toggleButton)

-- Loop para aplicar velocidad
RunService.RenderStepped:Connect(function()
if isSpeedEnabled and character and humanoidRootPart then
local moveDirection = humanoidRootPart.AssemblyLinearVelocity
local currentSpeed = moveDirection.Magnitude

if currentSpeed < speedValue then  
        humanoidRootPart.AssemblyLinearVelocity = moveDirection.Unit * speedValue  
    end  
end

end)

-- Actualizar cuando el personaje muere y respawns
player.CharacterAdded:Connect(function(newCharacter)
character = newCharacter
humanoidRootPart = character:WaitForChild("HumanoidRootPart")
humanoid = character:WaitForChild("Humanoid")
end)

print("✅ Script de velocidad cargado correctamente")
