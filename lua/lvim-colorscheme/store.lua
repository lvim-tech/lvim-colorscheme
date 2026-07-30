-- lvim-colorscheme.store: persistence for the runtime settings panel.
--
-- The settings live in the plugin's OWN document, `stdpath("data")/lvim-colorscheme/settings.json`,
-- written through the shared `lvim-utils.store` (json backend): atomic writes, and a plain readable
-- file rather than a database only one plugin knows how to open. They used to be rows in a dedicated
-- lvim-control-center instance; that made a colorscheme unable to render its own settings without a
-- second plugin present, and bought nothing these values need — there is exactly one of each, they
-- belong to the colorscheme, and the panel that edits them is this plugin's own.
--
-- Alongside it, one plain one-line THEME MIRROR: the active theme name, rewritten on every commit,
-- so a host's bootstrap/installer can read the theme WITHOUT loading the plugin. The document stays
-- the source of truth; the mirror is the early-read shortcut.
--
---@module "lvim-colorscheme.store"

local ustore = require("lvim-utils.store")

local M = {}

-- The settings document and the plain mirror, both under the plugin's own data directory.
local DIR = vim.fn.stdpath("data") .. "/lvim-colorscheme"
local SETTINGS_FILE = DIR .. "/settings.json"
local THEME_FILE = DIR .. "/theme"

-- Shared key for the active colorscheme.
local THEME_KEY = "colorscheme"

---@type table? the live store handle, opened on first use
local handle = nil

--- The store handle. Opening READS but never creates, so a fresh install writes nothing until the
--- first setting is changed.
---@return table
local function store()
    if not handle then
        handle = ustore.new({ backend = "json", path = SETTINGS_FILE })
    end
    return handle
end

--- Persist a value under `name`.
---@param name string
---@param value any
---@return nil
function M.save(name, value)
    pcall(function()
        store()[name] = value
    end)
end

--- Read a persisted value, or nil when nothing has been saved.
---@param name string
---@return any
function M.load(name)
    local ok, value = pcall(function()
        return store()[name]
    end)
    if ok then
        return value
    end
    return nil
end

--- Persist the active theme: the document (under the shared `colorscheme` key) PLUS the plain mirror
--- file for pre-load reads.
---@param name string  canonical colorscheme name (dash form, e.g. "lvim-everforest-dark")
---@return nil
function M.save_theme(name)
    M.save(THEME_KEY, name)
    pcall(vim.fn.mkdir, DIR, "p")
    pcall(vim.fn.writefile, { name }, THEME_FILE)
end

--- The remembered theme name, or nil when none has been saved. Reads the MIRROR first: it is always
--- readable this early and is rewritten on every commit alongside the document, so it never lags.
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

--- Absolute path of the plain theme mirror file (so a host can read it early, before the plugin is
--- on the runtimepath).
---@return string
function M.theme_file()
    return THEME_FILE
end

--- Absolute path of the settings document.
---@return string
function M.settings_file()
    return SETTINGS_FILE
end

return M
