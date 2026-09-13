local Library = {}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

Library.Theme = {
    Background = Color3.fromRGB(18, 18, 22),
    Sidebar = Color3.fromRGB(24, 24, 28),
    Header = Color3.fromRGB(22, 22, 26),
    Accent = Color3.fromRGB(230, 30, 90),
    ActiveToggle = Color3.fromRGB(0, 122, 255),
    InactiveToggle = Color3.fromRGB(50, 50, 60),
    Text = Color3.fromRGB(240, 240, 245),
    DarkText = Color3.fromRGB(140, 140, 150),
    ElementBg = Color3.fromRGB(28, 28, 34),
    Border = Color3.fromRGB(40, 40, 48),
    DropdownItem = Color3.fromRGB(34, 34, 42),
    SliderFill = Color3.fromRGB(0, 122, 255)
}

function Library:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "Xenon Hub"
    
    if CoreGui:FindFirstChild("kqUi_Xenon") then
        CoreGui.kqUi_Xenon:Destroy()
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "kqUi_Xenon"
    ScreenGui.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 700, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -210)
    MainFrame.BackgroundColor3 = Library.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Library.Theme.Header
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)
    
    local FixTop = Instance.new("Frame")
    FixTop.Size = UDim2.new(1, 0, 0, 5)
    FixTop.Position = UDim2.new(0, 0, 1, -5)
    FixTop.BackgroundColor3 = Library.Theme.Header
    FixTop.BorderSizePixel = 0
    FixTop.Parent = TopBar
    
    -- Draggable
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
        TabButton.BackgroundColor3 = Library.Theme.Accent
        TabButton.BackgroundTransparency = 1
        TabButton.Font = Enum.Font.SourceSansSemibold
        TabButton.Text = "    " .. tabName
        TabButton.TextColor3 = Library.Theme.DarkText
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = Sidebar
        
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)
        
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
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
        
        local function SelectTab()
            for _, v in pairs(ContainerHolder:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(Sidebar:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    v.TextColor3 = Library.Theme.DarkText
                end
            end
            
            TabPage.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
            TabButton.TextColor3 = Library.Theme.Text
        end
        
        TabButton.MouseButton1Click:Connect(SelectTab)
        
        if FirstTab then
            SelectTab()
            FirstTab = false
        end
        
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
        
        function TabObject:CreateDropdown(dropOptions)
            dropOptions = dropOptions or {}
            local dropName = dropOptions.Name or "Dropdown"
            local optionsList = dropOptions.Options or {"Option 1", "Option 2"}
            local defaultOption = dropOptions.Default or optionsList[1]
            local callback = dropOptions.Callback
            
            local isOpen = false
            local selected = defaultOption
            
            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, 0, 0, 46)
            DropFrame.BackgroundColor3 = Library.Theme.ElementBg
            DropFrame.BorderSizePixel = 0
            DropFrame.ClipsDescendants = true
            DropFrame.Parent = TabPage
            
            Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 8)
            
            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(0.6, 0, 0, 46)
            Title.Position = UDim2.new(0, 12, 0, 0)
            Title.BackgroundTransparency = 1
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = dropName
            Title.TextColor3 = Library.Theme.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = DropFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0.4, -30, 0, 46)
            ValueLabel.Position = UDim2.new(0.6, 0, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Font = Enum.Font.SourceSans
            ValueLabel.Text = tostring(selected)
            ValueLabel.TextColor3 = Library.Theme.DarkText
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = DropFrame
            
            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 0, 46)
            Arrow.Position = UDim2.new(1, -25, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Font = Enum.Font.SourceSansBold
            Arrow.Text = "+"
            Arrow.TextColor3 = Library.Theme.DarkText
            Arrow.TextSize = 16
            Arrow.Parent = DropFrame
            
            local DropContainer = Instance.new("Frame")
            DropContainer.Size = UDim2.new(1, 0, 0, 0)
            DropContainer.Position = UDim2.new(0, 0, 0, 46)
            DropContainer.BackgroundTransparency = 1
            DropContainer.Parent = DropFrame
            
            local DropLayout = Instance.new("UIListLayout")
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 4)
            DropLayout.Parent = DropContainer
            
            local DropPadding = Instance.new("UIPadding")
            DropPadding.PaddingTop = UDim.new(0, 5)
            DropPadding.PaddingBottom = UDim.new(0, 10)
            DropPadding.PaddingLeft = UDim.new(0, 10)
            DropPadding.PaddingRight = UDim.new(0, 10)
            DropPadding.Parent = DropContainer
            
            local function UpdateSize()
                local contentHeight = DropLayout.AbsoluteContentSize.Y + 15
                if isOpen then
                    TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 46 + contentHeight)}):Play()
                else
                    TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 46)}):Play()
                end
            end
            
            for _, opt in ipairs(optionsList) do
                local OptButton = Instance.new("TextButton")
                OptButton.Size = UDim2.new(1, 0, 0, 30)
                OptButton.BackgroundColor3 = Library.Theme.DropdownItem
                OptButton.BorderSizePixel = 0
                OptButton.Font = Enum.Font.SourceSansSemibold
                OptButton.Text = "  " .. tostring(opt)
                OptButton.TextColor3 = (opt == selected) and Library.Theme.Text or Library.Theme.DarkText
                OptButton.TextSize = 13
                OptButton.TextXAlignment = Enum.TextXAlignment.Left
                OptButton.Parent = DropContainer
                
                Instance.new("UICorner", OptButton).CornerRadius = UDim.new(0, 6)
                
                OptButton.MouseButton1Click:Connect(function()
                    selected = opt
                    ValueLabel.Text = tostring(selected)
                    isOpen = false
                    Arrow.Text = "+"
                    UpdateSize()
                    
                    for _, child in ipairs(DropContainer:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.TextColor3 = Library.Theme.DarkText
                        end
                    end
                    OptButton.TextColor3 = Library.Theme.Text
                    
                    if callback then
                        callback(selected)
                    end
                end)
            end
            
            local ClickBox = Instance.new("TextButton")
            ClickBox.Size = UDim2.new(1, 0, 0, 46)
            ClickBox.BackgroundTransparency = 1
            ClickBox.Text = ""
            ClickBox.Parent = DropFrame
            
            ClickBox.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                Arrow.Text = isOpen and "-" or "+"
                UpdateSize()
            end)
        end
        
        function TabObject:CreateSlider(sliderOptions)
            sliderOptions = sliderOptions or {}
            local sliderName = sliderOptions.Name or "Slider"
            local min = sliderOptions.Min or 0
            local max = sliderOptions.Max or 100
            local default = sliderOptions.Default or min
            local callback = sliderOptions.Callback
            
            local value = default
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 60)
            SliderFrame.BackgroundColor3 = Library.Theme.ElementBg
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabPage
            
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 8)
            
            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -60, 0, 30)
            Title.Position = UDim2.new(0, 12, 0, 5)
            Title.BackgroundTransparency = 1
            Title.Font = Enum.Font.SourceSansBold
            Title.Text = sliderName
            Title.TextColor3 = Library.Theme.Text
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 30)
            ValueLabel.Position = UDim2.new(1, -60, 0, 5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Font = Enum.Font.SourceSansBold
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Library.Theme.DarkText
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = SliderFrame
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -24, 0, 6)
            SliderBar.Position = UDim2.new(0, 12, 0, 42)
            SliderBar.BackgroundColor3 = Library.Theme.InactiveToggle
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Library.Theme.SliderFill
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar
            
            Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(1, 0, 1, 10)
            SliderButton.Position = UDim2.new(0, 0, 0, -5)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderBar
            
            local draggingSlider = false
            
            local function UpdateSlider(input)
                local sizeX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                value = math.floor(min + ((max - min) * sizeX))
                SliderFill.Size = UDim2.new(sizeX, 0, 1, 0)
                ValueLabel.Text = tostring(value)
                
                if callback then
                    callback(value)
                end
            end
            
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    UpdateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSlider(input)
                end
            end)
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
