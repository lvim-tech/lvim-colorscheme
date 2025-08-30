local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/OXY2DEV/ui.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local cmd_bg = util.blend_bg(c.bg_highlight, 0.85, c.bg)
    local cmd_icon_bg = util.blend_bg(c.bg_highlight, 0.95, c.bg)
  -- stylua: ignore
  return {
    -- Command Line
    UICmdlineDefault         = { bg = c.red, fg = c.fg },
    UICmdlineDefaultIcon     = { bg = cmd_icon_bg, fg = c.blue },
    UICmdlineLua             = { bg = cmd_bg, fg = c.fg },
    UICmdlineLuaIcon         = { bg = cmd_icon_bg, fg = c.purple },
    UICmdlineEval            = { bg = cmd_bg, fg = c.fg },
    UICmdlineEvalIcon        = { bg = cmd_icon_bg, fg = c.orange },
    UICmdlineSearchUp        = { bg = cmd_bg, fg = c.fg },
    UICmdlineSearchUpIcon    = { bg = cmd_icon_bg, fg = c.green },
    UICmdlineSearchDown      = { bg = cmd_bg, fg = c.fg },
    UICmdlineSearchDownIcon  = { bg = cmd_icon_bg, fg = c.cyan },
    UICmdlineSubstitute      = { bg = cmd_bg, fg = c.fg },
    UICmdlineSubstituteIcon  = { bg = cmd_icon_bg, fg = c.yellow },

    -- UI Messages
    UIMessageDefault         = { bg = util.blend_bg(c.blue, 0.15, c.bg), fg = c.blue },
    UIMessageOk              = { bg = util.blend_bg(c.green, 0.15, c.bg), fg = c.green },
    UIMessageInfo            = { bg = util.blend_bg(c.blue, 0.15, c.bg), fg = c.blue },
    UIMessageInfoSign        = { bg = util.blend_bg(c.blue, 0.15, c.bg), fg = c.blue },
    UIMessageHint            = { bg = util.blend_bg(c.cyan, 0.15, c.bg), fg = c.cyan },
    UIMessageWarn            = { bg = util.blend_bg(c.yellow, 0.15, c.bg), fg = c.yellow },
    UIMessageWarnSign        = { bg = util.blend_bg(c.yellow, 0.15, c.bg), fg = c.yellow },
    UIMessageError           = { bg = util.blend_bg(c.red, 0.15, c.bg), fg = c.red },
    UIMessageErrorSign       = { bg = util.blend_bg(c.red, 0.15, c.bg), fg = c.red },
    -- Palette (специална палитра/сигнали)
    UIMessagePalette         = { fg = c.purple, bg = util.blend_bg(c.purple, 0.15, c.bg) },
    UIMessagePaletteSign     = { fg = c.purple, bg = util.blend_bg(c.purple, 0.15, c.bg) }, -- ако се използва

    -- История (History UI)
    UIHistoryKeymap          = { fg = c.blue, bold = true },
    UIHistoryDesc            = { fg = c.fg_dark },

    -- Popup менюта (Menu UI)
    UIMenuSelect             = { bg = c.bg_highlight, fg = c.fg_light, bold = true },
    UIMenuKeymap             = { fg = c.orange, bg = c.bg, bold = true },

    -- LSP/List/Sidepanel Groups
    UILSBuffer               = { bg = c.bg_soft_dark, fg = c.blue, bold = true },
    UILSBufname              = { bg = c.bg_soft_dark, fg = c.teal, bold = true },
    UILSIndicator            = { bg = c.bg_highlight, fg = c.yellow, bold = true },
    UILSLnum                 = { bg = c.bg_dark, fg = c.orange_dark, bold = true },
  }
end

return M
