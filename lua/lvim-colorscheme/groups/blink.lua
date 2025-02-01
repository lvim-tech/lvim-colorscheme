local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
local ret = {
  BlinkCmpDoc                 = { bg = c.bg_float,   fg = c.fg },
  BlinkCmpDocBorder           = { bg = c.bg_float,   fg = c.border_highlight },
  BlinkCmpGhostText           = { bg = c.none,       fg = c.comment },
  BlinkCmpKindCodeium         = { bg = c.none,       fg = c.teal },
  BlinkCmpKindCopilot         = { bg = c.none,       fg = c.teal },
  BlinkCmpKindDefault         = { bg = c.none,       fg = c.green },
  BlinkCmpKindSupermaven      = { bg = c.none,       fg = c.teal },
  BlinkCmpKindTabNine         = { bg = c.none,       fg = c.teal },
  BlinkCmpLabel               = { bg = c.none,       fg = c.fg },
  BlinkCmpLabelDeprecated     = { bg = c.none,       fg = c.fg,                   strikethrough = true },
  BlinkCmpLabelMatch          = { bg = c.none,       fg = c.red_dark },
  BlinkCmpMenu                = { bg = c.bg_float,   fg = c.fg },
  BlinkCmpMenuBorder          = { bg = c.bg_float,   fg = c.border_highlight },
  BlinkCmpSignatureHelp       = { bg = c.bg_float,   fg = c.fg },
  BlinkCmpSignatureHelpBorder = { bg = c.bg_float,   fg = c.border_highlight },
}

    require("lvim-colorscheme.groups.kinds").kinds(ret, "BlinkCmpKind%s")
    return ret
end

return M
