-- lvim-colorscheme.groups.copilot: highlight groups for copilot.lua (https://github.com/zbirenbaum/copilot.lua).
--
---@module "lvim-colorscheme.groups.copilot"

local M = {}

M.url = "https://github.com/zbirenbaum/copilot.lua"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    local ret = {
        CopilotAnnotation = { fg = c.terminal_black },
        CopilotSuggestion = { fg = c.terminal_black },
    }
    return ret
end

return M
