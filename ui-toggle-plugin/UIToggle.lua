--[[
    ============================================
    Roblox Studio UI Toggle Plugin
    By majinboux
    Inspired by Mincraftmark0's video
    ============================================
    
    Helps you switch between Next Gen UI and Legacy UI
    using the "Reload custom tabs" method!
    
    INSTALLATION:
    1. Copy this file to: %APPDATA%\Roblox\Plugins\
    2. Restart Roblox Studio
    3. Click the "🎨 UI Toggle" button in toolbar
    
    USAGE:
    - Click the toolbar button to see instructions
    - Use "Add Tools" (Ctrl+Shift+X) to find "Reload custom tabs"
    - Customize your ribbon layout!
    
    NEW: One-click checklist to restore classic toolbar!
]]

local plugin = plugin

-- Create toolbar with toggle button
local toolbar = plugin:CreateToolbar("majinboux")
local mainButton = toolbar:CreateButton(
    "🎨 UI Toggle",
    "Switch between Next Gen and Legacy UI layouts",
    "rbxasset://textures/ui/TopBar/coloredToggle.png"
)

-- Add a second button for quick legacy layout
local legacyButton = toolbar:CreateButton(
    "⚡ Classic Layout",
    "See which tools to add for classic toolbar",
    "rbxasset://textures/StudioToolbox/AssetConfig/icon.png"
)

mainButton.ClickableWhenViewportHidden = true
legacyButton.ClickableWhenViewportHidden = true

-- Classic toolbar tools list (from the video's final result)
local CLASSIC_TOOLS = {
    {name = "Undo", search = "Undo", desc = "Undo last action"},
    {name = "Redo", search = "Redo", desc = "Redo last action"},
    {name = "Delete", search = "Delete", desc = "Delete selected"},
    {name = "Activity History", search = "Activity", desc = "View activity"},
    {name = "Block", search = "Block", desc = "Insert block part"},
    {name = "Insert...", search = "Insert", desc = "Insert objects"},
    {name = "Move", search = "Move", desc = "Move tool"},
    {name = "Scale", search = "Scale", desc = "Scale tool"},
    {name = "Rotate", search = "Rotate", desc = "Rotate tool"},
    {name = "Anchor", search = "Anchor", desc = "Toggle anchor"},
    {name = "Play", search = "Play", desc = "Playtest"},
    {name = "Toggle...", search = "Toggle", desc = "Toggle options"},
    {name = "Stop", search = "Stop", desc = "Stop playtest"},
    {name = "Device...", search = "Device", desc = "Device emulator"},
    {name = "Character", search = "Character", desc = "Character tools"},
    {name = "Animation", search = "Animation", desc = "Animation editor"},
    {name = "Game...", search = "Game", desc = "Game settings"},
    {name = "Spawn", search = "Spawn", desc = "Spawn location"},
}

-- Widget setup
local widgetInfo = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Float,
    false,
    false,
    420,
    380,
    380,
    320
)

local widget = plugin:CreateDockWidgetPluginGui("UIToggleHelp", widgetInfo)
widget.Title = "🎨 Switch UI Style - by majinboux"

-- Build the UI
local function buildUI()
    -- Clear old UI
    for _, child in ipairs(widget:GetChildren()) do
        child:Destroy()
    end
    
    -- Main container
    local main = Instance.new("Frame")
    main.Size = UDim2.new(1, 0, 1, 0)
    main.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
    main.BorderSizePixel = 0
    main.Parent = widget
    
    -- Padding
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 15)
    padding.PaddingBottom = UDim.new(0, 15)
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.Parent = main
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = "🎮 How to Get Old UI Back"
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = main
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 38)
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    subtitle.Text = "Time to make things right! 💪"
    subtitle.TextSize = 12
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = main
    
    -- Divider
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 0, 65)
    divider.BackgroundColor3 = Color3.fromRGB(70, 70, 72)
    divider.BorderSizePixel = 0
    divider.Parent = main
    
    -- Steps container
    local stepsFrame = Instance.new("Frame")
    stepsFrame.Size = UDim2.new(1, 0, 0, 200)
    stepsFrame.Position = UDim2.new(0, 0, 0, 80)
    stepsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    stepsFrame.BorderSizePixel = 0
    stepsFrame.Parent = main
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 10)
    corner1.Parent = stepsFrame
    
    -- Steps text
    local steps = Instance.new("TextLabel")
    steps.Size = UDim2.new(1, -20, 1, -20)
    steps.Position = UDim2.new(0, 10, 0, 10)
    steps.BackgroundTransparency = 1
    steps.TextColor3 = Color3.fromRGB(230, 230, 230)
    steps.Text = [[📋 STEPS TO TOGGLE UI:

Step 1️⃣  Open "Add Tools"
   • Press Ctrl + Shift + X
   • OR right-click on the ribbon toolbar
   • OR go to View menu → Add Tools

Step 2️⃣  Search for "Reload custom tabs"
   • Type it in the search box
   • Click on it when it appears

Step 3️⃣  Customize your ribbon!
   • Add/remove tools as you like
   • Arrange them how you want
   • Your layout is saved automatically!]]
    steps.TextSize = 12
    steps.Font = Enum.Font.Gotham
    steps.TextXAlignment = Enum.TextXAlignment.Left
    steps.TextYAlignment = Enum.TextYAlignment.Top
    steps.TextWrapped = true
    steps.Parent = stepsFrame
    
    -- Tip box
    local tipFrame = Instance.new("Frame")
    tipFrame.Size = UDim2.new(1, 0, 0, 50)
    tipFrame.Position = UDim2.new(0, 0, 0, 290)
    tipFrame.BackgroundColor3 = Color3.fromRGB(60, 80, 60)
    tipFrame.BorderSizePixel = 0
    tipFrame.Parent = main
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 8)
    corner2.Parent = tipFrame
    
    local tipText = Instance.new("TextLabel")
    tipText.Size = UDim2.new(1, -20, 1, 0)
    tipText.Position = UDim2.new(0, 10, 0, 0)
    tipText.BackgroundTransparency = 1
    tipText.TextColor3 = Color3.fromRGB(180, 255, 180)
    tipText.Text = "💡 TIP: You can also add Undo/Redo buttons back using the Add Tools menu!"
    tipText.TextSize = 11
    tipText.Font = Enum.Font.Gotham
    tipText.TextWrapped = true
    tipText.Parent = tipFrame
    
    -- Credit
    local credit = Instance.new("TextLabel")
    credit.Size = UDim2.new(1, 0, 0, 20)
    credit.Position = UDim2.new(0, 0, 1, -35)
    credit.BackgroundTransparency = 1
    credit.TextColor3 = Color3.fromRGB(100, 100, 100)
    credit.Text = "Made by majinboux | Inspired by Mincraftmark0"
    credit.TextSize = 10
    credit.Font = Enum.Font.Gotham
    credit.Parent = main
end

-- Toggle widget on button click
mainButton.Click:Connect(function()
    widget.Enabled = not widget.Enabled
    if widget.Enabled then
        buildUI()
    end
end)

-- ============================================
-- CLASSIC LAYOUT CHECKLIST WIDGET
-- ============================================

local checklistWidgetInfo = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Float,
    false,
    false,
    450,
    550,
    400,
    450
)

local checklistWidget = plugin:CreateDockWidgetPluginGui("ClassicLayoutChecklist", checklistWidgetInfo)
checklistWidget.Title = "⚡ Classic Toolbar Checklist"

local function buildChecklistUI()
    -- Clear old UI
    for _, child in ipairs(checklistWidget:GetChildren()) do
        child:Destroy()
    end
    
    -- Main container
    local main = Instance.new("Frame")
    main.Size = UDim2.new(1, 0, 1, 0)
    main.BackgroundColor3 = Color3.fromRGB(35, 35, 38)
    main.BorderSizePixel = 0
    main.Parent = checklistWidget
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 80)
    header.BackgroundColor3 = Color3.fromRGB(50, 70, 90)
    header.BorderSizePixel = 0
    header.Parent = main
    
    local headerTitle = Instance.new("TextLabel")
    headerTitle.Size = UDim2.new(1, -20, 0, 30)
    headerTitle.Position = UDim2.new(0, 10, 0, 10)
    headerTitle.BackgroundTransparency = 1
    headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    headerTitle.Text = "⚡ Classic Toolbar Setup"
    headerTitle.TextSize = 18
    headerTitle.Font = Enum.Font.GothamBold
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.Parent = header
    
    local headerDesc = Instance.new("TextLabel")
    headerDesc.Size = UDim2.new(1, -20, 0, 35)
    headerDesc.Position = UDim2.new(0, 10, 0, 40)
    headerDesc.BackgroundTransparency = 1
    headerDesc.TextColor3 = Color3.fromRGB(200, 220, 255)
    headerDesc.Text = "Add these tools via 'Add Tools' (Ctrl+Shift+X)\nSearch for each name and click to add!"
    headerDesc.TextSize = 11
    headerDesc.Font = Enum.Font.Gotham
    headerDesc.TextXAlignment = Enum.TextXAlignment.Left
    headerDesc.TextWrapped = true
    headerDesc.Parent = header
    
    -- Scrolling frame for checklist
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -150)
    scrollFrame.Position = UDim2.new(0, 10, 0, 90)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 48)
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #CLASSIC_TOOLS * 45 + 20)
    scrollFrame.Parent = main
    
    local scrollCorner = Instance.new("UICorner")
    scrollCorner.CornerRadius = UDim.new(0, 8)
    scrollCorner.Parent = scrollFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scrollFrame
    
    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop = UDim.new(0, 10)
    listPadding.PaddingLeft = UDim.new(0, 10)
    listPadding.PaddingRight = UDim.new(0, 10)
    listPadding.Parent = scrollFrame
    
    -- Create checklist items
    for i, tool in ipairs(CLASSIC_TOOLS) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Size = UDim2.new(1, -20, 0, 40)
        itemFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
        itemFrame.BorderSizePixel = 0
        itemFrame.LayoutOrder = i
        itemFrame.Parent = scrollFrame
        
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 6)
        itemCorner.Parent = itemFrame
        
        -- Number badge
        local numBadge = Instance.new("TextLabel")
        numBadge.Size = UDim2.new(0, 25, 0, 25)
        numBadge.Position = UDim2.new(0, 8, 0.5, -12)
        numBadge.BackgroundColor3 = Color3.fromRGB(80, 120, 180)
        numBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
        numBadge.Text = tostring(i)
        numBadge.TextSize = 12
        numBadge.Font = Enum.Font.GothamBold
        numBadge.Parent = itemFrame
        
        local numCorner = Instance.new("UICorner")
        numCorner.CornerRadius = UDim.new(0, 4)
        numCorner.Parent = numBadge
        
        -- Tool name
        local toolName = Instance.new("TextLabel")
        toolName.Size = UDim2.new(0.5, -50, 0, 20)
        toolName.Position = UDim2.new(0, 45, 0, 5)
        toolName.BackgroundTransparency = 1
        toolName.TextColor3 = Color3.fromRGB(255, 255, 255)
        toolName.Text = tool.name
        toolName.TextSize = 13
        toolName.Font = Enum.Font.GothamBold
        toolName.TextXAlignment = Enum.TextXAlignment.Left
        toolName.Parent = itemFrame
        
        -- Search hint
        local searchHint = Instance.new("TextLabel")
        searchHint.Size = UDim2.new(0.5, -50, 0, 15)
        searchHint.Position = UDim2.new(0, 45, 0, 23)
        searchHint.BackgroundTransparency = 1
        searchHint.TextColor3 = Color3.fromRGB(150, 150, 150)
        searchHint.Text = "Search: \"" .. tool.search .. "\""
        searchHint.TextSize = 10
        searchHint.Font = Enum.Font.Gotham
        searchHint.TextXAlignment = Enum.TextXAlignment.Left
        searchHint.Parent = itemFrame
        
        -- Checkmark (visual only - users check mentally)
        local checkBox = Instance.new("TextButton")
        checkBox.Size = UDim2.new(0, 30, 0, 30)
        checkBox.Position = UDim2.new(1, -40, 0.5, -15)
        checkBox.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
        checkBox.TextColor3 = Color3.fromRGB(100, 255, 100)
        checkBox.Text = ""
        checkBox.TextSize = 18
        checkBox.Font = Enum.Font.GothamBold
        checkBox.AutoButtonColor = true
        checkBox.Parent = itemFrame
        
        local checkCorner = Instance.new("UICorner")
        checkCorner.CornerRadius = UDim.new(0, 4)
        checkCorner.Parent = checkBox
        
        -- Toggle checkmark on click
        checkBox.MouseButton1Click:Connect(function()
            if checkBox.Text == "" then
                checkBox.Text = "✓"
                checkBox.BackgroundColor3 = Color3.fromRGB(50, 120, 80)
                itemFrame.BackgroundColor3 = Color3.fromRGB(45, 65, 55)
            else
                checkBox.Text = ""
                checkBox.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
                itemFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
            end
        end)
    end
    
    -- Bottom instruction
    local bottomFrame = Instance.new("Frame")
    bottomFrame.Size = UDim2.new(1, -20, 0, 50)
    bottomFrame.Position = UDim2.new(0, 10, 1, -60)
    bottomFrame.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
    bottomFrame.BorderSizePixel = 0
    bottomFrame.Parent = main
    
    local bottomCorner = Instance.new("UICorner")
    bottomCorner.CornerRadius = UDim.new(0, 8)
    bottomCorner.Parent = bottomFrame
    
    local bottomText = Instance.new("TextLabel")
    bottomText.Size = UDim2.new(1, -20, 1, 0)
    bottomText.Position = UDim2.new(0, 10, 0, 0)
    bottomText.BackgroundTransparency = 1
    bottomText.TextColor3 = Color3.fromRGB(220, 200, 255)
    bottomText.Text = "🎯 After adding tools, click 'Reload custom tabs' to apply!\nYour layout saves automatically."
    bottomText.TextSize = 11
    bottomText.Font = Enum.Font.Gotham
    bottomText.TextWrapped = true
    bottomText.Parent = bottomFrame
end

-- Legacy button opens checklist
legacyButton.Click:Connect(function()
    checklistWidget.Enabled = not checklistWidget.Enabled
    if checklistWidget.Enabled then
        buildChecklistUI()
    end
end)

-- Build initial UI
buildUI()

-- Show welcome message
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🎨 UI Toggle Plugin by majinboux")
print("   • Click '🎨 UI Toggle' for instructions")
print("   • Click '⚡ Classic Layout' for tool checklist")
print("   Inspired by Mincraftmark0's video")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")