

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

(function(...)local o={"\113\076\053\054\056\054\054\082\056\053\050\097\113\065\051\082\122\109\061\061";"\078\053\086\114\083\079\083\047\117\105\122\061","\113\054\052\121\054\065\077\122\100\097\109\061","\088\099\053\077\113\099\115\061";"\082\075\055\100\050\088\115\071\066\080\074\073\067\115\101\103","\118\098\120\047\048\082\070\061","\086\102\083\090\086\102\053\081";"\086\102\083\073\113\065\054\081\107\108\049\076";"\086\100\103\112\107\108\084\087\098\073\069\115\109\116\080\061","\122\074\121\075\121\099\079\052\050\112\074\110\108\108\109\048\056\070\061\061","\088\108\049\048\086\108\111\101","\115\055\078\102\112\112\052\053","\079\084\080\108\077\054\080\108\079\112\049\107\121\081\099\076\073\043\120\083\105\048\061\061";"\121\108\119\107\088\108\088\048\117\075\074\055\121\075\083\081";"\117\121\083\097\067\109\061\061","\071\081\105\061","\055\056\099\055\112\049\068\072\117\115\085\078\066\098\052\075\087\081\098\081\078\055\049\068";"\075\048\061\061","\066\071\048\116\088\070\109\080\049\074\043\049\088\114\070\097\049\084\103\108\114\105\053\079\068\050\090\052\122\066\122\111\053\108\066\055\078\057\112\104\085\067\053\085\102\070\070\120\077\052\079\066\054\051\109\103";"\105\089\054\084\113\065\121\076","\070\086\100\086\112\102\052\043","\074\073\083\057\073\052\084\112\115\099\048\106\047\047\102\076\105\083\085\069\076\117\118\106\089\112\078\110\111\097\114\074\121\101\075\061";"\120\056\099\106\108\078\082\117\108\048\061\061";"\121\102\053\084\121\122\061\061","\084\084\056\086\097\069\122\119";"\079\087\054\050\122\085\111\050\098\089\099\069";"\090\097\057\120\079\054\112\078";"\050\054\050\086\105\054\051\065\122\054\053\075\105\065\079\101\108\122\061\061","\088\099\083\090\088\108\074\077\121\071\080\061";"\071\074\083\084\121\071\050\119\088\099\053\077\113\099\115\061","\098\077\105\061","\118\110\116\076\080\067\111\112\083\075\075\061","\122\081\076\099\105\099\121\068\115\082\053\076\111\065\122\098\111\109\061\061";"\090\051\053\043\069\072\081\120\115\070\077\082\047\098\099\078\097\122\061\061";"\076\070\061\061";"\050\069\119\099\050\112\083\081\107\076\119\052\078\102\114\081";"\113\110\114\082\087\070\061\061";"\048\098\054\047\100\087\097\121\105\109\075\061";"\071\074\083\082\086\048\061\061";"","\043\106\111\050\119\048\061\061","\105\089\053\065\121\102\054\081";"\086\112\054\052\113\089\057\084\121\065\054\107\088\098\119\049\115\072\080\061","\105\053\088\122\121\082\051\086\122\108\054\052\117\069\051\068","\121\074\057\101\088\085\088\108\103\085\053\069\088\053\057\049\105\070\061\061","\088\071\049\110\115\109\061\061";"\083\067\102\084\071\048\103\115\072\054\109\117\055\097\065\086\116\101\110\061","\121\071\079\073\113\065\080\061","\097\084\043\105\052\109\115\061";"\103\112\080\073\088\076\105\081\122\072\053\120\103\075\114\073\115\075\114\061";"\104\057\112\055\122\106\057\072\088\086\085\047\072\122\061\061";"\108\104\103\121\102\054\048\061";"\085\055\077\057\111\070\104\111\048\117\121\110\101\110\117\054\085\054\066\061";"\072\068\102\104\118\052\087\084\113\074\070\115","\077\074\066\099","\066\116\120\061","\114\110\106\117\043\072\089\048\078\109\048\084\100\098\047\065\079\049\051\102\071\086\108\110";"\103\054\120\061";"\086\078\112\061";"\105\102\054\081\113\108\054\081\086\071\050\119\086\089\047\076","\078\073\048\083\090\047\051\043\087\051\113\101\080\051\055\089\053\047\104\116\067\057\072\122\065\109\061\061","\105\065\050\073\107\108\049\082";"\048\052\120\061";"\121\102\054\081\121\102\054\090\088\109\061\061";"\121\089\047\052\113\065\080\061","\086\065\054\089\078\115\057\049\054\076\119\043\108\099\079\072\103\112\115\061","\056\085\049\074";"\121\074\121\099\078\089\080\102\117\115\074\121\121\069\076\100\054\109\061\061","\110\052\082\104\074\067\084\102\065\086\069\097\054\089\047\075\114\055\075\061";"\115\070\048\078\054\066\104\118\070\113\076\114";"\103\048\110\043\104\065\070\065\113\109\071\072\057\112\110\061","\054\122\061\061","\117\077\109\076\121\055\114\057\117\109\061\061","\105\089\053\090\121\099\083\084";"\107\078\121\079\105\108\074\081\113\112\119\043\104\048\061\061","\088\089\047\065\054\075\110\077\075\065\109\115\098\100\080\071\121\120\087\109\101\100\097\089\110\076\101\079\065\085\113\115\087\073\080\081\097\119\085\078";"\048\090\084\055\110\111\090\056\119\109\061\061","\108\069\079\101\108\108\047\071\103\075\056\047\056\082\119\115\115\069\056\061","\102\115\067\074\072\114\097\113\100\082\057\102\106\057\116\049\081\108\114\061","\055\117\090\104\050\106\048\090";"\054\099\053\084\105\099\054\073\080\075\050\076\088\099\054\072\088\099\054\112\080\122\061\061","\068\110\052\114\101\085\073\103";"\113\078\051\122\105\115\121\099\113\074\079\085\108\071\054\043\113\070\061\061";"\085\043\116\087\053\079\118\076\071\070\061\061";"\073\049\113\086\069\122\061\061";"\054\082\121\073\054\085\051\071\115\074\054\050\054\102\075\073";"\071\074\083\110\121\108\120\061";"\121\065\111\074\086\109\061\061";"\113\108\053\081\107\070\061\061";"\078\109\105\061","\121\102\074\119\088\099\111\114","\086\102\119\119\105\109\061\061";"\113\099\054\090","\113\069\075\061";"\108\106\102\054\086\083\101\101\071\122\061\061";"\071\056\078\114\086\050\050\111\082\116\075\099\085\079\116\097\087\098\115\061","\105\082\121\081\115\099\057\072\104\112\049\084\115\074\114\102","\088\085\076\048\121\122\061\061";"\113\065\056\061","\071\074\083\057\113\089\050\076\103\070\061\061","\054\051\100\104\115\115\111\055\097\087\054\100\049\080\079\065\111\111\114\121\101\122\061\061","\104\078\111\098\115\069\053\101\105\112\084\119\086\072\050\090\086\109\061\061","\113\115\101\083\056\047\048\047\076\070\085\052\075\108\114\061","\117\109\061\061";"\050\102\054\081\115\102\054\073\088\089\076\072\121\122\061\061","\052\086\107\076\069\047\075\061","\107\108\047\085\113\098\088\110\107\089\081\120\054\076\076\080";"\056\074\056\049\104\082\121\054\103\076\054\107\050\069\070\061","\117\055\089\098\052\081\088\097\122\071\076\089\050\048\061\061";"\056\069\053\085\115\078\051\054\050\085\079\076\056\078\053\080\104\070\061\061";"\109\084\098\057\101\109\061\061","\066\107\104\117\067\115\097\070\083\047\083\081\057\086\083\055\088\102\108\048\055\102\086\108\121\113\057\057\111\082\074\105\098\069\049\055\050\106\048\109\077\065\077\076\100\053\081\072\097\069\109\109\078\066\054\070\118\088\072\116\077\108\057\101\102\053\119\111\056\120\117\074\070\112\114\120\114\077\087\110\087\089\048\050\053\090\100\048\086\069\078\055\057\112\107\075\111\099\071\070\065\085\088\121\107\104\081\075\099\066\055\108\065\051\074\083\081\099\120\120\084\055\086\116\088\053\078\120\114\109\071\108\048\115\067\076\090\118\115\071\114\122\118\065\049\073\074\110\078\089\043\049\115\108\075\099\086\051\120\069\113\047\099\081\112\105\109\082\102\054\069\121\070\074\112\098\118\108\069\115\104\108\098\108\121\082\098\049\067\110\074\073\098\043\108\047\077\103\077\067\055\102\070\073\056\104\083\079\087\088\054\090\109\074\084\098\122\098\114\115\085\113\084\053\055\076\121\120\075\113\056\076\053\103\116\066\080\043\116\097\104\068\054\070\109\054\111\086\117\107\067\049\114\067\077\119\110\090\074\114\053\057\089\105\043\056\077\052\097\113\099\087\077\054\043\077\083\069\086\079\054\086\086\085\078\084\108\100\117\066\054\056\067\069\115\052\088\051\120\102\089\051\100\087\072\068\099\079\107\074\073\068\083\085\106\066\072\102\066\116\072\118\120\061";"\121\104\076\048\118\107\100\078\085\114\087\118\076\076\119\098\102\097\099\057\084\071\076\113\118\107\105\071\079\077\048\109\077\111\108\056\119\070\055\070";"\117\116\066\061";"\104\078\111\081\113\065\053\047\104\082\053\084\108\099\049\081\054\065\112\061","\105\065\054\077";"\105\099\111\119\113\099\048\061";"\113\107\112\122\082\069\071\116\119\049\110\061","\103\115\121\119\113\054\119\050\105\075\049\053\113\115\076\122","\113\069\080\061","\114\109\105\048\077\086\047\066\118\081\075\061";"\049\070\113\120\050\116\115\102\089\067\105\061";"\077\086\102\054\079\118\082\099\066\113\116\089\122\066\078\053","\050\101\098\098\117\075\072\116\090\100\121\079\055\109\054\049\084\103\090\118\074\108\070\115\068\105\069\066\081\108\109\066";"\103\089\083\085\104\112\105\049\121\099\049\078\121\099\083\101\105\069\109\061";"\068\114\090\121\105\116\074\122\074\113\106\099\048\068\054\087\101\077\054\102\107\055\108\067\070\079\114\061","\088\099\083\098\088\085\079\057\113\089\105\061";"\072\051\043\072\087\112\100\106\084\076\113\102\065\101\048\101\115\122\105\061","\051\097\107\080\069\048\061\061";"\048\083\090\051\077\104\117\106\079\114\109\080\082\084\090\088\119\097\116\080\055\099\052\120\083\107\115\061","\068\068\053\111\080\109\061\061","\121\076\071\086\070\114\074\077\050\081\115\118\080\073\097\067\071\081\043\073\072\066\081\077\097\068\089\052\075\054\090\115\105\075\055\107\120\051\073\117","\082\105\043\098\053\120\116\057\117\049\108\112\082\057\083\107\073\068\100\105\055\057\083\052\067\089\056\061";"\086\082\076\081\121\122\061\061";"\043\112\043\043\103\065\090\077\068\065\097\055\051\086\098\114","\070\113\048\118\057\065\106\122\043\101\083\071";"\090\078\116\084\111\077\090\083\105\113\051\107\069\085\115\049\118\086\120\061"}for p,N in ipairs({{291196-291195;-186530-(-186667)};{911707-911706;43633-43572},{-523268-(-523330);822434+-822297}})do while N[101790-101789]<N[-816891-(-816893)]do o[N[877072+-877071]],o[N[-494515-(-494517)]],N[505079+-505078],N[751572-751570]=o[N[797698-797696]],o[N[88553+-88552]],N[210681+-210680]+(-642224-(-642225)),N[703946-703944]-(769866-769865)end end local function p(p)return o[p-(-597875-(-608556))]end do local p=string.len local N=math.floor local W=string.char local d=string.sub local t=table.concat local Z=table.insert local j=type local C=o local h={n=-551838-(-551882);V=571316-571292;u=303665-303651,m=-441858+441890,p=-733288+733324,["\043"]=452450+-452439;["\050"]=-297352+297369;e=480352+-480309;j=781186-781123;L=312264-312227;S=453836+-453775;I=-614200+614250;y=-862891-(-862916);f=818641-818587;T=618675-618630;["\051"]=-45057-(-45058);["\049"]=943067-943010,w=384338+-384305,["\054"]=-654721+654742;H=811239+-811204,J=397164+-397111;h=-490702-(-490720),["\057"]=727722+-727681;r=46894+-46854;B=902509-902449,["\055"]=-528039+528041,P=28331+-28323;["\053"]=69534+-69529,x=887915-887859,G=-86084+86107,l=-221609+221631,N=442574+-442555;t=-383539+383601;Y=476244+-476206,a=834515-834500;z=-276280+276296,R=359580+-359541,K=-623907+623911,X=-398438+398467;k=349495+-349469;["\048"]=-833132+833180,g=-464120+464150;D=331649+-331591,Z=-1039760+1039806;o=-877645+877658,["\056"]=-941210-(-941222),b=352788+-352737;W=742462+-742403,O=-861059+861068,c=223953-223947,d=-956122-(-956164);["\047"]=-314853+314902,F=238211-238211;["\052"]=337027-336980,E=223963-223960;M=-828821+828855;s=-257970+257990,C=129563-129532,q=-808999-(-809026),U=-229013+229020;i=-296042-(-296070);Q=-505250-(-505302),v=-692633+692643,A=-167289-(-167344)}for o=252557+-252556,#C,932007+-932006 do local Y=C[o]if j(Y)=="\115\116\114\105\110\103"then local j=p(Y)local O={}local D=341877-341876 local n=-461703-(-461703)local f=-73475+73475 while D<=j do local o=d(Y,D,D)local p=h[o]if p then n=n+p*(-727192+727256)^((218020-218017)-f)f=f+(-545575+545576)if f==-25015+25019 then f=583617+-583617 local o=N(n/(808798-743262))local p=N((n%(665697+-600161))/(-512869-(-513125)))local d=n%(-228295-(-228551))Z(O,W(o,p,d))n=-181760+181760 end elseif o=="\061"then Z(O,W(N(n/(753050+-687514))))if D>=j or d(Y,D+(707535+-707534),D+(364210-364209))~="\061"then Z(O,W(N((n%(-530032+595568))/(121433+-121177))))end break end D=D+(650572+-650571)end C[o]=t(O)end end end return(function(o,W,d,t,Z,j,C,f,n,O,r,U,Y,z,R,N,D,h,l,e,q,k,M)N,e,f,Y,l,q,h,R,k,D,z,M,U,n,O,r=function(N,d,t,Z)local C,P,s,I,u,i,rX,D,lX,n,w,iX,K,Y,g,nX,NX,pX,A,f,F,fX,jX,hX,v,y,zX,UX,Q,L,G,a,m,eX,b,H,S,V,YX,tX,X,B,dX,c,oX,CX,J,T,kX,E,WX,OX,qX,q,MX,TX,ZX,x,RX,DX while N do if N<7944714-(-525328)then if N<253318+2934997 then if N<534127+449465 then if N<-869669+1458252 then if N<-251710+722777 then if N<-342071+608531 then if N<-191480-(-418801)then F=N S=1018217+-1018216 g=a[S]S=false K=g==S N=K and 14106119-924908 or-644237+12122825 L=K else N=C and 242672+4498853 or 12693235-(-835690)end else if N<643372+-235298 then P=p(697658-686854)i=-687746-(-688001)N={}h[t[337862+-337860]]=N C=h[t[132489+-132486]]f=C q=-470432+35184372559264 C=D%q h[t[864431-864427]]=C T=D%i i=-313464+313466 q=T+i h[t[-856415+856420]]=q i=o[P]P=p(162445-151747)N=12897185-(-147747)T=i[P]i=T(Y)T=p(779909-769127)n[D]=T P=-400285-(-400286)b=421426+-421425 y=i T=-204121+204202 v=b b=199480-199480 u=v<b b=P-v else n=n+q i=not T C=n<=f C=i and C i=n>=f i=T and i C=i or C i=444360+5936777 N=C and i C=10718271-289920 N=N or C end end else if N<904890+-407716 then if N<1242891-746766 then N=713467-120217 T=h[q]C=T else C=y N=b N=y and 11124263-312646 or 1311084-663808 end else if N<-421739-(-921400)then G=not m w=w+H A=w<=X A=G and A G=w>=X G=m and G A=G or A G=795129+5170274 N=A and G A=741750+5854474 N=N or A else n=3852203-(-611641)D=p(-798816-(-809617))Y=D^n C=647424+15414594 N=C-Y Y=N C=p(270332+-259557)N=C/Y C={N}N=o[p(-11657-(-22400))]end end end else if N<1016917-159668 then if N<-770527+1448845 then if N<453706+148026 then i=p(51134+-40440)T=C C=o[i]i=p(-307691-(-318507))N=C[i]u=p(-327286-(-338032))P=p(999982+-989236)i=O()h[i]=N C=o[P]P=p(-180947+191696)N=C[P]v=o[u]b=N P=N y=v N=v and 15881571-(-308581)or 1087558-591046 else b=p(-65929+76682)y=o[b]N=1019301+9792316 C=y end else if N<355540-(-465197)then Y=p(512255+-501556)C=p(913879+-903154)N=o[C]C=o[Y]Y=p(60200-49501)o[Y]=N Y=p(728682-717957)o[Y]=C Y=h[t[-579239+579240]]N=13127503-(-16837)D=Y()else N=5446368-26793 h[D]=C end end else if N<-544014+1503349 then if N<1143563-265600 then C={}N=o[p(885973-875187)]else OX=h[y]rX=p(-498978+509769)fX=h[i]kX=h[f]RX=h[D]eX=16938702051601-309826 zX=RX(rX,eX)RX=-459514+18609919190227 N=15819672-317890 qX=kX[zX]UX={fX(hX,qX)}DX=OX(W(UX))fX=h[f]UX=h[D]kX=p(-1039315+1050038)qX=UX(kX,RX)OX=fX[qX]nX=DX==OX jX=nX end else i=p(871859-861075)P=p(263123+-252401)T=o[i]i=O()H=940348809887-(-630550)h[i]=T T=o[P]NX=14760260637595-(-509758)y=p(127116+-116413)P=O()h[P]=T ZX=p(59125-48399)T=o[y]y=O()X=p(-686902+697691)a=36543+11682589623937 h[y]=T b=p(472277+-461545)c=31044659312090-32098 T=o[b]pX=-351843+18273693302688 b=O()h[b]=T T=z(14349033-252933,{f;D})B=h[f]A=h[D]I=-792124+28236380359064 w=A(X,H)u=B[w]H=p(983871+-973142)g=16255634780752-201919 V=28994987783075-1015526 K=11976369163768-260144 J=24997667690930-863290 v=T(u)G=12843440664829-596385 u=O()h[u]=v A=h[f]w=h[D]X=w(H,G)B=A[X]v=T(B)S=-143167+12407960520144 B=O()h[B]=v w=h[f]G=p(-337379-(-348121))X=h[D]H=X(G,c)A=w[H]v=T(A)A=O()h[A]=v X=h[f]c=p(520252+-509525)H=h[D]G=H(c,I)w=X[G]I=p(5134+5551)v=T(w)w=O()h[w]=v H=h[f]G=h[D]c=G(I,J)J=p(-708760-(-719447))X=H[c]v=T(X)X=O()h[X]=v s=12288372275484-205506 G=h[f]c=h[D]I=c(J,a)H=G[I]v=T(H)dX=187575+10111220413869 H=O()h[H]=v c=h[f]I=h[D]a=p(-646434-(-657181))WX=31822500500069-(-239485)J=I(a,K)G=c[J]v=T(G)G=O()h[G]=v K=p(-80640+91373)I=h[f]J=h[D]a=J(K,g)c=I[a]v=T(c)oX=33949151074944-416960 c=O()h[c]=v g=p(-82412+93156)J=h[f]a=h[D]K=a(g,S)I=J[K]S=p(-872735-(-883452))v=T(I)I=O()h[I]=v a=h[f]K=h[D]g=K(S,s)J=a[g]v=T(J)jX=-56800+11658058740500 J=O()h[J]=v K=h[f]g=h[D]s=p(-467113+477874)S=g(s,V)V=p(-1018560-(-1029278))a=K[S]v=T(a)a=O()h[a]=v g=h[f]S=h[D]s=S(V,oX)K=g[s]v=T(K)K=O()h[K]=v S=h[f]oX=p(-52864+63628)s=h[D]V=s(oX,pX)g=S[V]v=T(g)g=O()pX=p(823733+-812996)h[g]=v s=h[f]V=h[D]oX=V(pX,NX)S=s[oX]v=T(S)S=O()h[S]=v NX=p(358370-347571)V=h[f]oX=h[D]pX=oX(NX,WX)s=V[pX]v=T(s)s=O()WX=p(-528261-(-539079))h[s]=v oX=h[f]pX=h[D]NX=pX(WX,dX)V=oX[NX]v=T(V)V=O()h[V]=v v=k(12465383-932878,{i,q,u,B,y;f;D})pX=O()oX=v()h[pX]=oX NX=h[y]dX=h[pX]WX=NX(dX)dX=h[f]tX=h[D]CX=tX(ZX,jX)NX=dX[CX]oX=WX~=NX N=oX and 5182995-(-53182)or 11556199-(-483956)end end end else if N<-827203+2785617 then if N<-473105+2287708 then if N<351684-(-847260)then if N<893003-(-220007)then N=e(9506780-754345,{f})E={N()}N=o[p(-9836-(-20538))]C={W(E)}else T=870315391796-(-935521)q=p(-85434-(-96116))C=p(583863+-573097)N=o[C]D=h[t[995471+-995470]]C=p(-185640-(-196350))n=h[t[271630+-271628]]f=n(q,T)Y=D[f]C=N[C]C=C(N,Y)Y=C N=Y and 579392+15863403 or 1013330+6230221 C=Y end else if N<2033339-756107 then D=h[t[448212+-448209]]n=-552602-(-552603)Y=D~=n N=Y and-12644+3017188 or 15497114-829309 else i=nil T=nil f=nil N=11738012-(-808741)end end else if N<2329814-471706 then if N<-678713+2519667 then N=12120287-141998 else N=C and 12030408-(-346837)or 1009288+3317001 end else if N<653743+1261458 then N=h[t[-223259-(-223260)]]b=25251252786857-(-841541)Y=h[t[943329-943327]]D=h[t[907016-907013]]P=p(380594-369854)n=h[t[-617248+617252]]C=N(Y,D,n)Y=C N={}D=O()h[D]=N y=6768557946927-388064 N=h[D]C=h[t[-93048+93053]]n=h[t[-104238+104244]]N[C]=n N=h[D]C=h[t[790427+-790420]]n=h[t[-276864+276872]]N[C]=n N=h[D]C=h[t[-895445+895454]]q=h[t[569424-569414]]T=h[t[-749801-(-749812)]]i=T(P,y)f=q[i]y=p(989078-978372)T=h[t[-618420+618430]]i=h[t[389972-389961]]P=i(y,b)q=T[P]n={[f]=q}N[C]=n N=h[D]n=Y C=h[t[19137+-19125]]Y=nil N[C]=n n=e(10722050-(-929924),{t[-342259+342273],D})D=U(D)N=h[t[-296549+296562]]C=N(n)N=o[p(-499118-(-509896))]C={}else N=true N=-948093+2060332 end end end else if N<-797935+3354147 then if N<-700327+2697605 then if N<1307502-(-679363)then b=U(b)NX=U(NX)X=U(X)c=U(c)f=U(f)N=o[p(-427332-(-438140))]V=U(V)i=U(i)S=U(S)H=U(H)D=U(D)q=U(q)u=U(u)B=U(B)oX=U(oX)C={}CX=nil s=U(s)WX=U(WX)T=nil hX=nil a=U(a)w=U(w)dX=U(dX)g=U(g)K=U(K)J=U(J)y=U(y)pX=U(pX)ZX=nil G=U(G)tX=nil P=U(P)v=nil I=U(I)A=U(A)else N=447537-(-523491)T=p(-347407-(-358165))n=o[T]h[q]=n end else if N<1020050+993941 then n=h[t[728353+-728347]]N=13929793-216469 D=n==Y C=D else D=h[t[208463+-208461]]n=-61936-(-62153)Y=D*n D=-470968+24528674167893 C=Y+D Y=35184372649266-560434 N=C%Y h[t[880135-880133]]=N N=15134939-467134 D=-336242-(-336243)Y=h[t[716121-716118]]C=Y~=D end end else if N<731001+2351043 then if N<431032+2401513 then N=true h[t[-579650+579651]]=N C={}N=o[p(415043-404313)]else y=-78648-(-78650)n=631010-630978 D=h[t[939643+-939640]]Y=D%n v=488496-488483 f=h[t[-232745-(-232749)]]i=h[t[-774489-(-774491)]]A=h[t[632220+-632217]]N=8225809-859628 B=A-Y A=854410-854378 u=B/A b=v-u P=y^b T=i/P q=f(T)f=4294121280-(-846016)n=q%f y=-424714-(-424970)q=746797-746795 f=q^Y D=n/f f=h[t[381018+-381014]]P=114068+-114067 i=D%P P=4294166556-(-800740)T=i*P q=f(T)v=-417728-(-417984)f=h[t[508389+-508385]]T=f(D)n=q+T q=-157793-(-223329)D=nil f=n%q T=n-f i=-955935+1021471 q=T/i i=272150-271894 T=f%i Y=nil P=f-T i=P/y y=674865+-674609 P=q%y b=q-P y=b/v q=nil b={T,i;P,y}f=nil n=nil T=nil P=nil i=nil h[t[269597+-269596]]=b y=nil end else G=-61420+61520 c=485960+-485705 H=O()m=p(-316690-(-327384))h[H]=x C=o[m]m=p(-657793+668609)N=C[m]V=148475-138475 m=905116-905115 C=N(m,G)K=p(19798-9066)a=303025+-303023 m=O()h[m]=C N=h[i]J=934261+-934260 G=726275+-726275 C=N(G,c)G=O()c=-392022+392023 h[G]=C N=h[i]I=h[m]C=N(c,I)c=O()h[c]=C C=h[i]I=C(J,a)C=910683+-910682 a=p(120099-109390)s=447978-447978 N=I==C I=O()h[I]=N C=p(-534403+545218)F=o[K]g=h[i]S={g(s,V)}K=F(W(S))F=p(-418053-(-428762))N=p(-455787+466480)N=A[N]L=K..F J=a..L N=N(A,C,J)a=p(-588434-(-599156))J=O()h[J]=N L=e(11178984-242113,{i;H,b;n;D;w;I,J;m,c,G;y})C=o[a]a={C(L)}N={W(a)}a=N N=h[I]N=N and 572263+3119178 or-936015+4183625 end end end end else if N<194288+5797101 then if N<597113+4636025 then if N<3775285-(-597792)then if N<1002212+2793281 then if N<3323890-(-294752)then F=h[D]N=F and 6261602-(-516398)or 14366516-(-812999)L=F else L=h[D]C=L N=L and 564727-493293 or-100450+953484 end else if N<494957+3667417 then YX=p(-297945+308729)jX=o[YX]qX=917850+13564202784594 OX=h[f]DX=h[D]N=-743378+2724555 UX=p(590233-579439)fX=DX(UX,qX)nX=OX[fX]YX=jX(hX,nX)jX=YX(CX)else D=nil N=1025472+12671848 end end else if N<687819+3953055 then if N<4363143-(-145568)then B=nil P=nil v=nil i=U(i)w=U(w)f=U(f)n=U(n)f=O()T=nil i=p(-805509-(-816203))q=U(q)D=U(D)A=nil N=696091+-197913 y=U(y)u=nil D=nil b=U(b)n=nil y=p(67191-56387)h[f]=D D=O()h[D]=n T=p(697772-687078)q=o[T]T=p(855993+-845186)n=q[T]q=O()h[q]=n P=p(427889+-417143)T=o[i]u=O()i=p(-50490-(-61306))n=T[i]i=o[P]P=p(1037270+-1026508)B={}v={}T=i[P]P=o[y]y=p(-448046-(-458743))i=P[y]y=O()P=617677-617677 A=604524+-604523 b=O()h[y]=P P=-682180+682182 h[b]=P P={}w=-500819+501075 h[u]=v X=w w=872665+-872664 v=-459696+459696 H=w w=321696+-321696 m=H<w w=A-H else Y=h[t[367974-367973]]C=#Y Y=570828+-570828 N=C==Y N=N and-53874+2478103 or-720126+8086307 end else if N<4284902-(-705644)then C=p(-625932-(-636703))P=p(1017905+-1007183)f=p(-822467+833199)N=o[C]Y=h[t[640047+-640043]]n=o[f]i=o[P]y=r(-859928+14945977,{})P={i(y)}i=-617622+617624 T={W(P)}q=T[i]f=n(q)n=p(574075-563260)D=Y(f,n)Y={D()}C=N(W(Y))Y=C D=h[t[-705618+705623]]C=D N=D and-224877+2223180 or 14734647-1021323 else C={}N=o[p(-660647+671354)]end end end else if N<-977757+6436672 then if N<6009588-589884 then if N<-1002312+6239132 then C={}N=o[p(444025+-433313)]else J=U(J)H=U(H)c=U(c)m=U(m)a=nil G=U(G)N=717379+6756545 I=U(I)end else if N<-36346+5462677 then f=h[t[-857461+857468]]y=p(-879044-(-889826))q=f(D)T=h[t[-442578+442583]]i=h[t[216968+-216962]]b=32785426275956-(-367918)N=894117-(-956692)P=i(y,b)f=T[P]n=q~=f C=n else N=o[p(335405-324717)]C={Y}end end else if N<-655249+6458374 then if N<-924305+6386962 then N=C and 14503246-669184 or 971392+10962418 else D=h[t[547828-547826]]n=h[t[-1023685+1023688]]N=863420-632170 Y=D==n C=Y end else N=231303+266875 A=w G=A B[A]=G A=nil end end end else if N<6758511-(-252034)then if N<5884787-(-581255)then if N<5557674-(-768048)then if N<6185504-10112 then Y=p(18105+-7315)N=o[Y]D=h[t[837738-837730]]n=989549+-989549 Y=N(D,n)N=7560699-(-947220)else P=b Q=p(212957+-202153)E=o[Q]Q=p(-876083-(-886822))x=E[Q]E=x(Y,P)x=h[t[650706-650700]]Q=x()P=nil w=E+Q N=13913453-868521 A=w+T w=406482+-406226 B=A%w Q=877474-877473 T=B w=n[D]E=T+Q x=f[E]A=w..x n[D]=A end else if N<481640+5910206 then A=p(-855432-(-866166))i=n P=p(97522-86776)C=o[P]w=491114+7468229938987 u=p(890520+-879751)y=h[t[156906-156905]]B=565238+6927914757284 b=h[t[143097-143095]]v=b(u,B)P=y[v]b=p(-495708+506512)N=C[P]y=o[b]v=h[t[-118767-(-118768)]]u=h[t[849549-849547]]B=u(A,w)b=v[B]v=p(-570656-(-581427))A=255401+-255400 P=y[b]b=o[v]u=p(-652784+663505)B=i+A u=Y[u]u=u(Y,i,B)i=nil B=35993-35977 v={b(u,B)}y={P(W(v))}C=N(D,W(y))N=1457570-988350 else T=p(604126+-593346)N=h[t[496974-496973]]Y=h[t[196471-196469]]D=h[t[803714-803711]]i=-646169+30415064175468 C=N(Y,D)Y=C C=h[t[-284998-(-285002)]]D=C(Y)n=h[t[178916-178911]]f=h[t[95678-95672]]q=f(T,i)C=n[q]N=D==C N=N and 16548971-(-70148)or 1008005+12689315 end end else if N<73002+6673284 then if N<-463888+7138095 then w=#B N=10415467-441701 X=1026530+-1026530 A=w==X else N=h[t[647275-647274]]n=N D=d[-761684-(-761686)]N=n[D]Y=d[682451-682450]N=N and 11363523-(-602496)or 12846-(-281993)end else if N<-900491+7738257 then K=-904456-(-904457)F=a[K]L=F N=-177730+15357245 else N=14005684-178966 CX=tX end end end else if N<399303+7677909 then if N<7196286-(-252265)then if N<6516005-(-824040)then N=C and 10367646-394831 or-214372+14585789 else N=o[p(-359536-(-370346))]n=p(-180576-(-191322))D=o[n]n=p(-295097+305859)Y=D[n]n=h[t[-228244-(-228245)]]D={Y(n)}C={W(D)}end else if N<7368207-(-215250)then H=not X x=x+Q C=x<=E C=H and C H=x>=E H=X and H C=H or C H=3861234-696076 N=C and H C=12954239-612394 N=N or C else Y=h[t[10128-10127]]n=h[t[-492716-(-492718)]]f=h[t[-378053-(-378057)]]D=Y(n,f)C=D N=7973550-(-247004)end end else if N<-778513+9121443 then if N<7843639-(-469587)then Y=C i=406071+32901015636385 C=h[t[-185619+185624]]D=C(Y)n=h[t[-404157+404163]]f=h[t[973524-973517]]T=p(640846+-630101)q=f(T,i)C=n[q]N=D==C N=N and 30938+5424369 or-223205+12485072 else qX=9400347416853-886780 nX=p(375038-364288)YX=o[nX]UX=p(-796349+807116)OX=h[f]DX=h[D]kX=p(-117002-(-127756))fX=DX(UX,qX)nX=OX[fX]N=113002+1868175 jX=YX[nX]DX=p(-798917-(-809667))RX=22114943525959-(-689139)OX=o[DX]fX=h[f]UX=h[D]qX=UX(kX,RX)DX=fX[qX]nX=OX[DX]OX={nX(CX)}YX=jX(W(OX))end else E=v==u N=16248267-962348 x=E end end end end end else if N<-269171+12457206 then if N<9699485-(-945318)then if N<10997305-1019037 then if N<9727066-(-75031)then if N<8190119-(-639077)then if N<60926+8614776 then N={}n=h[t[-878954+878963]]D=1024245+-1024244 Y=N f=n n=-179058-(-179059)N=11119668-814743 q=n n=1032642+-1032642 T=q<n n=D-q else N=750259+12394081 end else if N<1004465+8350205 then N=5201898-792984 else i=287575+4790687999327 N={}Y=N N=h[t[-783055-(-783056)]]P=31335336747549-977182 C=h[t[-68286-(-68288)]]T=p(-951546-(-962260))Y[N]=C N=h[t[258650+-258647]]C=h[t[-818230-(-818234)]]Y[N]=C N=h[t[-1007422-(-1007427)]]n=h[t[304153+-304147]]f=h[t[267897+-267890]]q=f(T,i)D=n[q]i=p(654031+-643236)f=h[t[1042968-1042962]]q=h[t[342339+-342332]]T=q(i,P)n=f[T]C={[D]=n}Y[N]=C N=h[t[352436-352428]]C=N(Y)D=C C=D N=D and-433121+14829635 or 10609244-550552 end end else if N<9313441-(-651626)then if N<8927033-(-1028375)then X=p(1022908+-1012183)N=o[X]X=p(442472+-431773)o[X]=N N=2644684-814037 else Y=nil D=nil N=o[p(531734-521010)]C={}end else if N<10699383-725853 then n=h[t[715116-715115]]f=h[t[356204-356202]]i=21565544114178-262344 T=p(-1030651+1041359)q=f(T,i)i=387021+13905685721470 D=n[q]C=Y[D]n=h[t[495514-495513]]f=h[t[369310+-369308]]T=p(726728-715971)q=f(T,i)D=n[q]N=C[D]h[t[36015-36012]]=N N=14805312-433895 else w=-264976-(-264977)G=565250-565249 X=#B A=n(w,X)w=T(B,A)X=h[u]m=w-G N=-206875+12549591 A=nil H=i(m)X[w]=H w=nil end end end else if N<11207753-803927 then if N<228847+9940338 then if N<531542+9471247 then Q=p(-708652-(-719384))N=o[Q]H=p(-641556+652255)X=o[H]Q=N(X)N=p(-807481+818206)o[N]=Q N=1584140-(-246507)else N=C and-899465+11446538 or 598911+9363075 end else if N<-511644+10792659 then N=10776946-(-64668)i=p(235996-225190)T=o[i]i=T()n=i else i=not T n=n+q D=n<=f D=i and D i=n>=f i=T and i D=i or D i=-539293+11249739 N=D and i D=-108107+13588648 N=N or D end end else if N<9983396-(-469216)then if N<-516295+10959719 then n=p(859116+-848370)P=4289103296219-(-266482)i=p(-1016191+1026954)C=o[n]f=h[t[60153-60152]]q=h[t[142107+-142105]]T=q(i,P)n=f[T]N=C[n]C={N(D)}N=o[p(-630706-(-641397))]C={W(C)}else w=O()B=nil m=p(796557-785755)T=nil X=R(5493079-878538,{w,y,b;q})A={}h[w]=A P=nil I=p(-82736-(-93441))A=O()i=nil h[A]=X q=U(q)a=p(618582+-607810)X={}H=O()G={}i=p(535942+-525136)h[H]=X K=nil X=o[m]J=h[H]c={[I]=J;[a]=K}m=X(G,c)X=z(-656286+7363657,{H;w;u;y,b,A})A=U(A)v=nil q=N u=U(u)y=U(y)n=nil w=U(w)h[f]=m h[D]=X T=o[i]N=T and-468755+10651189 or 9885671-(-955943)b=U(b)n=T H=U(H)end else N=h[t[684629+-684620]]P=p(706263-695480)q=h[t[155036+-155030]]y=-223263+16473278170645 T=h[t[497397+-497390]]i=T(P,y)f=q[i]P=-887750+8127333456526 i=p(-19598-(-30407))n=D[f]C=N(n)f=h[t[246857-246851]]q=h[t[-514033-(-514040)]]T=q(i,P)n=f[T]q=h[t[-614416-(-614422)]]P=p(374686+-363904)T=h[t[-893062-(-893069)]]y=23981654818615-463768 N=p(-131636+142329)i=T(P,y)f=q[i]T=-821535-(-821542)N=C[N]N=N(C,n,f)n=N q=#n f=q>=T N=f and 12181195-955412 or 908438+4550479 C=f end end end else if N<12029947-501027 then if N<10047856-(-827818)then if N<11359149-517748 then if N<968546+9789969 then y=-768364+768619 P=36569-36569 D=n N=h[t[-1032400+1032401]]i=N(P,y)Y[D]=i N=9443367-(-861558)D=nil else Q=p(-465049-(-475781))b=31791+-31788 y=O()h[y]=C A=R(-214469-(-796008),{})v=-949403-(-949468)N=h[i]C=N(b,v)b=O()B=p(-774450-(-785172))N=-112549+112549 h[b]=C v=N N=-128743-(-128743)u=N C=o[B]B={C(A)}C=-760166+760168 N={W(B)}B=N N=B[C]A=N C=p(-628647-(-639418))N=o[C]w=h[n]E=o[Q]Q=E(A)E=p(-878325-(-889140))x=w(Q,E)w={x()}C=N(W(w))w=O()h[w]=C C=-914237+914238 x=h[b]N=97830+7376094 E=x x=283990-283989 Q=x x=-463307+463307 X=Q<x x=C-Q end else if N<147607+10715073 then N=q i=p(-760566-(-771269))v=p(-682270-(-693018))q=O()h[q]=n T=o[i]P=h[q]u=25919983866311-320162 i=T(P)P=h[f]y=h[D]b=y(v,u)T=P[b]n=i~=T N=n and-198551+2195686 or 69359+901669 else Q=263467-263466 N=h[i]X=486117+-486111 E=N(Q,X)X=p(426581-415856)N=p(-312279-(-323004))o[N]=E Q=o[X]X=-171907+171909 N=Q>X N=N and 808633+9175044 or 481981+9418203 end end else if N<-904022+12140655 then if N<-645238+11589647 then D=h[t[-536344+536345]]f=865937+-865936 q=-583066+583068 n=D(f,q)D=31281+-31280 Y=n==D N=Y and 187540+43710 or 5650206-162229 C=Y else T=-48976-(-48991)q=#n N=476661+4982256 f=q<=T C=f end else if N<-362041+11746692 then N=true q=O()Y=d n=p(234461-223657)D=O()h[D]=N C=o[n]n=p(391092-380396)f=O()i=p(-372004+382726)N=C[n]n=O()h[n]=N P=k(166660+2508823,{q})N=k(-343773+16250096,{})h[f]=N N=false h[q]=N T=o[i]i=T(P)N=i and 1345640-850989 or 813156-219906 C=i else C=L N=F N=-801390+1654424 end end end else if N<-1010022+12956696 then if N<10756627-(-905717)then if N<12118897-559530 then Y=h[t[959457+-959456]]n=h[t[877450+-877448]]f=h[t[953347-953344]]D=Y(n,f)C=D N=D and-795801+9016355 or 669219+7398488 else N=h[t[-440739-(-440740)]]Y=h[t[124877-124875]]C=N(Y)N=o[p(-906742+917425)]C={}end else if N<695174+11104880 then N=h[t[649729-649728]]n=d[-786790-(-786793)]Y=d[-1008727+1008728]u=13616246405201-319373 m=p(175152+-164340)y=28881239229195-888451 C=N(Y)fX=p(-297881-(-308654))a=882820+27468767590771 pX=94156+13849940126053 q=h[t[-726773+726775]]T=h[t[-752750-(-752753)]]D=d[526697+-526695]P=p(859523+-848709)N=p(-763207-(-773900))MX=p(469783-459007)i=T(P,y)S=28612036491152-934789 f=q[i]rX=p(-1000993+1011790)dX=-1030616+23590543746241 b=20415704402066-(-236688)x=30269174229553-127778 v=p(-564656+575424)YX=69855+11450994689013 T=h[t[796981+-796979]]X=p(174400+-163607)y=p(-299704+310399)i=h[t[194291-194288]]P=i(y,b)y=1033563+17792267983618 q=T[P]OX=p(-941520-(-952251))N=C[N]N=N(C,f,q)P=p(-975900+986677)q=h[t[714014-714012]]b=-376677+27646017270190 T=h[t[410966-410963]]C=p(116163+-105470)i=T(P,y)y=p(-80714-(-91512))oX=p(1004544+-993843)w=p(563542+-552742)C=N[C]f=q[i]T=h[t[-64833+64835]]i=h[t[-378296-(-378299)]]CX=23842726482671-(-514159)TX=34433004676755-(-88079)P=i(y,b)b=-42627+3505025527011 q=T[P]y=p(736063+-725275)C=C(N,f,q)q=p(-395085-(-405789))f=C C=o[q]T=h[t[702641+-702639]]i=h[t[644239+-644236]]DX=28231840056165-(-208885)P=i(y,b)q=T[P]F=p(-331613-(-342351))y=p(-1017312+1028115)iX=p(316498+-305808)N=C[q]E=p(-357865-(-368620))T=h[t[432909-432907]]i=h[t[-354326+354329]]b=-663695+32552530828229 P=i(y,b)b=24284146548760-1020908 q=T[P]C=N(q)q=C T=h[t[740058-740056]]y=p(-728143-(-738871))i=h[t[-1029142-(-1029145)]]kX=5986+16520279721642 P=i(y,b)G=22725646201558-477568 H=-245546+8814540508978 C=T[P]P=h[t[-345002+345004]]y=h[t[-552115+552118]]b=y(v,u)i=P[b]tX=p(974021+-963225)y=h[t[-710082+710086]]u=h[t[-220945-(-220947)]]B=h[t[-261401-(-261404)]]A=B(w,x)v=u[A]A=h[t[5803+-5801]]w=h[t[-958960-(-958963)]]Q=757831290151-(-816185)x=w(E,Q)B=A[x]x=h[t[1022532-1022530]]WX=p(707264+-696529)E=h[t[-972803-(-972806)]]Q=E(X,H)w=x[Q]Q=h[t[474701+-474699]]X=h[t[415174+-415171]]K=144002+9684856463131 H=X(m,G)g=p(145654+-134913)E=Q[H]J=p(-85009+95693)X=h[t[663836+-663831]]G=h[t[309061+-309059]]lX=639353+29100289323893 c=h[t[1019635-1019632]]I=c(J,a)UX=26001333545310-(-214509)m=G[I]J=h[t[874808-874806]]a=h[t[-622359+622362]]L=a(F,K)I=J[L]L=h[t[760208-760206]]F=h[t[-32489-(-32492)]]K=F(g,S)qX=p(-885783+896542)a=L[K]F=h[t[502114-502108]]S=h[t[557041+-557039]]s=h[t[-857225-(-857228)]]V=s(oX,pX)g=S[V]oX=h[t[609738-609736]]pX=h[t[-305869-(-305872)]]NX=pX(WX,dX)hX=p(356381-345570)V=oX[NX]NX=h[t[-820575+820577]]eX=822621+1977868449340 WX=h[t[-330842+330845]]dX=WX(tX,CX)pX=NX[dX]WX=h[t[-359990+359997]]CX=h[t[-705262-(-705264)]]ZX=h[t[547844-547841]]jX=ZX(hX,YX)tX=CX[jX]hX=h[t[205587+-205585]]YX=h[t[-687230+687233]]nX=YX(OX,DX)jX=hX[nX]nX=h[t[986013+-986011]]OX=h[t[108320+-108317]]DX=OX(fX,UX)YX=nX[DX]DX=h[t[133365+-133363]]fX=h[t[-879544+879547]]UX=fX(qX,kX)OX=DX[UX]fX=h[t[-497576+497584]]kX=h[t[-36073+36075]]RX=h[t[1030761-1030758]]zX=RX(rX,eX)qX=kX[zX]zX=h[t[318782+-318780]]rX=h[t[257375+-257372]]eX=rX(MX,lX)RX=zX[eX]eX=h[t[-266037+266039]]MX=h[t[-498434-(-498437)]]lX=MX(iX,TX)rX=eX[lX]zX=q..rX kX=RX..zX UX=qX..kX DX=fX..UX nX=OX..DX hX=YX..nX ZX=jX..hX CX=n..ZX dX=tX..CX NX=WX..dX oX=pX..NX s=V..oX S=D..s K=g..S L=F..K J=a..L c=I..J G=f..c H=m..G Q=X..H x=E..Q A=w..x u=B..A b=v..u P=y..b T=i..P N=C..T T=N C={T}N=o[p(-181187+191957)]else n=nil N=9889610-(-72376)end end else if N<483174+11511989 then if N<13001784-1031522 then N=-989861+13536614 else N=true N=N and-367724+11237102 or 861296+398 end else jX=26710936391228-40358 CX=30382666159990-(-122830)NX=h[f]WX=h[D]tX=p(-442665+453365)dX=WX(tX,CX)ZX=27640844018930-291499 CX=p(915202-904437)oX=NX[dX]DX=p(732457+-721706)NX=O()h[NX]=oX WX=h[f]dX=h[D]tX=dX(CX,ZX)oX=WX[tX]WX=O()kX=p(-581862+592636)h[WX]=oX dX=h[f]tX=h[D]ZX=p(-713999-(-724688))CX=tX(ZX,jX)oX=dX[CX]dX=O()RX=-155606+23241835661852 h[dX]=oX CX=e(1305300-110604,{f,D,NX})oX=h[P]tX=oX(CX)CX=M(557+6454470,{i,q;A;y,f;D;b;WX})oX=h[P]tX=oX(CX)oX=h[P]CX=z(10445423-717429,{H,a;G,X,c,f;D,pX;b;dX})tX=oX(CX)oX=O()tX=l(912002+10857441,{b;f,D,K;g,S;s;V})h[oX]=tX tX=z(1521135-(-392240),{oX,NX,dX,WX;H;J;G,w;c,f,D;I;P;pX})CX=h[i]jX=h[q]fX=448017+6974651987614 YX=h[f]nX=h[D]OX=nX(DX,fX)hX=YX[OX]YX=N ZX=CX(jX,hX)OX=h[y]jX=N DX=OX(ZX)fX=h[f]UX=h[D]qX=UX(kX,RX)OX=fX[qX]nX=DX==OX hX=nX N=nX and 451482+15635164 or 13333139-456257 end end end end else if N<13619329-(-217237)then if N<934747+12244242 then if N<-980881+13518133 then if N<12331786-(-10464)then if N<-498531+12789997 then N=nil C={N}N=o[p(508363-497611)]else E=h[D]x=E N=E and 9117410-702715 or-54172+15340091 end else if N<13099789-753329 then X=752694-752694 w=#B A=w==X N=A and 9806431-(-638395)or 919979+9053787 else N=h[t[-874978+874985]]i=p(576192+-565476)C=N(D)P=-289541+4641297838966 y=-930191+2158607693180 f=h[t[702125-702120]]q=h[t[224203-224197]]T=q(i,P)N=p(329593-318900)n=f[T]P=p(121641-110859)N=C[N]q=h[t[239469+-239464]]T=h[t[998937-998931]]i=T(P,y)f=q[i]N=N(C,n,f)i=p(-863951-(-874711))f=h[t[-152823+152828]]P=-327207+5069285295967 q=h[t[-265451-(-265457)]]C=p(2448-(-8245))T=q(i,P)n=f[T]q=h[t[-564277-(-564282)]]P=p(-125321+136040)T=h[t[-488693-(-488699)]]y=8930400897259-(-214867)i=T(P,y)C=N[C]f=q[i]P=-560750+3098956764177 C=C(N,n,f)f=h[t[412886-412881]]N=p(-277112+287805)q=h[t[-860663-(-860669)]]y=17912725096624-59419 i=p(-110830-(-121644))T=q(i,P)n=f[T]q=h[t[1005400-1005395]]T=h[t[749356+-749350]]P=p(943241-932436)i=T(P,y)f=q[i]N=C[N]N=N(C,n,f)h[t[-47493+47501]]=N N=-852629+5178918 end end else if N<348457+12553690 then if N<12105717-(-651134)then N=o[p(-531964-(-542679))]C={D}else N=YX N=hX and-189736+14016454 or-268684+7275167 CX=hX end else if N<12553685-(-530301)then b=b+v P=b<=y B=not u P=B and P B=b>=y B=u and B P=B or P B=-954489+7214732 N=P and B P=2206759-421733 N=N or P else N=true N=N and-174099-(-990214)or 6047999-824667 end end end else if N<13921742-223719 then if N<94656+13404662 then if N<308162+12931168 then S=35872-35870 g=a[S]S=h[J]K=g==S N=10619708-(-858880)L=K else N=h[t[743762+-743752]]D=h[t[911869+-911858]]Y[N]=D N=h[t[747151-747139]]D={N(Y)}C={W(D)}N=o[p(-229272+240057)]end else if N<-456434+14143115 then N=h[t[690131+-690124]]N=N and 6661383-654767 or 143963+8363956 else C={}N=o[p(-576019+586775)]Y=nil end end else if N<14335366-503927 then if N<55942+13770659 then h[t[510946-510941]]=C N=-80408+13609333 Y=nil else N=jX jX=h[i]UX=p(817806+-807027)YX=h[q]OX=h[f]qX=33378587153768-956593 DX=h[D]kX=p(376745+-366034)fX=DX(UX,qX)nX=OX[fX]RX=30956307076018-285539 hX=jX(YX,nX)YX=N OX=h[y]DX=OX(hX)fX=h[f]UX=h[D]qX=UX(kX,RX)OX=fX[qX]nX=DX==OX jX=nX N=nX and 394968-(-505654)or 15920483-418701 end else N=n h[t[681461+-681451]]=N N=592015+11341795 end end end else if N<48760+15364788 then if N<14237348-(-310463)then if N<31451+14321370 then if N<13982332-(-104785)then C=5138594-729623 n=9656234-(-902330)D=p(850922-840105)Y=D^n N=C-Y Y=N C=p(638704+-627991)N=C/Y C={N}N=o[p(-232750-(-243542))]else N={}D=N C=-953632-(-953633)Y=d[487498-487497]n=#Y f=n n=405976-405974 q=n n=-938339-(-938339)T=q<n n=C-q N=-863894+1333114 end else if N<13837254-(-547981)then N=o[p(-43160+53947)]Y=nil C={}else q=h[t[-902183-(-902189)]]P=p(-464758-(-475494))y=7726020212016-452387 T=h[t[589256-589249]]N=-869150+10927842 i=T(P,y)f=q[i]n=D[f]C=n end end else if N<15891915-669032 then if N<340805+14769616 then n=-975302-(-975389)N=193129+1065049 D=h[t[988425-988422]]Y=D*n D=398603-398346 C=Y%D h[t[942391+-942388]]=C else h[D]=L s=-8698-(-8699)S=h[c]g=S+s K=a[g]F=v+K K=962598+-962342 N=F%K g=h[G]v=N K=u+g g=-187614+187870 F=K%g N=570781+4848794 u=F end else if N<-678858+16051901 then h[D]=x N=h[D]N=N and-608378+9827527 or 2502405-560002 else N=-873292+12851581 end end end else if N<908889+15222644 then if N<15472092-(-161294)then if N<16118611-623724 then N=true N=N and 15680590-268102 or 266400-(-845839)else N=YX N=jX and-925586+5065611 or 9280102-947042 end else if N<16251770-251330 then C=p(365990+-355200)N=o[C]Y=p(-655968+666654)C=N(Y)C={}N=o[p(-752956-(-763676))]else N=458590+12418292 nX=ZX(tX)hX=nX end end else if N<-289927+16829729 then if N<653805+15605559 then N=230209-(-266303)B=p(81210-70464)u=o[B]B=p(-749586+760339)v=u[B]y=v else P=5886389737875-(-94498)f=h[t[85956+-85955]]q=h[t[-868331+868333]]i=p(-347638+358451)T=q(i,P)n=f[T]D=Y[n]C=D N=340394+6903157 end else N=Y()D=N N=D and 6125416-705586 or 1174143-(-676666)C=D end end end end end end end N=#Z return W(C)end,function(o,p)local W=n(p)local d=function(d,t,Z,j,C)return N(o,{d;t;Z,j;C},p,W)end return d end,function(o)local p,N=896592+-896591,o[-355578+355579]while N do Y[N],p=Y[N]-(447189-447188),(-212552+212553)+p if Y[N]==795905+-795905 then Y[N],h[N]=nil,nil end N=o[p]end end,{},function(o,p)local W=n(p)local d=function(d,t,Z,j,C,h,Y)return N(o,{d,t,Z,j,C;h,Y},p,W)end return d end,function(o,p)local W=n(p)local d=function(...)return N(o,{...},p,W)end return d end,{},function(o,p)local W=n(p)local d=function()return N(o,{},p,W)end return d end,function(o,p)local W=n(p)local d=function(d,t,Z,j)return N(o,{d;t,Z;j},p,W)end return d end,9809-9809,function(o,p)local W=n(p)local d=function(d,t,Z)return N(o,{d;t,Z},p,W)end return d end,function(o,p)local W=n(p)local d=function(d)return N(o,{d},p,W)end return d end,function(o)Y[o]=Y[o]-(921016-921015)if Y[o]==-200181-(-200181)then Y[o],h[o]=nil,nil end end,function(o)for p=1038399-1038398,#o,-922764-(-922765)do Y[o[p]]=(860102+-860101)+Y[o[p]]end if d then local N=d(true)local W=Z(N)W[p(-477298-(-488003))],W[p(-192801-(-203582))],W[p(-990192-(-1000884))]=o,f,function()return-555218+2624152 end return N else return t({},{[p(359647-348866)]=f;[p(-662646-(-673351))]=o;[p(-893926-(-904618))]=function()return 1983066-(-85868)end})end end,function()D=(153207+-153206)+D Y[D]=876104-876103 return D end,function(o,p)local W=n(p)local d=function(d,t)return N(o,{d,t},p,W)end return d end return(q(12188497-883977,{}))(W(C))end)(getfenv and getfenv()or _ENV,unpack or table[p(173792+-163039)],newproxy,setmetatable,getmetatable,select,{...})end)(...)


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
