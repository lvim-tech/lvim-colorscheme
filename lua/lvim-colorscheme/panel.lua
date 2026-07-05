-- lvim-colorscheme.panel: the runtime settings panel, hosted by lvim-control-center.
--
-- Instead of a bespoke float, the settings (Background / Focus / Syntax) run as a DEDICATED
-- lvim-control-center instance with its OWN command and its OWN database (both configurable via
-- `config.settings_panel`) — so lvim-colorscheme's settings never mix with any other control
-- center. The groups are built from `settings.specs`; each row applies live through
-- `settings.set` and persists through the instance's store (`store.bind` points the store at
-- this instance's database). Startup restore stays owned by `settings.restore()` (one reload),
-- so every row carries `break_load = true` to skip the host's per-setting re-apply.
--
---@module "lvim-colorscheme.panel"

local settings = require("lvim-colorscheme.settings")
local store = require("lvim-colorscheme.store")
local config = require("lvim-colorscheme.config")

local M = {}

-- Per-tab (group) icons.
local GROUP_ICONS = {
    Background = "󰸉",
    Focus = "󰈈",
    Syntax = "󰅴",
}

---@type LvimControlCenterInstance? the dedicated control-center instance (created once)
M.instance = nil

--- Build the control-center groups from `settings.specs` (one group per section, in spec order).
---@return LvimControlCenterGroup[]
local function build_groups()
    local order, by_name = {}, {}
    for _, spec in ipairs(settings.specs) do
        if not by_name[spec.group] then
            by_name[spec.group] = {
                name = spec.group,
                label = spec.group,
                icon = GROUP_ICONS[spec.group],
                settings = {},
            }
            order[#order + 1] = spec.group
        end
        local s = spec
        table.insert(by_name[s.group].settings, {
            name = s.name,
            label = s.label,
            type = s.type,
            options = s.options,
            -- lvim-colorscheme OWNS startup restore (settings.restore applies ALL in ONE reload); skip the
            -- host's per-setting re-apply, else each row would trigger a full highlight reload on startup.
            break_load = true,
            get = function()
                return settings.get(s)
            end,
            set = function(value, is_load)
                settings.set(s, value, not is_load) -- persist on a user change, not while restoring
            end,
            disabled = function(value)
                return settings.value_disabled(s, value)
            end,
        })
    end
    local groups = {}
    for _, g in ipairs(order) do
        groups[#groups + 1] = by_name[g]
    end
    return groups
end

--- One-time migration: seed the dedicated database from the pre-refactor JSON store
--- (stdpath("data")/lvim-colorscheme/settings.json) the first time, then remove the file. Older
--- versions persisted there when control-center's shared DB was unavailable. Only real setting
--- names (and the theme key) are copied; junk keys are dropped. No-op without the file.
---@param instance LvimControlCenterInstance
local function migrate_legacy_json(instance)
    local file = vim.fn.stdpath("data") .. "/lvim-colorscheme/settings.json"
    if vim.fn.filereadable(file) == 0 then
        return
    end
    local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(file), "\n"))
    if ok and type(decoded) == "table" then
        local valid = { colorscheme = true }
        for _, s in ipairs(settings.specs) do
            valid[s.name] = true
        end
        for k, v in pairs(decoded) do
            if valid[k] and instance.data:load(k) == nil then
                instance.data:save(k, v)
            end
        end
    end
    pcall(vim.fn.delete, file)
end

--- Create the dedicated control-center instance (once) and bind the store to its database.
--- Call in setup() BEFORE settings.restore() so the restore reads persisted values. Returns the
--- instance, or nil when lvim-control-center is unavailable (the panel then can't open).
---@return LvimControlCenterInstance|nil
function M.setup()
    if M.instance then
        return M.instance
    end
    local ok, cc = pcall(require, "lvim-control-center")
    if not ok then
        vim.notify(
            "lvim-colorscheme: the settings panel requires lvim-control-center",
            vim.log.levels.WARN,
            { title = "lvim-colorscheme" }
        )
        return nil
    end
    local p = config.settings_panel or {}
    M.instance = cc.new({
        -- control-center REGISTERS the panel command (`:LvimColorschemeConfig`) — the plugin's own
        -- `:LvimColorscheme` stays the theme PICKER; the config panel is this separate command.
        command = p.command or "LvimColorschemeConfig",
        -- Its OWN database directory (separate store); default under the plugin's data dir.
        save = p.save or (vim.fn.stdpath("data") .. "/lvim-colorscheme"),
        title = "COLORSCHEME SETTINGS",
        title_icon = config.picker and config.picker.tab_icon or "󰏘",
        groups = build_groups(),
    })
    store.bind(M.instance.data)
    migrate_legacy_json(M.instance)
    return M.instance
end

--- Open the settings panel (creating the instance on first call).
function M.open()
    local inst = M.instance or M.setup()
    if inst then
        inst:open()
    end
end

return M
