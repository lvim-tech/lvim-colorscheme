local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/OXY2DEV/ui.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local cmd_bg = util.blend_bg(c.bg_highlight, 0.85, c.bg)
    local cmd_icon_bg = util.blend_bg(c.bg_highlight, 0.95, c.bg)
  -- stylua: ignore
  return {
    -- Command Line Highlights
    -- Default Command Line
    UICmdlineDefault = { bg = c.red, fg = c.fg },
    UICmdlineDefaultIcon = { bg = cmd_icon_bg, fg = c.blue },
    -- Lua Command Line
    UICmdlineLua = { bg = cmd_bg, fg = c.fg },
    UICmdlineLuaIcon = { bg = cmd_icon_bg, fg = c.purple },
    -- Eval Command Line
    UICmdlineEval = { bg = cmd_bg, fg = c.fg },
    UICmdlineEvalIcon = { bg = cmd_icon_bg, fg = c.orange },
    -- Search Command Line
    UICmdlineSearchUp = { bg = cmd_bg, fg = c.fg },
    UICmdlineSearchUpIcon = { bg = cmd_icon_bg, fg = c.green },
    UICmdlineSearchDown = { bg = cmd_bg, fg = c.fg },
    UICmdlineSearchDownIcon = { bg = cmd_icon_bg, fg = c.cyan },
    -- Substitute Command Line
    UICmdlineSubstitute = { bg = cmd_bg, fg = c.fg },
    UICmdlineSubstituteIcon = { bg = cmd_icon_bg, fg = c.yellow },
    -- Message Highlights
    -- Default Messages
    UIMessageDefault = { bg = util.blend_bg(c.bg_highlight, 0.8), fg = c.fg },
    -- Status Messages
    UIMessageOk = { bg = util.blend_bg(c.green, 0.15), fg = c.green },
    UIMessageInfo = { bg = util.blend_bg(c.blue, 0.15), fg = c.blue },
    UIMessageInfoSign = { bg = util.blend_bg(c.blue, 0.15), fg = c.blue },
    UIMessageHint = { bg = util.blend_bg(c.cyan, 0.15), fg = c.cyan },
    UIMessageWarn = { bg = util.blend_bg(c.yellow, 0.15), fg = c.yellow },
    UIMessageWarnSign = { bg = util.blend_bg(c.yellow, 0.15), fg = c.yellow },
    UIMessageError = { bg = util.blend_bg(c.red, 0.15), fg = c.red },
    UIMessageErrorSign = { bg = util.blend_bg(c.red, 0.15), fg = c.red },
    UIMessagePaletteSign = { bg = util.blend_bg(c.purple, 0.15), fg = c.purple },
    -- History UI
    UIHistoryKeymap = { fg = c.blue, bold = true },
    UIHistoryDesc = { fg = c.fg_dark },
  }
end

return M
