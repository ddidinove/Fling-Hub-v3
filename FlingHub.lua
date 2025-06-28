local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Função de Mensagem inicial animada
local function showIntroMessage(callback)
    local gui = Instance.new("ScreenGui")
    gui.Name = "DidiHubIntro"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local label = Instance.new("TextLabel")
    label.AnchorPoint = Vector2.new(0.5,0.5)
    label.Position = UDim2.new(0.5,0,0.5,0)
    label.Size = UDim2.new(0.65, 0, 0.13, 0)
    label.BackgroundTransparency = 1
    label.Text = "🌟 Didi Hub Fling v3 🌟"
    label.Font = Enum.Font.FredokaOne
    label.TextColor3 = Color3.fromRGB(0, 200, 255)
    label.TextStrokeTransparency = 0.18
    label.TextStrokeColor3 = Color3.new(0,0,0)
    label.TextScaled = true
    label.TextTransparency = 1
    label.Parent = gui

    -- Glow
    local glow = Instance.new("TextLabel")
    glow.AnchorPoint = label.AnchorPoint
    glow.Position = label.Position
    glow.Size = label.Size
    glow.BackgroundTransparency = 1
    glow.Text = label.Text
    glow.Font = Enum.Font.FredokaOne
    glow.TextColor3 = Color3.fromRGB(0, 255, 255)
    glow.TextStrokeTransparency = 1
    glow.TextScaled = true
    glow.TextTransparency = 1
    glow.ZIndex = label.ZIndex - 1
    glow.Parent = gui

    -- Fade in
    TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(glow, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.8}):Play()

    -- Glow efeito pulsante
    spawn(function()
        while gui.Parent do
            TweenService:Create(glow, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {TextTransparency = 0.5}):Play()
            wait(0.7)
            TweenService:Create(glow, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {TextTransparency = 0.8}):Play()
            wait(0.7)
        end
    end)

    -- Fade out depois de 2.5 segundos
    task.delay(2.5, function()
        local fadeOut1 = TweenService:Create(label, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1})
        local fadeOut2 = TweenService:Create(glow, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1})
        fadeOut1:Play() fadeOut2:Play()
        fadeOut1.Completed:Wait()
        gui:Destroy()
        if callback then callback() end
    end)
end

-- Função para Hub complexo/bonito
local function showFlingHub()
    local hubGui = Instance.new("ScreenGui")
    hubGui.Name = "DidiHubMain"
    hubGui.IgnoreGuiInset = true
    hubGui.ResetOnSpawn = false
    hubGui.Parent = PlayerGui

    -- Sombra
    local shadow = Instance.new("ImageLabel")
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = UDim2.new(0, 600, 0, 440)
    shadow.Position = UDim2.new(0.5, -300, 0.5, -220)
    shadow.ImageTransparency = 0.77
    shadow.ZIndex = 0
    shadow.Parent = hubGui

    -- Main frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 340)
    frame.Position = UDim2.new(0.5, -250, 0.5, -170)
    frame.BackgroundColor3 = Color3.fromRGB(30,40,60)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.Parent = hubGui

    -- Animação de entrada do Hub
    TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.07}):Play()

    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 54)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🌟 Didi Hub Fling v3 🌟"
    title.Font = Enum.Font.GothamBlack
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextStrokeTransparency = 0.6
    title.TextScaled = true
    title.Parent = frame

    -- Abas
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1,0,0,38)
    tabFrame.Position = UDim2.new(0,0,0,54)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = frame

    local tabs = {}
    local tabNames = {"Fling", "Logs", "Config", "Sobre"}
    local selectedTab = 1

    for i,tabName in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 116, 0, 30)
        btn.Position = UDim2.new(0, 16 + (i-1)*122, 0, 4)
        btn.BackgroundColor3 = i == 1 and Color3.fromRGB(0,200,255) or Color3.fromRGB(30,40,60)
        btn.TextColor3 = i == 1 and Color3.fromRGB(255,255,255) or Color3.fromRGB(170,180,210)
        btn.Font = Enum.Font.GothamSemibold
        btn.Text = tabName
        btn.TextScaled = true
        btn.AutoButtonColor = false
        btn.Parent = tabFrame
] = btn
    end

    -- Conteúdo das abas
    local pages = {}

    -- Página 1: Fling
    do
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, -36, 1, -116)
        page.Position = UDim2.new(0, 18 flingBtn = Instance.new("TextButton")
        flingBtn.Size = UDim2.new(0,200,0,50)
        flingBtn.Position = UDim2.new(0.5,-100,0.1,0)
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
            -- Coloque seu código de fling aqui!
        end)

        pages[1] = page
    end

    -- Página 2: Logs
    do
        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, -36, 1, -116)
        page.Position = UDim2.new(0, 18, 0, 92)
        page.BackgroundTransparency = 1
        page.Parent = frame

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
        page.Size = UDim2.new(1, -36, 1, -116)
        page.Position = UDim2.new(0, 18, 0, 92)
        page.BackgroundTransparency = 1
        page.Parent = frame

        -- Slider de Blur
        local blurLabel = Instance.new("TextLabel")
        blurLabel.Size = UDim2.new(0,120,0,32)
        blurLabel.Position = UDim2.new(0,10,0,18)
        blurLabel.BackgroundTransparency = 1
        blurLabel.Text = "Blur:"
        blurLabel.TextColor3 = Color3.fromRGB(160,170,188)
        blurLabel.Font = Enum.Font.Gotham
        blurLabel.TextScaled = true
        blurLabel.Parent = page

        local blurSlider = Instance.new("TextButton")
        blurSlider.Size = UDim2.new(0,220,0,32)
        blurSlider.Position = UDim2.new(0,140,0,18)
        blurSlider.BackgroundColor3 = Color3.fromRGB(40,60,100)
        blurSlider.Text = "15"
        blurSlider.TextColor3 = Color3.fromRGB(0,200,255)
        blurSlider.Font = Enum.Font.Gotham
        blurSlider.TextScaled = true
        blurSlider.Parent = page

        -- Mudar cor do Hub
        local colorBtn = Instance.new("TextButton")
        colorBtn.Size = UDim2.new(0,200,0,32)
        colorBtn.Position = UDim2.new(0,10,0,64)
        colorBtn.BackgroundColor3 = Color3.fromRGB(0,200,255)
        colorBtn.Text = "Mudar cor do Hub"
        colorBtn.TextColor3 = Color3.fromRGB(255,255,255)
        colorBtn.Font = Enum.Font.Gotham
        colorBtn.TextScaled = true
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
        page.Size = UDim2.new(1, -36, 1, -116)
        page.Position = UDim2.new(0, 18, 0, 92)
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

    -- Função de troca de abas
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

    -- ESC para fechar/abrir o Hub
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if input.KeyCode == Enum.KeyCode.Escape and not processed then
            hubGui.Enabled = not hubGui.Enabled
        end
    end)
end

-- Executa: Mensagem animada, depois Hub avançado
showIntroMessage(showFlingHub)
