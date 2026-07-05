-- lvim-colorscheme.store: persistence for the runtime settings panel.
--
-- Values go through the plugin's OWN lvim-control-center instance (its own database) — bound
-- via `M.bind(data)` when the panel is created (see `panel.lua`). There is no shared-database
-- translator and no JSON fallback: lvim-control-center is a required dependency now, and each
-- setting is a row in the dedicated instance's store.
--
-- The one file kept is the plain one-line THEME MIRROR: the active theme name, rewritten on
-- every commit, so a host's bootstrap/installer can read the theme WITHOUT loading the plugin
-- or touching sqlite. The database stays the source of truth; the mirror is the early-read
-- shortcut (and the standalone fallback at restore, before the instance's data is bound).
--
---@module "lvim-colorscheme.store"

local M = {}

-- Plain one-line mirror of the active theme name (early-read shortcut, see the header).
local THEME_FILE = vim.fn.stdpath("data") .. "/lvim-colorscheme/theme"

-- Shared key for the active colorscheme; matches control-center's setting name.
local THEME_KEY = "colorscheme"

---@type LvimControlCenterData? the dedicated instance's persistence, set by panel.setup via M.bind
local data = nil

--- Bind the store to the settings panel's control-center instance data. Called once, from
--- `panel.setup`, before `settings.restore()` so the restore reads the instance's database.
---@param instance_data LvimControlCenterData
function M.bind(instance_data)
    data = instance_data
end

--- Persist a value under `name` in the dedicated instance's database (no-op until bound).
---@param name string
---@param value any
function M.save(name, value)
    if data then
        pcall(function()
            data:save(name, value)
        end)
    end
end

--- Read a persisted value, or nil when nothing has been saved / the store is not bound yet.
---@param name string
---@return any
function M.load(name)
    if data then
        local ok, val = pcall(function()
            return data:load(name)
        end)
        if ok then
            return val
        end
    end
    return nil
end

--- Persist the active theme: the database (under the shared `colorscheme` key) PLUS the plain
--- mirror file for pre-load reads.
---@param name string  canonical colorscheme name (dash form, e.g. "lvim-everforest-dark")
function M.save_theme(name)
    M.save(THEME_KEY, name)
    pcall(vim.fn.mkdir, vim.fn.fnamemodify(THEME_FILE, ":h"), "p")
    pcall(vim.fn.writefile, { name }, THEME_FILE)
end

--- The remembered theme name, or nil when none has been saved. Reads the MIRROR first: it is
--- always readable this early (the instance data may not be bound yet at restore time) and is
--- rewritten on every commit alongside the store, so it never lags. The database is a secondary
--- source (e.g. a value seeded by another panel that shares this instance).
---@return string|nil
function M.load_theme()
    local ok, lines = pcall(vim.fn.readfile, THEME_FILE)
    if ok and type(lines) == "table" and type(lines[1]) == "string" and lines[1] ~= "" then
        return lines[1]
    end
    local v = M.load(THEME_KEY)
    if type(v) == "string" and v ~= "" then
        return v
    end
    return nil
end

--- Absolute path of the plain theme mirror file (so a host can read it early, before the
--- plugin is on the runtimepath).
---@return string
function M.theme_file()
    return THEME_FILE
end

return M
