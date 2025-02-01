local docs = require("lazy.docs")
local groups = require("lvim-colorscheme.groups")

local M = {}

local function link(name, url)
    return "[" .. name .. "](" .. url .. ")"
end

function M.row(t)
    return "| " .. table.concat(t, " | ") .. " |"
end

---@param t string[][]
function M.table(t)
    local header = table.remove(t, 1)
    local lines = {} ---@type string[]
    lines[#lines + 1] = M.row(header)
    lines[#lines + 1] = M.row({ "---", "---" })
    for _, row in ipairs(t) do
        lines[#lines + 1] = M.row(row)
    end
    return table.concat(lines, "\n")
end

function M.extras()
    local Extra = require("lvim-colorscheme.extra")
    local names = vim.tbl_keys(Extra.extras) ---@type string[]
    table.sort(names)
    local t = {
        { "Tool", "Extra" },
    }
    for _, name in ipairs(names) do
        local info = Extra.extras[name]
        t[#t + 1] = { link(info.label, info.url), link("extras/" .. name, "extras/" .. name) }
    end
    return M.table(t)
end

function M.plugins()
    local t = {
        { "Plugin", "Source" },
    }
    local names = vim.tbl_values(groups.plugins) ---@type string[]
    table.sort(names)
    for _, name in ipairs(names) do
        local group = groups.get_group(name)
        local repo = group.url:match("[^/]*$")
        t[#t + 1] = {
            link(repo, group.url),
            link(("`%s`"):format(name), "lua/lvim-colorscheme/groups/" .. name .. ".lua"),
        }
    end
    return M.table(t)
end

function M.update()
    local config = docs.extract("lua/lvim-colorscheme/config.lua", "\n(--@class lvim-colorscheme%.Config.-\n})")
    config = config:gsub("%s*debug = false.\n", "\n")
    docs.save({
        config = config,
        extras = { content = M.extras() },
        plugins = { content = M.plugins() },
    })
end

M.update()
print("Docs updated")

return M
