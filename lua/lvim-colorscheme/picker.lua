-- lvim-colorscheme: the :LvimColorscheme theme picker.
-- Prefers the lvim-utils floating tabs UI (one tab per family, live preview as the cursor
-- moves, ➤ on the active style). Falls back to the built-in vim.ui.select when lvim-utils
-- is absent, so the picker has no hard dependency.
--
---@module "lvim-colorscheme.picker"

local M = {}

-- Theme families: lighter → base → darker → light
local families = {
    {
        label = "Lvim",
        icon = "󰏘",
        items = {
            { label = "Lvim Soft", icon = "◔", style = "lvim_soft" },
            { label = "Lvim Dark", icon = "◑", style = "lvim_dark" },
            { label = "Lvim Darker", icon = "●", style = "lvim_darker" },
            { label = "Lvim Light", icon = "○", style = "lvim_light" },
        },
    },
    {
        label = "Kanagawa",
        icon = "󰏘",
        items = {
            { label = "Kanagawa Soft", icon = "◔", style = "kanagawa_soft" },
            { label = "Kanagawa Dark", icon = "◑", style = "kanagawa_dark" },
            { label = "Kanagawa Darker", icon = "●", style = "kanagawa_darker" },
            { label = "Kanagawa Light", icon = "○", style = "kanagawa_light" },
        },
    },
    {
        label = "Gruvbox",
        icon = "󰏘",
        items = {
            { label = "Gruvbox Soft", icon = "◔", style = "gruvbox_soft" },
            { label = "Gruvbox Dark", icon = "◑", style = "gruvbox_dark" },
            { label = "Gruvbox Darker", icon = "●", style = "gruvbox_darker" },
            { label = "Gruvbox Light", icon = "○", style = "gruvbox_light" },
        },
    },
    {
        label = "Everforest",
        icon = "󰏘",
        items = {
            { label = "Everforest Soft", icon = "◔", style = "everforest_soft" },
            { label = "Everforest Dark", icon = "◑", style = "everforest_dark" },
            { label = "Everforest Darker", icon = "●", style = "everforest_darker" },
            { label = "Everforest Light", icon = "○", style = "everforest_light" },
        },
    },
    {
        label = "Catppuccin",
        icon = "󰏘",
        items = {
            { label = "Catppuccin Soft", icon = "◔", style = "catppuccin_soft" },
            { label = "Catppuccin Dark", icon = "◑", style = "catppuccin_dark" },
            { label = "Catppuccin Darker", icon = "●", style = "catppuccin_darker" },
            { label = "Catppuccin Light", icon = "○", style = "catppuccin_light" },
        },
    },
    {
        label = "Tokyo Night",
        icon = "󰏘",
        items = {
            { label = "Tokyo Night Soft", icon = "◔", style = "tokyonight_soft" },
            { label = "Tokyo Night Dark", icon = "◑", style = "tokyonight_dark" },
            { label = "Tokyo Night Darker", icon = "●", style = "tokyonight_darker" },
            { label = "Tokyo Night Light", icon = "○", style = "tokyonight_light" },
        },
    },
    {
        label = "Nord",
        icon = "󰏘",
        items = {
            { label = "Nord Soft", icon = "◔", style = "nord_soft" },
            { label = "Nord Dark", icon = "◑", style = "nord_dark" },
            { label = "Nord Darker", icon = "●", style = "nord_darker" },
            { label = "Nord Light", icon = "○", style = "nord_light" },
        },
    },
    {
        label = "Dracula",
        icon = "󰏘",
        items = {
            { label = "Dracula Soft", icon = "◔", style = "dracula_soft" },
            { label = "Dracula Dark", icon = "◑", style = "dracula_dark" },
            { label = "Dracula Darker", icon = "●", style = "dracula_darker" },
            { label = "Dracula Light", icon = "○", style = "dracula_light" },
        },
    },
    {
        label = "Rosé Pine",
        icon = "󰏘",
        items = {
            { label = "Rosé Pine Soft", icon = "◔", style = "rosepine_soft" },
            { label = "Rosé Pine Dark", icon = "◑", style = "rosepine_dark" },
            { label = "Rosé Pine Darker", icon = "●", style = "rosepine_darker" },
            { label = "Rosé Pine Light", icon = "○", style = "rosepine_light" },
        },
    },
    {
        label = "Material",
        icon = "󰏘",
        items = {
            { label = "Material Soft", icon = "◔", style = "material_soft" },
            { label = "Material Dark", icon = "◑", style = "material_dark" },
            { label = "Material Darker", icon = "●", style = "material_darker" },
            { label = "Material Light", icon = "○", style = "material_light" },
        },
    },
    {
        label = "Solarized",
        icon = "󰏘",
        items = {
            { label = "Solarized Soft", icon = "◔", style = "solarized_soft" },
            { label = "Solarized Dark", icon = "◑", style = "solarized_dark" },
            { label = "Solarized Darker", icon = "●", style = "solarized_darker" },
            { label = "Solarized Light", icon = "○", style = "solarized_light" },
        },
    },
    {
        label = "Nightfox",
        icon = "󰏘",
        items = {
            { label = "Nightfox Soft", icon = "◔", style = "nightfox_soft" },
            { label = "Nightfox Dark", icon = "◑", style = "nightfox_dark" },
            { label = "Nightfox Darker", icon = "●", style = "nightfox_darker" },
            { label = "Nightfox Light", icon = "○", style = "nightfox_light" },
        },
    },
}

--- Flat list of every colorscheme name (the value passed to `:colorscheme`), in
--- family/variant order. Useful for a settings dropdown that never goes stale.
---@return string[]
function M.list()
    local out = {}
    for _, fam in ipairs(families) do
        for _, def in ipairs(fam.items) do
            -- colorscheme name = "lvim-" + style (dashes), with the redundant "lvim_" prefix
            -- of the base family stripped (lvim_soft → lvim-soft, catppuccin_soft → lvim-catppuccin-soft).
            out[#out + 1] = "lvim-" .. (def.style:gsub("^lvim_", ""):gsub("_", "-"))
        end
    end
    return out
end

--- The style name of the currently active lvim theme (or nil).
---@return string|nil
local function active_style()
    local name = vim.g.colors_name or ""
    return name:match("^lvim%-(.+)$")
end

--- Apply a style. `preview = true` is the lightweight live-preview path (no `hi clear`,
--- no User autocmd — see theme.setup); the final committed choice uses a full load.
---@param style string
---@param preview? boolean
local function apply(style, preview)
    require("lvim-colorscheme").load({ style = style, _preview = preview or nil })
end

--- Snapshot the picker's own chrome highlights (every `LvimUi*` group). Live preview
--- re-applies the previewed theme's highlights globally, which would recolour the picker
--- itself on every keystroke; restoring this snapshot after each preview keeps the picker
--- visually stable (the theme is previewed in the editor behind it, not in the picker).
---@return table<string, table>
local function snapshot_chrome()
    local snap = {}
    for name, def in pairs(vim.api.nvim_get_hl(0, {})) do
        if name:find("^LvimUi") then
            snap[name] = def
        end
    end
    return snap
end

---@param snap table<string, table>
local function restore_chrome(snap)
    for name, def in pairs(snap) do
        pcall(vim.api.nvim_set_hl, 0, name, def)
    end
end

--- vim.ui.select fallback (no lvim-utils): a flat list of every style.
---@param current string|nil
local function select_fallback(current)
    local items, by_label = {}, {}
    for _, fam in ipairs(families) do
        for _, def in ipairs(fam.items) do
            local label = def.label .. (def.style == current and "  ➤" or "")
            items[#items + 1] = label
            by_label[label] = def.style
        end
    end
    vim.ui.select(items, { prompt = "Colorscheme" }, function(choice)
        if choice and by_label[choice] then
            apply(by_label[choice])
        end
    end)
end

function M.open()
    local current_style = active_style()

    local ok, ui = pcall(require, "lvim-utils.ui")
    if not ok then
        return select_fallback(current_style)
    end

    -- Build tabs, keeping a reference to the currently-active item so lvim-utils can mark
    -- it with the current_item indicator (➤) — comparison is by reference, so the exact
    -- table object stored in tabs[n].items must be passed.
    local tabs = {}
    local found_item_ref, found_tab_idx = nil, nil
    for ti, fam in ipairs(families) do
        local items = {}
        for _, def in ipairs(fam.items) do
            local item = { label = def.label, icon = def.icon, _style = def.style }
            if def.style == current_style then
                found_item_ref, found_tab_idx = item, ti
            end
            items[#items + 1] = item
        end
        tabs[#tabs + 1] = { label = fam.label, icon = fam.icon, items = items }
    end

    -- Live preview: apply the theme as the cursor lands on each item; restore the original
    -- on cancel. `previewed` avoids redundant reloads when the same item re-fires. Unless
    -- `picker.live_chrome` is set, the picker keeps its OWN colours fixed (chrome snapshot)
    -- so it doesn't flicker through each previewed theme — the theme previews in the editor
    -- behind it; with live_chrome the picker itself recolours to the previewed theme too.
    local previewed = current_style
    local cfg = require("lvim-colorscheme.config").options or require("lvim-colorscheme.config").defaults
    local pin_chrome = not (cfg.picker and cfg.picker.live_chrome)
    local chrome = pin_chrome and snapshot_chrome() or nil
    ui.tabs({
        title = " Colorscheme",
        tabs = tabs,
        tab_selector = found_tab_idx,
        current_item = found_item_ref,
        width = 0.9,
        -- height omitted → M.tabs auto-fits to the content (a family's 4 variants), capped at its 0.9 default.
        position = "editor",
        on_item_change = function(item)
            if type(item) == "table" and item._style and item._style ~= previewed then
                previewed = item._style
                apply(item._style, true) -- lightweight preview
                if chrome then
                    restore_chrome(chrome) -- keep the picker itself stable
                end
            end
        end,
        callback = function(confirmed, result)
            if confirmed and type(result) == "table" and type(result.item) == "table" and result.item._style then
                apply(result.item._style) -- final: full load (fires User autocmd)
            elseif current_style and previewed ~= current_style then
                apply(current_style) -- cancelled after previewing → restore (full)
            end
        end,
    })
end

return M
