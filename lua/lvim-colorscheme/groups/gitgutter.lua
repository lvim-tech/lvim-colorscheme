local M = {}

M.url = "https://github.com/airblade/vim-gitgutter"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        GitGutterAdd          = { fg = c.git.add },
        GitGutterChange       = { fg = c.git.change },
        GitGutterDelete       = { fg = c.git.delete },
        GitGutterAddLineNr    = { fg = c.git.add },
        GitGutterChangeLineNr = { fg = c.git.change },
        GitGutterDeleteLineNr = { fg = c.git.delete },
    }
end

return M
