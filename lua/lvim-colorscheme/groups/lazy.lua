local M = {}

M.url = "https://github.com/folke/lazy.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LazyNormal = { bg = c.bg_float, fg = c.green_dark },
    LazyProgressDone = { bold = true, fg = c.magenta_dark },
    LazyProgressTodo = { bold = true, fg = c.fg_dark },
  }
end

return M
