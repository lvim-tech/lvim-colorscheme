-- The baseline every plugin in the set is held to.
--
-- 1. every module loads ON ITS OWN — consumers require them piecemeal, so a module that only
--    loads as a side effect of the aggregate is a break waiting for the first direct caller;
-- 2. setup() runs, and runs TWICE without stacking an autocmd, a command or a global keymap —
--    a host that re-applies its config must not end up with two of everything;
-- 3. the health check runs to completion against a bare environment.

local PLUGIN = "lvim-colorscheme"
-- The plugin's own root, derived from THIS file rather than from a harness global, so the spec
-- drops into any of the suites in the set.
local here = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
local root = here .. "/lua/" .. PLUGIN

---@return string[]
local function modules()
    local out = {}
    local function walk(dir, prefix)
        for name, kind in vim.fs.dir(dir) do
            if kind == "directory" then
                walk(dir .. "/" .. name, prefix .. name .. ".")
            elseif name:match("%.lua$") then
                local stem = name:sub(1, -5)
                out[#out + 1] = stem == "init" and prefix:sub(1, -2) or (prefix .. stem)
            end
        end
    end
    walk(root, PLUGIN .. ".")
    table.sort(out)
    return out
end

describe(PLUGIN .. ": every module loads")

local mods = modules()

it("there are modules to load at all", function()
    truthy(#mods > 0, "no modules found under " .. root)
end)

--- The name of the THIRD-PARTY module a load error blames, if any. An absent sqlite.lua or
--- another external dependency is a fact about this machine; an lvim-* module that will not load,
--- or any other error, is ours.
---@param err string
---@return string|nil
local function missing_external(err)
    local name = tostring(err):match("module '([^']+)' not found")
    if name and not vim.startswith(name, "lvim-") then
        return name
    end
    -- A module that failed because the one it requires failed is the same fact, once removed.
    if tostring(err):match("loop or previous error loading module") then
        return "a dependency that already failed to load"
    end
    return nil
end

for _, mod in ipairs(mods) do
    it(mod, function()
        local ok, err = pcall(require, mod)
        if not ok then
            local external = missing_external(err)
            if external then
                -- Reported as a skip, never as a pass: the module is NOT known to work here.
                skip(mod, "needs " .. external .. ", which is not installed on this machine")
                return
            end
        end
        truthy(ok, tostring(err))
    end)
end

describe(PLUGIN .. ": setup")

--- Everything a second setup() must not double.
---@return table
local function world()
    return {
        autocmds = #vim.api.nvim_get_autocmds({}),
        commands = vim.tbl_count(vim.api.nvim_get_commands({})),
        keymaps_n = #vim.api.nvim_get_keymap("n"),
        keymaps_i = #vim.api.nvim_get_keymap("i"),
    }
end

-- Not every plugin HAS a top-level module: lvim-ls, for one, is required by submodule
-- (`lvim-ls.core.manager`) and configured through its own state module.
local ok_plugin, plugin = pcall(require, PLUGIN)

if not ok_plugin or type(plugin) ~= "table" or type(plugin.setup) ~= "function" then
    skip("setup() runs twice without stacking anything", "no " .. PLUGIN .. ".setup() to call")
else
    it("runs at all", function()
        local ok, err = pcall(plugin.setup, {})
        truthy(ok, tostring(err))
    end)

    it("runs twice without stacking anything", function()
        pcall(plugin.setup, {})
        local before = world()
        pcall(plugin.setup, {})
        eq(before, world())
    end)
end

describe(PLUGIN .. ": health")

local ok_health, health = pcall(require, PLUGIN .. ".health")
if not ok_health or type(health.check) ~= "function" then
    skip("the health check runs to completion", "no " .. PLUGIN .. ".health.check()")
else
    it("the health check runs to completion", function()
        local ok, err = pcall(health.check)
        truthy(ok, tostring(err))
    end)
end
