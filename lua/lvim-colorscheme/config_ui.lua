-- lvim-colorscheme.config_ui: the :LvimColorscheme config settings panel.
--
-- A floating lvim-utils.ui.tabs panel (one tab per group) exposing the runtime-configurable
-- options from `settings.specs` as bool / select rows. Changing a row applies it live (via
-- `settings.set` → `lvim-colorscheme.set`) and persists it through `store`. Requires
-- lvim-utils for the tabbed UI; without it we just notify (a flat settings grid has no
-- meaningful vim.ui.select fallback, unlike the single-choice theme picker).
--
---@module "lvim-colorscheme.config_ui"

local settings = require("lvim-colorscheme.settings")

local M = {}

--- Build the ordered list of group names as they first appear in the spec list.
---@return string[]
local function group_order()
    local seen, order = {}, {}
    for _, spec in ipairs(settings.specs) do
        if not seen[spec.group] then
            seen[spec.group] = true
            order[#order + 1] = spec.group
        end
    end
    return order
end

--- Open the configuration panel.
function M.open()
    local ok, ui = pcall(require, "lvim-utils.ui")
    if not ok then
        vim.notify(
            "lvim-colorscheme: the config panel needs lvim-utils (:LvimColorscheme still opens the picker)",
            vim.log.levels.WARN
        )
        return
    end

    -- One tab per group; each spec becomes a row carrying its current value.
    local by_name = {}
    local tabs = {}
    for _, group in ipairs(group_order()) do
        local rows = {}
        for _, spec in ipairs(settings.specs) do
            if spec.group == group then
                by_name[spec.name] = spec
                rows[#rows + 1] = {
                    type = spec.type,
                    name = spec.name,
                    label = spec.label,
                    value = settings.get(spec),
                    options = spec.options,
                    -- Evaluated at render time: marks a value that exists but can't apply in the
                    -- current config (dimmed + struck through). Tracks e.g. the transparent toggle.
                    disabled = function(value)
                        return settings.value_disabled(spec, value)
                    end,
                }
            end
        end
        tabs[#tabs + 1] = { label = group, rows = rows }
    end

    ui.tabs({
        title = " Colorscheme settings",
        subtitle = " ",
        tabs = tabs,
        on_change = function(row)
            local spec = by_name[row.name]
            if spec then
                settings.set(spec, row.value)
            end
        end,
        width = 0.4,
        height = 0.6,
        position = "editor",
    })
end

return M
