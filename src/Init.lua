local Library = {}
Library.Theme = {
    MainColor = Color3.fromRGB(30, 30, 30),
    AccentColor = Color3.fromRGB(0, 120, 255),
    TextColor = Color3.fromRGB(255, 255, 255)
}

function Library:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "kqUi Library"
    
    -- สร้าง ScreenGui หลัก
    local CoreGui = game:GetService("CoreGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "kqUi_Screen"
    ScreenGui.Parent = CoreGui
    
    -- สร้างหน้าต่างหลัก (Main Frame)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Library.Theme.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- ทำมุมโค้งให้สวยงาม
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Title Bar (แถบหัวข้อ)
    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.TextColor3 = Library.Theme.TextColor
    TitleBar.TextSize = 16
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.Text = "  " .. WindowName
    TitleBar.TextXAlignment = Enum.TextXAlignment.Left
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar
    
    local WindowObject = {}
    
    function WindowObject:CreateTab(tabName)
        local TabObject = {}
        
        function TabObject:CreateButton(buttonOptions)
            buttonOptions = buttonOptions or {}
            print("Button created: " .. (buttonOptions.Name or "Button"))
            
            -- ปุ่มกดจำลองภายในหน้าต่าง
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 0, 35)
            Button.Position = UDim2.new(0, 10, 0, 60)
            Button.BackgroundColor3 = Library.Theme.AccentColor
            Button.TextColor3 = Library.Theme.TextColor
            Button.TextSize = 14
            Button.Font = Enum.Font.SourceSansBold
            Button.Text = buttonOptions.Name or "Button"
            Button.Parent = MainFrame
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = Button
            
            Button.MouseButton1Click:Connect(function()
                if buttonOptions.Callback then
                    buttonOptions.Callback()
                end
            end)
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
