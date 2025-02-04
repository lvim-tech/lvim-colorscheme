local M = {}

M.bg = "#000000"
M.fg = "#ffffff"
M.day_brightness = 0.3

local uv = vim.uv or vim.loop

---@param c string
---@return number[]
local function rgb(c)
    c = string.lower(c)
    return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local me = debug.getinfo(1, "S").source:sub(2)
me = vim.fn.fnamemodify(me, ":h:h")

---@param modname string
---@return any
function M.mod(modname)
    if package.loaded[modname] then
        return package.loaded[modname]
    end
    local ret = loadfile(me .. "/" .. modname:gsub("%.", "/") .. ".lua")()
    package.loaded[modname] = ret
    return ret
end

---@param foreground string foreground color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
---@param background string background color
---@return string
function M.blend(foreground, alpha, background)
    alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
    local bg = rgb(background)
    local fg = rgb(foreground)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

---@param hex string
---@param amount number
---@param bg? string
---@return string
function M.blend_bg(hex, amount, bg)
    return M.blend(hex, amount, bg or M.bg)
end
M.darken = M.blend_bg

---@param hex string
---@param amount number
---@param fg? string
---@return string
function M.blend_fg(hex, amount, fg)
    return M.blend(hex, amount, fg or M.fg)
end
M.lighten = M.blend_fg

---@param color string|Palette
---@return string|Palette
function M.invert(color)
    if type(color) == "table" then
        for key, value in pairs(color) do
            color[key] = M.invert(value)
        end
    elseif type(color) == "string" then
        local hsluv = require("lvim-colorscheme.hsluv")
        if color ~= "NONE" then
            local hsl = hsluv.hex_to_hsluv(color)
            hsl[3] = 100 - hsl[3]
            if hsl[3] < 40 then
                hsl[3] = hsl[3] + (100 - hsl[3]) * M.day_brightness
            end
            return hsluv.hsluv_to_hex(hsl)
        end
    end
    return color
end

---@param color string
---@param lightness_amount? number
---@param saturation_amount? number
---@return string
function M.brighten(color, lightness_amount, saturation_amount)
    lightness_amount = lightness_amount or 0.05
    saturation_amount = saturation_amount or 0.2
    local hsluv = require("lvim-colorscheme.hsluv")

    local hsl = hsluv.hex_to_hsluv(color)
    hsl[3] = math.min(hsl[3] + (lightness_amount * 100), 100)
    hsl[2] = math.min(hsl[2] + (saturation_amount * 100), 100)
    return hsluv.hsluv_to_hex(hsl)
end

---@param color string
---@param lightness_amount? number
---@param saturation_amount? number
---@return string
function M.darken(color, lightness_amount, saturation_amount)
    lightness_amount = lightness_amount or 0.05
    saturation_amount = saturation_amount or 0.2
    local hsluv = require("lvim-colorscheme.hsluv")

    local hsl = hsluv.hex_to_hsluv(color)
    hsl[3] = math.max(hsl[3] - (lightness_amount * 100), 0)
    hsl[2] = math.max(hsl[2] - (saturation_amount * 100), 0)
    return hsluv.hsluv_to_hex(hsl)
end

---@param groups lvim-colorscheme.Highlights
---@return lvim-colorscheme.Highlights
function M.resolve(groups)
    for _, hl in pairs(groups) do
        if type(hl.style) == "table" then
            for k, v in pairs(hl.style) do
                hl[k] = v
            end
            hl.style = nil
        end
    end
    return groups
end

---@param str string
---@param table table
---@return string
function M.template(str, table)
    return (
        str:gsub("($%b{})", function(w)
            return vim.tbl_get(table, unpack(vim.split(w:sub(3, -2), ".", { plain = true }))) or w
        end)
    )
end

---@param file string
---@return string
function M.read(file)
    local fd = assert(io.open(file, "r"))
    local data = fd:read("*a")
    fd:close()
    return data
end

---@param file string
---@param contents string
function M.write(file, contents)
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
    local fd = assert(io.open(file, "w+"))
    fd:write(contents)
    fd:close()
end

M.cache = {}

---@param key string
---@return string
function M.cache.file(key)
    return vim.fn.stdpath("cache") .. "/lvim-" .. key .. ".json"
end

---@param key string
---@return lvim-colorscheme.Cache|nil
function M.cache.read(key)
    local ok, ret = pcall(function()
        return vim.json.decode(
            M.read(M.cache.file(key)),
            { luanil = {
                object = true,
                array = true,
            } }
        )
    end)
    return ok and ret or nil
end

---@param key string
---@param data lvim-colorscheme.Cache
function M.cache.write(key, data)
    pcall(M.write, M.cache.file(key), vim.json.encode(data))
end

function M.cache.clear()
    for _, style in ipairs({ "storm", "day", "night", "moon" }) do
        uv.fs_unlink(M.cache.file(style))
    end
end

return M
