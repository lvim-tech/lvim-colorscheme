local M = {}

M.url = "https://github.com/hedyhli/outline.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    SideBar   = { bg = c.bg_sidebar },
    SideBarNC = { bg = c.bg_sidebar },
  }
end

return M
