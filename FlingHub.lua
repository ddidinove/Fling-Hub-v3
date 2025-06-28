-- Didi Hub fling v3 - Hub complexo e bonito

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Tela principal
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "DidiHubMain"
hubGui.IgnoreGuiInset = true
hubGui.ResetOnSpawn = false
hubGui.Parent = PlayerGui

-- Fundo escuro com blur
local blur = Instance.new("Frame")
blur.Size = UDim2.new(1,0,1,0)
blur.BackgroundColor3 = Color3.fromRGB(18,24,38)
blur.BackgroundTransparency = 0.3
blur.Parent = hubGui

-- Container central (janela principal)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 460230, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,40,60)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.Parent = hubGui

-- Sombra
local shadow = Instance.new("ImageLabel")
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Position = UDim2.new(-0.07, 0, -0.11, 0)
shadow.ImageTransparency = 0.7
shadow.ZIndex = 0
shadow.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌟 Didi Hub Fling v3 🌟"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextStrokeTransparency = 0.6
title.TextScaled = true
title.Parent = mainFrame

-- Abas (Tabs)
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1,0,0,38)
tabFrame.Position = UDim2.new(0,0,0,50)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = mainFrame

local tabs = {}
local tabNames = {"Fling", "Logs", "Config", "Sobre"}
local selectedTab = 1

for i,tabName in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 28)
    btn.Position = UDim2.new(0, 18 + (i-1)*110, 0, 5)
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0,200,255) or Color3.fromRGB(30,40,60)
    btn.TextColor3 = i == 1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(160,170,188)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = tabName
    btn.TextScaled = true
    btn.AutoButtonColor = false
    btn.Parent = tabFrame
    btn.ZIndex = 2
    tabs[i] = btn
end

-- Conteúdo das abas
local pages = {}

-- Página 1: Fling
do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -32, 1, -105)
    page.Position = UDim2.new(0, 16, 0, 88)
    page.BackgroundTransparency = 1
    page.Parent = mainFrame

    -- Botão de Fling
    local flingBtn = Instance.new("TextButton")
    flingBtn.Size = UDim2.new(0,200,0,45)
    flingBtn.Position = UDim2.new(0.5,-100,0,20)
    flingBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
    flingBtn.TextColor3 = Color3.fromRGB(255,255,255)
    flingBtn.Font = Enum.Font.GothamBold
    flingBtn.TextScaled = true
    flingBtn.Text = "Ativar Fling"
    flingBtn.AutoButtonColor = true
    flingBtn.Parent = page

    -- Animação hover
    flingBtn.MouseEnter:Connect(function()
        TweenService:Create(flingBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 220)}):Play()
    end)
    flingBtn.MouseLeave:Connect(function()
        TweenService:Create(flingBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
    end)

    -- Exemplo ação
    flingBtn.MouseButton1Click:Connect(function()
        flingBtn.Text = "Fling Ativado!"
        TweenService:Create(flingBtn, TweenInfo.new(0.4), {BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
    end)

    pages[1] = page
end

-- Página 2: Logs
do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -32, 1, -105)
    page.Position = UDim2.new(0, 16, 0, 88)
    page.BackgroundTransparency = 1
    page.Parent = mainFrame

    local logBox = Instance.new("TextBox")
    logBox.Size = UDim2.new(1, 0, 1, 0)
    logBox.Position = UDim2.new(0,0,0,0)
    logBox.BackgroundColor3 = Color3.fromRGB(25,32,48)
    logBox.TextColor3 = Color3.fromRGB(0,200,255)
    logBox.TextXAlignment = Enum.TextXAlignment.Left
    logBox.TextYAlignment = Enum.TextYAlignment.Top
    logBox.ClearTextOnFocus = false
    logBox.Font = Enum.Font.Code
    logBox.TextSize = 18
    logBox.Text = "Logs do Hub aparecerão aqui."
    logBox.MultiLine = true
    logBox.TextWrapped = true
    logBox.Parent = page

    pages[2] = page
end

-- Página 3: Config
do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -32, 1, -105)
    page.Position = UDim2.new(0, 16, 0, 88)
    page.BackgroundTransparency = 1
    page.Parent = mainFrame

    -- Exemplo: Slider de Blur
    local blurLabel = Instance.new("TextLabel")
    blurLabel.Size = UDim2.new(0,120,0,28)
    blurLabel.Position = UDim2.new(0,10,0,20)
    blurLabel.BackgroundTransparency = 1
    blurLabel.Text = "Blur:"
    blurLabel.TextColor3 = Color3.fromRGB(160,170,188)
    blurLabel.Font = Enum.Font.Gotham
    blurLabel.TextScaled = true
    blurLabel.Parent = page

    local blurSlider = Instance.new("TextButton")
    blurSlider.Size = UDim2.new(0,200,0,28)
    blurSlider.Position = UDim2.new(0,140,0,20)
    blurSlider.BackgroundColor3 = Color3.fromRGB(40,60,100)
    blurSlider.Text = "15"
    blurSlider.TextColor3 = Color3.fromRGB(0,200,255)
    blurSlider.Font = Enum.Font.Gotham
    blurSlider.TextScaled = true
    blurSlider.Parent = page

    -- Exemplo: mudar cor do Hub
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(0,170,0,28)
    colorBtn.Position = UDim2.new(0,10,0,60)
    colorBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
    colorBtn.Text = "Mudar cor do Hub"
    colorBtn.TextColor3 = Color3.fromRGB(255,255,255)
    colorBtn.Font = Enum.Font.Gotham
    colorBtn.TextScaled = true
    colorBtn.Parent = page

    colorBtn.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(math.random(20, 100),math.random(50,200),math.random(100,255))}):Play()
    end)

    pages[3] = page
end

-- Página 4: Sobre
do
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -32, 1, -105)
    page.Position = UDim2.new(0, 16, 0, 88)
    page.BackgroundTransparency = 1
    page.Parent = mainFrame

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 1, 0)
    info.Position = UDim2.new(0,0,0,0)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.fromRGB(0,200,255)
    info.Font = Enum.Font.Gotham
    info.TextScaled = true
    info.TextWrapped = true
    info.Text = "🌟 Didi Hub Fling v3 🌟\n\nHub feito para Roblox!\n\nPersonalize suas funções e aproveite."
    info.Parent = page

    pages[4] = page
end

-- Função de troca de abas
local function showTab(idx)
    for i,page in ipairs(pages) do
        page.Visible = (i == idx)
        TweenService:Create(tabs[i], TweenInfo.new(0.3), {
            BackgroundColor3 = (i==idx and Color3.fromRGB(0,200,255) or Color3.fromRGB(30,40,60)),
            TextColor3 = (i==idx and Color3.fromRGB(255,255,255) or Color3.fromRGB(160,170,188))
        }):Play()
    end
end
for i,btn in ipairs(tabs) do
    btn.MouseButton1Click:Connect(function()
        selectedTab = i
        showTab(i)
    end)
end

-- Inicialização do Hub
for i,page in ipairs(pages) do page.Visible = (i==1) end
mainFrame.Visible = false
mainFrame.BackgroundTransparency = 1
TweenService:Create(mainFrame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.08}):Play()
mainFrame.Visible = true

-- ESC para fechar o Hub
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.Escape and not processed then
        hubGui.Enabled = not hubGui.Enabled
    end
end)
