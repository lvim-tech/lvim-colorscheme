-- lvim-colorscheme.util: colour math + module/cache helpers for the engine.
-- Blend / lighten / darken / brighten / invert (via hsluv) build the derived palette; `mod`
-- lazy-loads a group/palette module by name; `resolve` flattens a group's `style` sub-table
-- into nvim_set_hl keys; `cache.*` reads/writes the on-disk highlight cache keyed by style.
--
---@module "lvim-colorscheme.util"

local M = {}

M.bg = "#000000"
M.fg = "#ffffff"
M.day_brightness = 0.3

local uv = vim.uv

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
    local chunk, err = loadfile(me .. "/" .. modname:gsub("%.", "/") .. ".lua")
    if not chunk then
        error(("unknown module %q (%s)"):format(modname, err), 2)
    end
    local ret = chunk()
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

--- Relative luminance (WCAG 2.1), 0 = black … 1 = white.
---@param color string  "#rrggbb"
---@return number
function M.luminance(color)
    local c = rgb(color)
    local function chan(v)
        v = v / 255
        return v <= 0.03928 and (v / 12.92) or ((v + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * chan(c[1]) + 0.7152 * chan(c[2]) + 0.0722 * chan(c[3])
end

--- WCAG contrast ratio between two colours: 1 = identical, 21 = black on white.
---@param a string
---@param b string
---@return number
function M.contrast(a, b)
    local la, lb = M.luminance(a), M.luminance(b)
    local hi, lo = math.max(la, lb), math.min(la, lb)
    return (hi + 0.05) / (lo + 0.05)
end

--- Push `color` away from `bg` until it clears `min` contrast against it, keeping its hue: the colour is
--- blended toward whichever pole (white / black) `bg` is NOT, in small steps, and the first step that clears
--- the floor wins. Returns `color` unchanged when it already does.
---
--- Terminal palettes need this because an EDITOR foreground is tuned against exactly one background under
--- syntax highlighting, while a TERMINAL foreground has to stay legible on every block background a TUI
--- paints — and several palettes here carry a deliberately muted `fg` that reads at barely 2:1 on their own
--- background once it is used that way.
---@param color string
---@param bg string
---@param min number  the contrast floor to clear (4.5 = WCAG AA for body text)
---@return string
function M.ensure_contrast(color, bg, min)
    if M.contrast(color, bg) >= min then
        return color
    end
    -- Move LIGHTNESS in hsluv, never blend toward white/black: blending desaturates, so a palette's
    -- tinted foreground came back as a near-neutral grey and the theme lost its character. hsluv is
    -- perceptually uniform, so stepping L keeps the hue and saturation the palette chose and only makes
    -- the colour lighter (on a dark background) or darker (on a light one) until it clears the floor.
    local hsluv = require("lvim-colorscheme.hsluv")
    local hsl = hsluv.hex_to_hsluv(color)
    local l0 = hsl[3]
    local s0 = hsl[2]
    local up = M.luminance(bg) < 0.5
    local out = color
    for _ = 1, 100 do
        hsl[3] = hsl[3] + (up and 1 or -1)
        if hsl[3] > 100 or hsl[3] < 0 then
            return out
        end
        -- Scale SATURATION with the lightness we added. hsluv keeps the hue exactly, but the same S reads
        -- as visibly less colourful once L climbs — a lifted foreground came out looking washed toward grey
        -- even though its numbers said the tint was intact. Holding the L:S ratio keeps the palette's
        -- character at the new lightness, and costs nothing: contrast is a function of L, so raising S
        -- leaves the measured ratio unchanged (verified: 6.02:1 at S 15 and at S 45).
        if l0 > 0 then
            hsl[2] = math.min(s0 * (hsl[3] / l0), 100)
        end
        out = hsluv.hsluv_to_hex(hsl)
        if M.contrast(out, bg) >= min then
            return out
        end
    end
    return out
end

--- Move `color` to roughly `target` contrast against `bg`, in EITHER direction, keeping its hue.
---
--- `ensure_contrast` is a floor: it only ever pushes a colour further from the background. That is
--- the wrong tool for a tier — "secondary text, visibly quieter than the body text" — because it
--- cannot bring a too-bright colour DOWN, and several palettes here carry a `fg_soft_dark` that is
--- brighter than the derived terminal foreground (measured: dracula, material and nightfox in all
--- four variants each). Floored against the background they came out level with, or above, the very
--- colour they were supposed to sit under, and the tier collapsed.
---
--- Stepping is the same as `ensure_contrast`: hsluv lightness, saturation held to the L:S ratio, so
--- the palette's hue and character survive the move.
---@param color string
---@param bg string
---@param target number  the contrast ratio to land on
---@return string
function M.to_contrast(color, bg, target)
    local hsluv = require("lvim-colorscheme.hsluv")
    local hsl = hsluv.hex_to_hsluv(color)
    local l0, s0 = hsl[3], hsl[2]
    -- Away from the background raises contrast, toward it lowers: which way that is in LIGHTNESS
    -- depends on which side the background sits on.
    local away = M.luminance(bg) < 0.5 and 1 or -1
    local step = M.contrast(color, bg) < target and away or -away
    local out = color
    for _ = 1, 100 do
        hsl[3] = hsl[3] + step
        if hsl[3] > 100 or hsl[3] < 0 then
            return out
        end
        if l0 > 0 then
            hsl[2] = math.min(s0 * (hsl[3] / l0), 100)
        end
        local next_color = hsluv.hsluv_to_hex(hsl)
        -- Stop at the first crossing, and keep whichever of the two ends up closer to the target.
        local crossed = step == away and M.contrast(next_color, bg) >= target
            or step ~= away and M.contrast(next_color, bg) <= target
        if crossed then
            local a, b = math.abs(M.contrast(out, bg) - target), math.abs(M.contrast(next_color, bg) - target)
            return b <= a and next_color or out
        end
        out = next_color
    end
    return out
end

--- Clear `min` contrast against `bg` by walking in EITHER direction, keeping the hue.
---
--- **`ensure_contrast` picks its direction once, from `luminance(bg) < 0.5`, and that is unsafe on a
--- mid-luminance background.** A saturated accent used as a *surface* sits between 0.18 and 0.49
--- luminance on all 48 palettes here, so the heuristic sends the walk toward white when down was
--- the way out — and `ensure_contrast` returns its best effort rather than raising, so it fails
--- **silently**. Measured 2026-08-07: qutebrowser's hint-match colour climbed to 1.96:1 on
--- kanagawa_dark while walking down reached 10.61:1, and it was wrong that way on **38 of 48
--- styles**. tmux's copy-mode strip had the same shape at 2.68:1 on solarized_soft.
---
--- So: try the floor, and if the floor did not reach, walk the other way. Stepping is
--- `ensure_contrast`'s — one unit of hsluv lightness, saturation held to the L:S ratio, so the hue
--- and the character the palette chose survive the move. Returns its best effort when neither
--- direction reaches, which is a colour that is still the palette's rather than a raise nobody
--- catches; the caller that needs to know can ask [`M.contrast`].
---
--- `ensure_contrast` is deliberately left alone: it is what eleven desktop targets already call, and
--- changing which way it walks would move colours nobody asked to have moved.
---@param color string
---@param bg string
---@param min number
---@return string
function M.ensure_contrast_either_way(color, bg, min)
    local walked = M.ensure_contrast(color, bg, min)
    if M.contrast(walked, bg) >= min then
        return walked
    end
    local hsluv = require("lvim-colorscheme.hsluv")
    local hsl = hsluv.hex_to_hsluv(color)
    local l0, s0 = hsl[3], hsl[2]
    local out = walked
    for _ = 1, 100 do
        hsl[3] = hsl[3] - 1
        if hsl[3] < 0 then
            return out
        end
        if l0 > 0 then
            hsl[2] = math.min(s0 * (hsl[3] / l0), 100)
        end
        out = hsluv.hsluv_to_hex(hsl)
        if M.contrast(out, bg) >= min then
            return out
        end
    end
    return out
end

--- The readable text colour for one accent used as a *background*, of the two a theme has.
---
--- `ensure_contrast` is the wrong tool for this case, and the reason is which colour is free to
--- move. On a message strip, a mode pill or a hint label the background is the palette's accent and
--- must not move — an error strip that is no longer red has stopped being an error strip — so the
--- *text* is what gets chosen, and it has only two candidates: the theme's own background, or
--- white. Whichever of the two reads better on that accent wins.
---
--- **Choosing the better of two texts is not always enough.** The accent caps what any text on it
--- can reach: measured on everforest, the darker candidate on `orange` reached only 4.49:1 and the
--- white one on `red` only 4.40:1, and both were the best answer available. When that happens the
--- accent has to give as well — feed this result back through `ensure_contrast` with the strip as
--- the colour and the text as the background, as `extra/desktop/bru.lua` does. hsluv holds the hue,
--- so a red strip stays red and only its lightness moves; the palette key itself is untouched.
---@param accent string  the background, which does not move
---@param dark string  the theme's own background, the dark candidate
---@return string
function M.readable_on(accent, dark)
    if M.contrast("#ffffff", accent) > M.contrast(dark, accent) then
        return "#ffffff"
    end
    return dark
end

--- Of the surfaces a colour may be painted on, the one it has the hardest time on: the nearest in
--- luminance. A colour floored against that one clears all of them.
---
--- **Which surface is the hard one depends on the palette**, and assuming it costs a measurement.
--- bru's completion rows are drawn on three surfaces; on everforest *dark* `bg_light` is the
--- lightest of the three, so flooring against it covered the other two, and on everforest *light*
--- the same floor came out at **4.47:1** because there the tab rows (`bg_soft_light`, `#e9e9e9`)
--- were the near one. Nearest-in-luminance is the honest test on either side of the wheel, and it
--- needs no knowledge of whether the theme is dark or light.
---
--- Variadic rather than taking the palette and naming three keys, which is what this was when it
--- lived in `extra/desktop/bru.lua`: those three are *bru's* surfaces. A statusline is drawn on
--- `bg_statusline`, a float on `bg_float`, a number column on `bg` or on the focused window's
--- `bg_active` — every caller has its own set, and the only thing they share is the question.
---@param text string  the colour that has to stay readable
---@param ... string  the surfaces it may be painted on; at least one
---@return string
function M.hardest(text, ...)
    local lum = M.luminance(text)
    local worst, gap = nil, math.huge
    for _, surface in ipairs({ ... }) do
        local d = math.abs(M.luminance(surface) - lum)
        if d < gap then
            gap, worst = d, surface
        end
    end
    return worst
end

---@param hex string
---@param amount number
---@param bg? string
---@return string
function M.blend_bg(hex, amount, bg)
    return M.blend(hex, amount, bg or M.bg)
end
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
        -- a value may be a link string; only definition tables carry a `style`
        if type(hl) == "table" then
            local style = hl.style
            if type(style) == "table" then
                for k, v in pairs(style) do
                    hl[k] = v
                end
                hl.style = nil
            end
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

-- Plugin-owned cache directory. The highlight cache lives under a dedicated
-- `lvim-colorscheme/` subdirectory of the shared cache root (not loose at the top level), so a
-- cache clear can own the whole directory without ever touching another lvim-tech plugin that
-- also caches `lvim-*.json`. `M.write` mkdir -p's the parent, so no explicit create is needed.
---@type string
M.cache.dir = vim.fn.stdpath("cache") .. "/lvim-colorscheme"

---@param key string
---@return string
function M.cache.file(key)
    return M.cache.dir .. "/" .. key .. ".json"
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
    -- Migrate away from the pre-subdirectory layout: drop this style's orphaned top-level file
    -- (if any) now that it is written under the plugin-owned directory. Targeted by exact key —
    -- never a glob — so it can never touch another plugin's cache.
    pcall(uv.fs_unlink, vim.fn.stdpath("cache") .. "/lvim-" .. key .. ".json")
end

--- Remove every cached highlight file. Clears the plugin-owned subdirectory wholesale, then
--- unlinks any LEGACY top-level `lvim-<style>.json` written by earlier versions — matched against
--- the exact set of known style names (the `colors/` modules), NEVER a broad `lvim-*` glob that
--- would also delete another lvim-tech plugin's cache in the shared cache root.
function M.cache.clear()
    if vim.fn.isdirectory(M.cache.dir) == 1 then
        for name, t in vim.fs.dir(M.cache.dir) do
            if t == "file" and name:match("%.json$") then
                uv.fs_unlink(M.cache.dir .. "/" .. name)
            end
        end
    end

    -- One-off migration cleanup: drop the orphaned pre-subdirectory files (one per known style).
    local root = vim.fn.stdpath("cache")
    for name, t in vim.fs.dir(me .. "/lvim-colorscheme/colors") do
        local style = t == "file" and name:match("^(.+)%.lua$")
        if style and style ~= "init" then
            uv.fs_unlink(root .. "/lvim-" .. style .. ".json")
        end
    end
end

return M
