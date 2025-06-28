-- Didi Hub Fling v3 - Suporte total para Celular e PC

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Mensagem inicial animada e responsiva
local function showIntroMessage(callback)
    -- Remove se já existir
    if PlayerGui:FindFirstChild("DidiHubIntro") then
        PlayerGui.DidiHubIntro:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "DidiHubIntro"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local label = Instance.new("TextLabel")
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, 0, 0.5, 0)
    label.Size = UDim2.new(0.85, 0, 0.11, 0) -- Responsivo
    label.BackgroundTransparency = 1
    label.Text = "🌟 Didi Hub Fling v3 🌟"
    label.Font = Enum.Font.FredokaOne
    label.TextColor3 = Color3.fromRGB(0, 200, 255)
    label.TextStrokeTransparency = 0.12
    label.TextStrokeColor3 = Color3.new(0,0,0)
    label.TextScaled = true
    label.TextWrapped = true
    label.TextTransparency = 1
    label.Parent = gui

    -- Glow
    local glow = Instance.new("TextLabel")
    glow.AnchorPoint = label.AnchorPoint
    glow.Position = label.Position
    glow.Size = label.Size
    glow.BackgroundTransparency = 1
    glow.Text = label.Text
    glow.Font = label.Font
    glow.TextColor3 = Color3.fromRGB(0, 255, 255)
    glow.TextStrokeTransparency = 1
    glow.TextScaled = true
    glow.TextWrapped = true
    glow.TextTransparency = 1
    glow.ZIndex = label.ZIndex - 1
    glow.Parent = gui

    -- Fade in
    TweenService:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(glow, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.82}):Play()

    -- Glow pulsante
    spawn(function()
        while gui.Parent do
            TweenService:Create(glow, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {TextTransparency = 0.6}):Play()
            wait(0.6)
            TweenService:Create(glow, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {TextTransparency = 0.82}):Play()
            wait(0.6)
        end
    end)

    -- Fade out depois de 1.7 segundos
    task.delay(1.7, function()
        TweenService:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
        TweenService:Create(glow, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
        task.wait(0.8)
        gui:Destroy()
        if callback then callback() end
    end)
end

-- Hub complexo e responsivo
local function showFlingHub()
    if PlayerGui:FindFirstChild("DidiHubMain") then
        PlayerGui.DidiHubMain:Destroy()
    end

    local hubGui = Instance.new("ScreenGui")
    hubGui.Name = "DidiHubMain"
    hubGui.IgnoreGuiInset = true
    hubGui.ResetOnSpawn = false
    hubGui.Parent = PlayerGui

    -- Sombra sutil
    local shadow = Instance.new("ImageLabel")
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = UDim2.new(0.96, 0, 0.75, 0)
    shadow.Position = UDim2.new(0.02, 0, 0.13, 0)
    shadow.ImageTransparency = 0.8
    shadow.ZIndex = 0
    shadow.Parent = hubGui

    -- Janela principal responsiva
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.92, 0, 0.64, 0)
    frame.Position = UDim2.new(0.04, 0, 0.18, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30,40,60)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.AnchorPoint = Vector2.new(0,0)
    frame.Parent = hubGui

    -- Animação de entrada
    TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.07}):Play()

    -- Título responsivo
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.16, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌟 Didi Hub Fling v3 🌟"
    title.Font = Enum.Font.GothamBlack
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextStrokeTransparency = 0.6
    title.TextScaled = true
    title.TextWrapped = true
    title.Parent = frame

    -- Abas responsivas
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 0.13, 0)
    tabFrame.Position = UDim2.new(0, 0, 0.16, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = frame

    local tabs = {}
    local tabNames = {"Fling", "Logs", "Config", "Sobre"}
    local selectedTab = 1

    for i,tabName in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.23, 0, 0.8, 0)
        btn.Position = UDim2.new(0.02 + (i-1)*0.25, 0, 0.1, 0)
        btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0,200,255) or Color3.fromRGB(30,40,60)
        btn.TextColor3 = i == 1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(170,180,210)
        btn.Font = Enum.Font.GothamSemibold
        btn.Text = tabName
        btn.TextScaled = true
        btn.TextWrapped = true
        btn.AutoButtonColor = false
        btn.Parent = tabFrame
        btn.ZIndex = 2
        tabs[i] = btn
    end

    -- Conteúdo das abas (0)
        flingBtn.Position = UDim2.new(0.25, 0, 0.2, 0)
        flingBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
        flingBtn.TextColor3 = Color3.fromRGB(255,255,255)
        flingBtn.Font = Enum.Font.GothamBold
        flingBtn.TextScaled = true
        flingBtn.TextWrapped = true
        flingBtn.Text = "Ativar Fling"
        flingBtn.AutoButtonColor = true
        flingBtn.Parent = page

        -- Hover animação
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
            -- Seu código de fling pode ir aqui
        end)

        pages[1] = page
    end

    -- Página 2: Logs
    do
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, -10, 0.6, 0)
        page.Position = UDim2.new(0, 5, 0.3, 0)
        page.BackgroundTransparency = 1
        page.Parent = frame

        local logBox = Instance.new("TextBox")
        logBox.Size = UDim2.new(1, 0, 1, 0)
        logBox.Position = UDim2.new(0, 0, 0, 0)
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
        page.Size = UDim2.new(1, -10, 0.6, 0)
        page.Position = UDim2.new(0, 5, 0.3, 0)
        page.BackgroundTransparency = 1
        page.Parent = frame

        -- Mudar cor do Hub
        local colorBtn = Instance.new("TextButton")
        colorBtn.Size = UDim2.new(0.6, 0, 0.2, 0)
        colorBtn.Position = UDim2.new(0.2, 0, 0.3, 0)
        colorBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
        colorBtn.Text = "Mudar cor do Hub"
        colorBtn.TextColor3 = Color3.fromRGB(255,255,255)
        colorBtn.Font = Enum.Font.Gotham
        colorBtn.TextScaled = true
        colorBtn.TextWrapped = true
        colorBtn.Parent = page

        colorBtn.MouseButton1Click:Connect(function()
            TweenService:Create(frame, TweenInfo.new(0.5), {
                BackgroundColor3 = Color3.fromRGB(math.random(20, 100),math.random(50,200),math.random(100,255))
            }):Play()
        end)

        pages[3] = page
    end

    -- Página 4: Sobre
    do
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, -10, 0.6, 0)
        page.Position = UDim2.new(0, 5, 0.3, 0)
        page.BackgroundTransparency = 1
        page.Parent = frame

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

    -- Troca de abas
    local function showTab(idx)
        for i,page in ipairs(pages) do
            page.Visible = (i == idx)
            TweenService:Create(tabs[i], TweenInfo.new(0.25), {
                BackgroundColor3 = (i==idx and Color3.fromRGB(0,200,255) or Color3.fromRGB(30,40,60)),
                TextColor3 = (i==idx and Color3.fromRGB(255,255,255) or Color3.fromRGB(170,180,210))
            }):Play()
        end
    end
    for i,btn in ipairs(tabs) do
        btn.MouseButton1Click:Connect(function()
            selectedTab = i
            showTab(i)
        end)
    end
    for i,page in ipairs(pages) do page.Visible = (i==1) end

    -- ESC fecha o Hub (no PC)
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if input.KeyCode == Enum.KeyCode.Escape and not processed then
            hubGui.Enabled = not hubGui.Enabled
        end
    end)
end

-- Executa: Mensagem animada, depois Hub responsivo
showIntroMessage(showFlingHub)
