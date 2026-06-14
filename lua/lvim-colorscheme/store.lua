-- lvim-colorscheme.store: persistence adapter for the runtime settings panel.
--
-- One key/value store, accessed the same way regardless of what is installed:
--   * lvim-control-center present (and its sqlite backend working) → values go through ITS
--     `persistence.data` module — the SAME database it reads on startup, so the two plugins
--     recognise each other's values automatically (the keys match control-center's setting
--     names). No sqlite path/schema is duplicated here.
--   * otherwise → a plain JSON file under stdpath("data")/lvim-colorscheme/ (pure Lua, no
--     sqlite). lvim-colorscheme therefore NEVER hard-depends on sqlite.
--
-- Every control-center call is pcall-guarded (the require AND the operation), so a present-
-- but-broken backend (e.g. sqlite missing, db not yet initialised) falls back to the JSON
-- file instead of erroring.
--
---@module "lvim-colorscheme.store"

local M = {}

local FILE = vim.fn.stdpath("data") .. "/lvim-colorscheme/settings.json"

--- lvim-control-center's data module, only when it is present AND usable.
---@return table? data  the persistence.data module, or nil to use the JSON fallback
local function cc_data()
    local ok, data = pcall(require, "lvim-control-center.persistence.data")
    if ok and type(data) == "table" and type(data.save) == "function" and type(data.load) == "function" then
        return data
    end
    return nil
end

--- Read the whole JSON file (empty table when missing/unreadable).
---@return table<string, any>
local function read_file()
    local fd = io.open(FILE, "r")
    if not fd then
        return {}
    end
    local content = fd:read("*a")
    fd:close()
    local ok, decoded = pcall(vim.json.decode, content or "")
    return (ok and type(decoded) == "table") and decoded or {}
end

--- Write the whole table back to the JSON file (creates the directory).
---@param tbl table<string, any>
local function write_file(tbl)
    pcall(vim.fn.mkdir, vim.fn.fnamemodify(FILE, ":h"), "p")
    local fd = io.open(FILE, "w")
    if not fd then
        return
    end
    fd:write(vim.json.encode(tbl))
    fd:close()
end

--- Persist a value under `name` (control-center DB when available, else the JSON file).
---@param name string
---@param value any
function M.save(name, value)
    local data = cc_data()
    if data and pcall(data.save, name, value) then
        return
    end
    local tbl = read_file()
    tbl[name] = value
    write_file(tbl)
end

--- Read a persisted value, or nil when nothing has been saved.
---@param name string
---@return any
function M.load(name)
    local data = cc_data()
    if data then
        local ok, val = pcall(data.load, name)
        if ok then
            return val
        end
    end
    return read_file()[name]
end

--- One-time bridge: when control-center is now available but its DB lacks a key the local
--- JSON file already holds, seed the DB from the file — so a setup configured standalone is
--- recognised once control-center is installed. No-op without control-center or without a file.
---@param names string[]  managed setting names to consider
function M.migrate(names)
    local data = cc_data()
    if not data then
        return
    end
    local tbl = read_file()
    if not next(tbl) then
        return
    end
    for _, name in ipairs(names) do
        if tbl[name] ~= nil then
            local ok, existing = pcall(data.load, name)
            if ok and existing == nil then
                pcall(data.save, name, tbl[name])
            end
        end
    end
end

return M
