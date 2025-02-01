local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local ret = {
    CmpDocumentation       = { bg = c.bg_float,   fg = c.fg },
    CmpDocumentationBorder = { bg = c.bg_float,   fg = c.border_highlight },
    CmpGhostText           = { bg = c.none,       fg = c.comment },
    CmpItemAbbr            = { bg = c.none,       fg = c.fg },
    CmpItemAbbrDeprecated  = { bg = c.none,       fg = c.fg_dark,  strikethrough = true },
    CmpItemAbbrMatch       = { bg = c.none,       fg = c.red_dark },
    CmpItemAbbrMatchFuzzy  = { bg = c.none,       fg = c.red_dark },
    CmpItemKindCodeium     = { bg = c.none,       fg = c.teal },
    CmpItemKindCopilot     = { bg = c.none,       fg = c.teal },
    CmpItemKindSupermaven  = { bg = c.none,       fg = c.teal },
    CmpItemKindDefault     = { bg = c.none,       fg = c.fg_soft_dark },
    CmpItemKindTabNine     = { bg = c.none,       fg = c.teal },
    CmpItemMenu            = { bg = c.none,       fg = c.comment },
  }

    require("lvim-colorscheme.groups.kinds").kinds(ret, "CmpItemKind%s")
    return ret
end

return M
