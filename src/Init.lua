local Library = {}
Library.Theme = {
    MainColor = Color3.fromRGB(30, 30, 30),
    AccentColor = Color3.fromRGB(0, 120, 255),
    TextColor = Color3.fromRGB(255, 255, 255)
}

function Library:CreateWindow(options)
    options = options or {}
    local WindowName = options.Name or "kqUi Library"
    
    print("Window created: " .. WindowName)
    
    local WindowObject = {}
    
    function WindowObject:CreateTab(tabName)
        print("Tab created: " .. tabName)
        local TabObject = {}
        
        function TabObject:CreateButton(buttonOptions)
            buttonOptions = buttonOptions or {}
            print("Button created: " .. (buttonOptions.Name or "Button"))
            if buttonOptions.Callback then
                -- จำลองการเรียกใช้งาน Callback
                -- buttonOptions.Callback()
            end
        end
        
        return TabObject
    end
    
    return WindowObject
end

return Library
