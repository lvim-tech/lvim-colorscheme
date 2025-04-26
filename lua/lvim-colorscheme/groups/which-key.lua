local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    WhichKey          = { fg = c.cyan },
    -- WhichKeyGroup     = { fg = c.green_dark },
    WhichKeyDesc      = { fg = c.magenta },
    WhichKeySeparator = { fg = c.comment },
    WhichKeyNormal     = { bg = c.bg_sidebar },
    WhichKeyValue     = { fg = c.bg_light },
  }
end

return M
