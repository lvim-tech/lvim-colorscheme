-- lvim-colorscheme.picker: the :LvimColorscheme theme picker.
-- Uses the canonical lvim-ui floating tabs UI (one tab per family, live preview as the cursor
-- moves, ➤ on the active style). lvim-ui is required — there is no non-canonical fallback; when
-- it is missing the picker reports the missing dependency and does nothing.
--
---@module "lvim-colorscheme.picker"

local config = require("lvim-colorscheme.config")

local M = {}

-- The palette glyph shown on every family tab. Read LIVE from config at open time (below),
-- so a runtime `setup({ picker = { tab_icon = … } })` takes effect without reloading the picker.

-- Theme families: lighter → base → darker → light
local families = {
    {
        label = "Lvim",
        items = {
            { label = "Lvim Soft", icon = "◔", style = "lvim_soft" },
            { label = "Lvim Dark", icon = "◑", style = "lvim_dark" },
            { label = "Lvim Darker", icon = "●", style = "lvim_darker" },
            { label = "Lvim Light", icon = "○", style = "lvim_light" },
        },
    },
    {
        label = "Kanagawa",
        items = {
            { label = "Kanagawa Soft", icon = "◔", style = "kanagawa_soft" },
            { label = "Kanagawa Dark", icon = "◑", style = "kanagawa_dark" },
            { label = "Kanagawa Darker", icon = "●", style = "kanagawa_darker" },
            { label = "Kanagawa Light", icon = "○", style = "kanagawa_light" },
        },
    },
    {
        label = "Gruvbox",
        items = {
            { label = "Gruvbox Soft", icon = "◔", style = "gruvbox_soft" },
            { label = "Gruvbox Dark", icon = "◑", style = "gruvbox_dark" },
            { label = "Gruvbox Darker", icon = "●", style = "gruvbox_darker" },
            { label = "Gruvbox Light", icon = "○", style = "gruvbox_light" },
        },
    },
    {
        label = "Everforest",
        items = {
            { label = "Everforest Soft", icon = "◔", style = "everforest_soft" },
            { label = "Everforest Dark", icon = "◑", style = "everforest_dark" },
            { label = "Everforest Darker", icon = "●", style = "everforest_darker" },
            { label = "Everforest Light", icon = "○", style = "everforest_light" },
        },
    },
    {
        label = "Catppuccin",
        items = {
            { label = "Catppuccin Soft", icon = "◔", style = "catppuccin_soft" },
            { label = "Catppuccin Dark", icon = "◑", style = "catppuccin_dark" },
            { label = "Catppuccin Darker", icon = "●", style = "catppuccin_darker" },
            { label = "Catppuccin Light", icon = "○", style = "catppuccin_light" },
        },
    },
    {
        label = "Tokyo Night",
        items = {
            { label = "Tokyo Night Soft", icon = "◔", style = "tokyonight_soft" },
            { label = "Tokyo Night Dark", icon = "◑", style = "tokyonight_dark" },
            { label = "Tokyo Night Darker", icon = "●", style = "tokyonight_darker" },
            { label = "Tokyo Night Light", icon = "○", style = "tokyonight_light" },
        },
    },
    {
        label = "Nord",
        items = {
            { label = "Nord Soft", icon = "◔", style = "nord_soft" },
            { label = "Nord Dark", icon = "◑", style = "nord_dark" },
            { label = "Nord Darker", icon = "●", style = "nord_darker" },
            { label = "Nord Light", icon = "○", style = "nord_light" },
        },
    },
    {
        label = "Dracula",
        items = {
            { label = "Dracula Soft", icon = "◔", style = "dracula_soft" },
            { label = "Dracula Dark", icon = "◑", style = "dracula_dark" },
            { label = "Dracula Darker", icon = "●", style = "dracula_darker" },
            { label = "Dracula Light", icon = "○", style = "dracula_light" },
        },
    },
    {
        label = "Rosé Pine",
        items = {
            { label = "Rosé Pine Soft", icon = "◔", style = "rosepine_soft" },
            { label = "Rosé Pine Dark", icon = "◑", style = "rosepine_dark" },
            { label = "Rosé Pine Darker", icon = "●", style = "rosepine_darker" },
            { label = "Rosé Pine Light", icon = "○", style = "rosepine_light" },
        },
    },
    {
        label = "Material",
        items = {
            { label = "Material Soft", icon = "◔", style = "material_soft" },
            { label = "Material Dark", icon = "◑", style = "material_dark" },
            { label = "Material Darker", icon = "●", style = "material_darker" },
            { label = "Material Light", icon = "○", style = "material_light" },
        },
    },
    {
        label = "Solarized",
        items = {
            { label = "Solarized Soft", icon = "◔", style = "solarized_soft" },
            { label = "Solarized Dark", icon = "◑", style = "solarized_dark" },
            { label = "Solarized Darker", icon = "●", style = "solarized_darker" },
            { label = "Solarized Light", icon = "○", style = "solarized_light" },
        },
    },
    {
        label = "Nightfox",
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

--- Snapshot the picker float's OWN surface highlights (the `LvimUi*` groups it renders with) so
--- live preview — which re-applies the previewed theme globally — does not recolour the picker
--- itself on every keystroke; restoring this snapshot after each preview keeps the picker stable.
---
--- The editor CHROME bars (`LvimUiChrome*` — winbar / statusline / tabline) are DELIBERATELY
--- EXCLUDED: they belong to the editor behind the float and MUST preview live. They never render
--- inside the picker surface (lvim-ui uses no `LvimUiChrome*` group), so pinning them served no
--- stability purpose — it only froze the winbar a theme behind while the picker was open.
---@return table<string, table>
local function snapshot_chrome()
    local snap = {}
    for name, def in pairs(vim.api.nvim_get_hl(0, {})) do
        if name:find("^LvimUi") and not name:find("^LvimUiChrome") then
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

--- Report a missing picker dependency without falling back to a non-canonical native selector.
local function select_fallback()
    vim.notify(
        "lvim-colorscheme: lvim-ui is required for the theme picker",
        vim.log.levels.ERROR,
        { title = "Colorscheme" }
    )
end

function M.open()
    local current_style = active_style()

    local ok, ui = pcall(require, "lvim-ui")
    if not ok then
        return select_fallback()
    end

    -- Build tabs, keeping a reference to the currently-active item so lvim-utils can mark
    -- it with the current_item indicator (➤) — comparison is by reference, so the exact
    -- table object stored in tabs[n].items must be passed. The family tab glyph is read LIVE
    -- from config here, so a runtime `tab_icon` change is honoured on the next open.
    local tab_icon = config.picker.tab_icon
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
        tabs[#tabs + 1] = { label = fam.label, icon = tab_icon, items = items }
    end

    -- Live preview: apply the theme as the cursor lands on each item; restore the original
    -- on cancel. `previewed` avoids redundant reloads when the same item re-fires. Unless
    -- `picker.live_chrome` is set, the picker keeps its OWN colours fixed (chrome snapshot)
    -- so it doesn't flicker through each previewed theme — the theme previews in the editor
    -- behind it; with live_chrome the picker itself recolours to the previewed theme too.
    local previewed = current_style
    local cfg = config
    local pin_chrome = not (cfg.picker and cfg.picker.live_chrome)
    local chrome = pin_chrome and snapshot_chrome() or nil
    local original_colorscheme = vim.g.colors_name
    ui.tabs({
        title = "Colorscheme",
        title_pos = "center", -- centred title band, like the control center
        tabs = tabs,
        tab_selector = found_tab_idx,
        current_item = found_item_ref,
        -- No explicit width/height: follow the SHARED lvim-ui geometry (config.ui.size.float), edited via the
        -- control-center's Utils tab — so the picker resizes with every other float instead of a hardcoded 0.9.
        pad = 1, -- a single-space body lpad — the variant rows sit one space from the edge
        position = "editor",
        footer_hints = true, -- bottom key-hint legend (panel keys • focused-row keys), like the control center

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
            elseif not current_style and original_colorscheme then
                pcall(vim.cmd.colorscheme, original_colorscheme)
            end
        end,
    })
end

return M
