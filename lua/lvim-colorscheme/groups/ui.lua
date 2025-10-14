local M = {}

M.url = "https://github.com/OXY2DEV/ui.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(colors)
    local blend = colors.blend

    return {
        -- Command Line
        UICmdlineDefault = { bg = blend.blueHigh, fg = colors.blue },
        UICmdlineDefaultIcon = { bg = blend.blueLow, fg = colors.blue },
        UICmdlineLua = { bg = blend.purpleHigh, fg = colors.purple },
        UICmdlineLuaIcon = { bg = blend.purpleLow, fg = colors.purple },
        UICmdlineEval = { bg = blend.redHigh, fg = colors.red },
        UICmdlineEvalIcon = { bg = blend.redLow, fg = colors.red },
        UICmdlineSearchUp = { bg = blend.blueHigh, fg = colors.blue },
        UICmdlineSearchUpIcon = { bg = blend.blueLow, fg = colors.blue },
        UICmdlineSearchDown = { bg = blend.blueHigh, fg = colors.blue },
        UICmdlineSearchDownIcon = { bg = blend.blueLow, fg = colors.blue },
        UICmdlineSubstitute = { bg = blend.cyanHigh, fg = colors.cyan },
        UICmdlineSubstituteIcon = { bg = blend.cyanLow, fg = colors.cyan },

        -- UI Messages
        UIMessageDefault = { bg = blend.blueHigh, fg = colors.blue },
        UIMessageOk = { bg = blend.greenHigh, fg = colors.green },
        UIMessageOkIcon = { bg = blend.greenLow, fg = colors.green },
        UIMessageInfo = { bg = blend.blueHigh, fg = colors.blue },
        UIMessageInfoSign = { bg = blend.blueLow, fg = colors.blue },
        UIMessageHint = { bg = blend.cyanHigh, fg = colors.cyan },
        UIMessageHintSign = { bg = blend.cyanHigh, fg = colors.cyan },
        UIMessageWarn = { bg = blend.orangeHigh, fg = colors.orange },
        UIMessageWarnSign = { bg = blend.orangeHigh, fg = colors.orange },
        UIMessageError = { bg = blend.redHigh, fg = colors.red },
        UIMessageErrorIcon = { bg = blend.redLow, fg = colors.red },
        UIMessageErrorSign = { bg = blend.redHigh, fg = colors.red },
        UIMessagePalette = { bg = blend.purpleHigh, fg = colors.purple },
        UIMessagePaletteSign = { bg = blend.purpleHigh, fg = colors.purple },

        -- History UI
        UIHistoryKeymap = { bg = blend.blueLow, fg = colors.blue, bold = true },
        UIHistoryDesc = { bg = blend.blueHigh, fg = colors.blue },

        -- Diagnostics
        DiagnosticInfo = { fg = colors.blue },
        DiagnosticOk = { fg = colors.green },
        DiagnosticWarn = { fg = colors.orange },
        DiagnosticError = { fg = colors.red },
        DiagnosticHint = { fg = colors.cyan },
    }
end

return M
