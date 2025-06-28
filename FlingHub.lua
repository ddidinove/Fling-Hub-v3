-- Hub Fling estilizado by Copilot Chat
local p=game.Players.LocalPlayer
local g=Instance.new("ScreenGui",p.PlayerGui) g.Name="FlingHub"
g.ResetOnSpawn=false
-- Blur effect
local blur=Instance.new("BlurEffect",game.Lighting)
blur.Size=0
-- Main button
local b=Instance.new("TextButton",g)
b.Size=UDim2.new(0,60,0,26) b.Position=UDim2.new(0,16,0.5,-13)
b.Text="FLING" b.BackgroundColor3=Color3.fromRGB(40,42,67)
b.TextColor3=Color3.fromRGB(255,195,80) b.Font=Enum.Font.GothamBold b.TextSize=18
Instance.new("UICorner",b).CornerRadius=UDim.new(0,12)
-- Main frame
local f=Instance.new("Frame",g) f.Size=b.Size f.Position=b.Position
f.BackgroundColor3=Color3.fromRGB(29,29,39) f.Visible=false f.ClipsDescendants=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,16)
-- Close button
local c=Instance.new("TextButton",f) c.Text="⨉" c.Size=UDim2.new(0,26,0,26)
c.Position=UDim2.new(1,-32,0,6) c.BackgroundColor3=Color3.fromRGB(58,58,90)
c.TextColor3=Color3.fromRGB(250,80,80) c.Font=Enum.Font.GothamBold c.TextSize=16
Instance.new("UICorner",c).CornerRadius=UDim.new(0,9) c.Visible=false
-- Título
local t=Instance.new("TextLabel",f) t.Text="FLING HUB" t.Size=UDim2.new(1,0,0,32)
t.Position=UDim2.new(0,0,0,4) t.BackgroundTransparency=1 t.TextColor3=Color3.fromRGB(255,220,120)
t.TextSize=18 t.Font=Enum.Font.GothamBold t.Visible=false
-- Scroll jogadores
local sc=Instance.new("ScrollingFrame",f)
sc.Size=UDim2.new(1,-18,1,-48) sc.Position=UDim2.new(0,9,0,40)
sc.BackgroundTransparency=1 sc.ScrollBarThickness=5 sc.Visible=false
local ul=Instance.new("UIListLayout",sc) ul.Padding=UDim.new(0,4) ul.HorizontalAlignment=Enum.HorizontalAlignment.Center

-- Animação de blur
local function blurto(val,time)
    if not blur or not blur.Parent then return end
    local st=blur.Size local startTick=os.clock()
    while os.clock()-startTick<time do
        blur.Size=st+(val-st)*((os.clock()-startTick)/time)
        task.wait()
    end
    blur.Size=val
end

-- Animação abrir
local TweenService=game:GetService("TweenService")
b.MouseButton1Click:Connect(function()
    b.Visible=false
    f.Size=b.Size f.Position=b.Position f.Visible=true t.Visible=false c.Visible=false sc.Visible=false
    TweenService:Create(f,TweenInfo.new(0.22,Enum.EasingStyle.Back),{Size=UDim2.new(0,250,0,350),Position=UDim2.new(0.5,-125,0.5,-175)}):Play()
    task.spawn(function() blurto(15,0.25) end)
    task.wait(0.23) t.Visible=true c.Visible=true sc.Visible=true
end)
-- Fechar
c.MouseButton1Click:Connect(function()
    t.Visible=false c.Visible=false sc.Visible=false
    TweenService:Create(f,TweenInfo.new(0.17,Enum.EasingStyle.Back),{Size=UDim2.new(0,60,0,26),Position=UDim2.new(0,16,0.5,-13)}):Play()
    task.spawn(function() blurto(0,0.2) end)
    task.wait(0.15) f.Visible=false b.Visible=true
end)

-- Atualiza lista
local function ref()
    for _,v in pairs(sc:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    local n=0
    for _,p2 in ipairs(game.Players:GetPlayers()) do
        if p2~=p then n=n+1
            local pf=Instance.new("Frame",sc) pf.Size=UDim2.new(1,-8,0,42)
            pf.BackgroundColor3=Color3.fromRGB(44,52,82) Instance.new("UICorner",pf).CornerRadius=UDim.new(0,8)
            local thumb=Instance.new("ImageLabel",pf)
            thumb.Size=UDim2.new(0,30,0,30) thumb.Position=UDim2.new(0,6,0,6)
            thumb.Image="https://www.roblox.com/headshot-thumbnail/image?userId="..p2.UserId.."&width=420&height=420&format=png"
            thumb.BackgroundTransparency=1
            local nm=Instance.new("TextLabel",pf) nm.Text=p2.DisplayName
            nm.Size=UDim2.new(1,-74,0,22) nm.Position=UDim2.new(0,40,0,9)
            nm.BackgroundTransparency=1 nm.TextColor3=Color3.fromRGB(230,230,230)
            nm.Font=Enum.Font.Gotham nm.TextSize=14 nm.TextXAlignment=Enum.TextXAlignment.Left
            local fl=Instance.new("TextButton",pf) fl.Text="FLING"
            fl.Size=UDim2.new(0,52,0,22) fl.Position=UDim2.new(1,-58,0.5,-11)
            fl.AnchorPoint=Vector2.new(0,0.5)
            fl.BackgroundColor3=Color3.fromRGB(110,160,255) fl.TextColor3=Color3.fromRGB(255,255,255)
            fl.Font=Enum.Font.GothamBold fl.TextSize=13 Instance.new("UICorner",fl).CornerRadius=UDim.new(0,8)
            fl.MouseButton1Click:Connect(function()
                local ch,me=p2.Character,p.Character
                if not ch or not me then return end
                local hrp,chp=ch:FindFirstChild("HumanoidRootPart"),me:FindFirstChild("HumanoidRootPart")
                if not hrp or not chp then return end
                -- Teleporta até o alvo
                chp.CFrame=hrp.CFrame*CFrame.new(0,0,2) wait(0.09)
                -- Fling
                local bv=Instance.new("BodyAngularVelocity",hrp)
                bv.AngularVelocity=Vector3.new(1e5,1e5,1e5)
                bv.MaxTorque=Vector3.new(1e9,1e9,1e9)
                wait(0.95) bv:Destroy()
            end)
        end
    end
    sc.CanvasSize=UDim2.new(0,0,0,math.max(n*46,1))
end
ref() game.Players.PlayerAdded:Connect(ref) game.Players.PlayerRemoving:Connect(ref)

-- Remove blur ao fechar o jogo
game:BindToClose(function() if blur and blur.Parent then blur:Destroy() end end)
