-- Forty-eight palettes, twelve families × four variants, every one of them read by name.
--
-- No one reads forty-eight files looking for a missing key or a typo'd hex; the editor just paints
-- the wrong thing, or nothing, in the one theme that has the slip. So the check is a property over
-- the whole set: every palette defines the SAME keys as the reference one, and every colour is a
-- well-formed `#rrggbb`. A new family that forgets `comment` or writes `#f0f0f` fails here instead
-- of in whichever buffer notices first.

local dir = PLUGIN_ROOT .. "/lua/lvim-colorscheme/colors"

--- The palette style names (every colors/<style>.lua except the loader itself).
---@return string[]
local function styles()
    local out = {}
    for name, kind in vim.fs.dir(dir) do
        if kind == "file" and name:match("%.lua$") and name ~= "init.lua" then
            out[#out + 1] = name:sub(1, -5)
        end
    end
    table.sort(out)
    return out
end

--- One palette as the loader materialises it. A LIGHT palette is not a table but a function of
--- the config — it inverts its dark sibling — so it is called the way colors/init.lua calls it,
--- with the effective config, rather than with nothing (which is a crash, and was this spec's
--- first mistake).
---@param style string
---@return table<string, any>
local function palette(style)
    local p = require("lvim-colorscheme.colors").styles[style]
    if type(p) == "function" then
        p = p(require("lvim-colorscheme.config").extend({ style = style }))
    end
    return p
end

local STYLES = styles()
local REFERENCE = "base_dark"

describe("lvim-colorscheme: the palettes are whole")

it("there are forty-eight of them, in families of four", function()
    eq(48, #STYLES, "found " .. #STYLES .. ": " .. table.concat(STYLES, " "))
    local families = {}
    for _, s in ipairs(STYLES) do
        local family = s:gsub("_[^_]+$", "")
        families[family] = (families[family] or 0) + 1
    end
    for family, n in pairs(families) do
        eq(4, n, family .. " has " .. n .. " variants, not four")
    end
    eq(12, vim.tbl_count(families), "twelve families")
end)

it("the reference palette is a table of colours", function()
    local p = palette(REFERENCE)
    truthy(type(p) == "table", REFERENCE .. " is not a table")
    truthy(vim.tbl_count(p) > 20, "only " .. vim.tbl_count(p) .. " keys in " .. REFERENCE)
end)

local ref_keys = {}
for k, v in pairs(palette(REFERENCE)) do
    if type(v) == "string" then
        ref_keys[#ref_keys + 1] = k
    end
end
table.sort(ref_keys)

for _, style in ipairs(STYLES) do
    it(style .. " defines every colour the reference does", function()
        local p = palette(style)
        truthy(type(p) == "table", style .. " did not resolve to a table")
        local missing = {}
        for _, k in ipairs(ref_keys) do
            if p[k] == nil then
                missing[#missing + 1] = k
            end
        end
        eq({}, missing, style .. " is missing: " .. table.concat(missing, ", "))
    end)
end

for _, style in ipairs(STYLES) do
    it(style .. " writes every colour as #rrggbb", function()
        local bad = {}
        for k, v in pairs(palette(style)) do
            if type(v) == "string" and v ~= "" and v ~= "NONE" and v ~= "none" then
                if not v:match("^#%x%x%x%x%x%x$") then
                    bad[#bad + 1] = ("%s = %q"):format(k, v)
                end
            end
        end
        eq({}, bad, style .. ": " .. table.concat(bad, ", "))
    end)
end

describe("lvim-colorscheme: the names the editor offers")

it("lists one colorscheme per palette, in command form", function()
    local names = require("lvim-colorscheme").colorschemes()
    eq(#STYLES, #names, ("%d palettes but %d names"):format(#STYLES, #names))
    for _, n in ipairs(names) do
        truthy(vim.startswith(n, "lvim-"), "not an lvim name: " .. n)
        truthy(n:find("_") == nil, "a command name must use dashes, not underscores: " .. n)
    end
end)

it("every offered name maps back to a palette that exists", function()
    local have = {}
    for _, s in ipairs(STYLES) do
        have[s] = true
    end
    for _, n in ipairs(require("lvim-colorscheme").colorschemes()) do
        local style = n:gsub("^lvim%-", ""):gsub("%-", "_")
        truthy(have[style], n .. " points at colors/" .. style .. ".lua, which is not there")
    end
end)
