local M = {}

M.url = "https://github.com/sindrets/diffview.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    DiffAdd     = { bg = c.diff.add },
    DiffChange  = { bg = c.diff.change },
    DiffDelete  = { bg = c.diff.delete },
    DiffText    = { bg = c.bg_sidebar },
  }
end

return M
