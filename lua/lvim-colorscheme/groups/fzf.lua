local M = {}

M.url = "https://github.com/ibhagwan/fzf-lua"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    FzfLuaBorder            = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaCursor            = "IncSearch",
    FzfLuaDirPart           = { fg = c.fg_soft_dark },
    FzfLuaFilePart          = "FzfLuaFzfNormal",
    FzfLuaFzfCursorLine     = "Visual",
    FzfLuaFzfNormal         = { bg = c.bg_float, fg = c.fg },
    FzfLuaFzfPointer        = { fg = c.magenta_dark },
    FzfLuaFzfSeparator      = { fg = c.orange, bg = c.bg_float },
    FzfLuaHeaderBind        = "@punctuation.special",
    FzfLuaHeaderText        = "Title",
    FzfLuaNormal            = { fg = c.fg, bg = c.bg_float },
    FzfLuaPath              = "Directory",
    FzfLuaPreviewTitle      = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaTitle             = { fg = c.orange, bg = c.bg_float },
    FzfLuaBackdrop          = { bg = c.bg_float },
    FzfLuaSearch            = { fg = c.red_dark },
    FzfLuaLine              = { fg = c.red },
    FzfLuaLivePrompt        = { fg = c.green },
    FzfLuaLiveSym           = { fg = c.green },
    FzfLuaFzfPrompt         = { fg = c.green },
    FzfLuaPreviewBorder     = { bg = c.bg_float, fg = c.orange_03 },
    FzfLuaPrompt            = { bg = c.bg_float, fg = c.red_02 },
    FzfLuaLinePlus          = { bg = c.bg_float, fg = c.green_02 },
    FzfLuaItemKindVariable  = { fg = c.blue_02 },
  }
end

return M
