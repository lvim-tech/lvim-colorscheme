-- lvim-colorscheme.extra.ansi: convert palette hex into the colour forms that
-- tools without truecolor support insist on.
--
-- Several targets cannot take `#rrggbb` at all: miller and procs want an
-- xterm-256 index, navi wants one of crossterm's sixteen names, ripgrep and
-- jq want decimal r,g,b. Rather than let each generator invent its own
-- rounding, they share this one — so the same palette colour always lands on
-- the same index everywhere.
--
---@module "lvim-colorscheme.extra.ansi"

local M = {}

--- Split "#rrggbb" (or "rrggbb") into three 0-255 components.
---@param hex string
---@return integer r, integer g, integer b
function M.rgb(hex)
    hex = hex:gsub("^#", "")
    return tonumber(hex:sub(1, 2), 16) or 0, tonumber(hex:sub(3, 4), 16) or 0, tonumber(hex:sub(5, 6), 16) or 0
end

--- "r,g,b" in decimal — ripgrep's `--colors` value form.
---@param hex string
---@return string
function M.decimal(hex)
    local r, g, b = M.rgb(hex)
    return string.format("%d,%d,%d", r, g, b)
end

--- "38;2;r;g;b" — the SGR truecolor foreground body jq's JQ_COLORS takes.
---@param hex string
---@param background? boolean  emit a background (48) sequence instead
---@return string
function M.sgr(hex, background)
    local r, g, b = M.rgb(hex)
    return string.format("%d;2;%d;%d;%d", background and 48 or 38, r, g, b)
end

local function distance(r1, g1, b1, r2, g2, b2)
    -- Plain squared euclidean distance. Not perceptual, but the 256 cube is
    -- coarse enough that a fancier metric changes almost nothing, and this
    -- stays readable.
    local dr, dg, db = r1 - r2, g1 - g2, b1 - b2
    return dr * dr + dg * dg + db * db
end

-- The 6 levels the 6x6x6 colour cube uses on each axis.
local CUBE = { 0, 95, 135, 175, 215, 255 }

--- Nearest xterm-256 index (16-255; the first 16 are skipped because their
--- actual colours are whatever the terminal theme says, which would make the
--- match meaningless).
---@param hex string
---@return integer
function M.to_256(hex)
    local r, g, b = M.rgb(hex)
    local best, best_distance = 16, math.huge

    for ri = 1, 6 do
        for gi = 1, 6 do
            for bi = 1, 6 do
                local d = distance(r, g, b, CUBE[ri], CUBE[gi], CUBE[bi])
                if d < best_distance then
                    best_distance = d
                    best = 16 + (ri - 1) * 36 + (gi - 1) * 6 + (bi - 1)
                end
            end
        end
    end

    for i = 0, 23 do
        local level = 8 + i * 10
        local d = distance(r, g, b, level, level, level)
        if d < best_distance then
            best_distance = d
            best = 232 + i
        end
    end

    return best
end

--- Nearest crossterm colour NAME — the only thing navi accepts. The choice
--- goes by HUE, not by euclidean distance: with only sixteen names a pastel
--- blue is numerically closest to grey, which is exactly the wrong answer for
--- an accent colour. Greys are decided by lightness instead.
---@param hex string
---@return string
function M.to_name(hex)
    local r, g, b = M.rgb(hex)
    local rf, gf, bf = r / 255, g / 255, b / 255
    local max, min = math.max(rf, gf, bf), math.min(rf, gf, bf)
    local lightness = (max + min) / 2
    local delta = max - min

    if delta < 0.12 then
        if lightness < 0.2 then
            return "black"
        elseif lightness < 0.45 then
            return "dark_grey"
        elseif lightness < 0.8 then
            return "grey"
        end
        return "white"
    end

    local hue
    if max == rf then
        hue = (gf - bf) / delta % 6
    elseif max == gf then
        hue = (bf - rf) / delta + 2
    else
        hue = (rf - gf) / delta + 4
    end
    hue = hue * 60
    if hue < 0 then
        hue = hue + 360
    end

    local sectors = {
        { 30, "red" },
        { 90, "yellow" },
        { 150, "green" },
        { 210, "cyan" },
        { 270, "blue" },
        { 330, "magenta" },
    }
    local name = "red"
    for _, sector in ipairs(sectors) do
        if hue < sector[1] then
            name = sector[2]
            break
        end
    end

    -- The dark_ variants are the 0-7 half of the palette; anything this dim
    -- reads better there than as the full-brightness colour.
    if lightness < 0.42 then
        return "dark_" .. name
    end
    return name
end

return M
