local Library = {}
local TweenService = game:GetService("TweenService")

Library.Theme = {
    Background = Color3.fromRGB(18, 18, 22),
    Sidebar = Color3.fromRGB(24, 24, 28),
    Header = Color3.fromRGB(22, 22, 26),
    Accent = Color3.fromRGB(230, 30, 90), -- สีแดง/ชมพูสไตล์ Xenon สำหรับปุ่มเมนูที่เลือก
    ActiveToggle = Color3.fromRGB(0, 122, 255),
    InactiveToggle = Color3.fromRGB(50, 50, 60),
    Text = Color3.fromRGB(240, 240, 245),
    DarkText = Color3.fromRGB(140, 140, 150),
    ElementBg = Color3.fromRGB(28, 28, 34),
    Border = Color3.fromRGB(40, 40, 48)
}

function Library:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "Xenon Hub"
    
    local CoreGui = game:GetService("CoreGui")
    if CoreGui:FindFirstChild("kqUi_Xenon") then
        CoreGui.kqUi_Xenon:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "kqUi_Xenon"
    ScreenGui.Parent = CoreGui
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 700, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -210)
    MainFrame.BackgroundColor3 = Library.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    -- Top Bar (macOS style)
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Library.Theme.Header
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar
    
    local FixTop = Instance.new("Frame")
    FixTop.Size = UDim2.new(1, 0, 0, 5)
    FixTop.Position = UDim2.new(0, 0, 1, -5)
    FixTop.BackgroundColor3 = Library.Theme.Header
    FixTop.BorderSizePixel = 0
    FixTop.Parent = TopBar
    
    -- Draggable
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Mac Dots
    local RedDot = Instance.new("TextButton")
    RedDot.Size = UDim2.new(0, 12, 0, 12)
    RedDot.Position = UDim2.new(0, 12, 0.5, -6)
    RedDot.BackgroundColor3 = Color3.fromRGB(255, 95, 85)
    RedDot.Text = ""
    RedDot.Parent = TopBar
    Instance.new("UICorner", RedDot).CornerRadius = UDim.new(1, 0)
    
    RedDot.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local YellowDot = Instance.new("Frame")
    YellowDot.Size = UDim2.new(0, 12, 0, 12)
    YellowDot.Position = UDim2.new(0, 32, 0.5, -6)
    YellowDot.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
    YellowDot.Parent = TopBar
    Instance.new("UICorner", YellowDot).CornerRadius = UDim.new(1, 0)
    
    local GreenDot = Instance.new("Frame")
    GreenDot.Size = UDim2.new(0, 12, 0, 12)
    GreenDot.Position = UDim2.new(0, 52, 0.5, -6)
    GreenDot.BackgroundColor3 = Color3.fromRGB(40, 200, 64)
    GreenDot.Parent = TopBar
    Instance.new("UICorner", GreenDot).CornerRadius = UDim.new(1, 0)
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 300, 1, 0)
    TitleLabel.Position = UDim2.new(0, 80, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = WindowName
    TitleLabel.TextColor3 = Library.Theme.Text
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    -- Sidebar
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 180, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Library.Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    Sidebar.ScrollBarThickness = 2
    Sidebar.Parent = MainFrame
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 4)
    SidebarLayout.Parent = Sidebar
    
    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.PaddingLeft = UDim.new(0, 10)
    SidebarPadding.PaddingRight = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar
    
    -- Container Holder
    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Size = UDim2.new(1, -180, 1, -35)
    ContainerHolder.Position = UDim2.new(0, 180, 0, 35)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.Parent = MainFrame
    
    local WindowObject = {}
    local FirstTab = true
    
    function WindowObject:CreateTab(tabName)
        local TabObject = {}
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 32)
        TabButton.BackgroundColor3 = FirstTab and Library.Theme.AccentColor or Color3.fromRGB(0,0,0)
        TabButton.BackgroundTransparency = FirstTab and 0 or 1
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.Text = "   " .. tabName
        TabButton.TextColor3 = FirstTab and Library.Theme.Text or Library.Theme.DarkText
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = Sidebar
        
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)
        
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = FirstTab
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.ScrollBarThickness = 4
        TabPage.Parent = ContainerHolder
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = TabPage
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 15)
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingRight = UDim.new(0, 15)
        PagePadding.Parent = TabPage
        
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 30)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContainerHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(Sidebar:GetChildren()) do
                if v:IsA("TextButton") then
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(v, tweenInfo, {
                        BackgroundColor3 = Color3.fromRGB(0,0,0),
                        BackgroundTransparency = 1
                    }):Play()
                    v.TextColor3 = Library.Theme.DarkText
                end
            end
            
            TabPage.Visible = true
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(TabButton, tweenInfo, {
                BackgroundColor3 = Library.Theme.AccentColor,
                BackgroundTransparency = 0
            }):Play()
            TabButton.TextColor3 = Library.Theme.Text
        end)
        
        FirstTab = false
        
        function TabObject:CreateToggle(toggleOptions)
            toggleOptions = toggleOptions or {}
            local toggled = toggleOptions.Default or false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 46)
            ToggleFrame.BackgroundColor3 = Library.Theme.ElementBg
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabPage
            
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)
            
            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -60, 1, 0)
            Title.Position = UDim2.new(0, 12, 0, 0)
            Title.BackgroundTransparency = 1
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = toggleOptions.Name or "Toggle"
            Title.TextColor3 = Library.Theme.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = ToggleFrame
            
            local SwitchBg = Instance.new("Frame")
            SwitchBg.Size = UDim2.new(0, 40, 0, 22)
            SwitchBg.Position = UDim2.new(1, -52, 0.5, -11)
            SwitchBg.BackgroundColor3 = toggled and Library.Theme.ActiveToggle or Library.Theme.InactiveToggle
            SwitchBg.Parent = ToggleFrame
            Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)
            
            local SwitchCircle = Instance.new("Frame")
            SwitchCircle.Size = UDim2.new(0, 16, 0, 16)
            SwitchCircle.Position = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
            SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SwitchCircle.Parent = SwitchBg
            Instance.new("UICorner", SwitchCircle).CornerRadius = UDim.new(1, 0)
            
            local ClickBox = Instance.new("TextButton")
            ClickBox.Size = UDim2.new(1, 0, 1, 0)
            ClickBox.BackgroundTransparency = 1
            ClickBox.Text = ""
            ClickBox.Parent = ToggleFrame
            
            ClickBox.MouseButton1Click:Connect(function()
                toggled = not toggled
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local targetBgColor = toggled and Library.Theme.ActiveToggle or Library.Theme.InactiveToggle
                local targetPos = toggled and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                
                TweenService:Create(SwitchBg, tweenInfo, {BackgroundColor3 = targetBgColor}):Play()
                TweenService:Create(SwitchCircle, tweenInfo, {Position = targetPos}):Play()
                
                if toggleOptions.Callback then
                    toggleOptions.Callback(toggled)
                end
            end)
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
