--[[
    NEW EXAMPLE SCRIPT – FULL DEMONSTRATION OF THE ATLANTA UI LIBRARY
    This script shows every available function of the library exactly once.
    The library is loaded from the external source (same as original).
    All functions are thoroughly commented in English.
]]

-- Load the library and themes
local library, themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/fakealexxx/ui-core/refs/heads/main/UI-CORE/Atlanta/Atlanta-Library.lua"))()

-- Shortcuts for convenience
local dim2 = UDim2.new
local hex = Color3.fromHex

-- ============================================================
-- 1. CREATE THE MAIN WINDOW
--    Parameters: name (title), size (UDim2), position (optional)
--    Returns a window object used to create tabs.
-- ============================================================
local window = library:window({
    name = "Atlanta Example | " .. os.date('%d.%m.%Y'),
    size = dim2(0, 700, 0, 650)   -- width 700, height 650
})

-- ============================================================
-- 2. CREATE TABS
--    Each tab is a separate section of the UI.
-- ============================================================
local mainTab = window:tab({ name = "Main" })
local settingsTab = window:tab({ name = "Settings" })
local espTab = window:tab({ name = "ESP" })
local playersTab = window:tab({ name = "Players" })

-- ============================================================
-- 3. COLUMNS AND MULTI‑SECTION BLOCKS
--    column – a vertical container for sections.
--    multi_section – creates multiple sub‑tabs within one section (switchable).
-- ============================================================

-- Create two columns in the main tab
local col1 = mainTab:column()
local col2 = mainTab:column()

-- ------------------------------------------------------------
-- 3.1. multi_section – groups elements into sub‑tabs
--      Parameters: names – array of sub‑tab names.
--      Returns a table of sections, each behaving like a normal section.
-- ------------------------------------------------------------
local sectionA, sectionB = col1:multi_section({ names = { "Target Settings", "Visuals" } })

-- ------------------------------------------------------------
-- 3.2. section – a regular section with a header and scrolling.
--      Inside it you place control elements.
-- ------------------------------------------------------------
local generalSection = col1:section({ name = "General Settings" })

-- ============================================================
-- 4. CONTROL ELEMENTS
--    All elements return an object with methods: set(), set_visible(), etc.
-- ============================================================

-- ------------------------------------------------------------
-- 4.1. toggle – on/off switch
--      Parameters: name, flag (unique key), default (initial state),
--                  callback (function called on change), tooltip (hover text).
-- ------------------------------------------------------------
local toggleExample = generalSection:toggle({
    name = "Enable Feature",
    flag = "my_toggle",
    default = true,
    tooltip = "This is a toggle example",
    callback = function(value)
        print("Toggle changed:", value)
    end
})

-- ------------------------------------------------------------
-- 4.2. slider – numeric slider
--      Parameters: name, flag, min, max, default, interval (step),
--                  suffix (e.g. "ms"), callback.
-- ------------------------------------------------------------
generalSection:slider({
    name = "Animation Speed",
    flag = "my_slider",
    min = 0,
    max = 100,
    default = 50,
    interval = 1,
    suffix = "%",
    callback = function(value)
        print("Slider value:", value)
    end
})

-- ------------------------------------------------------------
-- 4.3. dropdown – dropdown list (single or multiple selection)
--      Parameters: name, flag, items (table of strings), default (value or table),
--                  multi (true/false), scrolling (enable scroll for long lists),
--                  callback.
-- ------------------------------------------------------------
local dropdownExample = generalSection:dropdown({
    name = "Select Mode",
    flag = "my_dropdown",
    items = { "Mode 1", "Mode 2", "Mode 3" },
    default = "Mode 2",
    callback = function(value)
        print("Selected:", value)
    end
})

-- Multi‑select dropdown
generalSection:dropdown({
    name = "Multiple Selection",
    flag = "my_multi_dropdown",
    items = { "Option A", "Option B", "Option C", "Option D" },
    default = { "Option A", "Option C" },
    multi = true,
    callback = function(values)
        print("Selected:", table.concat(values, ", "))
    end
})

-- ------------------------------------------------------------
-- 4.4. colorpicker – color picker (with transparency)
--      Parameters: name, flag, color (initial), alpha (opacity),
--                  callback (called when color changes).
-- ------------------------------------------------------------
generalSection:colorpicker({
    name = "Accent Color",
    flag = "my_color",
    color = hex("#FF5733"),
    alpha = 0.8,
    callback = function(color, transparency)
        print("Color:", color, "Transparency:", transparency)
    end
})

-- ------------------------------------------------------------
-- 4.5. keybind – key binding (modes: toggle, hold, always)
--      Parameters: name, flag, key (default key, e.g. Enum.KeyCode.F),
--                  mode (toggle/hold/always), default (active initially),
--                  callback (called on state change).
-- ------------------------------------------------------------
generalSection:keybind({
    name = "Activation Key",
    flag = "my_keybind",
    key = Enum.KeyCode.F,
    mode = "toggle",
    default = false,
    callback = function(active)
        print("Key state:", active)
    end
})

-- ------------------------------------------------------------
-- 4.6. list – a selectable list (with search)
--      Parameters: flag, items (array of strings), default, callback.
-- ------------------------------------------------------------
generalSection:list({
    flag = "my_list",
    items = { "Profile 1", "Profile 2", "Profile 3" },
    default = "Profile 1",
    callback = function(value)
        print("Selected profile:", value)
    end
})

-- ------------------------------------------------------------
-- 4.7. textbox – text input field
--      Parameters: flag, placeholder (hint), default, callback.
-- ------------------------------------------------------------
generalSection:textbox({
    flag = "my_textbox",
    placeholder = "Enter name...",
    default = "Player",
    callback = function(text)
        print("Input:", text)
    end
})

-- ------------------------------------------------------------
-- 4.8. button_holder – container for buttons (horizontal layout)
--      Used together with button.
-- ------------------------------------------------------------
local buttonHolder = generalSection:button_holder({})
buttonHolder:button({
    name = "Click Me",
    callback = function()
        print("Button pressed!")
        library:notification({ text = "You clicked the button!", time = 3 })
    end
})
buttonHolder:button({
    name = "Copy",
    callback = function()
        setclipboard("Example text")
        library:notification({ text = "Copied!", time = 2 })
    end
})

-- ------------------------------------------------------------
-- 4.9. label – plain text (can be updated with .set())
-- ------------------------------------------------------------
local infoLabel = generalSection:label({ name = "Info: waiting..." })
-- Later you can update: infoLabel.set("New value")

-- ============================================================
-- 5. SECOND COLUMN (col2) – more elements
-- ============================================================
local sectionC = col2:section({ name = "Extra" })

-- Another toggle
sectionC:toggle({
    name = "Show Watermark",
    flag = "show_watermark",
    default = true,
    callback = function(value)
        if watermark then watermark.set_visible(value) end
    end
})

-- Another slider
sectionC:slider({
    name = "Volume",
    flag = "volume",
    min = 0,
    max = 100,
    default = 70,
    interval = 5,
    suffix = "%"
})

-- ------------------------------------------------------------
-- 5.1. dropdown with scrolling (scrolling = true)
-- ------------------------------------------------------------
sectionC:dropdown({
    name = "Long List (with scroll)",
    flag = "long_list",
    items = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
              "Item 6", "Item 7", "Item 8", "Item 9", "Item 10" },
    default = "Item 5",
    scrolling = true
})

-- ------------------------------------------------------------
-- 5.2. keybind in "hold" mode
-- ------------------------------------------------------------
sectionC:keybind({
    name = "Hold Key",
    flag = "hold_key",
    key = Enum.KeyCode.LeftControl,
    mode = "hold",
    callback = function(active)
        print("Hold active:", active)
    end
})

-- ============================================================
-- 6. "SETTINGS" TAB – theme, watermark, notifications
-- ============================================================
local settingsCol = settingsTab:column()
local themeSection = settingsCol:section({ name = "Theme" })

-- ------------------------------------------------------------
-- 6.1. Change theme colours via colorpicker (as in original)
-- ------------------------------------------------------------
themeSection:label({ name = "Accent" })
    :colorpicker({
        name = "Accent Color",
        flag = "accent_color",
        color = themes.preset.accent,
        callback = function(color)
            library:update_theme("accent", color)
        end
    })

themeSection:label({ name = "Background (low)" })
    :colorpicker({
        name = "Low Contrast",
        flag = "low_contrast",
        color = themes.preset.low_contrast,
        callback = function(color)
            library:update_theme("low_contrast", color)
        end
    })

themeSection:label({ name = "Background (high)" })
    :colorpicker({
        name = "High Contrast",
        flag = "high_contrast",
        color = themes.preset.high_contrast,
        callback = function(color)
            library:update_theme("high_contrast", color)
        end
    })

-- ------------------------------------------------------------
-- 6.2. Create a watermark
--      Parameters: text (initial text) or default.
-- ------------------------------------------------------------
local watermark = library:watermark({
    default = "Example Watermark | " .. os.date('%H:%M:%S')
})

-- Update watermark every second (demonstration)
task.spawn(function()
    while true do
        task.wait(1)
        watermark.change_text("Current time: " .. os.date('%H:%M:%S'))
    end
end)

-- ------------------------------------------------------------
-- 6.3. Notifications
--      Parameters: text, time (in seconds).
-- ------------------------------------------------------------
settingsCol:section({ name = "Notifications" }):button_holder({})
    :button({
        name = "Show Notification",
        callback = function()
            library:notification({
                text = "This is a notification example!",
                time = 5
            })
        end
    })
    :button({
        name = "Error Notification",
        callback = function()
            library:notification({
                text = "❌ Error: something went wrong",
                time = 4
            })
        end
    })

-- ============================================================
-- 7. "ESP" TAB – esp_preview demonstration
--    esp_preview creates a preview of ESP based on current settings.
--    It accepts an empty table and returns an object with refresh_elements().
--    Requires flags like "esp_enabled", "esp_boxes", etc. to work.
-- ============================================================
local espCol = espTab:column()
local espSection = espCol:section({ name = "ESP Settings" })

-- Create switches and other elements that affect ESP
espSection:toggle({
    name = "Enable ESP",
    flag = "esp_enabled",
    default = true
})
espSection:toggle({
    name = "Names",
    flag = "esp_names",
    default = true
})
espSection:toggle({
    name = "Boxes",
    flag = "esp_boxes",
    default = true
})
espSection:dropdown({
    name = "Box Type",
    flag = "esp_box_type",
    items = { "Corner", "Full" },
    default = "Corner"
})
espSection:toggle({
    name = "Health",
    flag = "esp_health",
    default = true
})
espSection:toggle({
    name = "Distance",
    flag = "esp_distance",
    default = true
})
espSection:toggle({
    name = "Weapon",
    flag = "esp_weapon",
    default = true
})

-- Create the ESP preview section
local espPreviewSection = espCol:section({ name = "Preview" })
local espPreview = espPreviewSection:esp_preview({})

-- Add a color picker for box colour
espSection:colorpicker({
    name = "Box Color",
    flag = "esp_box_color",
    color = hex("#00FF00"),
    callback = function(color)
        espPreview.refresh_elements()
    end
})

-- Function to refresh ESP preview when toggles change
local function updateESP()
    espPreview.refresh_elements()
end

-- Dummy toggle to trigger refresh (for demonstration)
espSection:toggle({
    name = "Refresh ESP (demo)",
    flag = "esp_update_dummy",
    default = false,
    callback = updateESP
})

-- Force initial refresh
task.wait(0.5)
espPreview.refresh_elements()

-- ============================================================
-- 8. "PLAYERS" TAB – playerlist demonstration
--    playerlist creates a list of players with priority assignment.
--    Returns methods for search, labels, etc.
-- ============================================================
local playersCol = playersTab:column()
local playerSection = playersCol:section({ name = "Player List" })

-- Create the playerlist
local playerlist = playerSection:playerlist({})

-- Add a label to show the selected player
local selectedLabel = playerSection:label({ name = "Selected: none" })

-- Monitor selection changes (library.selected_player is updated by playerlist)
task.spawn(function()
    while true do
        task.wait(0.5)
        local selected = library.selected_player
        if selected then
            selectedLabel.set("Selected: " .. selected .. " (priority: " .. (library.get_priority(selected) or "unknown") .. ")")
        else
            selectedLabel.set("Selected: none")
        end
    end
end)

-- ============================================================
-- 9. ADDITIONAL FEATURES
--    - library:config_list_update() – updates config list (used in Config panel)
--    - library:get_config() / load_config() – for config management
--    - library:notification() – already shown
--    - library:tool_tip() – used internally, no need to call manually
-- ============================================================

-- ============================================================
-- 10. FINALISATION
--     Open the main tab by default, apply theme, save old config.
-- ============================================================
mainTab.open_tab()

-- Update config list (if config folder exists)
library:config_list_update()

-- Apply theme (as in original)
for index, value in pairs(themes.preset) do
    pcall(function()
        library:update_theme(index, value)
    end)
end

-- Store current config for rollback
library.old_config = library:get_config()

print("Library loaded. Example script ready.")
