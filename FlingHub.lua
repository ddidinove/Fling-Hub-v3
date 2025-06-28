-- 🎮 HUB MOBILE PREMIUM PARA OBBY 🎮
-- Interface otimizada para celular com animações e efeitos visuais

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Variáveis de controle
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local infiniteJumpEnabled = false
local godModeEnabled = false
local espEnabled = false
local hubVisible = true

local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpPower = humanoid.JumpPower

-- Cores do tema
local colors = {
    primary = Color3.fromRGB(138, 43, 226), -- Roxo vibrante
    secondary = Color3.fromRGB(75, 0, 130), -- Roxo escuro
    accent = Color3.fromRGB(255, 20, 147), -- Rosa neon
    success = Color3.fromRGB(0, 255, 127), -- Verde neon
    danger = Color3.fromRGB(255, 69, 0), -- Laranja vermelho
    warning = Color3.fromRGB(255, 215, 0), -- Dourado
    dark = Color3.fromRGB(20, 20, 30), -- Quase preto
    darker = Color3.fromRGB(15, 15, 25), -- Mais escuro
    light = Color3.fromRGB(255, 255, 255) -- Branco
}

-- Criação da GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ObbyHubMobile"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal com efeito glassmorphism
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = colors.dark
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true

-- Efeito de borda brilhante
local borderGlow = Instance.new("UIStroke")
borderGlow.Color = colors.primary
borderGlow.Thickness = 2
borderGlow.Transparency = 0.3
borderGlow.Parent = mainFrame

-- Cantos arredondados
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- Efeito de blur no fundo
local blurEffect = Instance.new("Frame")
blurEffect.Size = UDim2.new(1, 0, 1, 0)
blurEffect.Position = UDim2.new(0, 0, 0, 0)
blurEffect.BackgroundColor3 = colors.darker
blurEffect.BackgroundTransparency = 0.2
blurEffect.BorderSizePixel = 0
blurEffect.Parent = mainFrame

local blurCorner = Instance.new("UICorner")
blurCorner.CornerRadius = UDim.new(0, 20)
blurCorner.Parent = blurEffect

-- Header com gradiente
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 80)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = colors.primary
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = header

-- Gradiente do header
local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, colors.primary),
    ColorSequenceKeypoint.new(1, colors.accent)
}
headerGradient.Rotation = 45
headerGradient.Parent = header

-- Título animado
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 20, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🚀 OBBY HUB PRO"
titleLabel.TextColor3 = colors.light
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Parent = header

-- Efeito de brilho no título
local titleGlow = Instance.new("UIStroke")
titleGlow.Color = colors.light
titleGlow.Thickness = 1
titleGlow.Transparency = 0.7
titleGlow.Parent = titleLabel

-- Subtitle
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(1, -100, 0, 20)
subtitleLabel.Position = UDim2.new(0, 20, 1, -25)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Mobile Edition v2.0"
subtitleLabel.TextColor3 = colors.light
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextTransparency = 0.3
subtitleLabel.Parent = header

-- Botão de minimizar/maximizar
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(1, -65, 0, 15)
toggleButton.BackgroundColor3 = colors.accent
toggleButton.Text = "─"
toggleButton.TextColor3 = colors.light
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BorderSizePixel = 0
toggleButton.Parent = header

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 25)
toggleCorner.Parent = toggleButton

local toggleGlow = Instance.new("UIStroke")
toggleGlow.Color = colors.light
toggleGlow.Thickness = 2
toggleGlow.Transparency = 0.5
toggleGlow.Parent = toggleButton

-- Container principal dos botões
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- ScrollingFrame para os botões
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = colors.primary
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = contentFrame

-- Layout dos botões
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.Parent = scrollFrame

-- Função para criar botões com animações
local function createAnimatedButton(text, icon, callback, color, enabled)
    color = color or colors.primary
    enabled = enabled or false
    
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -20, 0, 60)
    buttonFrame.BackgroundColor3 = enabled and colors.success or color
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 15)
    buttonCorner.Parent = buttonFrame
    
    -- Gradiente do botão
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, buttonFrame.BackgroundColor3),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(
            math.min(255, buttonFrame.BackgroundColor3.R * 255 + 30),
            math.min(255, buttonFrame.BackgroundColor3.G * 255 + 30),
            math.min(255, buttonFrame.BackgroundColor3.B * 255 + 30)
        ))
    }
    buttonGradient.Rotation = 45
    buttonGradient.Parent = buttonFrame
    
    -- Borda brilhante
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = colors.light
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = 0.8
    buttonStroke.Parent = buttonFrame
    
    -- Botão invisível para clique
    local clickButton = Instance.new("TextButton")
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Position = UDim2.new(0, 0, 0, 0)
    clickButton.BackgroundTransparency = 1
    clickButton.Text = ""
    clickButton.Parent = buttonFrame
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 40, 0, 40)
    iconLabel.Position = UDim2.new(0, 15, 0.5, -20)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = colors.light
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.FredokaOne
    iconLabel.Parent = buttonFrame
    
    -- Texto principal
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -70, 0, 25)
    textLabel.Position = UDim2.new(0, 60, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = colors.light
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = buttonFrame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -70, 0, 15)
    statusLabel.Position = UDim2.new(0, 60, 0, 35)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = enabled and "ATIVADO" or "DESATIVADO"
    statusLabel.TextColor3 = enabled and colors.success or Color3.fromRGB(150, 150, 150)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = buttonFrame
    
    -- Efeito de onda ao clicar
    local function createRipple()
        local ripple = Instance.new("Frame")
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = colors.light
        ripple.BackgroundTransparency = 0.5
        ripple.BorderSizePixel = 0
        ripple.Parent = buttonFrame
        
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        
        local rippleTween = TweenService:Create(ripple, 
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
            {
                Size = UDim2.new(2, 0, 2, 0),
                Position = UDim2.new(-0.5, 0, -0.5, 0),
                BackgroundTransparency = 1
            }
        )
        
        rippleTween:Play()
        rippleTween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end
    
    -- Animações do botão
    local function animatePress()
        createRipple()
        
        local pressInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local pressTween = TweenService:Create(buttonFrame, pressInfo, {Size = UDim2.new(1, -25, 0, 55)})
        local returnTween = TweenService:Create(buttonFrame, pressInfo, {Size = UDim2.new(1, -20, 0, 60)})
        
        pressTween:Play()
        pressTween.Completed:Connect(function()
            returnTween:Play()
        end)
    end
    
    -- Hover effect para dispositivos com mouse
    clickButton.MouseEnter:Connect(function()
        if not UserInputService.TouchEnabled then
            local hoverTween = TweenService:Create(buttonStroke, 
                TweenInfo.new(0.2, Enum.EasingStyle.Quad), 
                {Transparency = 0.3}
            )
            hoverTween:Play()
        end
    end)
    
    clickButton.MouseLeave:Connect(function()
        if not UserInputService.TouchEnabled then
            local unhoverTween = TweenService:Create(buttonStroke, 
                TweenInfo.new(0.2, Enum.EasingStyle.Quad), 
                {Transparency = 0.8}
            )
            unhoverTween:Play()
        end
    end)
    
    -- Função de clique
    clickButton.MouseButton1Click:Connect(function()
        animatePress()
        
        -- Delay pequeno para mostrar a animação
        wait(0.1)
        
        if callback then
            local success, newState = pcall(callback)
            if success and newState ~= nil then
                enabled = newState
                statusLabel.Text = enabled and "ATIVADO" or "DESATIVADO"
                statusLabel.TextColor3 = enabled and colors.success or Color3.fromRGB(150, 150, 150)
                
                -- Animar mudança de cor
                local colorTween = TweenService:Create(buttonFrame,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = enabled and colors.success or color}
                )
                colorTween:Play()
                
                -- Atualizar gradiente
                colorTween.Completed:Connect(function()
                    buttonGradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, buttonFrame.BackgroundColor3),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(
                            math.min(255, buttonFrame.BackgroundColor3.R * 255 + 30),
                            math.min(255, buttonFrame.BackgroundColor3.G * 255 + 30),
                            math.min(255, buttonFrame.BackgroundColor3.B * 255 + 30)
                        ))
                    }
                end)
            end
        end
    end)
    
    return buttonFrame, statusLabel
end

-- Funções das funcionalidades (otimizadas para mobile)
local flyConnection = nil
local noclipConnection = nil
local jumpConnection = nil

local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        -- Criar controles de toque para fly
        local flyGui = Instance.new("ScreenGui")
        flyGui.Name = "FlyControls"
        flyGui.Parent = playerGui
        flyGui.ResetOnSpawn = false
        
        local controlFrame = Instance.new("Frame")
        controlFrame.Size = UDim2.new(0, 200, 0, 200)
        controlFrame.Position = UDim2.new(1, -220, 1, -220)
        controlFrame.BackgroundTransparency = 1
        controlFrame.Parent = flyGui
        
        -- Joystick virtual
        local joystickBase = Instance.new("Frame")
        joystickBase.Size = UDim2.new(0, 120, 0, 120)
        joystickBase.Position = UDim2.new(0, 0, 0, 0)
        joystickBase.BackgroundColor3 = colors.dark
        joystickBase.BackgroundTransparency = 0.3
        joystickBase.BorderSizePixel = 0
        joystickBase.Parent = controlFrame
        
        local joystickCorner = Instance.new("UICorner")
        joystickCorner.CornerRadius = UDim.new(1, 0)
        joystickCorner.Parent = joystickBase
        
        local joystickKnob = Instance.new("Frame")
        joystickKnob.Size = UDim2.new(0, 40, 0, 40)
        joystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
        joystickKnob.BackgroundColor3 = colors.primary
        joystickKnob.BorderSizePixel = 0
        joystickKnob.Parent = joystickBase
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(1, 0)
        knobCorner.Parent = joystickKnob
        
        -- Botões Up/Down
        local upButton = Instance.new("TextButton")
        upButton.Size = UDim2.new(0, 60, 0, 30)
        upButton.Position = UDim2.new(0, 130, 0, 30)
        upButton.BackgroundColor3 = colors.success
        upButton.Text = "⬆️"
        upButton.TextScaled = true
        upButton.BorderSizePixel = 0
        upButton.Parent = controlFrame
        
        local downButton = Instance.new("TextButton")
        downButton.Size = UDim2.new(0, 60, 0, 30)
        downButton.Position = UDim2.new(0, 130, 0, 90)
        downButton.BackgroundColor3 = colors.danger
        downButton.Text = "⬇️"
        downButton.TextScaled = true
        downButton.BorderSizePixel = 0
        downButton.Parent = controlFrame
        
        -- Arredondar botões
        for _, btn in pairs({upButton, downButton}) do
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = btn
        end
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        local joystickDirection = Vector2.new(0, 0)
        local verticalMovement = 0
        
        -- Lógica do joystick
        local function updateJoystick(input)
            local center = joystickBase.AbsolutePosition + joystickBase.AbsoluteSize/2
            local inputPos = Vector2.new(input.Position.X, input.Position.Y)
            local direction = (inputPos - center)
            local distance = math.min(direction.Magnitude, 40)
            
            if distance > 5 then
                direction = direction.Unit * distance
                joystickDirection = direction / 40
            else
                direction = Vector2.new(0, 0)
                joystickDirection = Vector2.new(0, 0)
            end
            
            joystickKnob.Position = UDim2.new(0.5, direction.X - 20, 0.5, direction.Y - 20)
        end
        
        joystickBase.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                updateJoystick(input)
            end
        end)
        
        joystickBase.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                updateJoystick(input)
            end
        end)
        
        joystickBase.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                joystickDirection = Vector2.new(0, 0)
                joystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
            end
        end)
        
        -- Botões de subir/descer
        upButton.TouchTap:Connect(function() verticalMovement = 1 end)
        downButton.TouchTap:Connect(function() verticalMovement = -1 end)
        upButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                verticalMovement = 0
            end
        end)
        downButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                verticalMovement = 0
            end
        end)
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyEnabled then
                bodyVelocity:Destroy()
                flyGui:Destroy()
                flyConnection:Disconnect()
                return
            end
            
            local camera = Workspace.CurrentCamera
            local direction = Vector3.new(joystickDirection.X, verticalMovement, -joystickDirection.Y)
            
            if direction.Magnitude > 0 then
                local cameraDirection = camera.CFrame:VectorToWorldSpace(direction)
                bodyVelocity.Velocity = cameraDirection * 50
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
        end
        
        -- Remover GUI de controles
        local flyGui = playerGui:FindFirstChild("FlyControls")
        if flyGui then
            flyGui:Destroy()
        end
    end
    
    return flyEnabled
end

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then
                noclipConnection:Disconnect()
                return
            end
            
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
    
    return noclipEnabled
end

local function toggleSpeed()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        humanoid.WalkSpeed = 50
    