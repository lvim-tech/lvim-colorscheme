local M = {}

M.url = "https://github.com/folke/lazy.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LazyNormal        = { bg = c.bg_float, fg = c.green_dark },
    LazyDimmer        = { fg = c.fg_soft_dark },
    LazyProp          = { fg = c.yellow_dark },
    LazyProgressDone  = { bold = true, fg = c.magenta_dark },
    LazyProgressTodo  = { bold = true, fg = c.fg_dark },
  }
end

return M
