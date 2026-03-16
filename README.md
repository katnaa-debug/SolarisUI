
# 🌌 Solaris UI Library



**Solaris** is a modern, fully animated, and highly customizable user interface library for Roblox script execution. It features a built-in configuration manager, theme editor, key system, and optimized tween animations.

---

## 📢 Social Networks
- Telegram: t.me/SolarisUI
- Owner Telegram: @x_kat4na_x


## ✨ Features

- **Fluid Animations:** Smooth tweens for all interactions (hover, click, toggle, window events).
- **Theme System:** 13+ Built-in presets or full customization via Lua tables (Gradients, Image Backgrounds, Transparency).
- **Config Manager:** Auto-save/load functionality for flags.
- **Key System:** Secure your script with a built-in key verification interface.
- **Modern Layouts:** Supports standard lists and 2-column block layouts.
- **Optimized:** Low memory usage with global render loops.

---

## 📥 Installation

Load the library directly into your script using `loadstring`:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/katnaa-debug/SolarisUI/refs/heads/main/Lib.lua"))()
```

## 📚 Documentation
1. Key System (Optional)

If you want to protect your script, call this before creating the window.

```lua
Library:KeySystem({
    Key = "SecretKey123",             -- The correct key
    Link = "https://discord.gg/...",  -- Link copied to clipboard
    Title = "Solaris Key System",     -- Window title
    Theme = "Void"                    -- Theme for the key window
})
```

2. Creating a Window

You can use a Preset Theme name or a Custom Table.
Option A: Preset Theme


```lua
local Window = Library:CreateWindow({
    Title = "My Script Hub",
    Theme = "Void",                  -- See "Themes" section below for list
    ToggleKey = Enum.KeyCode.RightShift,
    Transparency = 0.25,             -- Window Background Transparency (0-1)
    ShowWatermark = {
        Enabled = true,
        Title = true,
        User = false,
        FPS = true,
        Time = false,
        Ping = true
    },             -- Top HUD (FPS, Ping, Time)
    AutoSave = true,                 -- Enable auto-saving configs
    ConfigFolder = "MyScriptConfig", -- Folder name in Executor Workspace
    CustomIcon = "1234567890"        -- (Optional) Icon ID (if don't need just delete this)
})
```

Option B: Custom Theme Table

Full control over colors and transparency (0-100 scale).

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Theme = {
        Font = "GothamBold",          -- See "Fonts" section below for list
        ImageTransparency = 50,       -- 0-100
        BGTransparency = 0,          -- 0-100
        OrbsTransparency = 90,        -- 0-100
        BackgroundID = "1234567890",    -- Image Texture ID
        Main = Color3.fromRGB(20, 20, 20),
        Second = Color3.fromRGB(30, 30, 30),
        ElementAccent = Color3.fromRGB(250, 20, 250),
        TextColor = Color3.fromRGB(255, 255, 255),
        GradientStart = Color3.fromRGB(0, 0, 255),
        GradientEnd = Color3.fromRGB(255, 0, 0)
    },
    ToggleKey = Enum.KeyCode.RightShift, -- Open/Close bind
    Transparency = 0.25,                 -- Window Background Transparency (0-1)
    ShowWatermark = {
        Enabled = true,
        Title = true,
        User = false,
        FPS = true,
        Time = false,
        Ping = true
    },             -- Top HUD (FPS, Ping, Time)
    AutoSave = true,                     -- Enable auto-saving configs
    ConfigFolder = "MyScriptConfig",     -- Folder name in Executor Workspace
    CustomIcon = "1234567890"            -- (Optional) Icon ID (if don't need just delete this)
})
```

3. Tabs & Containers
Standard Tab

```lua
local MainTab = Window:CreateTab("Main")
```

Settings/Column Tab

Use true as the second argument to enable Block mode (Side-by-side columns).

```lua
local SettingsTab = Window:CreateTab("Settings", true)
```

Creating Blocks (For Column Tabs Only), you can make unlimited blocks on each side

```lua
local LeftBlock = SettingsTab:CreateBlock({
    Name = "Player",
    Side = "Left" -- Side: "Left" or "Right"
})

-- Now add elements to the block:
LeftBlock:CreateToggle({ ... })

LeftBlock:CreateButton({ ... })
-- etc.
```

## 📖 Elements UI

Section
```lua
MainTab:CreateSection("Section")
```


Button
```lua
MainTab:CreateButton({
    Name = "Click",
    Callback = function()
        print("Pressed")
    end
})
```

Toggle

```lua
MainTab:CreateToggle({
    Name = "Toggle",
    Default = false, -- or true
    Flag = "AutoFarm", 
    Callback = function(State)
        print("Toggled:", State)
    end
})
```

Slider

```lua
MainTab:CreateSlider({
    Name = "Slider",
    Min = 16,
    Max = 200,
    Default = 16,
    Flag = "Slider",
    Callback = function(Value)
        print("Value:", Value)
    end
})
```

Input (TextBox)

```lua
MainTab:CreateInput({
    Name = "Nickname",
    Placeholder = "Nick",
    Default = "",
    Flag = "Input",
    Callback = function(Text)
        print("Input:", Text)
    end
})
```

Dropdown

```lua
local Drop = MainTab:CreateDropdown({
    Name = "Select Mode",
    Items = {"Easy", "Medium", "Hard"},
    Default = "Medium",
    Flag = "ModeDrop",
    Callback = function(Value)
        print("Selected:", Value)
    end
})
```

Color Picker

```lua
MainTab:CreateColorPicker({
    Name = "Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "ColorPicker",
    Callback = function(Color)
        print("Color:", Color)
    end
})
```

Keybind

```lua
MainTab:CreateKeybind({
    Name = "Example",
    Default = Enum.KeyCode.Delete,
    Flag = "Bind",
    Callback = function()
        print("Key pressed")
    end
})
```

Notifications

Send a notification to the user (Bottom Right).

```lua
Library:Notify({
    Title = "Alert",
    Content = "Script loaded!",
    Duration = 5, -- In seconds
    ImageID = "4483345998" -- Optional: Asset ID (if need standart delete this)
})
```

## 🎨 Themes

Available built-in themes:

Default, Blood, Purple, Abyss, Ocean, Toxic, Sunrise, Vaporwave, Gold, Orange, Mint, Night, Void.

## 🅰️ Fonts

Available Fonts:

Gotham, GothamBold, SourceSans, SourceSansBold, Oswald, Roboto, RobotoMono, Sarpanch, Code, AmaticSC, FredokaOne, Jura, Arcade, SciFi, Ubuntu, Arial, Cartoon, Highway, Bodoni, Garamond, Nunito
