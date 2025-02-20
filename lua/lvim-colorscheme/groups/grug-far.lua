local M = {}

M.url = "https://github.com/MagicDuck/grug-far.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    GrugFarHelpHeader             = { fg = c.comment },
    GrugFarHelpHeaderKey          = { fg = c.cyan },
    GrugFarInputLabel             = { fg = c.red_dark },
    GrugFarInputPlaceholder       = { fg = c.comment },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsHeader          = { fg = c.orange },
    GrugFarResultsLineColumn      = { fg = c.comment },
    GrugFarResultsLineNo          = { fg = c.comment },
    GrugFarResultsMatch           = { fg = c.black, bg = c.bg_highlight },
    GrugFarResultsStats           = { fg = c.green_dark },
  }
end

return M
