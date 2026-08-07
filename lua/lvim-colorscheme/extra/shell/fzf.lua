-- lvim-colorscheme.extra.fzf: build the fzf highlight-link map that themes fzf-lua's built-in fzf UI.
--
---@module "lvim-colorscheme.extra.fzf"

local util = require("lvim-colorscheme.util")

local M = {}

function M.generate()
    local links = {
        FzfLuaFzfCursorLine = "CursorLine",
        FzfLuaFzfMatch = "Special",
        FzfLuaFzfBorder = "FzfLuaBorder",
        FzfLuaFzfScrollbar = "FzfLuaBorder",
        FzfLuaFzfSeparator = "FzfLuaBorder",
        FzfLuaFzfGutter = "FzfLuaNormal",
        FzfLuaFzfHeader = "FzfLuaTitle",
        FzfLuaFzfInfo = "NonText",
        FzfLuaFzfPointer = "Special",
        FzfLuaFzfMarker = "FzfLuaFzfPointer",
        FzfLuaFzfSpinner = "FzfLuaFzfPointer",
        FzfLuaFzfPrompt = "Special",
        FzfLuaFzfQuery = "FzfLuaNormal",
    }

    local spec = {
        ["fg"] = { "fg", "FzfLuaNormal" },
        ["bg"] = { "bg", "FzfLuaNormal" },
        ["hl"] = { "fg", "FzfLuaFzfMatch" },
        -- ["fg+"] = { "fg", "FzfLuaFzfCursorLine" },
        ["bg+"] = { "bg", "FzfLuaFzfCursorLine" },
        ["hl+"] = { "fg", "FzfLuaFzfMatch" },
        ["info"] = { "fg", "FzfLuaFzfInfo" },
        ["border"] = { "fg", "FzfLuaFzfBorder" },
        ["separator"] = { "fg", "FzfLuaFzfSeparator" },
        ["scrollbar"] = { "fg", "FzfLuaFzfScrollbar" },
        ["gutter"] = { "bg", "FzfLuaFzfGutter" },
        ["query"] = { "fg", "FzfLuaFzfQuery", "regular" },
        ["prompt"] = { "fg", "FzfLuaFzfPrompt" },
        ["pointer"] = { "fg", "FzfLuaFzfPointer" },
        ["marker"] = { "fg", "FzfLuaFzfMarker" },
        ["spinner"] = { "fg", "FzfLuaFzfSpinner" },
        ["header"] = { "fg", "FzfLuaFzfHeader" },
    }
    -- Which slot paints the SURFACE each foreground slot is read on. fzf draws a normal row on
    -- `bg` and the row under the cursor on `bg+`, so `fg` has to clear both — the slot is one
    -- colour and the terminal picks the row. The four slots left out of this table are left out
    -- deliberately: `border` and `separator` are the box's own lines, `scrollbar` is the thumb
    -- beside them, and `gutter` is a background rather than something drawn on one. Nothing is
    -- read against any of the four, and flooring them draws lines nobody asked for.
    --
    -- The colours here are neovim's own highlight groups, already floored for neovim's floats by
    -- `groups/base.lua`. That is not the same measurement: fzf is a separate process painting on
    -- its own window, so `FzfLuaNormal`'s foreground lands on `FzfLuaNormal`'s background with no
    -- popup wash under it. Measured across the 48 styles before this existed, 377 of fzf's 480
    -- text pairs were under 4.5:1 — `fg` at **1.97:1** on everforest_soft and the match counter
    -- at **1.90:1** on kanagawa_light.
    local on = {
        ["fg"] = { "bg", "bg+" },
        ["hl"] = { "bg" },
        ["hl+"] = { "bg+" },
        ["info"] = { "bg" },
        ["query"] = { "bg" },
        ["prompt"] = { "bg" },
        ["header"] = { "bg" },
        ["pointer"] = { "bg+" },
        ["marker"] = { "bg+" },
        ["spinner"] = { "bg" },
    }

    local value = {}
    for c, v in pairs(spec) do
        local hl_group = links[v[2]]
        if vim.fn.hlexists(v[2]) == 1 then
            hl_group = v[2]
        end
        assert(hl_group, "hl_group not found for " .. v[2])
        local hl = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
        assert(hl, "hl not found for " .. hl_group)
        local color = hl[v[1]]
        assert(color, "color not found for " .. c .. ":" .. hl_group)
        value[c] = string.format("#%06x", color)
    end

    -- Floored after every slot is resolved, because a foreground's surface is another slot.
    for c, surfaces in pairs(on) do
        if value[c] then
            local list = {}
            for _, s in ipairs(surfaces) do
                if value[s] then
                    list[#list + 1] = value[s]
                end
            end
            if #list > 0 then
                value[c] = util.ensure_contrast(value[c], util.hardest(value[c], unpack(list)), 4.5)
            end
        end
    end

    local ret = {}
    for c, v in pairs(spec) do
        local line = string.format("--color=%s:%s", c, value[c])
        if v[3] then
            line = line .. ":" .. v[3]
        end
        ret[#ret + 1] = "  " .. line .. " \\"
    end
    table.sort(ret)

    return M.template:format(table.concat(ret, "\n"))
end

-- Colours only. The behaviour flags this used to carry (--ansi, --info,
-- --layout, --border, --highlight-line) belong to whoever owns the fzf
-- config — clipack's config.sh already sets its own and sources this file
-- afterwards, so the theme's copies silently won every disagreement.
M.template = [[export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
%s
"]]

return M
