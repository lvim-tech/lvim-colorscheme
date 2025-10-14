local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/lvim-tech/lvim-space"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    -- stylua: ignore
    return {
        -- ICONS & HEADINGS
        MarkviewIcon0                = { fg = c.teal, bold = true },
        MarkviewIcon1                = { fg = c.blue, bold = true },
        MarkviewIcon2                = { fg = c.cyan, bold = true },
        MarkviewIcon3                = { fg = c.green, bold = true },
        MarkviewIcon4                = { fg = c.yellow, bold = true },
        MarkviewIcon5                = { fg = c.orange, bold = true },
        MarkviewIcon6                = { fg = c.red, bold = true },

        MarkviewHeading1             = { bg = util.blend(c.blue, 0.2, c.bg), fg = c.blue, bold = true },
        MarkviewHeading2             = { bg = util.blend(c.cyan, 0.2, c.bg), fg = c.cyan, bold = true },
        MarkviewHeading3             = { bg = util.blend(c.green, 0.2, c.bg), fg = c.green, bold = true },
        MarkviewHeading4             = { bg = util.blend(c.yellow, 0.2, c.bg), fg = c.yellow, bold = true },
        MarkviewHeading5             = { bg = util.blend(c.orange, 0.2, c.bg), fg = c.orange, bold = true },
        MarkviewHeading6             = { bg = util.blend(c.red, 0.2, c.bg), fg = c.red, bold = true },

        MarkviewHeading1Sign         = { fg = c.blue, bold = true },
        MarkviewHeading2Sign         = { fg = c.cyan, bold = true },
        MarkviewHeading3Sign         = { fg = c.green, bold = true },
        MarkviewHeading4Sign         = { fg = c.yellow, bold = true },
        MarkviewHeading5Sign         = { fg = c.orange, bold = true },
        MarkviewHeading6Sign         = { fg = c.red, bold = true },

        MarkviewBlockQuoteDefault    = { fg = c.blue, bg = util.blend(c.bg, 0.75, c.blue) },
        MarkviewBlockQuoteError      = { fg = c.red, bg = util.blend(c.red, 0.08, c.bg) },
        MarkviewBlockQuoteNote       = { fg = c.purple, bg = util.blend(c.purple, 0.08, c.bg) },
        MarkviewBlockQuoteOk         = { fg = c.green, bg = util.blend(c.green, 0.08, c.bg) },
        MarkviewBlockQuoteSpecial    = { fg = c.cyan, bg = util.blend(c.cyan, 0.08, c.bg) },
        MarkviewBlockQuoteWarn       = { fg = c.yellow, bg = util.blend(c.yellow, 0.08, c.bg) },

        -- CHECKBOXES
        MarkviewCheckboxCancelled    = { fg = c.comment, italic = true },
        MarkviewCheckboxChecked      = { fg = c.green, bold = true },
        MarkviewCheckboxPending      = { fg = c.yellow, bold = true },
        MarkviewCheckboxProgress     = { fg = c.blue, bold = true },
        MarkviewCheckboxUnchecked    = { fg = c.red, bold = true },
        MarkviewCheckboxStriked      = { fg = c.fg_dark, strikethrough = true, italic = true },

        -- INLINE & LINKS
        MarkviewInlineCode           = { fg = c.orange, bg = util.blend(c.bg, 0.7, c.orange), italic = true },
        MarkviewHyperlink            = { fg = c.blue, underline = true, bold = true },
        MarkviewImage                = { fg = c.cyan, underline = true },
        MarkviewEmail                = { fg = c.teal, underline = true, italic = true },

        MarkviewSubscript            = { fg = c.cyan_dark, italic = true },
        MarkviewSuperscript          = { fg = c.blue_dark, italic = true },

        -- LISTS
        MarkviewListItemMinus        = { fg = c.yellow_dark, bold = true },
        MarkviewListItemPlus         = { fg = c.green_dark, bold = true },
        MarkviewListItemStar         = { fg = c.blue_dark, bold = true },

        -- TABLES
        MarkviewTableHeader          = { fg = c.green },
        MarkviewTableBorder          = { fg = c.green },
        MarkviewTableAlignLeft       = { fg = c.green },
        MarkviewTableAlignCenter     = { fg = c.green },
        MarkviewTableAlignRight      = { fg = c.green },

        -- CODE BLOCKS
        MarkviewCode                 = { bg = c.bg_float, fg = c.fg_soft_dark },
        MarkviewCodeInfo             = { bg = c.bg_float, fg = c.orange_dark, italic = true },

        -- METADATA
        MarkviewCodeFg               = { fg = c.fg },
        MarkviewCodeBg               = { bg = c.bg_soft_dark },

        -- GRADIENTS (for horizontal rules)
        MarkviewGradient1            = { fg = c.blue },
        MarkviewGradient2            = { fg = c.cyan },
        MarkviewGradient3            = { fg = c.green },
        MarkviewGradient4            = { fg = c.yellow },
        MarkviewGradient5            = { fg = c.orange },
        MarkviewGradient6            = { fg = c.red },
        MarkviewGradient7            = { fg = c.purple },
        MarkviewGradient8            = { fg = c.magenta },
        MarkviewGradient9            = { fg = c.teal },

        -- ICONS FOR RULES (horizontal rules)
        MarkviewIcon3Fg              = { fg = c.green, bold = true },

        -- PALETTE (for reference_definitions etc)
        MarkviewPalette0Fg           = { fg = c.blue },
        MarkviewPalette0Fg1          = { fg = c.blue_dark },
        MarkviewPalette0Fg2          = { fg = c.cyan },
        MarkviewPalette1Fg           = { fg = c.red },
        MarkviewPalette1Fg2          = { fg = c.red_dark },
        MarkviewPalette2Fg           = { fg = c.yellow },
        MarkviewPalette2Fg2          = { fg = c.yellow_dark },
        MarkviewPalette3             = { fg = c.cyan },
        MarkviewPalette3Fg           = { fg = c.cyan },
        MarkviewPalette3Fg2          = { fg = c.cyan_dark },
        MarkviewPalette4Fg           = { fg = c.green },
        MarkviewPalette4Fg2          = { fg = c.green_dark },
        MarkviewPalette5Fg           = { fg = c.purple },
        MarkviewPalette5Fg2          = { fg = c.purple_dark },
        MarkviewPalette6Fg           = { fg = c.orange },
        MarkviewPalette6Fg2          = { fg = c.orange_dark },
        MarkviewPalette7Fg           = { fg = c.magenta },
        MarkviewPalette7Fg2          = { fg = c.magenta_dark },

        -- For code_blocks.diff (explicitly needed)
        MarkviewPalette4             = { fg = c.green },
        MarkviewPalette1             = { fg = c.red },
    }
end

return M
