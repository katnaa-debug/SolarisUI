local Library = {}
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local TxtS = game:GetService("TextService")
local CG = game:GetService("CoreGui")
local Plrs = game:GetService("Players")
local LP = Plrs.LocalPlayer
local Mouse = LP:GetMouse()
local Stats = game:GetService("Stats")

local CurrentFPS = 60
local Frames = 0
local LastTick = os.clock()

RS.Heartbeat:Connect(function()
    Frames = Frames + 1
    local Now = os.clock()
    if Now - LastTick >= 1 then
        CurrentFPS = Frames
        Frames = 0
        LastTick = Now
    end
end)

local NetworkStats = Stats:FindFirstChild("Network")
local ServerStats = NetworkStats and NetworkStats:FindFirstChild("ServerStatsItem")
local DataPing = ServerStats and ServerStats:FindFirstChild("Data Ping")

local KeyMap = {
    Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9",
    KeypadZero = "0", KeypadOne = "1", KeypadTwo = "2", KeypadThree = "3", KeypadFour = "4", KeypadFive = "5", KeypadSix = "6", KeypadSeven = "7", KeypadEight = "8", KeypadNine = "9",
    LeftShift = "LShift", RightShift = "RShift", LeftControl = "LCtrl", RightControl = "RCtrl", LeftAlt = "LAlt", RightAlt = "RAlt",
    LeftBracket = "[", RightBracket = "]", Semicolon = ";", Quote = "'", BackSlash = "\\", Comma = ",", Period = ".", Slash = "/", Minus = "-", Equals = "=",
    Space = "Space", Tab = "Tab", Return = "Enter", Escape = "Esc", Backspace = "Bksp", Delete = "Del", Insert = "Ins",
    Home = "Home", End = "End", PageUp = "PgUp", PageDown = "PgDn", Up = "Up", Down = "Down", Left = "Left", Right = "Right",
    CapsLock = "Caps", NumLock = "Num"
}

Library.Flags = {}
Library.Items = {}
Library.TextObjects = {} 
Library.GradientObjects = {} 
Library.CornerObjects = {}
Library.ThemeObjects = {     
    Main = {},
    Second = {},
    Accent = {},
    ElementAccent = {},
    Text = {},
    TextDark = {},
    Toggles = {},
    TabLabels = {},
    Keybinds = {}
}
Library.WatermarkIslands = {}

Library.ThemeFolder = "SolarisUI-Themes"

local AvailableFonts = {
    "Gotham", "GothamBold", "SourceSans", "SourceSansBold", 
    "Oswald", "Roboto", "RobotoMono", "Sarpanch", "Code", "AmaticSC",
    "FredokaOne", "Jura", "Arcade", "SciFi", "Ubuntu", "Arial",
    "Cartoon", "Highway", "Bodoni", "Garamond", "Nunito"
}

Library.GlobalFont = Enum.Font.Gotham
Library.GlobalFontBold = Enum.Font.GothamBold
Library.GlobalCornerValue = 10

local Themes = {
    Default = {
        Main = Color3.fromRGB(25, 25, 30),
        Second = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(255, 255, 255),
        ElementAccent = Color3.fromRGB(0, 160, 255),
        GradientStart = Color3.fromRGB(255, 255, 255),
        GradientEnd = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(170, 170, 170),
        Error = Color3.fromRGB(255, 60, 60),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Blood = {
        Main = Color3.fromRGB(20, 15, 15),
        Second = Color3.fromRGB(30, 20, 20),
        Accent = Color3.fromRGB(220, 40, 40),
        ElementAccent = Color3.fromRGB(220, 40, 40),
        GradientStart = Color3.fromRGB(255, 0, 0),
        GradientEnd = Color3.fromRGB(150, 0, 0),
        Text = Color3.fromRGB(255, 240, 240),
        TextDark = Color3.fromRGB(170, 120, 120),
        Error = Color3.fromRGB(255, 0, 0),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Purple = {
        Main = Color3.fromRGB(20, 15, 25),
        Second = Color3.fromRGB(30, 25, 40),
        Accent = Color3.fromRGB(160, 80, 255),
        ElementAccent = Color3.fromRGB(160, 80, 255),
        GradientStart = Color3.fromRGB(140, 0, 255),
        GradientEnd = Color3.fromRGB(255, 0, 255),
        Text = Color3.fromRGB(240, 230, 255),
        TextDark = Color3.fromRGB(160, 140, 190),
        Error = Color3.fromRGB(255, 0, 100),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Abyss = {
        Main = Color3.fromRGB(20, 15, 25),
        Second = Color3.fromRGB(30, 25, 40),
        Accent = Color3.fromRGB(100, 0, 255),
        ElementAccent = Color3.fromRGB(100, 0, 255),
        GradientStart = Color3.fromRGB(80, 0, 200),
        GradientEnd = Color3.fromRGB(120, 50, 255),
        Text = Color3.fromRGB(240, 230, 255),
        TextDark = Color3.fromRGB(160, 140, 190),
        Error = Color3.fromRGB(255, 0, 100),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Ocean = {
        Main = Color3.fromRGB(15, 25, 35),
        Second = Color3.fromRGB(25, 35, 45),
        Accent = Color3.fromRGB(0, 255, 200),
        ElementAccent = Color3.fromRGB(0, 255, 200),
        GradientStart = Color3.fromRGB(0, 200, 255),
        GradientEnd = Color3.fromRGB(0, 255, 150),
        Text = Color3.fromRGB(220, 255, 255),
        TextDark = Color3.fromRGB(120, 170, 170),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Toxic = {
        Main = Color3.fromRGB(10, 20, 10),
        Second = Color3.fromRGB(20, 30, 20),
        Accent = Color3.fromRGB(50, 255, 100),
        ElementAccent = Color3.fromRGB(50, 255, 100),
        GradientStart = Color3.fromRGB(0, 255, 0),
        GradientEnd = Color3.fromRGB(150, 255, 150),
        Text = Color3.fromRGB(220, 255, 220),
        TextDark = Color3.fromRGB(120, 170, 170),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Sunrise = {
        Main = Color3.fromRGB(30, 20, 15),
        Second = Color3.fromRGB(40, 30, 25),
        Accent = Color3.fromRGB(255, 150, 0),
        ElementAccent = Color3.fromRGB(255, 150, 0),
        GradientStart = Color3.fromRGB(255, 100, 0),
        GradientEnd = Color3.fromRGB(255, 200, 0),
        Text = Color3.fromRGB(255, 240, 230),
        TextDark = Color3.fromRGB(170, 140, 120),
        Error = Color3.fromRGB(255, 0, 0),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Vaporwave = {
        Main = Color3.fromRGB(30, 20, 35),
        Second = Color3.fromRGB(45, 30, 50),
        Accent = Color3.fromRGB(255, 100, 200),
        ElementAccent = Color3.fromRGB(255, 100, 200),
        GradientStart = Color3.fromRGB(255, 0, 255),
        GradientEnd = Color3.fromRGB(0, 255, 255),
        Text = Color3.fromRGB(255, 230, 255),
        TextDark = Color3.fromRGB(170, 120, 170),
        Error = Color3.fromRGB(255, 50, 100),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Gold = {
        Main = Color3.fromRGB(25, 20, 10),
        Second = Color3.fromRGB(35, 30, 20),
        Accent = Color3.fromRGB(255, 200, 50),
        ElementAccent = Color3.fromRGB(255, 200, 50),
        GradientStart = Color3.fromRGB(255, 215, 0),
        GradientEnd = Color3.fromRGB(255, 150, 0),
        Text = Color3.fromRGB(255, 250, 220),
        TextDark = Color3.fromRGB(170, 160, 120),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Orange = {
        Main = Color3.fromRGB(20, 20, 20),
        Second = Color3.fromRGB(35, 30, 25),
        Accent = Color3.fromRGB(218, 165, 32),
        ElementAccent = Color3.fromRGB(218, 165, 32),
        GradientStart = Color3.fromRGB(255, 215, 0),
        GradientEnd = Color3.fromRGB(184, 134, 11),
        Text = Color3.fromRGB(255, 250, 220),
        TextDark = Color3.fromRGB(170, 160, 120),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Mint = {
        Main = Color3.fromRGB(20, 25, 25),
        Second = Color3.fromRGB(30, 35, 35),
        Accent = Color3.fromRGB(100, 255, 180),
        ElementAccent = Color3.fromRGB(100, 255, 180),
        GradientStart = Color3.fromRGB(50, 200, 120),
        GradientEnd = Color3.fromRGB(150, 255, 200),
        Text = Color3.fromRGB(230, 255, 240),
        TextDark = Color3.fromRGB(120, 160, 140),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Night = {
        Main = Color3.fromRGB(10, 10, 20),
        Second = Color3.fromRGB(20, 20, 35),
        Accent = Color3.fromRGB(80, 120, 255),
        ElementAccent = Color3.fromRGB(80, 120, 255),
        GradientStart = Color3.fromRGB(50, 50, 255),
        GradientEnd = Color3.fromRGB(150, 150, 255),
        Text = Color3.fromRGB(230, 230, 255),
        TextDark = Color3.fromRGB(100, 120, 160),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    },
    Void = {
        Main = Color3.fromRGB(12, 12, 12),
        Second = Color3.fromRGB(22, 22, 22),
        Accent = Color3.fromRGB(220, 220, 220),
        ElementAccent = Color3.fromRGB(220, 220, 220),
        GradientStart = Color3.fromRGB(150, 150, 150),
        GradientEnd = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(240, 240, 240),
        TextDark = Color3.fromRGB(120, 120, 120),
        Error = Color3.fromRGB(255, 100, 100),
        Transparency = 0.25,
        HudTransparency = 0.5,
        ImageTransparency = 0,
        Font = "Gotham",
        Background = ""
    }
}

local function GetGradientSeq(theme)
    local startC = theme.GradientStart or theme.Accent
    local endC = theme.GradientEnd or theme.Accent
    return ColorSequence.new{
        ColorSequenceKeypoint.new(0, startC), 
        ColorSequenceKeypoint.new(1, endC)
    }
end

for _, t in pairs(Themes) do
    if not t.Gradient then
        t.Gradient = GetGradientSeq(t)
    end
    if not t.ElementAccent then
        t.ElementAccent = t.Accent
    end
    if not t.Font then
        t.Font = "Gotham"
    end
    if not t.HudTransparency then
        t.HudTransparency = 0.5
    end
end

local function GetAssetId(id)
    if not id or id == "" then
        return ""
    end
    local str = tostring(id)
    if str:find("rbxasset://") or str:find("rbxthumb://") or str:find("rbxassetid://") then
        return str
    end
    local num = str:match("%d+")
    if num then
        return "rbxassetid://" .. num
    end
    return ""
end

local function SetImageAsync(instance, property, idStr)
    local parsedId = GetAssetId(idStr)
    if parsedId == "" then
        instance[property] = ""
        return
    end
    
    instance[property] = parsedId
    
    if parsedId:find("rbxassetid://") then
        task.spawn(function()
            local success, result = pcall(function()
                return game:GetObjects(parsedId)[1]
            end)
            if success and result and result:IsA("Decal") then
                if instance.Parent then
                    instance[property] = result.Texture
                end
            end
        end)
    end
end

local function GetTheme(cfg)
    if type(cfg) == "table" then 
        local mapped = {}
        mapped.Main = cfg["Main color"] or cfg.Main
        mapped.Second = cfg["SecondColor"] or cfg.Second
        mapped.Accent = cfg["AccentColor"] or cfg.Accent
        mapped.ElementAccent = cfg["ElementColor"] or cfg.ElementAccent
        mapped.Text = cfg["TextColor"] or cfg.Text
        mapped.GradientStart = cfg["GradientStart"] or mapped.Accent
        mapped.GradientEnd = cfg["GradientEnd"] or mapped.Accent
        
        if cfg["BGTransparency"] then
            mapped.Transparency = tonumber(cfg["BGTransparency"]) / 100 
        else
            mapped.Transparency = cfg.Transparency
        end
        
        if cfg["HudTransparency"] then
            mapped.HudTransparency = tonumber(cfg["HudTransparency"]) / 100
        elseif cfg.HudTransparency then
            mapped.HudTransparency = cfg.HudTransparency
        else
            mapped.HudTransparency = 0.5
        end
        
        if cfg["ImageTransparency"] then
            mapped.ImageTransparency = tonumber(cfg["ImageTransparency"]) / 100
        else
            mapped.ImageTransparency = cfg.ImageTransparency
        end

        if cfg["BackgroundID"] then
            mapped.Background = GetAssetId(cfg["BackgroundID"])
        else 
            mapped.Background = GetAssetId(cfg.Background) 
        end

        if cfg["Font"] then
            mapped.Font = cfg["Font"]
        end

        if cfg["CornerRadius"] ~= nil then
            mapped.CornerRadius = cfg["CornerRadius"]
        end

        if not mapped.Main then mapped.Main = Themes.Default.Main end
        if not mapped.Second then mapped.Second = Themes.Default.Second end
        if not mapped.Accent then mapped.Accent = Themes.Default.Accent end
        if not mapped.ElementAccent then mapped.ElementAccent = mapped.Accent end
        if not mapped.Text then mapped.Text = Themes.Default.Text end
        if not mapped.TextDark then mapped.TextDark = Color3.fromRGB(170, 170, 170) end
        if not mapped.Error then mapped.Error = Color3.fromRGB(255, 60, 60) end
        if not mapped.GradientStart then mapped.GradientStart = mapped.Accent end
        if not mapped.GradientEnd then mapped.GradientEnd = mapped.Accent end
        
        mapped.Gradient = GetGradientSeq(mapped)
        return mapped
    end

    if isfile(Library.ThemeFolder .. "/" .. tostring(cfg) .. ".json") then
        local content = readfile(Library.ThemeFolder .. "/" .. tostring(cfg) .. ".json")
        local parsed = HS:JSONDecode(content)
        local restored = {}
        for k, v in pairs(parsed) do
            if type(v) == "table" and v.R then
                restored[k] = Color3.new(v.R, v.G, v.B)
            else
                restored[k] = v
            end
        end
        if restored.GradientStart and restored.GradientEnd then
            restored.Gradient = ColorSequence.new{
                ColorSequenceKeypoint.new(0, restored.GradientStart),
                ColorSequenceKeypoint.new(1, restored.GradientEnd)
            }
        else
            restored.GradientStart = restored.Accent
            restored.GradientEnd = restored.Accent
            restored.Gradient = ColorSequence.new{
                ColorSequenceKeypoint.new(0, restored.Accent),
                ColorSequenceKeypoint.new(1, restored.Accent)
            }
        end
        if not restored.ElementAccent then restored.ElementAccent = restored.Accent end
        if not restored.Font then restored.Font = "Gotham" end
        if not restored.TextDark then restored.TextDark = Color3.fromRGB(170, 170, 170) end
        if not restored.Error then restored.Error = Color3.fromRGB(255, 60, 60) end
        if restored.CornerRadius == nil then restored.CornerRadius = 10 end
        if restored.HudTransparency == nil then restored.HudTransparency = 0.5 end
        return restored
    end
    return Themes[cfg] or Themes.Default
end

local function Create(class, properties)
    local tag = properties.ThemeTag
    properties.ThemeTag = nil
    local instance = Instance.new(class)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    if class == "TextLabel" or class == "TextButton" or class == "TextBox" then
        table.insert(Library.TextObjects, instance)
        if not properties.Font then
            instance.Font = Library.GlobalFont
        end
    end
    if tag and Library.ThemeObjects[tag] then
        table.insert(Library.ThemeObjects[tag], instance)
    end
    return instance
end

local function UpdateFonts(FontName)
    local NewFont = Enum.Font[FontName] or Enum.Font.Gotham
    Library.GlobalFont = NewFont
    local BoldName = FontName .. "Bold"
    if pcall(function() return Enum.Font[BoldName] end) then
        Library.GlobalFontBold = Enum.Font[BoldName]
    else
        Library.GlobalFontBold = NewFont
    end

    for _, obj in pairs(Library.TextObjects) do
        if obj and obj.Parent then
            local s = tostring(obj.Font)
            if s:find("Bold") then
                obj.Font = Library.GlobalFontBold
            else
                obj.Font = Library.GlobalFont
            end
        end
    end
end

local function UpdateThemeObjects()
    for i = #Library.ThemeObjects.Main, 1, -1 do
        local obj = Library.ThemeObjects.Main[i]
        if obj and obj.Parent then
            obj.BackgroundColor3 = Themes.Default.Main
        else
            table.remove(Library.ThemeObjects.Main, i)
        end
    end
    for i = #Library.ThemeObjects.Second, 1, -1 do
        local obj = Library.ThemeObjects.Second[i]
        if obj and obj.Parent then
            obj.BackgroundColor3 = Themes.Default.Second
        else
            table.remove(Library.ThemeObjects.Second, i)
        end
    end
    for i = #Library.ThemeObjects.Accent, 1, -1 do
        local obj = Library.ThemeObjects.Accent[i]
        if obj and obj.Parent then
            if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                obj.ImageColor3 = Themes.Default.Accent
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.Accent
            else
                obj.BackgroundColor3 = Themes.Default.Accent
            end
        else
            table.remove(Library.ThemeObjects.Accent, i)
        end
    end
    for i = #Library.ThemeObjects.ElementAccent, 1, -1 do
        local obj = Library.ThemeObjects.ElementAccent[i]
        if obj and obj.Parent then
            if obj:IsA("ImageLabel") then
                obj.ImageColor3 = Themes.Default.ElementAccent
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.ElementAccent
            else
                obj.BackgroundColor3 = Themes.Default.ElementAccent
            end
        else
            table.remove(Library.ThemeObjects.ElementAccent, i)
        end
    end
    for i = #Library.ThemeObjects.Text, 1, -1 do
        local obj = Library.ThemeObjects.Text[i]
        if obj and obj.Parent then 
            if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
                obj.TextColor3 = Themes.Default.Text 
            elseif obj:IsA("Frame") then
                obj.BackgroundColor3 = Themes.Default.Text
            end
        else
            table.remove(Library.ThemeObjects.Text, i)
        end
    end
    for i = #Library.ThemeObjects.TextDark, 1, -1 do
        local obj = Library.ThemeObjects.TextDark[i]
        if obj and obj.Parent then 
            if obj:IsA("ImageLabel") then
                obj.ImageColor3 = Themes.Default.TextDark
            elseif obj:IsA("Frame") then
                obj.BackgroundColor3 = Themes.Default.TextDark
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.TextDark
            else
                obj.TextColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.TextDark, i)
        end
    end
    for i = #Library.ThemeObjects.Toggles, 1, -1 do
        local t = Library.ThemeObjects.Toggles[i]
        if t.Box and t.Box.Parent and t.Stroke and t.Stroke.Parent and t.Square and t.Square.Parent then
            if t.State() then
                t.Stroke.Color = Themes.Default.ElementAccent
                t.Stroke.Transparency = 0
                t.Square.BackgroundColor3 = Themes.Default.ElementAccent
            else
                t.Stroke.Color = Themes.Default.TextDark
                t.Stroke.Transparency = 0.8
                t.Square.BackgroundColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.Toggles, i)
        end
    end
    for i = #Library.ThemeObjects.TabLabels, 1, -1 do
        local tab = Library.ThemeObjects.TabLabels[i]
        if tab.Label and tab.Label.Parent then
            if tab.Btn.BackgroundTransparency < 0.8 then 
                tab.Label.TextColor3 = Themes.Default.Text 
                if tab.Icon then
                    tab.Icon.ImageColor3 = Themes.Default.ElementAccent
                end
            else 
                tab.Label.TextColor3 = Themes.Default.TextDark 
                if tab.Icon then
                    tab.Icon.ImageColor3 = Themes.Default.TextDark
                end
            end
        else
            table.remove(Library.ThemeObjects.TabLabels, i)
        end
    end
    for i = #Library.ThemeObjects.Keybinds, 1, -1 do
        local btn = Library.ThemeObjects.Keybinds[i]
        if btn and btn.Parent then
            if btn.Text == "..." then
                btn.TextColor3 = Themes.Default.Accent
            else
                btn.TextColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.Keybinds, i)
        end
    end
end

local function UpdateGradients(newGradient)
    for _, grad in pairs(Library.GradientObjects) do
        if grad and grad.Parent then
            grad.Color = newGradient
        end
    end
end

local function UpdateCorners(val)
    Library.GlobalCornerValue = val
    for i = #Library.CornerObjects, 1, -1 do
        local obj = Library.CornerObjects[i]
        if obj.Corner and obj.Corner.Parent then
            obj.Corner.CornerRadius = UDim.new(0, math.floor(obj.BaseRadius * (val / 10)))
        else
            table.remove(Library.CornerObjects, i)
        end
    end
end

local function AddCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, math.floor(radius * (Library.GlobalCornerValue / 10)))
    corner.Parent = instance
    table.insert(Library.CornerObjects, {Corner = corner, BaseRadius = radius})
    return corner
end

local function CreateDropShadow(parent, blurRadius, opacity)
    local Shadow = Create("ImageLabel", {
        Parent = parent,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, blurRadius * 2, 1, blurRadius * 2),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554836806", 
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = opacity or 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(120, 120, 136, 136),
        ZIndex = (parent.ZIndex or 1) - 1
    })
    return Shadow
end

local function AddStroke(instance, theme)
    local stroke = Create("UIStroke", {
        Color = Color3.new(1, 1, 1),
        Thickness = 1.2,
        Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = instance
    })
    local gradient = Create("UIGradient", {
        Color = theme.Gradient,
        Rotation = 45,
        Parent = stroke
    })
    table.insert(Library.GradientObjects, gradient)
    return stroke
end

local function CreateRipple(btn, color)
    btn.ClipsDescendants = true
    btn.MouseButton1Click:Connect(function()
        local ripple = Create("ImageLabel", {
            Name = "Ripple",
            Parent = btn,
            Image = "rbxassetid://4743389506",
            ImageColor3 = color,
            BackgroundTransparency = 1,
            ImageTransparency = 0.5,
            Position = UDim2.new(0, Mouse.X - btn.AbsolutePosition.X, 0, Mouse.Y - btn.AbsolutePosition.Y),
            Size = UDim2.new(0, 0, 0, 0),
            ZIndex = 20,
            AnchorPoint = Vector2.new(0.5, 0.5)
        })
        local tween = TS:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 500), ImageTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end)
end

local function MakeDraggable(topbar, frame)
    local dragging, dragInput, dragStart, startPos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end 
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TS:Create(frame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
end

local function MakeResizable(handle, frame)
    local dragging, dragStart, startSize
    local MinSize = Vector2.new(500, 350)
    local MaxSize = Vector2.new(1000, 800)
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startSize = frame.AbsoluteSize
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newX = math.clamp(startSize.X + delta.X, MinSize.X, MaxSize.X)
            local newY = math.clamp(startSize.Y + delta.Y, MinSize.Y, MaxSize.Y)
            TS:Create(frame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(newX, newY)}):Play()
        end
    end)
end

local function AttachHorizontalScroll(box, scrollingFrame, defaultAlignment)
    defaultAlignment = defaultAlignment or Enum.TextXAlignment.Left
    
    box:GetPropertyChangedSignal("TextBounds"):Connect(function()
        if scrollingFrame.AbsoluteWindowSize.X > 0 and box.TextBounds.X > scrollingFrame.AbsoluteWindowSize.X then
            box.TextXAlignment = Enum.TextXAlignment.Left
        else
            box.TextXAlignment = defaultAlignment
        end
    end)

    box:GetPropertyChangedSignal("CursorPosition"):Connect(function()
        if box:IsFocused() and box.CursorPosition > 0 then
            
            local textToCursor = string.sub(box.Text, 1, box.CursorPosition - 1)
            local size = TxtS:GetTextSize(textToCursor, box.TextSize, box.Font, Vector2.new(10000, 100))
            
            local visibleStart = scrollingFrame.CanvasPosition.X
            local visibleEnd = visibleStart + scrollingFrame.AbsoluteWindowSize.X
            
            local padding = 12
            if box.TextXAlignment == Enum.TextXAlignment.Left then
                if size.X > visibleEnd - padding then
                    TS:Create(scrollingFrame, TweenInfo.new(0.1), {CanvasPosition = Vector2.new(size.X - scrollingFrame.AbsoluteWindowSize.X + padding * 2, 0)}):Play()
                elseif size.X < visibleStart + padding then
                    TS:Create(scrollingFrame, TweenInfo.new(0.1), {CanvasPosition = Vector2.new(math.max(0, size.X - padding * 2), 0)}):Play()
                end
            end
        end
    end)
end

--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local M={"\057\074\109\056\057\103\066\073\100\080\115\061";"\103\106\115\047\104\047\057\050\121\069\070\047\100\069\067\056\057\075\082\061","\101\088\118\043\051\083\083\115\098\080\070\061";"\075\054\069\074\098\118\105\113\076\082\069\118\103\081\112\102\098\048\088\072\115\122\075\105\107\085\061\061";"\104\111\068\056\100\074\109\084";"\054\073\071\077\101\119\061\061","\043\080\090\076\090\111\088\052\074\103\101\112\113\122\108\100\052\069\090\061";"\086\049\122\052\083\103\089\053\055\049\043\085\069\075\122\085\081\097\061\061","\090\074\069\055\086\098\084\048","\069\065\076\085\103\074\109\067","\106\115\097\061";"\073\120\115\061";"\082\109\070\077\099\085\061\061","\102\106\049\075\100\119\061\061";"\081\112\069\053\121\072\119\075\107\068\051\088\121\057\069\061","\067\072\089\121\088\080\049\103\055\074\114\055\065\068\069\047\055\119\061\061","\104\117\121\082\080\108\086\050","\104\100\065\049\068\110\065\102\087\097\112\110\083\098\087\073\084\050\119\061","\112\071\067\055\086\074\076\071\104\066\054\061";"\102\047\109\056\102\047\068\075","\102\120\084\075\069\097\072\054","\088\102\081\118\113\107\100\101\090\115\110\071\103\054\061\061","\112\069\057\101\103\071\067\049\076\069\053\090\081\074\067\122\067\049\090\061";"\088\073\054\049\100\117\122\110\088\054\061\061","\112\067\122\066\065\111\067\073\103\071\070\061","\057\074\068\073\083\074\069\061";"\104\078\076\118\086\103\114\106";"\086\043\119\117\110\049\105\098\075\043\106\103\113\078\056\079\069\072\077\101\073\115\088\113\070\057\087\115\103\081\054\072\065\109\071\056\119\055\065\071\056\052\057\056\114\105\057\082\104\056\057\102\073\117\087\117\110\057\116\053\051\097\102\057\106\055\109\049\056\112\106\071\057\114\117\099\103\085\109\049\121\117\055\120\084\083\078\106\075\077\079\074\068\054\110\047\078\049\087\068\048\088\074\065\050\107\056\119\080\072\104\050\076\114\121\097\069\085\049\054\120\049\051\106\085\082\089\085\082\050\118\113\107\053\118\069\087\065\109\043\078\115\108\119\072\054\089\090\088\051\048\121\083\100\083\108\067\054\102\068\074\084\101\085\108\112\048\113\047\053\081\043\081\110\078\109\121\083\070\103\084\081\114\043\079\085\069\052\109\076\115\084\074\054\109\107\116\073\101\070\079\106\049\078\098\077\077\052\119\117\057\116\106\043\049\102\090\049\104\075\122\113\115\070\054\079\082\079\113\052\087\070\048\086\118\074\054\049\120\115\106\081\122\048\089\048\068\103\075\077\089\084\103\103\086\052\117\109\104\049\070\080\090\086\089\117\053\104\108\056\116\121\087\100\107\113\104\055\057\054\114\115\112\074\089\068\066\097\080\113\115\085\078\104\043\086\069\103\071\114\070\048\043\077\086\103\085\105\111\120\116\113\084\118\090\082\055\098\043\052\057\088\075\061","\103\108\105\061";"\103\090\057\102\076\074\049\075\065\108\068\113\103\068\110\068\067\047\122\061","\088\065\116\115\065\113\122\083\073\068\122\108\108\102\117\055\082\057\106\098\104\066\115\081\067\065\085\061";"\108\052\053\108\074\065\047\122\105\119\111\068\068\117\074\077\104\066\072\107\081\122\081\068\090\067\080\086\050\077\118\049","\057\074\109\052\057\071\089\110\083\111\104\061","\080\066\109\105\100\103\101\061";"\114\090\070\083\099\068\066\106\083\103\050\088\109\111\075\061","\083\072\115\061","\120\099\052\083\090\116\083\075\053\102\087\066\083\088\090\061";"\085\119\061\061","\047\081\081\115\098\049\082\105\083\054\061\061","\100\047\067\075\100\047\067\056\057\054\061\061";"\114\120\101\071\078\097\061\061","\104\047\109\085\051\065\078\105\121\100\088\080\083\069\105\057\103\105\081\048\078\097\061\061","\057\078\122\082\118\082\090\061";"\100\047\068\053\065\065\057\121\081\075\100\066\119\078\067\068\083\054\061\061";"\114\055\051\078\083\119\061\061";"\083\103\068\075\086\097\061\061","\057\100\073\050\090\066\075\061","\102\070\103\068\071\114\053\079\100\087\065\083\073\108\047\074\072\101\075\066\052\105\111\118\067\072\050\054\112\110\098\098\075\117\081\061","\100\078\055\066\102\054\061\061","\122\047\081\120\108\119\061\061";"\056\097\061\061";"\049\071\101\097\065\067\112\086\051\055\056\085\052\121\106\051\087\074\104\121\117\054\061\061","\099\097\052\048\079\055\106\077\078\100\075\106\043\088\121\081\107\050\081\061";"\076\049\104\075\121\067\055\074\086\075\057\119\076\065\076\110\104\119\061\061","\083\065\055\073\081\052\089\049\055\068\089\101\104\066\110\090\055\085\061\061","\102\056\070\085\066\072\068\048\117\090\097\061";"\083\074\067\056","\079\119\048\097\110\051\121\119\115\109\071\105","\112\068\057\106\102\069\110\080\065\065\055\052\076\080\055\070","\104\111\068\078\100\047\067\075","\100\047\066\053\057\074\055\122","\071\099\122\061","\100\106\122\066\083\071\089\088\086\080\069\061";"\078\076\114\066\085\089\048\070";"\120\076\098\051\104\098\053\119\122\121\101\066\090\101\049\111\090\109\084\056\106\097\071\099";"\089\054\061\061";"\083\114\081\061";"\080\066\109\106\102\085\061\061";"\110\067\069\076\084\089\057\076\050\052\099\108\109\051\103\052\049\081\083\084\048\069\043\073\117\097\101\061";"\089\098\098\120","\068\078\077\113\116\049\081\061";"\103\111\100\056\067\090\110\118\088\069\053\114\100\090\067\065","\065\111\110\043\065\070\049\073\104\090\114\069\083\065\100\048\067\097\061\061","\084\097\061\061","\114\057\082\065\047\101\118\088\104\106\071\102\078\054\111\072";"\111\051\089\108\112\085\097\070\105\065\118\075\122\090\085\118\077\104\107\120\112\065\108\110\068\069\114\102\100\116\117\089\047\118\085\118\070\043\101\051","\054\109\050\111\119\076\047\047\069\049\085\117\120\101\055\084\100\083\043\101\111\043\121\082\073\070\048\069\121\082\072\100\102\107\083\117\069\090\088\103","\122\043\085\069\109\053\102\088\122\089\065\074\118\084\105\047\076\048\097\061";"\121\106\115\116\068\072\082\071\067\118\085\061","\121\075\049\111\103\080\043\051\083\111\084\088\086\072\076\119";"\075\118\120\049\117\047\055\077\104\118\113\087\073\102\077\078\103\079\069\061","\117\103\120\117\117\090\051\070\073\073\115\061";"\080\075\104\061","\083\078\081\061";"\108\103\109\113\116\084\073\048\053\106\097\117\115\098\068\081\113\085\085\053\105\043\048\107\080\122\116\067\105\065\121\053\087\056\114\088\081\074\071\109\107\088\049\073\079\088\111\067\082\111\097\113\118\056\116\083";"\109\097\101\052\047\075\102\067\070\105\117\055\118\076\081\117\089\070\097\061","\057\043\103\114\110\056\080\108\081\079\086\115";"\056\073\052\049\119\057\107\052","\073\057\104\079\057\072\085\118\100\122\122\061","\102\047\053\053\104\054\061\061","\076\108\076\121\102\075\100\110\112\103\053\106\102\080\089\114\067\075\101\061","";"\104\052\067\088\069\080\068\108\057\075\066\118\065\068\068\115\065\070\085\061","\114\073\111\078\054\116\100\115\080\067\100\119\065\083\112\105\120\054\061\061";"\054\089\115\101\106\089\056\118\068\085\061\061","\054\077\108\068\083\122\101\076";"\113\043\105\052\104\098\051\083\066\087\066\048\079\116\072\088\119\113\069\061","\116\067\082\109\087\112\079\056\109\077\043\075\099\121\084\109","\069\090\100\065\088\068\043\085\081\069\049\102\069\108\043\071\104\067\081\061","\113\079\121\114\089\043\100\113\117\071\068\104";"\104\078\067\073","\088\054\061\061","\088\080\089\106\065\071\102\101\055\103\110\103\112\074\084\110\057\111\090\061";"\057\071\049\085\100\119\061\061","\111\107\097\061","\067\049\076\080\057\090\099\090\057\069\081\052\112\090\084\111\076\111\115\061";"\057\070\055\076\103\074\122\066\086\066\067\074\104\072\057\099\112\054\061\061","\100\047\068\084\100\119\061\061";"\066\065\113\057\050\085\061\061","\080\066\109\110\083\111\076\049\112\097\061\061";"\065\070\110\043\069\078\068\079\065\090\100\115\076\103\067\085\103\068\102\061";"\055\052\075\065\084\085\061\061";"\080\066\109\084\100\080\076\053\057\074\068\073\083\074\069\061","\081\114\075\097\066\070\105\070\069\086\079\098\069\097\061\061";"\109\078\088\099";"\104\074\055\053\083\074\085\061","\075\107\118\081\085\075\054\068\090\119\061\061";"\053\106\065\116\075\104\076\085\088\104\085\061","\102\047\109\118\083\078\067\075\086\103\114\049","\057\086\105\098\103\081\087\111\103\090\105\113\121\049\115\080","\100\111\099\077\083\078\115\061";"\067\074\068\084\104\074\067\118\115\070\076\049\057\074\067\108\057\074\067\090\115\119\061\061","\087\105\112\109\069\106\050\119\109\085\061\061","\083\072\070\061";"\053\118\054\089\051\097\061\061","\104\049\100\121\076\071\070\085\119\067\043\111\103\068\110\118\121\054\061\061","\050\066\088\104\087\077\086\101\111\098\049\054\082\100\053\112\122\043\080\121\070\097\101\088\057\078\101\061";"\057\103\114\085\102\103\055\079","\104\073\080\047\056\072\085\061","\100\080\089\118\083\078\115\061","\104\047\067\075\083\103\067\075\102\080\076\053\102\111\099\049","\090\072\105\082\071\106\083\086\109\053\102\061";"\076\047\067\075\069\047\067\118\057\111\049\108\100\119\061\061","\098\090\049\099\052\088\102\117\081\079\108\052\111\086\081\072\073\120\113\048\104\099\120\105\111\052\056\080\107\052\049\050\100\083\099\073\087\047\111\057","\104\111\067\084\083\078\100\049","\087\068\073\118\097\111\052\052\047\082\110\082\071\054\083\078\121\073\111\105\109\077\120\086";"\081\067\100\122\102\047\109\071\083\068\067\052\081\070\110\066\081\119\061\061";"\067\069\101\104\103\065\052\074\048\083\107\075"}local function G(G)return M[G+(-273368-(-332325))]end for G,o in ipairs({{-494665-(-494666),-109622-(-109760)},{-178162+178163,606621-606617},{772441+-772436;293679-293541}})do while o[166781+-166780]<o[88977-88975]do M[o[-610748+610749]],M[o[-35392+35394]],o[746302+-746301],o[63244-63242]=M[o[-489031-(-489033)]],M[o[328665+-328664]],o[-343745+343746]+(-59520-(-59521)),o[-269467+269469]-(979091+-979090)end end do local G=table.concat local o={E=-144359-(-144379),a=116398-116398,["\050"]=42296+-42281;x=978312-978253;N=517390+-517335;W=533165+-533134;["\043"]=-863994+863995;p=94181-94151;c=9410-9361,["\056"]=-916815-(-916861),X=524896+-524882,d=34132+-34107,F=990337+-990333;f=925607-925583,e=-667875+667931;["\048"]=445828+-445818,j=-869724-(-869763),I=-844181-(-844215);Z=786794+-786758,Q=390592+-390580;i=-575642-(-575686);k=-392116+392174,T=-228446+228491,["\049"]=-218643+218680,M=735898-735851,J=-1035447+1035453,w=-765266-(-765282),B=54265+-54212;g=-695660-(-695682);n=-4110+4151,u=912935-912933,A=952118+-952099;O=501619+-501576,l=239596+-239561;C=-710890+710911;G=-900468-(-900475);v=-653085-(-653135);["\054"]=1035276-1035244,K=-370268-(-370320),D=-758173+758178,H=-247928+247931,U=1019926-1019878;z=943841+-943801,h=-243880+243908,["\051"]=294643+-294632;o=620283-620245;P=596931-596908,["\052"]=-580399+580450,s=-723094-(-723102);b=71748-71686;t=268428+-268365,["\053"]=873129-873096;r=507706-507649;["\057"]=853020-852991,L=-698793-(-698810);m=-84962-(-85023),S=225543-225516;y=-681025+681043,["\055"]=-830265-(-830278),Y=-460176-(-460185),V=-313+339,["\047"]=-316422-(-316476);R=502102-502042;q=369793-369751}local R=M local S=string.sub local b=table.insert local P=string.char local p=type local l=string.len local Z=math.floor for M=173300-173299,#R,-27155-(-27156)do local K=R[M]if p(K)=="\115\116\114\105\110\103"then local p=l(K)local r={}local c=631421+-631420 local z=-1031928+1031928 local i=-467169+467169 while c<=p do local M=S(K,c,c)local G=o[M]if G then z=z+G*(854881+-854817)^((460710+-460707)-i)i=i+(128002-128001)if i==-608246-(-608250)then i=218631+-218631 local M=Z(z/(410271+-344735))local G=Z((z%(248226-182690))/(-696787+697043))local o=z%(905451-905195)b(r,P(M,G,o))z=721485-721485 end elseif M=="\061"then b(r,P(Z(z/(-768507+834043))))if c>=p or S(K,c+(116025+-116024),c+(795804-795803))~="\061"then b(r,P(Z((z%(-909685+975221))/(695198-694942))))end break end c=c+(-146556+146557)end R[M]=G(r)end end end return(function(M,R,S,b,P,p,l,Z,a,x,q,r,s,c,i,K,O,I,y,z,o)Z,y,s,K,O,q,c,i,r,o,I,a,z,x={},function(M,G)local R=z(G)local S=function(S,b,P)return o(M,{S;b;P},G,R)end return S end,function(M,G)local R=z(G)local S=function(S)return o(M,{S},G,R)end return S end,{},function(M,G)local R=z(G)local S=function(...)return o(M,{...},G,R)end return S end,function(M,G)local R=z(G)local S=function(S,b)return o(M,{S;b},G,R)end return S end,924808+-924808,function(M)local G,o=67617-67616,M[-663641+663642]while o do K[o],G=K[o]-(688781-688780),G+(780996-780995)if K[o]==-97697+97697 then K[o],Z[o]=nil,nil end o=M[G]end end,function()c=(430562+-430561)+c K[c]=-965061-(-965062)return c end,function(o,S,b,P)local e,D,aW,X,sW,cW,yW,RW,IW,J,u,SW,A,OW,k,H,bW,PW,pW,N,T,w,C,MW,E,U,c,xW,TW,Q,F,GW,l,d,t,j,V,ZW,zW,Y,KW,W,n,L,iW,EW,K,v,O,qW,i,g,B,oW,f,m,lW,h,rW,z while o do if o<9201551-365625 then if o<-125477+4557187 then if o<778795+1055728 then if o<935114-(-82960)then if o<532411+221261 then if o<736690+-124872 then if o<892186+-381464 then w=Z[c]o=w and 583811+13026740 or-870612+11151362 W=w else o=-945104+1896726 T=Z[O]l=T end else if o<235319+411548 then Z[c]=D e=37457-37456 n=Z[U]X=n+e f=B[X]Q=F+f f=447641+-447385 o=Q%f F=o X=Z[N]f=Y+X X=686955-686699 o=28486+4840336 Q=f%X Y=Q else c=Z[b[825832-825829]]z=-213946-(-213947)K=c~=z o=K and 5480545-342243 or 13667428-559013 end end else if o<909376-(-12817)then if o<-653067+1482269 then K=nil Z[b[-714182-(-714187)]]=l o=500417+8647481 else z=Z[b[334603-334597]]c=z==K o=325417-(-480450)l=c end else if o<1598084-640465 then T=l E=G(-147004-(-88097))l=M[E]E=G(-669688+610740)o=l[E]E=r()Z[E]=o h=G(299074-358001)l=M[h]h=G(885743-944676)o=l[h]h=o J=o Y=G(-567180+508253)F=M[Y]m=F o=F and-51208+12516686 or 7331680-(-598562)else o=K()c=o o=c and 2624797-(-899969)or 7739807-(-999859)l=c end end end else if o<1710853-136068 then if o<153981+1084258 then if o<-932273+2092977 then z=z+O c=z<=i E=not T c=E and c E=z>=i E=T and E c=E or c E=8726338-37732 o=c and E c=-364579+10908536 o=o or c else IW=G(-878592+819733)X=G(708943+-767838)V=G(386650-445541)pW=G(500322-559222)J=860930+34305304271716 m=159888+22138099709876 K=S[219598-219597]o=Z[b[-932325-(-932326)]]h=G(-64756+5877)l=o(K)o=G(-149655+90751)z=S[-233075+233078]O=Z[b[-878781+878783]]T=Z[b[569332+-569329]]E=T(h,m)Q=G(-239273-(-180447))A=G(893853-952784)m=G(741800-800686)i=O[E]c=S[-213378-(-213380)]T=Z[b[-821822-(-821824)]]E=Z[b[813639+-813636]]h=E(m,J)m=17753796479625-(-5570)o=l[o]J=435969601273-(-643538)aW=69020+32221827001600 O=T[h]o=o(l,i,O)O=Z[b[813135+-813133]]l=G(547378+-606282)T=Z[b[1048281+-1048278]]h=G(-459522-(-400607))E=T(h,m)m=G(644755-703679)i=O[E]T=Z[b[695448+-695446]]GW=G(501437+-560321)f=16570310716090-(-1028970)E=Z[b[-761152-(-761155)]]h=E(m,J)O=T[h]KW=5325802479304-(-912104)l=o[l]l=l(o,i,O)m=G(-408197-(-349356))w=G(-293455+234544)O=G(306010-364879)qW=G(655567-714450)Y=-132374+3399509429061 i=l l=M[O]T=Z[b[-367547-(-367549)]]E=Z[b[-783799-(-783802)]]W=13277646679883-(-190683)J=164675+3427445261049 v=18289876859709-(-1025543)h=E(m,J)O=T[h]o=l[O]J=12292247902784-852964 m=G(-607043-(-548094))T=Z[b[911654-911652]]j=G(-730204+671338)E=Z[b[109188+-109185]]h=E(m,J)n=32718774840682-520679 O=T[h]l=o(O)J=-302130+31165394588898 O=l T=Z[b[376123+-376121]]F=G(-262398-(-203545))m=G(-323991-(-265113))E=Z[b[904263-904260]]yW=29038864112783-927677 h=E(m,J)ZW=G(884449-943371)l=T[h]h=Z[b[-616428-(-616430)]]iW=G(-637206-(-578318))EW=G(686985-745888)m=Z[b[653160-653157]]J=m(F,Y)L=G(192070+-250945)E=h[J]m=Z[b[-498421+498425]]Y=Z[b[-125989-(-125991)]]C=Z[b[634552+-634549]]u=C(V,W)B=10815002088683-295231 F=Y[u]u=Z[b[606282+-606280]]H=-187017+16433043044461 V=Z[b[-523338+523341]]RW=G(849279-908232)W=V(w,v)C=u[W]W=Z[b[-885938+885940]]w=Z[b[414197+-414194]]v=w(A,H)N=279714+26012889082543 V=W[v]v=Z[b[874948-874946]]g=33735602885148-234687 A=Z[b[851222-851219]]H=A(j,N)w=v[H]A=Z[b[225941-225936]]N=Z[b[-576929+576931]]U=Z[b[313208+-313205]]k=G(135767-194639)t=U(k,B)j=N[t]k=Z[b[-641340-(-641342)]]B=Z[b[720547-720544]]D=B(Q,f)t=k[D]D=Z[b[1042472+-1042470]]sW=3763804208232-30096 Q=Z[b[510369-510366]]f=Q(X,n)B=D[f]Q=Z[b[-587919+587925]]n=Z[b[-441488-(-441490)]]e=Z[b[454641-454638]]d=e(L,g)X=n[d]L=Z[b[893617-893615]]oW=566860+20114609028682 g=Z[b[382510+-382507]]PW=117563+24848371868151 MW=g(GW,oW)d=L[MW]MW=Z[b[-958925-(-958927)]]GW=Z[b[-1019326-(-1019329)]]TW=32954723050825-338264 cW=G(-178863+120015)oW=GW(RW,PW)g=MW[oW]GW=Z[b[748723+-748716]]PW=Z[b[-1009358-(-1009360)]]zW=13081385096881-(-344346)lW=11647573888740-(-345675)SW=Z[b[523156-523153]]bW=SW(pW,lW)RW=PW[bW]pW=Z[b[-810278-(-810280)]]lW=Z[b[-648737+648740]]rW=lW(ZW,KW)bW=pW[rW]rW=Z[b[772528+-772526]]ZW=Z[b[-846785-(-846788)]]KW=ZW(cW,zW)lW=rW[KW]KW=Z[b[-818299-(-818301)]]cW=Z[b[48258-48255]]zW=cW(iW,aW)ZW=KW[zW]cW=Z[b[390673+-390665]]aW=Z[b[-722352-(-722354)]]OW=Z[b[-994899+994902]]xW=OW(qW,sW)iW=aW[xW]xW=Z[b[-365142+365144]]qW=Z[b[-271357-(-271360)]]sW=qW(IW,yW)OW=xW[sW]sW=Z[b[-993787+993789]]IW=Z[b[250171-250168]]yW=IW(EW,TW)qW=sW[yW]xW=O..qW aW=OW..xW zW=iW..aW KW=cW..zW rW=ZW..KW pW=lW..rW SW=bW..pW PW=z..SW oW=RW..PW MW=GW..oW L=g..MW e=d..L n=c..e f=X..n D=Q..f k=B..D U=t..k N=i..U H=j..N v=A..H W=w..v u=V..W Y=C..u J=F..Y h=m..J T=E..h o=l..T T=o o=M[G(-964614-(-905660))]l={T}end else if o<-725169+2197657 then l=G(902853-961698)o=M[l]c=Z[b[978754+-978753]]l=G(-1003682-(-944862))z=Z[b[-308784-(-308786)]]O=G(-421383+362547)T=222452+137268665163 l=o[l]i=z(O,T)K=c[i]l=l(o,K)K=l l=K o=K and 3709981-(-256830)or 508172+1178101 else o=Z[b[-490916+490917]]K=Z[b[-1042307-(-1042309)]]c=Z[b[1576-1573]]z=Z[b[-571536-(-571540)]]l=o(K,c,z)K=l c=r()h=G(-444394+385561)o={}Z[c]=o o=Z[c]l=Z[b[335092+-335087]]z=Z[b[-453326+453332]]m=1041042+18919994802136 o[l]=z o=Z[c]l=Z[b[769191-769184]]z=Z[b[1016664+-1016656]]o[l]=z o=Z[c]l=Z[b[-212036+212045]]O=Z[b[1023426+-1023416]]T=Z[b[-531322+531333]]E=T(h,m)i=O[E]m=G(105675+-164576)T=Z[b[-821196+821206]]J=813669+34351144064023 E=Z[b[-949583+949594]]h=E(m,J)O=T[h]z={[i]=O}o[l]=z o=Z[c]l=Z[b[626449-626437]]z=K K=nil o[l]=z z=q(109012+14940505,{b[-141448+141462];c})o=Z[b[279487-279474]]c=a(c)l=o(z)o=M[G(372971-431916)]l={}end end else if o<776613-(-937853)then if o<656358-(-993549)then O=35184372820137-731305 J=-358563+358564 F=J o={}Z[b[819677-819675]]=o h=G(739585+-798511)l=Z[b[86718+-86715]]i=l l=c%O Z[b[-976913-(-976917)]]=l E=739512-739257 T=c%E E=415999-415997 O=T+E Z[b[-118518+118523]]=O E=M[h]h=G(-762089-(-703193))T=E[h]E=T(K)T=G(859528+-918389)h=-505671+505672 z[c]=T o=340626+3337302 T=226905-226721 J=-706890+706890 m=E Y=F<J J=h-F else o=l and 9910802-(-51865)or 7944493-(-894159)end else l=G(-914394-(-855571))o=M[l]K=G(-663959+605128)l=o(K)o=M[G(791025+-849919)]l={}end end end else if o<-112512+3184572 then if o<2670828-104437 then if o<-202839+2668600 then if o<-169507+2120662 then o=x(11608469-(-1025392),{i})w={o()}l={R(w)}o=M[G(477176+-536049)]else o=648582+7505018 end else if o<3231418-723333 then o=Z[b[-961366-(-961367)]]K=Z[b[1005005-1005003]]c=Z[b[-319385+319388]]l=o(K,c)K=l l=Z[b[845489+-845485]]c=l(K)E=523183+27313969247744 z=Z[b[-822116+822121]]T=G(48339-107289)i=Z[b[66639+-66633]]O=i(T,E)l=z[O]o=c==l o=o and-113370+1131139 or-303972+9545731 else zW=G(164103-223015)o=bW iW=-101567+9411558776285 aW=G(-17469+-41413)bW=Z[E]lW=Z[O]ZW=Z[c]KW=Z[i]cW=KW(zW,iW)rW=ZW[cW]OW=-494836+29958718456690 pW=bW(lW,rW)lW=o ZW=Z[m]KW=ZW(pW)cW=Z[c]zW=Z[i]iW=zW(aW,OW)ZW=cW[iW]rW=KW==ZW bW=rW o=rW and 3208800-(-288660)or 108000+4955207 end end else if o<246749+2439031 then if o<1667279-(-948072)then u=G(206363+-265191)h=G(429775+-488702)l=M[h]m=Z[b[-509218-(-509219)]]E=z C=-352896+31287788231529 J=Z[b[-693783-(-693785)]]Y=G(-15229+-43703)F=J(Y,C)h=m[F]J=G(-571126+512200)o=l[h]m=M[J]F=Z[b[-481446+481447]]V=7477908568509-(-578525)Y=Z[b[157632+-157630]]C=Y(u,V)J=F[C]F=G(-961786+902834)u=587900-587899 h=m[J]Y=G(11718+-70570)J=M[F]Y=K[Y]C=E+u Y=Y(K,E,C)C=81091+-81075 F={J(Y,C)}m={h(R(F))}E=nil l=o(c,R(m))o=-162429+9401177 else o=-18110+4886932 Z[c]=l end else if o<-584793+3325769 then o=l and 825722+13403218 or 14940268-(-482417)else z=16530295-654937 c=G(-466634-(-407706))l=62776+3627084 K=c^z o=l-K l=G(-721596+662662)K=o o=l/K l={o}o=M[G(158713+-217664)]end end end else if o<4985651-1025314 then if o<3810744-302403 then if o<4276934-802978 then K=Z[b[53464-53463]]l=#K K=-670098-(-670098)o=l==K o=o and-511783+10510500 or 674597+9317554 else ZW=Z[m]cW=Z[E]qW=G(-1033678+974854)sW=11321205114275-979212 aW=Z[c]OW=Z[i]o=687443+4375764 xW=OW(qW,sW)iW=aW[xW]zW={cW(pW,iW)}KW=ZW(R(zW))cW=Z[c]zW=Z[i]OW=8532491498615-(-203534)aW=G(90492+-149363)iW=zW(aW,OW)ZW=cW[iW]rW=KW==ZW bW=rW end else if o<2781316-(-836134)then i=Z[b[744426-744419]]J=-748835+13096344421621 o=9317239-577573 m=G(822546+-881407)O=i(c)T=Z[b[-575315-(-575320)]]E=Z[b[734622-734616]]h=E(m,J)i=T[h]z=O~=i l=z else C=not Y J=J+F h=J<=m h=C and h C=J>=m C=Y and C h=C or h C=-583177+9347613 o=h and C h=15676669-(-406100)o=o or h end end else if o<4085645-(-246846)then if o<4254422-140331 then o=1517000-(-169273)i=Z[b[-98821+98822]]O=Z[b[-59320+59322]]h=6705885498546-540800 E=G(114533-173451)T=O(E,h)z=i[T]c=K[z]l=c else o=M[G(-246665-(-187756))]l={c}end else Q=Z[c]o=Q and-448029+11403982 or-175714-(-794201)D=Q end end end end else if o<518541+6013530 then if o<5133268-(-409883)then if o<827406+4313281 then if o<993197+4035199 then if o<4336344-(-559643)then B=nil t=a(t)j=a(j)o=-420949+15745063 H=a(H)k=a(k)U=a(U)N=a(N)else J=G(-76703-(-17878))m=M[J]l=m o=14664421-(-618046)end else if o<612088+4514829 then o=lW o=bW and 6534779-535986 or-769061+10512271 else o=282691+9709460 z=270668+-270636 c=Z[b[-585259+585262]]K=c%z F=540781+-540768 i=Z[b[846464+-846460]]m=923675+-923673 E=Z[b[895754-895752]]u=Z[b[873912+-873909]]C=u-K u=616016-615984 Y=C/u J=F-Y h=m^J T=E/h h=-198661-(-198662)O=i(T)i=4294679929-(-287367)z=O%i O=897264+-897262 i=O^K c=z/i i=Z[b[-1029492-(-1029496)]]E=c%h h=4295370052-402756 m=-669992+670248 K=nil T=E*h O=i(T)i=Z[b[-94001-(-94005)]]T=i(c)z=O+T O=-914471-(-980007)E=-698930-(-764466)i=z%O T=z-i O=T/E F=-505971-(-506227)z=nil E=-149162+149418 T=i%E h=i-T E=h/m m=24987-24731 h=O%m c=nil i=nil J=O-h m=J/F J={T;E,h,m}m=nil T=nil O=nil Z[b[1031860+-1031859]]=J h=nil E=nil end end else if o<-519298+5946913 then if o<159643+5094030 then o=Z[b[-990072+990079]]m=-472872+23417386017216 l=o(c)E=G(614047-672987)i=Z[b[-461009+461014]]h=20395566726121-841424 O=Z[b[419668-419662]]T=O(E,h)z=i[T]O=Z[b[-308850-(-308855)]]o=G(439771+-498675)h=G(178179-237040)T=Z[b[10911+-10905]]E=T(h,m)m=67596+33622372824348 i=O[E]o=l[o]h=-672301+20574253508505 o=o(l,z,i)i=Z[b[697038+-697033]]l=G(-899032-(-840128))E=G(-561295+502408)O=Z[b[-463224+463230]]T=O(E,h)h=G(987092+-1046033)z=i[T]O=Z[b[267283+-267278]]T=Z[b[-275396-(-275402)]]E=T(h,m)l=o[l]i=O[E]l=l(o,z,i)E=G(294697+-353599)i=Z[b[-985946-(-985951)]]o=G(-815104+756200)O=Z[b[594503+-594497]]h=15957476945507-(-798371)T=O(E,h)h=G(1042960+-1101902)z=i[T]m=-333001+732895974942 O=Z[b[814861-814856]]T=Z[b[783285-783279]]E=T(h,m)o=l[o]i=O[E]o=o(l,z,i)Z[b[793016+-793008]]=o o=106920+12266964 else K=l l=Z[b[8978-8973]]c=l(K)z=Z[b[-323036+323042]]i=Z[b[-1017696-(-1017703)]]T=G(-728785-(-669921))E=263290+985399541072 O=i(T,E)l=z[O]o=c==l o=o and-627400+7795975 or 771542+10829705 end else if o<460952+5048065 then K=Z[b[-759197+759198]]z=Z[b[321952+-321950]]o=348321+5040243 i=Z[b[972449+-972445]]c=K(z,i)l=c else o=true o=o and 452125+7359307 or-998204+10413029 end end end else if o<5171275-(-770880)then if o<6096917-252801 then if o<830168+4959292 then o=15176506-(-3308)else o={}K=o o=Z[b[173263-173262]]l=Z[b[-162470+162472]]K[o]=l h=5312281306474-(-386111)o=Z[b[-162509+162512]]T=G(-135324-(-76485))l=Z[b[68273+-68269]]K[o]=l o=Z[b[712171-712166]]z=Z[b[64829+-64823]]i=Z[b[853443+-853436]]E=15156191654658-6001 O=i(T,E)c=z[O]i=Z[b[-867012-(-867018)]]E=G(-258130+199274)O=Z[b[762539-762532]]T=O(E,h)z=i[T]l={[c]=z}K[o]=l o=Z[b[-698938-(-698946)]]l=o(K)c=l o=c and-978413+7553697 or 15122428-(-813007)l=c end else if o<1037229+4863057 then H=r()V=r()A=I(3448484-(-18966),{V,m;J;O})C=nil t=G(-250093-(-191250))T=nil N={}u={}Z[V]=u u=r()Z[u]=A z=nil j=G(874403-933225)f=nil A={}B=G(-664091+605251)O=a(O)Z[H]=A A=M[j]E=nil k=Z[H]U={[t]=k,[B]=f}j=A(N,U)A=y(15896674-870618,{H;V;Y,m,J,u})Y=a(Y)E=G(-520067-(-461154))u=a(u)J=a(J)H=a(H)O=o Z[c]=j V=a(V)h=nil m=a(m)F=nil Z[i]=A T=M[E]o=T and 9918914-721294 or 11475936-495681 z=T else o=true Z[b[563075-563074]]=o l={}o=M[G(514996+-573933)]end end else if o<7009264-547438 then if o<7047221-770420 then lW=G(-708835-(-649942))bW=M[lW]ZW=Z[c]iW=12528141533941-(-807892)KW=Z[i]zW=G(389262-448172)cW=KW(zW,iW)o=10503653-(-1007913)rW=ZW[cW]lW=bW(pW,rW)bW=lW(PW)else A=#C V=-650514+650515 u=z(V,A)N=-126302+126303 V=T(C,u)A=Z[Y]j=V-N H=E(j)u=nil o=395602+11488997 A[V]=H V=nil end else o=M[G(-522560-(-463710))]c=nil K=nil l={}end end end else if o<863139+7061654 then if o<7643842-284915 then if o<6824858-(-37310)then if o<6388310-(-384655)then O=Z[b[-1031145-(-1031151)]]T=Z[b[-1030928+1030935]]m=6454128499526-(-634999)h=G(-818159-(-759212))o=16347955-412520 E=T(h,m)i=O[E]z=c[i]l=z else KW=G(-189186-(-130270))RW=G(449678-508536)MW=Z[c]GW=Z[i]PW=-600292+13033534161049 bW=27709495541239-(-455792)aW=G(-504595-(-445760))oW=GW(RW,PW)L=MW[oW]MW=r()Z[MW]=L GW=Z[c]oW=Z[i]PW=G(72099-130929)SW=-422052+12735242913742 RW=oW(PW,SW)L=GW[RW]GW=r()SW=G(280984+-339898)Z[GW]=L oW=Z[c]RW=Z[i]PW=RW(SW,bW)L=oW[PW]oW=r()Z[oW]=L L=Z[h]PW=q(287997+1046386,{c;i;MW})RW=L(PW)L=Z[h]PW=q(607398+1891913,{E,O;u,m;c;i,J,GW})RW=L(PW)L=Z[h]PW=s(5711173-(-89512),{H;B,N,A,U,c;i,g,J;oW})RW=L(PW)L=r()RW=x(1181687-(-29143),{J;c,i;f;X,n;e,d})Z[L]=RW PW=Z[E]bW=Z[O]RW=I(-59944+1606973,{L,MW;oW,GW,H;k;N;V,U,c;i;t;h;g})lW=Z[c]cW=-364375+4224480106246 rW=Z[i]ZW=rW(KW,cW)pW=lW[ZW]SW=PW(bW,pW)bW=o lW=o ZW=Z[m]KW=ZW(SW)cW=Z[c]OW=801912+24367475568602 zW=Z[i]iW=zW(aW,OW)ZW=cW[iW]rW=KW==ZW o=rW and 681353+14247411 or 10651245-293399 pW=rW end else if o<6706619-(-446388)then V=#C o=5649694-(-810652)A=-1040301-(-1040301)u=V==A else o=M[G(5836+-64766)]l={K}end end else if o<6956507-(-607674)then if o<-470647+8005225 then o=M[G(45303-104226)]l={}else K=G(-372280+313457)z=-241233+241233 o=M[K]c=Z[b[537976+-537968]]K=o(c,z)o=16652588-550574 end else if o<7167805-(-586017)then h=G(-744034+685197)E=G(-476353+417460)U=16718191856396-994467 N=41629+15343014869323 T=M[E]E=r()m=G(833249-892098)Z[E]=T T=M[h]h=r()Z[h]=T B=-858393+25475661825904 H=27724465332446-1044080 T=M[m]J=G(-396271-(-337351))L=13482242958283-478021 m=r()t=24539176936786-882864 Z[m]=T T=M[J]J=r()A=G(213882-272828)Z[J]=T T=q(12943232-900703,{c,i})C=Z[c]u=Z[i]g=4306511576316-(-821977)V=u(A,H)Y=C[V]F=T(Y)MW=-428414+29722823098254 Y=r()Z[Y]=F k=5721234009868-533668 u=Z[c]V=Z[i]H=G(-1105420-(-1046499))A=V(H,N)C=u[A]N=G(-232850-(-173983))F=T(C)C=r()Z[C]=F V=Z[c]A=Z[i]H=A(N,U)u=V[H]F=T(u)u=r()n=16690619995068-652640 Z[u]=F A=Z[c]U=G(-535198+476324)bW=22308855370058-(-333642)H=Z[i]N=H(U,t)V=A[N]F=T(V)V=r()Z[V]=F H=Z[c]t=G(-711768+652911)f=4932503914382-(-278890)N=Z[i]U=N(t,k)A=H[U]F=T(A)A=r()k=G(-644073-(-585184))Z[A]=F X=19280109124158-55084 N=Z[c]U=Z[i]t=U(k,B)B=G(-320521-(-261666))H=N[t]F=T(H)H=r()Z[H]=F U=Z[c]t=Z[i]k=t(B,f)f=G(-338000-(-279065))N=U[k]F=T(N)N=r()Z[N]=F t=Z[c]k=Z[i]B=k(f,X)U=t[B]oW=35156436083804-107626 X=G(-610171-(-551350))F=T(U)U=r()Z[U]=F k=Z[c]B=Z[i]f=B(X,n)t=k[f]n=G(904765+-963690)F=T(t)d=27203929812837-(-557590)t=r()Z[t]=F B=Z[c]e=24060519478892-248488 f=Z[i]X=f(n,e)k=B[X]F=T(k)k=r()Z[k]=F e=G(847023-905891)f=Z[c]X=Z[i]n=X(e,d)B=f[n]F=T(B)B=r()Z[B]=F d=G(-864753+805876)X=Z[c]n=Z[i]e=n(d,L)f=X[e]F=T(f)f=r()Z[f]=F L=G(-624384-(-565479))n=Z[c]e=Z[i]d=e(L,g)X=n[d]F=T(X)X=r()Z[X]=F g=G(-1016252-(-957376))e=Z[c]d=Z[i]L=d(g,MW)n=e[L]GW=30729423629514-(-412443)F=T(n)n=r()Z[n]=F SW=G(170743-229640)d=Z[c]MW=G(-863844+804889)L=Z[i]g=L(MW,GW)e=d[g]F=T(e)e=r()Z[e]=F GW=G(87081-145900)L=Z[c]g=Z[i]MW=g(GW,oW)d=L[MW]g=r()F=T(d)d=r()Z[d]=F F=y(532366+14933934,{E,O;Y,C,m,c;i})L=F()Z[g]=L MW=Z[m]oW=Z[g]GW=MW(oW)oW=Z[c]RW=Z[i]PW=RW(SW,bW)MW=oW[PW]L=GW~=MW o=L and 278540+7723139 or-1030573+7886688 else l=G(-957792-(-898875))K=G(-314633+255804)o=M[l]l=M[K]K=G(-1024211+965382)M[K]=o o=428995+5109854 K=G(-372211-(-313294))M[K]=l K=Z[b[-177512-(-177513)]]c=K()end end end else if o<-636456+9120523 then if o<8423166-389729 then if o<8044251-112438 then l=m o=J o=m and 16236311-953844 or 797342+4184497 else o=M[G(-139682-(-80801))]l={}end else if o<7620702-(-467525)then c=Z[b[396620-396618]]o=127572+15618330 z=Z[b[-386576-(-386579)]]K=c==z l=K else z=a(z)c=a(c)J=a(J)u=nil C=nil m=a(m)Y=nil T=nil m=G(-652224-(-593298))h=nil F=nil o=10365785-(-1007798)c=nil z=nil i=a(i)V=a(V)J=r()O=a(O)E=a(E)i=r()Z[i]=c c=r()T=G(-1049658-(-990751))E=G(-844274-(-785367))Z[c]=z O=M[T]T=G(557693+-616525)z=O[T]O=r()h=G(-358802+299875)F={}V=910759-910503 Z[O]=z T=M[E]E=G(605556+-664504)z=T[E]E=M[h]h=G(-1054968-(-996012))T=E[h]h=M[m]m=G(-1052450-(-993587))E=h[m]h=-83221-(-83221)m=r()Z[m]=h h=-993358+993360 Z[J]=h h={}Y=r()Z[Y]=F A=V u=-654230-(-654231)V=677699+-677698 F=635323-635323 H=V V=-333350-(-333350)j=H<V C={}V=u-H end end else if o<893360+7860880 then if o<577369+8143258 then m=1031258+-1031003 c=z o=Z[b[-882788-(-882789)]]h=-892094+892094 E=o(h,m)K[c]=E o=950310-(-148186)c=nil else o=l and 6002215-861351 or 12657103-283219 end else h=J v=G(-801838-(-742912))w=M[v]v=G(166867-225806)W=w[v]w=W(K,h)W=Z[b[-689977-(-689983)]]v=W()V=w+v u=V+T V=697966+-697710 C=u%V V=z[c]v=-261910+261911 T=C w=T+v W=i[w]u=V..W z[c]=u h=nil o=3695653-17725 end end end end end else if o<12541130-164948 then if o<474298+9805284 then if o<9774023-318612 then if o<-1011509+10169710 then if o<740966+8370274 then if o<-764302+9615587 then l={}o=M[G(-215186+156344)]K=nil else z=G(-925889+866962)l=M[z]h=746450+13226806260797 i=Z[b[856106-856105]]E=G(-41183-17682)O=Z[b[-460980-(-460982)]]T=O(E,h)z=i[T]o=l[z]l={o(c)}o=M[G(510473+-569300)]l={R(l)}end else if o<-487589+9627201 then h=G(463703+-522547)o=Z[b[-842006-(-842015)]]O=Z[b[999503-999497]]m=5447480432564-(-94772)T=Z[b[-852018+852025]]E=T(h,m)i=O[E]z=c[i]l=o(z)h=-301505+10244786187363 E=G(91087+-149925)i=Z[b[598776-598770]]o=G(847561-906465)m=25734238180101-(-23498)O=Z[b[428841-428834]]T=O(E,h)z=i[T]O=Z[b[-903674+903680]]T=Z[b[844315-844308]]o=l[o]h=G(-498738+439877)E=T(h,m)i=O[E]T=-814618+814625 o=o(l,z,i)z=o O=#z i=O>=T l=i o=i and 10866169-(-863459)or 431722+2270255 else o=Z[b[215641-215634]]o=o and 6734018-(-801094)or 15935144-(-166870)end end else if o<-920523+10161591 then if o<929932+8278659 then E=G(62220-121133)T=M[E]E=T()o=10817148-(-163107)z=E else z=z+O l=z<=i E=not T l=E and l E=z>=i E=T and E l=E or l E=3364811-790015 o=l and E l=924409+7930698 o=o or l end else if o<8834757-(-563278)then K=nil l={}o=M[G(-1012870-(-954010))]else l={}o=M[G(980703+-1039601)]end end end else if o<-584569+10557741 then if o<-806345+10567537 then if o<9445795-(-230869)then o=4972989-640567 else zW=G(-894932-(-835996))iW=459054+11757173937204 rW=G(867043+-925877)o=-195250+11706816 OW=528797+11959936599076 lW=M[rW]ZW=Z[c]KW=Z[i]cW=KW(zW,iW)rW=ZW[cW]KW=G(948722-1007556)bW=lW[rW]ZW=M[KW]cW=Z[c]aW=G(-113789+54845)zW=Z[i]iW=zW(aW,OW)KW=cW[iW]rW=ZW[KW]ZW={rW(PW)}lW=bW(R(ZW))end else if o<9824761-(-13341)then o=-985806+3527010 PW=RW else E=22920600260548-(-596461)z=Z[b[85882+-85881]]i=Z[b[-469405-(-469407)]]T=G(-807142+748204)O=i(T,E)T=G(-968355+909447)c=z[O]E=640065+3544297210417 l=K[c]z=Z[b[531273+-531272]]i=Z[b[-334690-(-334692)]]O=i(T,E)c=z[O]o=l[c]Z[b[-913698-(-913701)]]=o o=8673711-(-164941)end end else if o<10954598-824994 then if o<10343654-347898 then o=M[G(-720526-(-661664))]z=G(725526-784453)c=M[z]z=G(-884801+825845)K=c[z]z=Z[b[-2551+2552]]c={K(z)}l={R(c)}else z=663635-663414 c=Z[b[-327695+327697]]K=c*z c=20608084194932-(-601863)l=K+c c=-989962+989963 K=35184371791371-(-297461)o=l%K Z[b[441038+-441036]]=o K=Z[b[265367+-265364]]o=-969076+14077491 l=K~=c end else o=true o=o and-975395+15329838 or 2286545-366205 end end end else if o<-575908+12169218 then if o<10988299-95534 then if o<-199069+10571271 then if o<10042784-(-309872)then Z[c]=W o=Z[c]o=o and 2038804-(-153336)or 15496007-786959 else o=lW o=pW and-613587+3154791 or 10551907-769550 PW=pW end else if o<354043+10213768 then o=Z[b[-826018+826028]]c=Z[b[811768+-811757]]K[o]=c o=Z[b[-298126-(-298138)]]c={o(K)}l={R(c)}o=M[G(893356-952210)]else i=-95256+95257 c=Z[b[92383+-92382]]O=-613272-(-613274)z=c(i,O)c=-575080+575081 K=z==c l=K o=K and 15522733-(-223169)or 8911931-824779 end end else if o<10399771-(-775624)then if o<1043048+9914539 then f=-363603+363604 Q=B[f]o=471389+147098 D=Q else E=G(326229-385078)Y=-476770+16851268510984 o=O O=r()Z[O]=z T=M[E]h=Z[O]E=T(h)h=Z[c]F=G(614500-673406)m=Z[i]J=m(F,Y)T=h[J]z=E~=T o=z and 11220010-(-769151)or-481880+8233025 end else if o<804625+10630380 then N=not j V=V+H u=V<=A u=N and u N=V>=A N=j and N u=N or u N=902076+15220647 o=u and N u=7218627-76848 o=o or u else Y=a(Y)PW=nil GW=a(GW)m=a(m)T=nil t=a(t)n=a(n)O=a(O)g=a(g)E=a(E)l={}V=a(V)h=a(h)i=a(i)N=a(N)A=a(A)RW=nil SW=nil J=a(J)oW=a(oW)f=a(f)pW=nil B=a(B)X=a(X)U=a(U)d=a(d)C=a(C)k=a(k)c=a(c)MW=a(MW)o=M[G(1035121+-1093967)]L=a(L)e=a(e)u=a(u)H=a(H)F=nil end end end else if o<11937452-(-21479)then if o<10858633-(-977139)then if o<304360+11401734 then o=nil l={o}o=M[G(762457-821304)]else T=515471-515456 O=#z i=O<=T l=i o=3470703-768726 end else if o<12005646-99239 then A=-946383+946383 V=#C u=V==A o=u and 6451858-571643 or-1000137+7460483 else o=Z[E]v=-455222+455223 A=771737-771731 w=o(v,A)A=G(-741462-(-682545))o=G(227668+-286585)M[o]=w v=M[A]A=1011842+-1011840 o=v>A o=o and 775145+12354824 or 13947157-(-370799)end end else if o<461790+11813050 then if o<518463+11492314 then T=G(-215782+156912)z=M[T]o=7044730-(-706415)Z[O]=z else l=-256476+256477 K=S[-820758-(-820759)]o={}c=o z=#K i=z z=-632149-(-632151)O=z z=-724140+724140 T=O<z o=452045+8786703 z=l-O end else o=8712649-(-529110)c=nil end end end end else if o<915054+14032157 then if o<14942773-649191 then if o<12482110-(-442908)then if o<-893248+13539094 then if o<11633336-(-989306)then C=G(-935701-(-876774))Y=M[C]C=G(-870986-(-812161))o=6980039-(-950203)F=Y[C]m=F else o=-938420+6477269 end else if o<-1006813+13716250 then n=653833+-653832 Q=o X=B[n]n=false f=X==n o=f and 15611107-(-945084)or 12117470-(-687214)D=f else o=Q l=D o=893673+1765065 end end else if o<930570+12272822 then if o<13575622-458996 then z=490057-489980 c=Z[b[614831-614828]]K=c*z o=57999-(-692445)c=-181067+181324 l=K%c Z[b[-603020-(-603023)]]=l else v=G(594188+-653108)o=M[v]H=G(1004759+-1063588)A=M[H]v=o(A)o=G(-497546+438629)M[o]=v o=757982+4804488 end else if o<13003136-(-662225)then o=736411+9544339 w=F==Y W=w else o=z Z[b[727631-727621]]=o o=1039228+14383457 end end end else if o<-730738+15459388 then if o<15362215-956410 then if o<13484245-(-849945)then A=G(-401617-(-342700))o=M[A]A=G(-628683-(-569854))M[A]=o o=-333080+5895550 else o=15169669-(-10145)end else if o<14901207-213205 then D=Z[c]o=D and 12704536-39556 or 2120742-(-537996)l=D else o=true o=1676029-(-244311)end end else if o<-91231+15008334 then if o<-683022+15536314 then o=true E=G(772715-831552)K=S c=r()Z[c]=o z=G(748226-807152)l=M[z]z=G(172677+-231569)o=l[z]z=r()i=r()Z[z]=o o=q(936332-(-802177),{})O=r()Z[i]=o o=false h=q(6898424-969780,{O})Z[O]=o T=M[E]E=T(h)l=E o=E and 1459064-921432 or 354347+597275 else i=G(-1082094-(-1023174))l=G(-205932-(-146980))o=M[l]h=G(-10312-48525)m=q(16544956-261422,{})K=Z[b[-463532+463536]]z=M[i]E=M[h]h={E(m)}T={R(h)}E=-63804-(-63806)O=T[E]i=z(O)z=G(347133+-406062)c=K(i,z)K={c()}l=o(R(K))K=l c=Z[b[-561139-(-561144)]]l=c o=c and 405364-(-434149)or 280567-(-525300)end else rW=SW(RW)pW=rW o=10684575-326729 end end end else if o<-493499+16382042 then if o<16227969-933762 then if o<-715232+15851471 then if o<-884010+15923685 then o=Z[b[946545-946544]]z=o K=S[-863369+863370]c=S[-595429-(-595431)]o=z[c]o=o and 8951060-(-671362)or 1115588-(-507068)else o=Z[b[-318913-(-318914)]]K=Z[b[677458-677456]]l=o(K)o=M[G(-304812+245932)]l={}end else if o<121550+15095119 then o=true o=o and 11890917-(-32451)or 6577208-(-951735)else C=G(642456-701293)m=r()F=-449984+450049 v=G(10467+-69387)Z[m]=l o=Z[E]J=-355414-(-355417)l=o(J,F)J=r()u=s(3433114-646029,{})Z[J]=l o=-616035-(-616035)l=M[C]F=o o=-54264-(-54264)Y=o C={l(u)}o={R(C)}l=-415811+415813 C=o o=C[l]u=o l=G(-800904+741952)o=M[l]V=Z[z]w=M[v]v=w(u)w=G(892177-951106)W=V(v,w)V={W()}l=o(R(V))V=r()Z[V]=l W=Z[J]l=-868106+868107 w=W W=752615+-752614 v=W W=-89995-(-89995)A=v<W W=l-v o=15496722-172608 end end else if o<16300583-851805 then if o<-741407+16076590 then W=W+v l=W<=w H=not A l=H and l H=W>=w H=A and H l=H or l H=-859613+16904598 o=l and H l=503615-334053 o=o or l else o=559844+5915317 z=nil end else if o<16404956-699555 then K=Z[b[-199853+199854]]z=Z[b[-299274+299276]]i=Z[b[-318505-(-318508)]]c=K(z,i)l=c o=c and 518408+4870156 or-292753+5759566 else o=l and-465706+15350800 or-384758+9532656 end end end else if o<15934996-(-180800)then if o<16258472-192425 then if o<-968760+16947540 then o=l and 9126665-(-6233)or 1042096+5433065 else H=r()Z[H]=W j=G(-492215-(-433308))l=M[j]j=G(-177835+118887)N=412351-412251 o=l[j]j=861908-861907 l=o(j,N)d=-385434+395434 N=-706695+706695 k=-865026-(-865027)j=r()U=-1045377+1045632 e=319598+-319598 Z[j]=l o=Z[E]B=-611606-(-611608)f=G(11504-70424)l=o(N,U)U=-734911-(-734912)N=r()Z[N]=l o=Z[E]t=Z[j]l=o(U,t)U=r()Z[U]=l l=Z[E]t=l(k,B)l=-301420+301421 o=t==l t=r()l=G(406166-465095)Z[t]=o Q=M[f]X=Z[E]B=G(649406+-708257)n={X(e,d)}f=Q(R(n))Q=G(916220+-975071)D=f..Q o=G(-692268-(-633364))k=B..D o=u[o]o=o(u,l,k)k=r()B=G(-689069-(-630232))Z[k]=o D=s(-517000+11105810,{E,H;J;z;c,V;t;k,j;U;N;m})l=M[B]B={l(D)}o={R(B)}B=o o=Z[t]o=o and 15139629-604277 or-323456+4663595 end else if o<-57776+16147289 then E=nil o=4595521-263099 i=nil T=nil else o={}K=o z=Z[b[-925859-(-925868)]]i=z c=-24828+24829 z=462962+-462961 O=z z=-317620+317620 T=O<z z=c-O o=-904022+2002518 end end else if o<-687707+17073243 then if o<-633825+16910630 then u=V o=10724567-(-649016)N=u C[u]=N u=nil else c=G(-995323+936380)z=1037010+486667 K=c^z l=-587815+11186763 o=l-K l=G(-1020712-(-961822))K=o o=l/K l={o}o=M[G(533791-592690)]end else o=12879486-74802 n=122773-122771 X=B[n]n=Z[k]f=X==n D=f end end end end end end end o=#P return R(l)end,function(M,G)local R=z(G)local S=function(S,b,P,p)return o(M,{S;b,P,p},G,R)end return S end,function(M)K[M]=K[M]-(-334381-(-334382))if-927435-(-927435)==K[M]then K[M],Z[M]=nil,nil end end,function(M)for G=-872472-(-872473),#M,698469+-698468 do K[M[G]]=(-203389-(-203390))+K[M[G]]end if S then local o=S(true)local R=P(o)R[G(-465791-(-406948))],R[G(-293312+234427)],R[G(1002040+-1060959)]=M,i,function()return-3503086-(-955978)end return o else return b({},{[G(-994654-(-935769))]=i,[G(-37377-21466)]=M,[G(-752353+693434)]=function()return 313991+-2861099 end})end end,function(M,G)local R=z(G)local S=function(S,b,P,p,l)return o(M,{S;b;P;p,l},G,R)end return S end return(O(13892867-(-862907),{}))(R(l))end)(getfenv and getfenv()or _ENV,unpack or table[G(367347-426172)],newproxy,setmetatable,getmetatable,select,{...})end)(...)

function Library:KeySystem(Settings)
    local Config = Settings or {}
    local Key = Config.Key
    if not Key or Key == "" then
        return
    end
    
    local LinkToCopy = tostring(Config.Link or "https://google.com")
    local SelectedTheme = GetTheme(Config.Theme)
    local Validated = false

    local ScreenGui = Create("ScreenGui", {
        Name = "KeyUI",
        ResetOnSpawn = false,
        DisplayOrder = 20000
    })
    
    if RS:IsStudio() then
        ScreenGui.Parent = LP:WaitForChild("PlayerGui")
    else
        pcall(function()
            ScreenGui.Parent = CG
        end)
        if not ScreenGui.Parent then
            ScreenGui.Parent = LP:WaitForChild("PlayerGui")
        end
    end

    local VP = workspace.CurrentCamera.ViewportSize
    local IsMobile = UIS.TouchEnabled and (VP.X < 850 or VP.Y < 600)
    local KeySizeX = IsMobile and math.min(VP.X - 40, 350) or 450
    local KeySizeY = IsMobile and math.min(VP.Y - 40, 220) or 260

    local KeyContainer = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 2
    })
    
    local Main = Create("Frame", {
        Parent = KeyContainer,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = 0.05,
        ClipsDescendants = true
    })
    AddCorner(Main, 12)
    AddStroke(Main, SelectedTheme)
    
    local Shadow1 = CreateDropShadow(KeyContainer, 80, 0.3)
    local Shadow2 = CreateDropShadow(KeyContainer, 30, 0.4)
    Shadow1.ImageTransparency = 1
    Shadow2.ImageTransparency = 1

    TS:Create(KeyContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(KeySizeX, KeySizeY)}):Play()
    TS:Create(Shadow1, TweenInfo.new(0.6), {ImageTransparency = 0.3}):Play()
    TS:Create(Shadow2, TweenInfo.new(0.6), {ImageTransparency = 0.4}):Play()
    
    local Content = Create("Frame", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 2
    })
    
    Create("TextLabel", {
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Text = Config.Title or "Security Access",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 24,
        ZIndex = 3
    })
    
    local InputBG = Create("ScrollingFrame", {
        Parent = Content,
        Size = UDim2.new(1, -60, 0, 48),
        Position = UDim2.new(0, 30, 0, 75),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.4,
        ZIndex = 3,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.X,
        AutomaticCanvasSize = Enum.AutomaticSize.X
    })
    AddCorner(InputBG, 8)
    
    Create("UIPadding", {
        Parent = InputBG,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    })
    
    local InputStroke = AddStroke(InputBG, SelectedTheme)
    InputStroke.Transparency = 0.8
    
    local Input = Create("TextBox", {
        Parent = InputBG,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "Enter License Key...",
        TextColor3 = SelectedTheme.Text,
        Font = Library.GlobalFont,
        TextSize = 15,
        ZIndex = 4,
        TextWrapped = false,
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    AttachHorizontalScroll(Input, InputBG, Enum.TextXAlignment.Left)

    Input.Focused:Connect(function()
        TS:Create(InputStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    end)
    Input.FocusLost:Connect(function()
        TS:Create(InputStroke, TweenInfo.new(0.3), {Transparency = 0.8}):Play()
    end)

    local CheckColor = Color3.new(SelectedTheme.Accent.R * 0.8, SelectedTheme.Accent.G * 0.8, SelectedTheme.Accent.B * 0.8)
    
    local CheckBtn = Create("TextButton", {
        Parent = Content,
        Size = UDim2.new(0.5, -40, 0, 42),
        Position = UDim2.new(0, 30, 0, 145),
        BackgroundColor3 = CheckColor,
        BackgroundTransparency = 0.1,
        Text = "Verify Key",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Main,
        TextSize = 14,
        ZIndex = 3
    })
    AddCorner(CheckBtn, 8)
    CreateRipple(CheckBtn, Color3.new(1, 1, 1))
    
    local GetKeyBtn = Create("TextButton", {
        Parent = Content,
        Size = UDim2.new(0.5, -40, 0, 42),
        Position = UDim2.new(0.5, 10, 0, 145),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.4,
        Text = "Get Key Link",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 14,
        ZIndex = 3
    })
    AddCorner(GetKeyBtn, 8)
    CreateRipple(GetKeyBtn, SelectedTheme.Accent)
    AddStroke(GetKeyBtn, SelectedTheme).Transparency = 0.7
    
    local Status = Create("TextLabel", {
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -35),
        BackgroundTransparency = 1,
        Text = "Protected System",
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 13,
        ZIndex = 3
    })

    local function BtnHover(btn, isAccent)
        local hoverTween, leaveTween
        btn.MouseEnter:Connect(function()
            if leaveTween then leaveTween:Cancel() end
            hoverTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = isAccent and 0 or 0.2})
            hoverTween:Play()
        end)
        btn.MouseLeave:Connect(function()
            if hoverTween then hoverTween:Cancel() end
            leaveTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = isAccent and 0.1 or 0.4})
            leaveTween:Play()
        end)
    end
    BtnHover(CheckBtn, true)
    BtnHover(GetKeyBtn, false)

    GetKeyBtn.MouseButton1Click:Connect(function() 
        local success, err = pcall(function()
            if setclipboard then
                setclipboard(LinkToCopy)
                return true
            elseif toclipboard then
                toclipboard(LinkToCopy)
                return true
            elseif syn and syn.write_clipboard then
                syn.write_clipboard(LinkToCopy)
                return true
            elseif Clipboard and Clipboard.set then
                Clipboard.set(LinkToCopy)
                return true
            end
            return false
        end)
        if success then
            Status.Text = "Link copied to clipboard!"
            Status.TextColor3 = SelectedTheme.Accent
        else
            Status.Text = "Check Console (F9)"
            Status.TextColor3 = SelectedTheme.Error
        end
        task.wait(2)
        Status.Text = "Protected System"
        Status.TextColor3 = SelectedTheme.TextDark
    end)

    CheckBtn.MouseButton1Click:Connect(function()
        if Input.Text == Key then 
            TS:Create(KeyContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)}):Play()
            TS:Create(Shadow1, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            task.wait(0.4)
            ScreenGui:Destroy()
            Validated = true
        else
            Status.Text = "Incorrect or Invalid Key!"
            Status.TextColor3 = SelectedTheme.Error
            InputStroke.Color = SelectedTheme.Error
            InputStroke.Transparency = 0
            
            local x = KeyContainer.Position.X.Scale
            local y = KeyContainer.Position.Y.Scale
            for i = 1, 5 do
                KeyContainer.Position = UDim2.fromScale(x + math.random(-1, 1) / 150, y)
                task.wait(0.04)
            end
            
            KeyContainer.Position = UDim2.fromScale(x, y)
            task.wait(1)
            
            InputStroke.Color = Color3.new(1, 1, 1)
            InputStroke.Transparency = 0.8
            Status.Text = "Protected System"
            Status.TextColor3 = SelectedTheme.TextDark
        end
    end)
    
    repeat
        task.wait()
    until Validated
end

function Library:CreateWindow(Settings)
    local Config = Settings or {}
    local Title = Config.Title or "UI"
    local SelectedTheme = GetTheme(Config.Theme)
    
    Library.GlobalCornerValue = Config.CornerRadius or SelectedTheme.CornerRadius or 10

    Library.ConfigFolder = Config.ConfigFolder or "SolarisUI-Configs"
    if not isfolder(Library.ConfigFolder) then makefolder(Library.ConfigFolder) end
    if not isfolder(Library.ThemeFolder) then makefolder(Library.ThemeFolder) end

    Themes.Default.Main = SelectedTheme.Main
    Themes.Default.Second = SelectedTheme.Second
    Themes.Default.Accent = SelectedTheme.Accent
    Themes.Default.ElementAccent = SelectedTheme.ElementAccent
    Themes.Default.Text = SelectedTheme.Text
    Themes.Default.TextDark = SelectedTheme.TextDark
    Themes.Default.Error = SelectedTheme.Error
    Themes.Default.GradientStart = SelectedTheme.GradientStart
    Themes.Default.GradientEnd = SelectedTheme.GradientEnd
    Themes.Default.Gradient = SelectedTheme.Gradient

    if SelectedTheme.Font then
        UpdateFonts(SelectedTheme.Font)
    end

    Library.ToggleKey = Config.ToggleKey or Enum.KeyCode.RightControl
    local WindowTrans = SelectedTheme.Transparency or Config.Transparency or 0.25 
    local ImageTrans = SelectedTheme.ImageTransparency or 0
    
    local WatermarkConfig = { Enabled = true, Title = true, User = true, FPS = true, Time = true, Ping = true }
    if type(Config.ShowWatermark) == "table" then
        for k, v in pairs(Config.ShowWatermark) do
            WatermarkConfig[k] = v
        end
    elseif Config.ShowWatermark == false then
        WatermarkConfig.Enabled = false
    end

    local CustomIconID = Config.CustomIcon

    local ScreenGui = Create("ScreenGui", {
        Name = "MainUI",
        ResetOnSpawn = false,
        DisplayOrder = 10000
    })
    
    if RS:IsStudio() then
        ScreenGui.Parent = LP:WaitForChild("PlayerGui")
    else
        pcall(function()
            ScreenGui.Parent = CG
        end)
        if not ScreenGui.Parent then
            ScreenGui.Parent = LP:WaitForChild("PlayerGui")
        end
    end

    function Library:GetThemes()
        local list = {}
        if isfolder(Library.ThemeFolder) then
            for _, file in pairs(listfiles(Library.ThemeFolder)) do
                if file:sub(-5) == ".json" then
                    table.insert(list, (file:match("([^/]+)%.json$") or file))
                end
            end
        end
        return list
    end
    
    function Library:GetConfigs()
        local list = {}
        if isfolder(Library.ConfigFolder) then
            for _, file in pairs(listfiles(Library.ConfigFolder)) do
                if file:sub(-5) == ".json" then
                    local success, decoded = pcall(function()
                        return HS:JSONDecode(readfile(file))
                    end)
                    if success and type(decoded) == "table" and decoded["Settings_Identifier"] == Title then
                        table.insert(list, file:match("([^/]+)%.json$") or file)
                    end
                end
            end
        end
        return list
    end

    function Library:SaveConfig(Name)
        local ConfigToSave = {}
        for flag, value in pairs(Library.Flags) do
            if string.sub(flag, 1, 9) ~= "Settings_" then
                ConfigToSave[flag] = value
            end
        end
        ConfigToSave["Settings_Identifier"] = Title
        
        local success, json = pcall(function() return HS:JSONEncode(ConfigToSave) end)
        if success then
            local path = Library.ConfigFolder .. "/" .. Name .. ".json"
            writefile(path, json)
            Library:Notify({Title = "Config Saved", Content = "Successfully saved " .. Name, Duration = 3})
        else
            Library:Notify({Title = "Save Error", Content = "Failed to encode config data", Duration = 3})
        end
    end

    function Library:LoadConfig(Name)
        local path = Library.ConfigFolder .. "/" .. Name .. ".json"
        if isfile(path) then
            local success, err = pcall(function()
                local json = readfile(path)
                local data = HS:JSONDecode(json)
                for flag, value in pairs(data) do
                    if Library.Items[flag] then
                        task.spawn(function()
                            Library.Items[flag].Set(value)
                        end)
                    end
                end
            end)
            if success then
                Library:Notify({Title = "Config Loaded", Content = "Successfully loaded " .. Name, Duration = 3})
            else
                Library:Notify({Title = "Config Error", Content = "Corrupted JSON file", Duration = 3})
            end
        end
    end

    function Library:DeleteConfig(Name)
        local path = Library.ConfigFolder .. "/" .. Name .. ".json"
        if isfile(path) then
            delfile(path)
            Library:Notify({Title = "Config Deleted", Content = "Deleted " .. Name, Duration = 3})
        end
    end

    if WatermarkConfig.Enabled then
        local WatermarkContainer = Create("Frame", {
            Name = "WatermarkContainer",
            Parent = ScreenGui,
            Size = UDim2.new(0, 0, 0, 30),
            Position = UDim2.new(0.5, 0, -0.1, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            ZIndex = 5000
        })

        TS:Create(WatermarkContainer, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0, 20)}):Play()

        local ItemsContainer = Create("Frame", {
            Parent = WatermarkContainer,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = 5000
        })

        local WatermarkLayout = Create("UIListLayout", {
            Parent = ItemsContainer,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        WatermarkLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            WatermarkContainer.Size = UDim2.new(0, WatermarkLayout.AbsoluteContentSize.X, 0, 30)
        end)

        local WmDragBtn = Create("TextButton", {
            Parent = WatermarkContainer,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 5005
        })
        MakeDraggable(WmDragBtn, WatermarkContainer)

        local function CreateHudItem(order, iconId, textFunc)
            local Island = Create("Frame", {
                Parent = ItemsContainer,
                BackgroundColor3 = SelectedTheme.Main,
                BackgroundTransparency = SelectedTheme.HudTransparency or 0.5,
                Size = UDim2.new(0, 100, 1, 0),
                LayoutOrder = order,
                ZIndex = 5001,
                ThemeTag = "Main"
            })
            AddCorner(Island, 6)
            local stroke = AddStroke(Island, SelectedTheme)
            stroke.Transparency = 0.5
            table.insert(Library.WatermarkIslands, Island)

            local Inner = Create("Frame", {
                Parent = Island,
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1
            })

            local Icon = Create("ImageLabel", {
                Parent = Inner,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 8, 0.5, -8),
                BackgroundTransparency = 1,
                ImageColor3 = SelectedTheme.Accent,
                ZIndex = 5002,
                ThemeTag = "Accent"
            })
            SetImageAsync(Icon, "Image", iconId)

            local Label = Create("TextLabel", {
                Parent = Inner,
                Size = UDim2.new(1, -32, 1, 0),
                Position = UDim2.new(0, 30, 0, 0),
                BackgroundTransparency = 1,
                Font = Library.GlobalFontBold,
                TextSize = 13,
                TextColor3 = SelectedTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = textFunc(),
                ZIndex = 5002,
                ThemeTag = "Text"
            })

            local function UpdateSize()
                local bounds = TxtS:GetTextSize(Label.Text, 13, Library.GlobalFontBold, Vector2.new(9999, 30))
                Island.Size = UDim2.new(0, bounds.X + 40, 1, 0)
            end

            Label:GetPropertyChangedSignal("Text"):Connect(UpdateSize)
            Label:GetPropertyChangedSignal("Font"):Connect(UpdateSize)
            UpdateSize()

            task.spawn(function()
                while Island.Parent do
                    local txt = textFunc()
                    if Label.Text ~= txt then
                        Label.Text = txt
                    end
                    task.wait(1)
                end
            end)
        end

        local Order = 1
        local titleIcon = (CustomIconID and CustomIconID ~= "") and CustomIconID or "rbxassetid://10884488899"
        
        if WatermarkConfig.Title then
            CreateHudItem(Order, titleIcon, function() return Title end)
            Order = Order + 1
        end
        if WatermarkConfig.User then
            CreateHudItem(Order, "rbxassetid://10884490076", function() return LP.DisplayName end)
            Order = Order + 1
        end
        if WatermarkConfig.FPS then
            CreateHudItem(Order, "rbxassetid://10884494953", function() return CurrentFPS .. " FPS" end)
            Order = Order + 1
        end
        if WatermarkConfig.Time then
            CreateHudItem(Order, "rbxassetid://10884491769", function() return os.date("%H:%M:%S") end)
            Order = Order + 1
        end
        if WatermarkConfig.Ping then
            CreateHudItem(Order, "rbxassetid://10884496263", function() 
                if DataPing then
                    return math.floor(DataPing:GetValue()) .. " ms"
                end
                return "0 ms"
            end)
            Order = Order + 1
        end
    end

    local NotifContainer = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 320, 1, -20),
        Position = UDim2.new(1, -340, 0, 50),
        BackgroundTransparency = 1,
        ZIndex = 10000
    })
    
    Create("UIListLayout", {
        Parent = NotifContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 12)
    })

    function Library:Notify(Config)
        local Title = Config.Title or "Notification"
        local Content = Config.Content or "Message"
        local Duration = Config.Duration or 3
        
        if #Title > 30 then
            Title = string.sub(Title, 1, 27) .. "..."
        end
        
        local ImageUrl = Config.ImageID or "rbxassetid://3944703587"

        local ContentSize = TxtS:GetTextSize(Content, 13, Library.GlobalFont, Vector2.new(230, 1000))
        local TotalHeight = math.max(70, 55 + ContentSize.Y)

        local NotifHolder = Create("Frame", {
            Parent = NotifContainer,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = false 
        })
        
        local Frame = Create("Frame", {
            Parent = NotifHolder,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 1,
            ZIndex = 10001,
            ClipsDescendants = true,
            ThemeTag = "Main"
        })
        AddCorner(Frame, 10)
        
        local Stroke = AddStroke(Frame, SelectedTheme)
        Stroke.Transparency = 1 

        local Shadow = CreateDropShadow(NotifHolder, 45, 0)
        Shadow.ImageTransparency = 1
        
        local Icon = Create("ImageLabel", {
            Parent = Frame,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 31, 0, 31),
            BackgroundTransparency = 1,
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ZIndex = 10002,
            ImageTransparency = 1,
            Rotation = -15
        })
        SetImageAsync(Icon, "Image", ImageUrl)
        
        local TitleLabel = Create("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -64, 0, 20),
            Position = UDim2.new(0, 60, 0, 12),
            BackgroundTransparency = 1,
            Text = Title,
            Font = Library.GlobalFontBold,
            TextColor3 = SelectedTheme.Text,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 10002,
            TextTransparency = 1,
            ThemeTag = "Text"
        })
        
        local ContentLabel = Create("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -64, 1, -34),
            Position = UDim2.new(0, 60, 0, 34),
            BackgroundTransparency = 1,
            Text = Content,
            Font = Library.GlobalFont,
            TextColor3 = SelectedTheme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 10002,
            TextWrapped = true,
            TextTransparency = 1,
            ThemeTag = "TextDark"
        })

        local BarBg = Create("Frame", {
            Parent = Frame,
            Size = UDim2.new(1, -28, 0, 3),
            Position = UDim2.new(0, 14, 1, -8),
            BackgroundColor3 = SelectedTheme.Second,
            BorderSizePixel = 0,
            ZIndex = 10002,
            BackgroundTransparency = 1,
            ThemeTag = "Second"
        })
        AddCorner(BarBg, 3)
        
        local Bar = Create("Frame", {
            Parent = BarBg,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = SelectedTheme.ElementAccent,
            BorderSizePixel = 0,
            ZIndex = 10003,
            BackgroundTransparency = 1,
            ThemeTag = "ElementAccent"
        })
        AddCorner(Bar, 3)
        
        local InInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local LinearInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        TS:Create(NotifHolder, InInfo, {Size = UDim2.new(1, 0, 0, TotalHeight)}):Play()
        TS:Create(Frame, LinearInfo, {BackgroundTransparency = SelectedTheme.HudTransparency or 0.5}):Play()
        TS:Create(Stroke, LinearInfo, {Transparency = 0.4}):Play()
        TS:Create(Shadow, LinearInfo, {ImageTransparency = 0.35}):Play()
        TS:Create(Icon, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 38, 0, 38), Position = UDim2.new(0, 12, 0, 12), ImageTransparency = 0, Rotation = 0}):Play()
        TS:Create(TitleLabel, LinearInfo, {TextTransparency = 0}):Play()
        TS:Create(ContentLabel, LinearInfo, {TextTransparency = 0}):Play()
        TS:Create(BarBg, LinearInfo, {BackgroundTransparency = 0.5}):Play()
        TS:Create(Bar, LinearInfo, {BackgroundTransparency = 0}):Play()
        
        local TimerTween = TS:Create(Bar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
        TimerTween:Play()
        
        TimerTween.Completed:Connect(function()
            local OutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            TS:Create(NotifHolder, OutInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TS:Create(Frame, OutInfo, {BackgroundTransparency = 1}):Play()
            TS:Create(Stroke, OutInfo, {Transparency = 1}):Play()
            TS:Create(Shadow, OutInfo, {ImageTransparency = 1}):Play()
            TS:Create(Icon, OutInfo, {ImageTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0, 31, 0, 31)}):Play()
            TS:Create(TitleLabel, OutInfo, {TextTransparency = 1}):Play()
            TS:Create(ContentLabel, OutInfo, {TextTransparency = 1}):Play()
            TS:Create(BarBg, OutInfo, {BackgroundTransparency = 1}):Play()
            TS:Create(Bar, OutInfo, {BackgroundTransparency = 1}):Play()
            task.delay(0.5, function()
                NotifHolder:Destroy()
            end)
        end)
    end

    local VP = workspace.CurrentCamera.ViewportSize
    local IsMobile = UIS.TouchEnabled and (VP.X < 850 or VP.Y < 600)
    local WindowSizeX = IsMobile and math.clamp(VP.X - 40, 300, 480) or 780
    local WindowSizeY = IsMobile and math.clamp(VP.Y - 40, 200, 320) or 540
    local WindowSize = UDim2.fromOffset(WindowSizeX, WindowSizeY)

    local WindowContainer = Create("Frame", {
        Name = "WindowContainer",
        Parent = ScreenGui,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    local Main = Create("Frame", {
        Name = "Main",
        Parent = WindowContainer,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 2
    })
    
    local Shadow1 = CreateDropShadow(WindowContainer, 120, 0.35)
    local Shadow2 = CreateDropShadow(WindowContainer, 35, 0.4) 
    Shadow1.ImageTransparency = 1
    Shadow2.ImageTransparency = 1

    local MainBgImage = Create("ImageLabel", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ImageTransparency = ImageTrans,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = 1
    })
    SetImageAsync(MainBgImage, "Image", SelectedTheme.Background)
    AddCorner(MainBgImage, 12)
    
    local MainBgColor = Create("Frame", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = WindowTrans,
        ZIndex = 2,
        ThemeTag = "Main"
    })
    AddCorner(MainBgColor, 12)

    AddCorner(Main, 12)
    AddStroke(Main, SelectedTheme)
    
    TS:Create(WindowContainer, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = WindowSize}):Play()
    TS:Create(Shadow1, TweenInfo.new(0.7), {ImageTransparency = 0.35}):Play()
    TS:Create(Shadow2, TweenInfo.new(0.7), {ImageTransparency = 0.4}):Play()

    local ResizeBtn = Create("TextButton", {
        Parent = Main,
        Size = UDim2.fromOffset(25, 25),
        Position = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Text = "◢",
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 10,
        ZIndex = 2000,
        ThemeTag = "TextDark"
    })
    MakeResizable(ResizeBtn, WindowContainer)

    local TopBar = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundTransparency = 1,
        ZIndex = 5
    })
    MakeDraggable(TopBar, WindowContainer)
    
    Create("Frame", {
        Parent = TopBar,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = SelectedTheme.TextDark,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        ZIndex = 6,
        ThemeTag = "TextDark"
    })
    
    local TitleOffsetX = 18
    if CustomIconID and CustomIconID ~= "" then
        TitleOffsetX = 48
        local TopIcon = Create("ImageLabel", {
            Parent = TopBar,
            Size = UDim2.new(0, 26, 0, 26),
            Position = UDim2.new(0, 16, 0.5, -13),
            BackgroundTransparency = 1,
            ZIndex = 6
        })
        SetImageAsync(TopIcon, "Image", CustomIconID)
    end

    Create("TextLabel", {
        Parent = TopBar,
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, TitleOffsetX, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    
    local Close = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(0, 45, 1, 0),
        Position = UDim2.new(1, -45, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 6
    })
    
    local Cross1 = Create("Frame", {
        Parent = Close,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 2),
        BackgroundColor3 = SelectedTheme.Text,
        Rotation = 45,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    AddCorner(Cross1, 2)
    
    local Cross2 = Create("Frame", {
        Parent = Close,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 2),
        BackgroundColor3 = SelectedTheme.Text,
        Rotation = -45,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    AddCorner(Cross2, 2)
    
    Close.MouseEnter:Connect(function() 
        TS:Create(Cross1, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Error}):Play() 
        TS:Create(Cross2, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Error}):Play() 
    end)
    Close.MouseLeave:Connect(function() 
        TS:Create(Cross1, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Text}):Play() 
        TS:Create(Cross2, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Text}):Play() 
    end)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TabContainer = Create("ScrollingFrame", {
        Parent = Main,
        Size = UDim2.new(0, 165, 1, -123),
        Position = UDim2.new(0, 15, 0, 60),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.5,
        ScrollBarThickness = 0,
        BorderSizePixel = 0,
        ZIndex = 5,
        ThemeTag = "Second"
    })
    AddCorner(TabContainer, 8)

    local TabContainerStroke = AddStroke(TabContainer, SelectedTheme)
    TabContainerStroke.Transparency = 0.8
    Create("UIListLayout", {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
    Create("UIPadding", {
        Parent = TabContainer,
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6)
    })

    local ProfileFrame = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(0, 165, 0, 40),
        Position = UDim2.new(0, 15, 1, -55),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 5,
        ThemeTag = "Second"
    })
    AddCorner(ProfileFrame, 8)
    AddStroke(ProfileFrame, SelectedTheme).Transparency = 0.8

    local AvatarImg = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    pcall(function()
        AvatarImg = Plrs:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    end)
    
    local Avatar = Create("ImageLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, 6, 0.5, -14),
        BackgroundTransparency = 1,
        Image = AvatarImg,
        ZIndex = 6
    })
    AddCorner(Avatar, 100)
    
    Create("TextLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(1, -45, 0, 16),
        Position = UDim2.new(0, 40, 0, 5),
        BackgroundTransparency = 1,
        Text = LP.DisplayName,
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ThemeTag = "Text"
    })
    Create("TextLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(1, -45, 0, 14),
        Position = UDim2.new(0, 40, 0, 20),
        BackgroundTransparency = 1,
        Text = "@" .. LP.Name,
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ThemeTag = "TextDark"
    })

    local PageContainer = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, -210, 1, -75),
        Position = UDim2.new(0, 195, 0, 60),
        BackgroundTransparency = 1,
        ZIndex = 5,
        ClipsDescendants = true
    })

    local IsOpen, LastSize = true, WindowSize
    
    local function ToggleUI()
        IsOpen = not IsOpen 
        if IsOpen then 
            WindowContainer.Visible = true 
            TS:Create(WindowContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = LastSize}):Play() 
            TS:Create(Shadow1, TweenInfo.new(0.6), {ImageTransparency = 0.35}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.6), {ImageTransparency = 0.4}):Play()
        else 
            LastSize = WindowContainer.Size 
            local close = TS:Create(WindowContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            close:Play() 
            TS:Create(Shadow1, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
            close.Completed:Connect(function()
                if not IsOpen then
                    WindowContainer.Visible = false
                end
            end) 
        end
    end

    if UIS.TouchEnabled then
        local MobileBtn = Create("ImageButton", {
            Name = "MobileToggle",
            Parent = ScreenGui,
            Size = UDim2.fromOffset(50, 50),
            Position = UDim2.new(0.9, 0, 0.5, 0),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            Image = "rbxassetid://10884488899",
            ImageColor3 = SelectedTheme.Accent,
            ThemeTag = "Main"
        })
        AddCorner(MobileBtn, 14)
        AddStroke(MobileBtn, SelectedTheme)
        MakeDraggable(MobileBtn, MobileBtn)
        CreateDropShadow(MobileBtn, 35, 0.3)
        table.insert(Library.ThemeObjects.Accent, MobileBtn)
        
        MobileBtn.MouseButton1Click:Connect(ToggleUI)
    end

    UIS.InputBegan:Connect(function(input, gpe)
        if gpe or UIS:GetFocusedTextBox() then
            return
        end
        
        local currentToggle = Library.ToggleKey
        if Library.Flags["Settings_ToggleKey"] then
            local s, k = pcall(function() return Enum.KeyCode[Library.Flags["Settings_ToggleKey"]] end)
            if s and k then
                currentToggle = k
            end
        end

        if input.KeyCode == currentToggle then 
            ToggleUI()
        end
    end)
    
    local TabCount = 0
    local ActiveTab = nil
    local Funcs = {}

    function Funcs:CreateTab(TabName, Two_Column, ImageID)
        TabCount = TabCount + 1
        local MyIndex = TabCount
        local Tab = {}
        
        local HasIcon = (ImageID ~= nil and ImageID ~= "")
        
        local isSettings = (TabName == "UI Settings")
        local TabBtn = Create("TextButton", {
            Name = "TabBtn",
            Parent = TabContainer,
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 6,
            LayoutOrder = isSettings and 99999 or MyIndex,
            ThemeTag = "Main"
        })
        AddCorner(TabBtn, 6)

        local TabLabel
        local ActiveLine
        local TabIcon

        if HasIcon then
            TabLabel = Create("TextLabel", {
                Name = "TabLabel",
                Parent = TabBtn,
                Size = UDim2.new(1, -44, 1, 0),
                Position = UDim2.new(0, 38, 0, 0),
                BackgroundTransparency = 1,
                Text = TabName,
                Font = Library.GlobalFontBold,
                TextColor3 = SelectedTheme.TextDark,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            TabIcon = Create("ImageLabel", {
                Name = "TabIcon",
                Parent = TabBtn,
                Size = UDim2.new(0, 22, 0, 22),
                Position = UDim2.new(0, 10, 0.5, -11),
                BackgroundTransparency = 1,
                ImageColor3 = SelectedTheme.TextDark,
                ZIndex = 7
            })
            SetImageAsync(TabIcon, "Image", ImageID)
            table.insert(Library.ThemeObjects.TabLabels, {Label = TabLabel, Btn = TabBtn, Icon = TabIcon})
        else
            TabLabel = Create("TextLabel", {
                Name = "TabLabel",
                Parent = TabBtn,
                Size = UDim2.new(1, -25, 1, 0),
                Position = UDim2.new(0, 20, 0, 0),
                BackgroundTransparency = 1,
                Text = TabName,
                Font = Library.GlobalFontBold,
                TextColor3 = SelectedTheme.TextDark,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            ActiveLine = Create("Frame", {
                Name = "ActiveLine",
                Parent = TabBtn,
                Size = UDim2.new(0, 3, 0, 0),
                Position = UDim2.new(0, 6, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = SelectedTheme.ElementAccent,
                BorderSizePixel = 0,
                ZIndex = 7,
                ThemeTag = "ElementAccent"
            })
            AddCorner(ActiveLine, 4)
            table.insert(Library.ThemeObjects.TabLabels, {Label = TabLabel, Btn = TabBtn})
        end

        local hoverTweenTab, leaveTweenTab
        TabBtn.MouseEnter:Connect(function()
            if ActiveTab and ActiveTab.Btn ~= TabBtn then
                if leaveTweenTab then leaveTweenTab:Cancel() end
                hoverTweenTab = TS:Create(TabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
                hoverTweenTab:Play()
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if ActiveTab and ActiveTab.Btn ~= TabBtn then
                if hoverTweenTab then hoverTweenTab:Cancel() end
                leaveTweenTab = TS:Create(TabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                leaveTweenTab:Play()
            end
        end)

        local Page = Create("ScrollingFrame", {
            Parent = PageContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = SelectedTheme.TextDark,
            BorderSizePixel = 0,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ZIndex = 6
        })
        
        local LeftCol, RightCol
        if Two_Column then
            local ColumnsHolder = Create("Frame", {
                Parent = Page,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            })
            
            Create("UIListLayout", {
                Parent = ColumnsHolder,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            Create("UIPadding", {
                Parent = ColumnsHolder,
                PaddingTop = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 15)
            })
            
            LeftCol = Create("Frame", {
                Parent = ColumnsHolder,
                Size = UDim2.new(0.5, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
            
            local LeftLayout = Create("UIListLayout", {
                Parent = LeftCol,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            RightCol = Create("Frame", {
                Parent = ColumnsHolder,
                Size = UDim2.new(0.5, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2
            })
            
            local RightLayout = Create("UIListLayout", {
                Parent = RightCol,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            local function UpdateCanvasSize()
                local maxH = math.max(LeftLayout.AbsoluteContentSize.Y, RightLayout.AbsoluteContentSize.Y)
                Page.CanvasSize = UDim2.new(0, 0, 0, maxH + 30)
            end
            
            LeftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
            RightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
        else
            local Layout = Create("UIListLayout", {
                Parent = Page,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
            
            Create("UIPadding", {
                Parent = Page,
                PaddingTop = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 15)
            })
            
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 30)
            end)
        end

        local function Activate()
            if ActiveTab and ActiveTab.Btn == TabBtn then
                return
            end
            
            local OldTab = ActiveTab
            local Direction = (OldTab and MyIndex > OldTab.Index) and "Down" or "Up"
            ActiveTab = {Btn = TabBtn, Page = Page, Index = MyIndex}
            
            for _, v in pairs(TabContainer:GetChildren()) do 
                if v:IsA("TextButton") then 
                    TS:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    local lbl = v:FindFirstChild("TabLabel")
                    local line = v:FindFirstChild("ActiveLine")
                    local icon = v:FindFirstChild("TabIcon")
                    
                    if lbl then
                        local isIconTab = icon ~= nil
                        TS:Create(lbl, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.TextDark, Position = UDim2.new(0, isIconTab and 38 or 20, 0, 0)}):Play()
                    end
                    if line then
                        TS:Create(line, TweenInfo.new(0.3), {Size = UDim2.new(0, 3, 0, 0)}):Play()
                    end
                    if icon then
                        TS:Create(icon, TweenInfo.new(0.3), {ImageColor3 = SelectedTheme.TextDark}):Play()
                    end
                end 
            end

            TS:Create(TabBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
            TS:Create(TabLabel, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.Text, Position = UDim2.new(0, HasIcon and 42 or 24, 0, 0)}):Play()
            
            if ActiveLine then
                TS:Create(ActiveLine, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 3, 0, 18)}):Play()
            end
            if TabIcon then
                TS:Create(TabIcon, TweenInfo.new(0.3), {ImageColor3 = SelectedTheme.ElementAccent}):Play()
            end

            if OldTab then
                local OldPage = OldTab.Page
                local OutPos = (Direction == "Down") and UDim2.new(0, 0, -1, 0) or UDim2.new(0, 0, 1, 0)
                TS:Create(OldPage, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = OutPos}):Play()
                task.delay(0.4, function()
                    if ActiveTab.Page ~= OldPage then
                        OldPage.Visible = false
                    end
                end)
            end
            
            Page.Visible = true
            Page.Position = (Direction == "Down") and UDim2.new(0, 0, 1, 0) or (Direction == "Up" and UDim2.new(0, 0, -1, 0) or UDim2.new(0, 0, 0, 0))
            if Direction ~= "None" then
                TS:Create(Page, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            end
        end
        
        TabBtn.MouseButton1Click:Connect(Activate)
        
        if MyIndex == 1 then
            Activate()
        end

        local function GetElements(TargetParent)
            local Elements = {}
            local ElementOrder = 0

            local function DefaultHover(btn)
                local hoverTween, leaveTween
                btn.MouseEnter:Connect(function()
                    if leaveTween then leaveTween:Cancel() end
                    hoverTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3})
                    hoverTween:Play()
                end)
                btn.MouseLeave:Connect(function()
                    if hoverTween then hoverTween:Cancel() end
                    leaveTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
                    leaveTween:Play()
                end)
            end

            function Elements:CreateSection(Text)
                ElementOrder = ElementOrder + 1
                local Lab = Create("TextLabel", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = Text,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = ElementOrder,
                    ZIndex = 8,
                    ThemeTag = "Text"
                })
                Create("UIPadding", { Parent = Lab, PaddingLeft = UDim.new(0, 6) })
            end

            function Elements:CreateButton(Cfg)
                ElementOrder = ElementOrder + 1
                local Btn = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Btn, 8)
                AddStroke(Btn, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Btn,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name or "Button",
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                CreateRipple(Btn, SelectedTheme.Accent)
                DefaultHover(Btn)
                
                Btn.MouseButton1Click:Connect(function()
                    TS:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 30), Position = UDim2.new(0, 2, 0, 2)}):Play()
                    task.wait(0.1)
                    TS:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 34), Position = UDim2.new(0, 0, 0, 0)}):Play()
                    if Cfg.Callback then
                        Cfg.Callback()
                    end
                end)
            end

            function Elements:CreateToggle(Cfg)
                ElementOrder = ElementOrder + 1
                local State = false
                local Flag = Cfg.Flag or Cfg.Name
                local Btn = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Btn, 8)
                AddStroke(Btn, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Btn,
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name or "Toggle",
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                DefaultHover(Btn)
                
                local Box = Create("Frame", {
                    Parent = Btn,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -32, 0.5, -10),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 8
                })
                AddCorner(Box, 4)
                
                local BoxStroke = Create("UIStroke", {
                    Parent = Box, 
                    Color = SelectedTheme.TextDark, 
                    Transparency = 0.8, 
                    Thickness = 1
                })
                
                local InnerSquare = Create("Frame", {
                    Parent = Box,
                    Size = UDim2.fromScale(0, 0),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = SelectedTheme.TextDark,
                    BackgroundTransparency = 1,
                    ZIndex = 9
                })
                AddCorner(InnerSquare, 2)

                table.insert(Library.ThemeObjects.Toggles, {Box = Box, Stroke = BoxStroke, Square = InnerSquare, State = function() return State end})
                
                local function UpdateState(val)
                    State = val
                    Library.Flags[Flag] = val
                    
                    TS:Create(BoxStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Color = State and SelectedTheme.ElementAccent or SelectedTheme.TextDark,
                        Transparency = State and 0 or 0.8
                    }):Play()
                    
                    TS:Create(InnerSquare, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        BackgroundColor3 = State and SelectedTheme.ElementAccent or SelectedTheme.TextDark,
                        Size = State and UDim2.fromScale(0.6, 0.6) or UDim2.fromScale(0, 0),
                        BackgroundTransparency = State and 0 or 1
                    }):Play()
                    
                    if Cfg.Callback then
                        Cfg.Callback(State)
                    end
                end
                
                if Cfg.Default then
                    UpdateState(Cfg.Default)
                else
                    Library.Flags[Flag] = false
                end

                Btn.MouseButton1Click:Connect(function()
                    UpdateState(not State)
                end)
                
                Library.Items[Flag] = {
                    Set = function(val)
                        if val == nil then return end
                        if State == val then return end
                        UpdateState(val)
                    end
                }
            end

            function Elements:CreateSlider(Cfg)
                ElementOrder = ElementOrder + 1
                local Min = Cfg.Min or 0
                local Max = Cfg.Max or 100
                local Val = Cfg.Default or Cfg.Min
                local Flag = Cfg.Flag or Cfg.Name
                Library.Flags[Flag] = Val
                
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -70, 0, 24),
                    Position = UDim2.new(0, 12, 0, 2),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local ValBg = Create("ScrollingFrame", {
                    Parent = Frame,
                    Size = UDim2.new(0, 36, 0, 20),
                    Position = UDim2.new(1, -48, 0, 4),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 8,
                    ClipsDescendants = true,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    AutomaticCanvasSize = Enum.AutomaticSize.X
                })
                AddCorner(ValBg, 4)
                Create("UIPadding", { Parent = ValBg, PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) })

                local ValLbl = Create("TextBox", {
                    Parent = ValBg,
                    Size = UDim2.new(1, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Text = tostring(Val),
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 9,
                    ThemeTag = "Text",
                    TextWrapped = false,
                    ClearTextOnFocus = false
                })
                AttachHorizontalScroll(ValLbl, ValBg, Enum.TextXAlignment.Center)

                local SlideBar = Create("TextButton", {
                    Parent = Frame,
                    Size = UDim2.new(1, -24, 0, 6),
                    Position = UDim2.new(0, 12, 0, 28),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 45),
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 8
                })
                AddCorner(SlideBar, 10)
                
                local Fill = Create("Frame", {
                    Parent = SlideBar,
                    Size = UDim2.new((Val - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = SelectedTheme.ElementAccent,
                    BorderSizePixel = 0,
                    ZIndex = 9,
                    ThemeTag = "ElementAccent"
                })
                AddCorner(Fill, 10)
                
                local Thumb = Create("Frame", {
                    Parent = Fill,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -7, 0.5, -7),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 10
                })
                AddCorner(Thumb, 10)
                
                local function Update(val)
                    val = math.clamp(val, Min, Max)
                    Val = val
                    Library.Flags[Flag] = val
                    ValLbl.Text = tostring(Val)
                    TS:Create(Fill, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new((Val - Min) / (Max - Min), 0, 1, 0)}):Play()
                    if Cfg.Callback then
                        Cfg.Callback(Val)
                    end
                end
                
                if Cfg.Default then
                    Update(Cfg.Default)
                elseif Cfg.Callback then
                    task.spawn(Cfg.Callback, Val)
                end
                
                local Dragging = false
                
                local function DragUpdate(input)
                    local p = math.clamp((input.Position.X - SlideBar.AbsolutePosition.X) / SlideBar.AbsoluteSize.X, 0, 1)
                    Update(math.floor(Min + ((Max - Min) * p)))
                end
                
                SlideBar.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        DragUpdate(i)
                        TS:Create(Thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -9, 0.5, -9)}):Play()
                    end
                end)
                
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                        TS:Create(Thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}):Play()
                    end
                end)
                
                UIS.InputChanged:Connect(function(i)
                    if Dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        DragUpdate(i)
                    end
                end)
                
                ValLbl.FocusLost:Connect(function()
                    local number = tonumber(ValLbl.Text)
                    if number then
                        Update(number)
                    else
                        ValLbl.Text = tostring(Val)
                    end
                end)

                Library.Items[Flag] = {Set = Update}
            end

            function Elements:CreateInput(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -130, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local BoxContainer = Create("ScrollingFrame", { 
                    Parent = Frame,
                    Size = UDim2.new(0, 120, 0, 26),
                    Position = UDim2.new(1, -128, 0.5, -13), 
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 8, 
                    ClipsDescendants = true,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 0, 
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    AutomaticCanvasSize = Enum.AutomaticSize.X 
                })
                AddCorner(BoxContainer, 6)
                Create("UIPadding", { Parent = BoxContainer, PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })

                local BoxStroke = Create("UIStroke", {
                    Parent = BoxContainer, 
                    Color = SelectedTheme.TextDark, 
                    Transparency = 0.8, 
                    Thickness = 1, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                table.insert(Library.ThemeObjects.TextDark, BoxStroke)

                local Box = Create("TextBox", {
                    Parent = BoxContainer,
                    Size = UDim2.new(1, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Text = Cfg.Default or "",
                    PlaceholderText = Cfg.Placeholder or "Type...",
                    TextColor3 = SelectedTheme.Text,
                    Font = Library.GlobalFont,
                    TextSize = 13,
                    ZIndex = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ThemeTag = "Text",
                    TextWrapped = false,
                    ClearTextOnFocus = false
                })
                AttachHorizontalScroll(Box, BoxContainer, Enum.TextXAlignment.Left)

                Box.Focused:Connect(function()
                    TS:Create(BoxStroke, TweenInfo.new(0.3), {Color = SelectedTheme.ElementAccent, Transparency = 0}):Play()
                end)
                
                Box.FocusLost:Connect(function()
                    TS:Create(BoxStroke, TweenInfo.new(0.3), {Color = SelectedTheme.TextDark, Transparency = 0.8}):Play()
                end)

                local function Update(val)
                    Box.Text = val
                    if Cfg.Callback then
                        Cfg.Callback(val)
                    end
                end
                
                if Cfg.Default then
                    Library.Flags[Flag] = Cfg.Default
                    if Cfg.Callback then
                        task.spawn(Cfg.Callback, Cfg.Default)
                    end
                end
                
                Box.FocusLost:Connect(function()
                    Update(Box.Text)
                end)
                
                Library.Items[Flag] = {Set = Update}
            end

            function Elements:CreateDropdown(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Expanded = false
                local Selected = Cfg.Default
                local Options = Cfg.Items or {}
                
                local Drop = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ClipsDescendants = true,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Drop, 8)
                AddStroke(Drop, SelectedTheme).Transparency = 0.8

                DefaultHover(Drop)
                
                local Title = Create("TextLabel", {
                    Parent = Drop,
                    Size = UDim2.new(1, -40, 0, 34),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = (Cfg.Name or "Dropdown") .. (Selected and " - " .. tostring(Selected) or ""),
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local Arrow = Create("ImageLabel", {
                    Parent = Drop,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(1, -28, 0, 9),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://6031091004",
                    ImageColor3 = SelectedTheme.TextDark,
                    ZIndex = 8
                })
                table.insert(Library.ThemeObjects.TextDark, Arrow)

                local Container = Create("ScrollingFrame", {
                    Parent = Drop,
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 34),
                    BackgroundTransparency = 1,
                    ZIndex = 8,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = SelectedTheme.TextDark,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Create("UIPadding", {
                    Parent = Container,
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5),
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10)
                })
                
                local ListLayout = Create("UIListLayout", { Parent = Container, Padding = UDim.new(0, 4) })
                
                local function Update(val) 
                    Selected = val 
                    Title.Text = (Cfg.Name or "Dropdown") .. " - " .. tostring(Selected) 
                    if Cfg.Callback then
                        Cfg.Callback(val)
                    end
                    Library.Flags[Flag] = val
                end

                local function RefreshList(newOptions)
                    Options = newOptions or Options
                    for _, v in pairs(Container:GetChildren()) do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                    
                    local found = false
                    for _, v in pairs(Options) do
                        if v == Selected then
                            found = true
                            break
                        end
                    end
                    
                    if found then
                        Title.Text = (Cfg.Name or "Dropdown") .. " - " .. tostring(Selected)
                    else
                        Selected = nil
                        Title.Text = Cfg.Name or "Dropdown"
                    end

                    for _, item in pairs(Options) do
                        local Btn = Create("TextButton", {
                            Parent = Container,
                            Size = UDim2.new(1, 0, 0, 28),
                            Position = UDim2.new(0, 0, 0, 0),
                            BackgroundColor3 = SelectedTheme.Main,
                            BackgroundTransparency = 0.8,
                            Text = tostring(item),
                            Font = Library.GlobalFont,
                            TextColor3 = SelectedTheme.TextDark,
                            TextSize = 13,
                            ZIndex = 9,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            AutoButtonColor = false,
                            ThemeTag = "Main"
                        })
                        AddCorner(Btn, 6)
                        table.insert(Library.ThemeObjects.TextDark, Btn)

                        local hoverTweenBtn, leaveTweenBtn
                        Btn.MouseEnter:Connect(function()
                            if leaveTweenBtn then leaveTweenBtn:Cancel() end
                            hoverTweenBtn = TS:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = SelectedTheme.Text})
                            hoverTweenBtn:Play()
                        end)
                        Btn.MouseLeave:Connect(function()
                            if hoverTweenBtn then hoverTweenBtn:Cancel() end
                            leaveTweenBtn = TS:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = SelectedTheme.TextDark})
                            leaveTweenBtn:Play()
                        end)
                        Btn.MouseButton1Click:Connect(function()
                            Update(item)
                            Expanded = false
                            TS:Create(Drop, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 34)}):Play()
                            TS:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        end)
                    end
                    Container.CanvasSize = UDim2.new(0, 0, 0, #Options * 32 + 10)
                end
                
                RefreshList(Options)
                
                if Cfg.Default and Cfg.Callback then
                    task.spawn(Cfg.Callback, Selected)
                end

                Drop.MouseButton1Click:Connect(function()
                    if Cfg.UpdateList then
                        RefreshList(Cfg.UpdateList())
                    end
                    Expanded = not Expanded
                    local H = Expanded and math.min(#Options * 32 + 44, 180) or 34
                    TS:Create(Drop, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, H)}):Play()
                    TS:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = Expanded and 180 or 0}):Play()
                    TS:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, -34)}):Play()
                end)
                
                Library.Items[Flag] = {
                    Set = Update,
                    Refresh = function(self, list) RefreshList(list) end,
                    Get = function() return Selected end
                }
                
                return Library.Items[Flag]
            end

            function Elements:CreateColorPicker(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Color = Cfg.Default or Color3.fromRGB(255, 255, 255)
                Library.Flags[Flag] = {R = Color.R, G = Color.G, B = Color.B}
                local IsExpanded = false
                
                local Wrapper = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ClipsDescendants = true,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Wrapper, 8)
                AddStroke(Wrapper, SelectedTheme).Transparency = 0.8

                local TriggerBtn = Create("TextButton", { Parent = Wrapper, Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = "", ZIndex = 8 })
                
                Create("TextLabel", { 
                    Parent = TriggerBtn, 
                    Size = UDim2.new(1, -50, 1, 0), 
                    Position = UDim2.new(0, 12, 0, 0), 
                    BackgroundTransparency = 1, 
                    Text = Cfg.Name or "Color Picker", 
                    Font = Library.GlobalFont, 
                    TextColor3 = SelectedTheme.Text, 
                    TextSize = 14, 
                    TextXAlignment = Enum.TextXAlignment.Left, 
                    ZIndex = 9, 
                    TextTruncate = Enum.TextTruncate.AtEnd, 
                    ThemeTag = "Text" 
                })
                
                local PreviewContainer = Create("Frame", {
                    Parent = TriggerBtn,
                    Size = UDim2.new(0, 30, 0, 20),
                    Position = UDim2.new(1, -42, 0.5, -10),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 9
                })
                AddCorner(PreviewContainer, 6)
                Create("UIStroke", {Parent = PreviewContainer, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})

                local Preview = Create("Frame", { Parent = PreviewContainer, Size = UDim2.new(1, -4, 1, -4), Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color, ZIndex = 10 })
                AddCorner(Preview, 4)
                
                local Container = Create("Frame", { Parent = Wrapper, Size = UDim2.new(1, 0, 0, 160), Position = UDim2.new(0, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 8 })
                
                local BoxContainer = Create("Frame", { Parent = Container, Size = UDim2.new(0, 140, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 9 })
                
                Create("TextLabel", { 
                    Parent = BoxContainer, 
                    Size = UDim2.new(1, 0, 0, 20), 
                    Position = UDim2.new(0, 12, 0, 5), 
                    BackgroundTransparency = 1, 
                    Text = "RGB / Hex", 
                    TextColor3 = SelectedTheme.TextDark, 
                    Font = Library.GlobalFontBold, 
                    TextSize = 12, 
                    TextXAlignment = Enum.TextXAlignment.Left, 
                    ZIndex = 10, 
                    ThemeTag = "TextDark" 
                })
                
                local function CreateCBox(parent, size, pos, txt)
                    local box = Create("TextBox", {
                        Parent = parent,
                        Size = size,
                        Position = pos,
                        Text = txt,
                        BackgroundColor3 = Color3.new(0, 0, 0),
                        BackgroundTransparency = 0.85,
                        TextColor3 = SelectedTheme.Text,
                        Font = Library.GlobalFont,
                        TextSize = 12,
                        ZIndex = 10,
                        ThemeTag = "Text"
                    })
                    AddCorner(box, 4)
                    local boxStroke = Create("UIStroke", {Parent = box, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})
                    table.insert(Library.ThemeObjects.TextDark, boxStroke)
                    return box
                end

                local RInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 12, 0, 30), math.floor(Color.R * 255))
                local GInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 54, 0, 30), math.floor(Color.G * 255))
                local BInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 96, 0, 30), math.floor(Color.B * 255))
                local HexInput = CreateCBox(BoxContainer, UDim2.new(0, 120, 0, 28), UDim2.new(0, 12, 0, 66), "#" .. Color:ToHex())
                
                local PalContainer = Create("Frame", { Parent = Container, Size = UDim2.new(1, -150, 1, -20), Position = UDim2.new(0, 140, 0, 10), BackgroundTransparency = 1, ZIndex = 9 })
                local h, s, v = Color:ToHSV()
                
                local SVMap = Create("ImageButton", {
                    Parent = PalContainer,
                    Size = UDim2.new(1, -15, 0, 115),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.fromHSV(h, 1, 1),
                    Image = "rbxassetid://4155801252",
                    ZIndex = 10,
                    AutoButtonColor = false
                })
                AddCorner(SVMap, 6)
                
                local SVTrigger = Create("TextButton", { Parent = SVMap, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 100 })
                
                local SVCursor = Create("Frame", {
                    Parent = SVMap,
                    Size = UDim2.new(0, 8, 0, 8),
                    Position = UDim2.fromScale(s, 1 - v),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 12,
                    AnchorPoint = Vector2.new(0.5, 0.5)
                })
                AddCorner(SVCursor, 100)
                Create("UIStroke", {Parent = SVCursor, Color = Color3.new(0, 0, 0), Thickness = 1})
                
                local HueBar = Create("ImageButton", {
                    Parent = PalContainer,
                    Size = UDim2.new(1, -15, 0, 12),
                    Position = UDim2.new(0, 0, 0, 125),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 10,
                    AutoButtonColor = false
                })
                AddCorner(HueBar, 6)
                Create("UIGradient", { 
                    Parent = HueBar, 
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), 
                        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)), 
                        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)), 
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), 
                        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)), 
                        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)), 
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    } 
                })
                
                local HueTrigger = Create("TextButton", { Parent = HueBar, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 100 })
                
                local HueCursor = Create("Frame", { 
                    Parent = HueBar, 
                    Size = UDim2.new(0, 4, 1, 4), 
                    Position = UDim2.fromScale(h, 0.5), 
                    AnchorPoint = Vector2.new(0.5, 0.5), 
                    BackgroundColor3 = Color3.new(1, 1, 1), 
                    ZIndex = 11 
                })
                AddCorner(HueCursor, 2)
                Create("UIStroke", {Parent = HueCursor, Color = Color3.new(0, 0, 0), Thickness = 1})
                
                TriggerBtn.MouseButton1Click:Connect(function()
                    IsExpanded = not IsExpanded
                    TS:Create(Wrapper, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = IsExpanded and UDim2.new(1, 0, 0, 194) or UDim2.new(1, 0, 0, 34)}):Play()
                end)

                local function Update(col)
                    Color = col
                    h, s, v = Color:ToHSV()
                    Preview.BackgroundColor3 = Color
                    SVMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    SVCursor.Position = UDim2.fromScale(s, 1 - v)
                    HueCursor.Position = UDim2.fromScale(h, 0.5)
                    RInput.Text = math.floor(Color.R * 255)
                    GInput.Text = math.floor(Color.G * 255)
                    BInput.Text = math.floor(Color.B * 255)
                    HexInput.Text = "#" .. Color:ToHex()
                    Library.Flags[Flag] = {R = Color.R, G = Color.G, B = Color.B}
                    if Cfg.Callback then
                        Cfg.Callback(Color)
                    end
                end
                
                if Cfg.Default and Cfg.Callback then
                    task.spawn(Cfg.Callback, Color)
                end
                
                local function VisualUpdate(newH, newS, newV)
                    h = newH or h
                    s = newS or s
                    v = newV or v
                    Update(Color3.fromHSV(h, s, v))
                end
                
                RInput.FocusLost:Connect(function()
                    local r = tonumber(RInput.Text)
                    if r then
                        local c = Color3.fromRGB(math.clamp(r, 0, 255), Color.G * 255, Color.B * 255)
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                GInput.FocusLost:Connect(function()
                    local g = tonumber(GInput.Text)
                    if g then
                        local c = Color3.fromRGB(Color.R * 255, math.clamp(g, 0, 255), Color.B * 255)
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                BInput.FocusLost:Connect(function()
                    local b = tonumber(BInput.Text)
                    if b then
                        local c = Color3.fromRGB(Color.R * 255, Color.G * 255, math.clamp(b, 0, 255))
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                HexInput.FocusLost:Connect(function()
                    local success, c = pcall(function() return Color3.fromHex(HexInput.Text) end)
                    if success then
                        VisualUpdate(c:ToHSV())
                    end
                end)

                local draggingSV = false
                local draggingHue = false
                local dragConnection
                
                local function StartDragging()
                    if not dragConnection then
                        dragConnection = RS.RenderStepped:Connect(function()
                            if draggingSV then
                                VisualUpdate(nil, math.clamp((Mouse.X - SVMap.AbsolutePosition.X) / SVMap.AbsoluteSize.X, 0, 1), 1 - math.clamp((Mouse.Y - SVMap.AbsolutePosition.Y) / SVMap.AbsoluteSize.Y, 0, 1))
                            elseif draggingHue then
                                VisualUpdate(math.clamp((Mouse.X - HueBar.AbsolutePosition.X) / HueBar.AbsoluteSize.X, 0, 1), nil, nil)
                            end
                        end)
                    end
                end

                local function StopDragging()
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                end

                SVTrigger.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingSV = true
                        StartDragging()
                    end
                end)
                
                HueTrigger.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingHue = true
                        StartDragging()
                    end
                end)
                
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingSV = false
                        draggingHue = false
                        StopDragging()
                    end
                end)
                
                Library.Items[Flag] = {
                    Set = function(t)
                        if type(t) == "table" then
                            Update(Color3.new(t.R, t.G, t.B))
                        else
                            Update(t)
                        end
                    end
                }
            end

            function Elements:CreateKeybind(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local CurrentKey = Cfg.Default or Enum.KeyCode.RightControl
                Library.Flags[Flag] = CurrentKey.Name
                local Binding = false
                
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                local TitleOffset = 12
                local VP_Key = workspace.CurrentCamera.ViewportSize
                local IsMobile = UIS.TouchEnabled and (VP_Key.X < 850 or VP_Key.Y < 600)
                local MobileCheckboxState = false
                local MobileFlag = Flag .. "_Mobile"
                Library.Flags[MobileFlag] = false
                
                local OnScreenBtn

                if IsMobile then
                    TitleOffset = 40
                    local MBox = Create("TextButton", {
                        Parent = Frame,
                        Size = UDim2.new(0, 20, 0, 20),
                        Position = UDim2.new(0, 12, 0.5, -10),
                        BackgroundColor3 = Color3.new(0, 0, 0),
                        BackgroundTransparency = 1,
                        Text = "",
                        ZIndex = 8
                    })
                    AddCorner(MBox, 4)
                    local MStroke = Create("UIStroke", {Parent = MBox, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})

                    local MSquare = Create("Frame", {
                        Parent = MBox,
                        Size = UDim2.fromScale(0, 0),
                        Position = UDim2.fromScale(0.5, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = SelectedTheme.ElementAccent,
                        BackgroundTransparency = 1,
                        ZIndex = 9,
                        ThemeTag = "ElementAccent"
                    })
                    AddCorner(MSquare, 2)

                    local function UpdateMobileBtnState(val)
                        MobileCheckboxState = val
                        Library.Flags[MobileFlag] = val

                        TS:Create(MStroke, TweenInfo.new(0.3), {
                            Color = val and SelectedTheme.ElementAccent or SelectedTheme.TextDark,
                            Transparency = val and 0 or 0.8
                        }):Play()

                        TS:Create(MSquare, TweenInfo.new(0.3), {
                            Size = val and UDim2.fromScale(0.6, 0.6) or UDim2.fromScale(0, 0),
                            BackgroundTransparency = val and 0 or 1
                        }):Play()

                        if val then
                            if not OnScreenBtn then
                                OnScreenBtn = Create("TextButton", {
                                    Parent = ScreenGui,
                                    Size = UDim2.fromOffset(50, 50),
                                    Position = UDim2.new(0.8, 0, 0.8, 0),
                                    BackgroundColor3 = SelectedTheme.Main,
                                    BackgroundTransparency = SelectedTheme.HudTransparency or 0.5,
                                    Text = KeyMap[CurrentKey.Name] or CurrentKey.Name,
                                    Font = Library.GlobalFontBold,
                                    TextColor3 = SelectedTheme.Text,
                                    TextSize = 16,
                                    ZIndex = 10000,
                                    ThemeTag = "Main"
                                })
                                AddCorner(OnScreenBtn, 12)
                                AddStroke(OnScreenBtn, SelectedTheme).Transparency = 0.5
                                table.insert(Library.ThemeObjects.Text, OnScreenBtn)

                                local osDragging = false
                                local osInput, osPos, osFramePos
                                local dragDist = 0

                                OnScreenBtn.InputBegan:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                        osDragging = true
                                        osPos = input.Position
                                        osFramePos = OnScreenBtn.Position
                                        dragDist = 0
                                        input.Changed:Connect(function()
                                            if input.UserInputState == Enum.UserInputState.End then
                                                osDragging = false
                                            end
                                        end)
                                    end
                                end)

                                OnScreenBtn.InputChanged:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                                        osInput = input
                                    end
                                end)

                                UIS.InputChanged:Connect(function(input)
                                    if input == osInput and osDragging then
                                        local delta = input.Position - osPos
                                        dragDist = dragDist + delta.Magnitude
                                        OnScreenBtn.Position = UDim2.new(osFramePos.X.Scale, osFramePos.X.Offset + delta.X, osFramePos.Y.Scale, osFramePos.Y.Offset + delta.Y)
                                    end
                                end)

                                OnScreenBtn.MouseButton1Click:Connect(function()
                                    if dragDist < 10 then
                                        if Cfg.Callback then Cfg.Callback(CurrentKey) end
                                    end
                                end)
                            end
                            OnScreenBtn.Visible = true
                            OnScreenBtn.Text = KeyMap[CurrentKey.Name] or CurrentKey.Name
                        else
                            if OnScreenBtn then
                                OnScreenBtn.Visible = false
                            end
                        end
                    end

                    MBox.MouseButton1Click:Connect(function()
                        UpdateMobileBtnState(not MobileCheckboxState)
                    end)

                    Library.Items[MobileFlag] = {
                        Set = function(val)
                            if MobileCheckboxState ~= val then
                                UpdateMobileBtnState(val)
                            end
                        end
                    }
                end

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -110, 1, 0),
                    Position = UDim2.new(0, TitleOffset, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local BindBtn = Create("TextButton", {
                    Parent = Frame,
                    Size = UDim2.new(0, 70, 0, 24),
                    Position = UDim2.new(1, -82, 0.5, -12),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    Text = KeyMap[CurrentKey.Name] or CurrentKey.Name,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.TextDark,
                    TextSize = 12,
                    ZIndex = 9,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                AddCorner(BindBtn, 6)
                local BindStroke = Create("UIStroke", {Parent = BindBtn, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})
                
                table.insert(Library.ThemeObjects.Keybinds, BindBtn)
                table.insert(Library.ThemeObjects.TextDark, BindStroke)

                local hoverTweenBind, leaveTweenBind
                BindBtn.MouseEnter:Connect(function()
                    if leaveTweenBind then leaveTweenBind:Cancel() end
                    hoverTweenBind = TS:Create(BindBtn, TweenInfo.new(0.2), {TextColor3 = SelectedTheme.Text})
                    hoverTweenBind:Play()
                end)
                
                BindBtn.MouseLeave:Connect(function()
                    if not Binding then
                        if hoverTweenBind then hoverTweenBind:Cancel() end
                        leaveTweenBind = TS:Create(BindBtn, TweenInfo.new(0.2), {TextColor3 = SelectedTheme.TextDark})
                        leaveTweenBind:Play()
                    end
                end)
                
                local function Update(key)
                    CurrentKey = key
                    BindBtn.Text = KeyMap[key.Name] or key.Name
                    BindBtn.TextColor3 = SelectedTheme.TextDark
                    if OnScreenBtn and OnScreenBtn.Visible then
                        OnScreenBtn.Text = KeyMap[CurrentKey.Name] or CurrentKey.Name
                    end
                    Library.Flags[Flag] = key.Name
                    Binding = false
                end
                
                BindBtn.MouseButton1Click:Connect(function()
                    Binding = true
                    BindBtn.Text = "..."
                    BindBtn.TextColor3 = SelectedTheme.Accent
                end)
                
                local Connection
                Connection = UIS.InputBegan:Connect(function(input, gpe) 
                    if not Frame.Parent then
                        Connection:Disconnect()
                        return
                    end 
                    if not Binding then 
                        if input.KeyCode == CurrentKey and not gpe and not UIS:GetFocusedTextBox() then 
                            if Cfg.Callback then
                                Cfg.Callback(input.KeyCode)
                            end 
                        end 
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Unknown then 
                        Update(input.KeyCode) 
                    end 
                end)
                
                Library.Items[Flag] = {
                    Set = function(keyName)
                        if Enum.KeyCode[keyName] then
                            Update(Enum.KeyCode[keyName])
                        end
                    end
                }
            end

            return Elements
        end

        local TabElements = GetElements(Page)

        if Two_Column then
            function TabElements:CreateBlock(BlockCfg)
                local BlockName = BlockCfg.Name or "Block"
                local Side = BlockCfg.Side or "Left"
                local TargetColumn = (Side == "Right" and RightCol) or LeftCol
                
                local BlockFrame = Create("Frame", {
                    Parent = TargetColumn,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 5,
                    ThemeTag = "Second"
                })
                AddCorner(BlockFrame, 8)

                local BlockStroke = Create("UIStroke", { Parent = BlockFrame, Color = Color3.new(1, 1, 1), Transparency = 0.7, Thickness = 1 })
                local BlockGrad = Create("UIGradient", { Parent = BlockStroke, Color = SelectedTheme.Gradient })
                table.insert(Library.GradientObjects, BlockGrad)
                
                Create("Frame", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, -24, 0, 1),
                    Position = UDim2.new(0, 12, 0, 36),
                    BackgroundColor3 = SelectedTheme.TextDark,
                    BackgroundTransparency = 0.8,
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    ThemeTag = "TextDark"
                })
                
                local HasIcon = (BlockCfg.ImageID ~= nil and BlockCfg.ImageID ~= "")
                local TitleOffsetX = 12
                
                if HasIcon then
                    local BlockIcon = Create("ImageLabel", {
                        Parent = BlockFrame,
                        Size = UDim2.new(0, 18, 0, 18),
                        Position = UDim2.new(0, 12, 0, 9),
                        BackgroundTransparency = 1,
                        ImageColor3 = SelectedTheme.TextDark,
                        ZIndex = 6
                    })
                    SetImageAsync(BlockIcon, "Image", BlockCfg.ImageID)
                    TitleOffsetX = 36
                    table.insert(Library.ThemeObjects.TextDark, BlockIcon)
                end
                
                Create("TextLabel", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, -TitleOffsetX - 12, 0, 36),
                    Position = UDim2.new(0, TitleOffsetX, 0, 0),
                    BackgroundTransparency = 1,
                    Text = BlockName,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 6,
                    ThemeTag = "Text"
                })
                
                local BlockContent = Create("Frame", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 42),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    ZIndex = 5
                })
                
                Create("UIListLayout", { Parent = BlockContent, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
                Create("UIPadding", { Parent = BlockContent, PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
                
                return GetElements(BlockContent)
            end
        end
        
        return TabElements, Activate
    end

    local SettingsTab, OpenSettingsFunc = Funcs:CreateTab("UI Settings", true, "rbxassetid://7059346373")

    local AppBlock = SettingsTab:CreateBlock({Name = "Appearance", Side = "Left"})
    
    AppBlock:CreateDropdown({
        Name = "Font",
        Flag = "Settings_Font",
        Items = AvailableFonts,
        Default = Library.GlobalFont.Name,
        Callback = function(val)
            UpdateFonts(val)
        end
    })
    
    AppBlock:CreateSlider({
        Name = "Image Transparency",
        Flag = "Settings_ImageTrans",
        Min = 0,
        Max = 100,
        Default = math.floor(ImageTrans * 100),
        Callback = function(val)
            MainBgImage.ImageTransparency = val / 100
        end
    })
    
    AppBlock:CreateSlider({
        Name = "Background Transparency",
        Flag = "Settings_BgTrans",
        Min = 0,
        Max = 100,
        Default = math.floor(WindowTrans * 100),
        Callback = function(val)
            local t = val / 100
            MainBgColor.BackgroundTransparency = t
        end
    })
    
    AppBlock:CreateSlider({
        Name = "HUD Transparency",
        Flag = "Settings_HudTrans",
        Min = 0,
        Max = 100,
        Default = math.floor((SelectedTheme.HudTransparency or 0.5) * 100),
        Callback = function(val)
            local t = val / 100
            SelectedTheme.HudTransparency = t
            for _, obj in pairs(Library.WatermarkIslands) do
                if obj and obj.Parent then
                    obj.BackgroundTransparency = t
                end
            end
        end
    })

    AppBlock:CreateInput({
        Name = "Background ID",
        Flag = "Settings_BgImage",
        Placeholder = "ID...",
        Callback = function(val)
            val = GetAssetId(val)
            SetImageAsync(MainBgImage, "Image", val)
            SelectedTheme.Background = val
        end
    })

    AppBlock:CreateSlider({
        Name = "Corner Radius",
        Flag = "Settings_CornerRadius",
        Min = 0,
        Max = 25,
        Default = Library.GlobalCornerValue,
        Callback = function(val)
            UpdateCorners(val)
        end
    })

    local KeyBlock = SettingsTab:CreateBlock({Name = "Keybinds", Side = "Left"})
    
    KeyBlock:CreateKeybind({
        Name = "Toggle UI",
        Flag = "Settings_ToggleKey",
        Default = Library.ToggleKey,
        Callback = function() end
    })

    local ConfigBlock = SettingsTab:CreateBlock({Name = "Config Manager", Side = "Left"})

    local ConfigNameInput = "MyConfig"
    ConfigBlock:CreateInput({
        Name = "Config Name",
        Flag = "Settings_CfgName",
        Default = "MyConfig",
        Callback = function(v)
            ConfigNameInput = v
        end
    })
    
    ConfigBlock:CreateButton({
        Name = "Save Config",
        Callback = function()
            Library:SaveConfig(ConfigNameInput)
        end
    })

    local LoadDropCfg = ConfigBlock:CreateDropdown({
        Name = "Load Config",
        Flag = "Settings_CfgLoad",
        Items = Library:GetConfigs(),
        UpdateList = function()
            return Library:GetConfigs()
        end,
        Callback = function(val)
            Library:LoadConfig(val)
        end
    })

    ConfigBlock:CreateButton({
        Name = "Delete Selected Config",
        Callback = function()
            local sel = LoadDropCfg:Get()
            if sel and isfile(Library.ConfigFolder .. "/" .. sel .. ".json") then
                Library:DeleteConfig(sel)
            end
        end
    })

    local ColorBlock = SettingsTab:CreateBlock({Name = "Theme Colors", Side = "Right"})
    
    ColorBlock:CreateColorPicker({
        Name = "MainColor",
        Flag = "Settings_MainColor",
        Default = SelectedTheme.Main,
        Callback = function(c)
            SelectedTheme.Main = c
            Themes.Default.Main = c
            UpdateThemeObjects()
        end
    }) 
    
    ColorBlock:CreateColorPicker({
        Name = "Second Color",
        Flag = "Settings_SecondColor",
        Default = SelectedTheme.Second,
        Callback = function(c)
            SelectedTheme.Second = c
            Themes.Default.Second = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Element Color",
        Flag = "Settings_ElementColor",
        Default = SelectedTheme.ElementAccent,
        Callback = function(c)
            SelectedTheme.ElementAccent = c
            Themes.Default.ElementAccent = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Text Color",
        Flag = "Settings_TextColor",
        Default = SelectedTheme.Text,
        Callback = function(c) 
            SelectedTheme.Text = c
            Themes.Default.Text = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Gradient Start",
        Flag = "Settings_GradStart",
        Default = SelectedTheme.GradientStart or SelectedTheme.Accent,
        Callback = function(c)
            SelectedTheme.GradientStart = c
            SelectedTheme.Gradient = GetGradientSeq(SelectedTheme)
            UpdateGradients(SelectedTheme.Gradient)
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Gradient End",
        Flag = "Settings_GradEnd",
        Default = SelectedTheme.GradientEnd or SelectedTheme.Accent,
        Callback = function(c)
            SelectedTheme.GradientEnd = c
            SelectedTheme.Gradient = GetGradientSeq(SelectedTheme)
            UpdateGradients(SelectedTheme.Gradient)
        end
    })

    local ThemeBlock = SettingsTab:CreateBlock({Name = "Theme Manager", Side = "Right"})
    
    local ThemeNameInput = "MyTheme"
    ThemeBlock:CreateInput({
        Name = "Theme Name",
        Flag = "Settings_ThemeName",
        Default = "MyTheme",
        Callback = function(v)
            ThemeNameInput = v
        end
    })
    
    ThemeBlock:CreateButton({
        Name = "Save Theme",
        Callback = function()
            local ThemeConfig = {
                Main = {R = SelectedTheme.Main.R, G = SelectedTheme.Main.G, B = SelectedTheme.Main.B},
                Second = {R = SelectedTheme.Second.R, G = SelectedTheme.Second.G, B = SelectedTheme.Second.B},
                Accent = {R = SelectedTheme.Accent.R, G = SelectedTheme.Accent.G, B = SelectedTheme.Accent.B},
                ElementAccent = {R = SelectedTheme.ElementAccent.R, G = SelectedTheme.ElementAccent.G, B = SelectedTheme.ElementAccent.B},
                Text = {R = SelectedTheme.Text.R, G = SelectedTheme.Text.G, B = SelectedTheme.Text.B},
                TextDark = {R = SelectedTheme.TextDark.R, G = SelectedTheme.TextDark.G, B = SelectedTheme.TextDark.B},
                Error = {R = SelectedTheme.Error.R, G = SelectedTheme.Error.G, B = SelectedTheme.Error.B},
                GradientStart = {R = SelectedTheme.GradientStart.R, G = SelectedTheme.GradientStart.G, B = SelectedTheme.GradientStart.B},
                GradientEnd = {R = SelectedTheme.GradientEnd.R, G = SelectedTheme.GradientEnd.G, B = SelectedTheme.GradientEnd.B},
                Background = SelectedTheme.Background,
                Transparency = MainBgColor.BackgroundTransparency,
                HudTransparency = SelectedTheme.HudTransparency,
                ImageTransparency = MainBgImage.ImageTransparency,
                Font = Library.GlobalFont.Name,
                CornerRadius = Library.GlobalCornerValue
            }
            writefile(Library.ThemeFolder .. "/" .. ThemeNameInput .. ".json", HS:JSONEncode(ThemeConfig))
            Library:Notify({Title = "Theme Saved", Content = "Saved as " .. ThemeNameInput})
        end
    })

    local LoadDrop = ThemeBlock:CreateDropdown({
        Name = "Load Theme",
        Flag = "Settings_ThemeLoad",
        Items = Library:GetThemes(),
        UpdateList = function()
            return Library:GetThemes()
        end,
        Callback = function(val)
            local NewTheme = GetTheme(val)
            MainBgColor.BackgroundColor3 = NewTheme.Main
            SetImageAsync(MainBgImage, "Image", NewTheme.Background or "")
            MainBgColor.BackgroundTransparency = NewTheme.Transparency or 0.25
            MainBgImage.ImageTransparency = NewTheme.ImageTransparency or 0
            
            SelectedTheme = NewTheme
            Themes.Default.Main = NewTheme.Main
            Themes.Default.Second = NewTheme.Second
            Themes.Default.Accent = NewTheme.Accent
            Themes.Default.ElementAccent = NewTheme.ElementAccent
            Themes.Default.Text = NewTheme.Text
            SelectedTheme.HudTransparency = NewTheme.HudTransparency or 0.5
            
            for _, island in pairs(Library.WatermarkIslands) do
                if island and island.Parent then
                    island.BackgroundTransparency = SelectedTheme.HudTransparency
                end
            end
            
            if NewTheme.Font then
                UpdateFonts(NewTheme.Font)
            end
            
            UpdateThemeObjects()
            UpdateGradients(SelectedTheme.Gradient)

            if Library.Items["Settings_MainColor"] then Library.Items["Settings_MainColor"].Set(NewTheme.Main) end
            if Library.Items["Settings_SecondColor"] then Library.Items["Settings_SecondColor"].Set(NewTheme.Second) end
            if Library.Items["Settings_ElementColor"] then Library.Items["Settings_ElementColor"].Set(NewTheme.ElementAccent) end
            if Library.Items["Settings_TextColor"] then Library.Items["Settings_TextColor"].Set(NewTheme.Text) end
            if Library.Items["Settings_GradStart"] then Library.Items["Settings_GradStart"].Set(NewTheme.GradientStart or NewTheme.Accent) end
            if Library.Items["Settings_GradEnd"] then Library.Items["Settings_GradEnd"].Set(NewTheme.GradientEnd or NewTheme.Accent) end
            if Library.Items["Settings_BgTrans"] then Library.Items["Settings_BgTrans"].Set(math.floor((NewTheme.Transparency or 0.25) * 100)) end
            if Library.Items["Settings_HudTrans"] then Library.Items["Settings_HudTrans"].Set(math.floor((SelectedTheme.HudTransparency) * 100)) end
            if Library.Items["Settings_ImageTrans"] then Library.Items["Settings_ImageTrans"].Set(math.floor((NewTheme.ImageTransparency or 0) * 100)) end
            if Library.Items["Settings_BgImage"] then Library.Items["Settings_BgImage"].Set(NewTheme.Background or "") end
            if Library.Items["Settings_Font"] and NewTheme.Font then Library.Items["Settings_Font"].Set(NewTheme.Font) end
            if Library.Items["Settings_CornerRadius"] then Library.Items["Settings_CornerRadius"].Set(NewTheme.CornerRadius or 10) end

            Library:Notify({Title = "Theme Loaded", Content = "Loaded " .. val})
        end
    })

    ThemeBlock:CreateButton({
        Name = "Delete Selected Theme",
        Callback = function()
            local selected = LoadDrop:Get()
            if selected and isfile(Library.ThemeFolder .. "/" .. selected .. ".json") then
                delfile(Library.ThemeFolder .. "/" .. selected .. ".json")
                Library:Notify({Title = "Theme Deleted", Content = "Deleted " .. selected})
            else
                Library:Notify({Title = "Error", Content = "Select a valid theme first"})
            end
        end
    })

    return Funcs
end

return Library
