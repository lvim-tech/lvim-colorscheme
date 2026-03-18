local M = {}

-- Theme families: lighter → base → darker → light
local families = {
    {
        label = "Lvim",
        icon  = "󰖔",
        items = {
            { label = "Lvim Soft",   icon = "󰖨", style = "lvim_soft"   },
            { label = "Lvim Dark",   icon = "●",  style = "lvim_dark"   },
            { label = "Lvim Darker", icon = "󰖓",  style = "lvim_darker" },
            { label = "Lvim Light",  icon = "󰛪",  style = "lvim_light"  },
        },
    },
    {
        label = "Kanagawa",
        icon  = "󱏿",
        items = {
            { label = "Kanagawa Lighter", icon = "󰖨", style = "kanagawa_lighter" },
            { label = "Kanagawa",         icon = "●",  style = "kanagawa"         },
            { label = "Kanagawa Darker",  icon = "󰖓",  style = "kanagawa_darker"  },
            { label = "Kanagawa Light",   icon = "󰛪",  style = "kanagawa_light"   },
        },
    },
    {
        label = "Gruvbox",
        icon  = "󰏘",
        items = {
            { label = "Gruvbox Lighter", icon = "󰖨", style = "gruvbox_lighter" },
            { label = "Gruvbox",         icon = "●",  style = "gruvbox"         },
            { label = "Gruvbox Darker",  icon = "󰖓",  style = "gruvbox_darker"  },
            { label = "Gruvbox Light",   icon = "󰛪",  style = "gruvbox_light"   },
        },
    },
    {
        label = "Everforest",
        icon  = "󰄛",
        items = {
            { label = "Everforest Soft",   icon = "󰖨", style = "everforest_soft"   },
            { label = "Everforest Dark",   icon = "●",  style = "everforest_dark"   },
            { label = "Everforest Darker", icon = "󰖓",  style = "everforest_darker" },
            { label = "Everforest Light",  icon = "󰛪",  style = "everforest_light"  },
        },
    },
}

-- Returns the style name of the currently active lvim theme (or nil)
local function active_style()
    local name = vim.g.colors_name or ""
    return name:match("^lvim%-(.+)$")
end

function M.open()
    local ok, ui = pcall(require, "lvim-utils.ui")
    if not ok then
        vim.notify("lvim-utils not found – cannot open theme picker", vim.log.levels.ERROR)
        return
    end

    local current_style = active_style()

    -- Build tabs, keeping a reference to the currently-active item so that
    -- lvim-utils can highlight it with the current_item indicator (➤).
    -- current_item comparison in popup.lua uses reference equality, so we
    -- must pass the exact same table object that lives in tabs[n].items.
    local tabs = {}
    local found_item_ref = nil
    local found_tab_idx  = nil

    for ti, fam in ipairs(families) do
        local items = {}
        for _, def in ipairs(fam.items) do
            local item = { label = def.label, icon = def.icon, _style = def.style }
            if def.style == current_style then
                found_item_ref = item  -- keep reference BEFORE pushing to array
                found_tab_idx  = ti
            end
            items[#items + 1] = item
        end
        tabs[#tabs + 1] = { label = fam.label, icon = fam.icon, items = items }
    end

    ui.tabs({
        title        = " Colorscheme",
        subtitle     = current_style and ("  lvim-" .. current_style) or nil,
        tabs         = tabs,
        tab_selector = found_tab_idx,   -- open on the tab that owns the active style
        current_item = found_item_ref,  -- highlight the active style with ➤
        width        = 0.38,
        height       = 0.5,
        position     = "editor",
        callback = function(confirmed, result)
            if not confirmed or type(result) ~= "table" then return end
            local item = result.item
            if type(item) ~= "table" or not item._style then return end
            require("lvim-colorscheme").load({ style = item._style })
        end,
    })
end

return M
