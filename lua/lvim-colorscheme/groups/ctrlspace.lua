local M = {}

M.url = "https://github.com/vim-ctrlspace/vim-ctrlspace"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    CtrlSpaceNormal = { bg = c.bg_float },
    CtrlSpaceSelected = { bg = c.bg_float, fg = c.yellow_dark },
    CtrlSpaceSearch = { fg = c.cyan },
    CtrlSpaceStatus = { fg = c.green },
  }
end

return M
