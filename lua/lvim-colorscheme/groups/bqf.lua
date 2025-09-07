local M = {}

M.url = "https://github.com/kevinhwang91/nvim-bqf"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    BqfPreviewBorder  = { bg = c.bg_soft_dark,  fg = c.green_dark },
    BqfPreviewTitle   = { bg = c.bg_soft_dark,  fg = c.red_dark,      bold = true },
    BqfPreviewSbar    = { bg = c.bg_soft_dark,  fg = c.green_dark},
    BqfPreviewThumb   = { bg = c.green_dark,    fg = c.green_dark},
    BqfPreviewRange   = { bg = c.bg_visual},
  }
end

return M
