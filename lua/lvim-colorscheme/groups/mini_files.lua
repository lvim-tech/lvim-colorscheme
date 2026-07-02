-- lvim-colorscheme.groups.mini_files: highlight groups for mini.files (https://github.com/echasnovski/mini.files).
--
---@module "lvim-colorscheme.groups.mini_files"

local M = {}

M.url = "https://github.com/echasnovski/mini.files"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        MiniFilesBorder         = "FloatBorder",
        MiniFilesBorderModified = "DiagnosticFloatingWarn",
        MiniFilesCursorLine     = "CursorLine",
        MiniFilesDirectory      = "Directory",
        MiniFilesFile           = { fg = c.fg_float },
        MiniFilesNormal         = "NormalFloat",
        MiniFilesTitle          = "FloatTitle",
        MiniFilesTitleFocused   = { fg = c.border_highlight, bg = c.bg_float, bold = true },
    }
end

return M
