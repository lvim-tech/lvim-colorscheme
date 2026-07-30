-- lvim-colorscheme.panel: the runtime settings panel, built directly on lvim-ui.
--
-- One tab per section of `settings.specs` (Background / Focus / Syntax), each row typed from its
-- spec. Editing a row applies live through `settings.set`, which also persists it — these are the
-- colorscheme's own options, there is exactly one of each, and this panel is the only thing that
-- edits them, so there is nothing for a separate "save" step to decide.
--
-- It used to run as a dedicated lvim-control-center instance, which made a colorscheme unable to
-- show its own settings without a second plugin installed, in exchange for a command surface
-- (export / import / reset / preset) these options never needed. `lvim-ui.tabs` is the canonical
-- tabbed-form preset (§1 of the panel canon) — and is what control-center itself renders through.
--
-- Startup restore stays owned by `settings.restore()` — one `set` call, one reload — so opening the
-- panel never re-applies anything by itself.
--
---@module "lvim-colorscheme.panel"

local ui = require("lvim-ui")
local settings = require("lvim-colorscheme.settings")
local config = require("lvim-colorscheme.config")

local M = {}

--- The panel's title.
local TITLE = "COLORSCHEME SETTINGS"

-- Per-tab (section) icons.
local GROUP_ICONS = {
    Background = "󰸉",
    Focus = "󰈈",
    Syntax = "󰅴",
}

--- Build one tab per section of `settings.specs`, in spec order.
---@return table[] tabs, table<string, lvim-colorscheme.Setting> by_row_name
local function build_tabs()
    local order, by_group, by_name = {}, {}, {}
    for _, spec in ipairs(settings.specs) do
        if not by_group[spec.group] then
            by_group[spec.group] = {
                name = spec.group,
                label = spec.group,
                icon = GROUP_ICONS[spec.group],
                rows = {},
            }
            order[#order + 1] = spec.group
        end
        by_name[spec.name] = spec
        local rows = by_group[spec.group].rows
        rows[#rows + 1] = {
            type = spec.type,
            name = spec.name,
            label = spec.label,
            options = spec.options,
            value = settings.get(spec),
            -- Evaluated live at render, so a row goes inert the moment the toggle it depends on
            -- changes (a "transparent" sidebar while the global transparent is off, say). The
            -- predicate is handed the ROW — `value_disabled` wants the VALUE, and passing the row
            -- straight through (as the control-center version did) silently never matched, so no
            -- row ever rendered as inert.
            disabled = function(row)
                return settings.value_disabled(spec, row.value)
            end,
        }
    end
    local tabs = {}
    for _, name in ipairs(order) do
        tabs[#tabs + 1] = by_group[name]
    end
    return tabs, by_name
end

--- Open the settings panel.
---@param tab? string|integer  the section to focus — its name, or an index
---@param layout? string  "float" (default) | "area" | "bottom"; overrides `settings_panel.layout`
---@return nil
function M.open(tab, layout)
    local p = config.settings_panel or {}
    local tabs, by_name = build_tabs()
    ---@type table? the ui.tabs handle, so an edit can repaint the rows it invalidated
    local handle
    handle = ui.tabs({
        title = TITLE,
        title_pos = "center",
        layout = layout or p.layout or "float",
        tabs = tabs,
        tab_selector = tab,
        footer_hints = true,
        ---@param row table
        on_change = function(row)
            local spec = by_name[row.name]
            if not spec then
                return
            end
            settings.set(spec, row.value)
            -- Several rows gate each other (transparent → the sidebar/float styles, dim_inactive →
            -- its strength), so an edit changes which OTHER rows are inert. Repaint to show it.
            if handle and handle.render then
                handle.render()
            end
        end,
    })
end

return M
