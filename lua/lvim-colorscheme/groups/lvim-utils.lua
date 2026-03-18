local M = {}

M.url = "https://github.com/lvim-tech/lvim-utils"

---@type lvim-colorscheme.HighlightsFn
function M.get(c, _opts)
    local blend = c.blend

    -- stylua: ignore
    local groups = {
        -- Window chrome
        LvimUiNormal    = { bg = c.bg_dark,      fg = c.fg             },
        LvimUiBorder    = { bg = c.bg_dark,      fg = c.blue           },
        LvimUiSeparator = {                       fg = c.cyan           },

        -- Title block
        LvimUiTitle    = { bg = blend.blueHigh,  fg = c.blue,  bold = true },
        LvimUiSubtitle = {                        fg = c.orange          },
        LvimUiInfo     = {                        fg = c.yellow          },

        -- Tab bar
        LvimUiTabActive      = { bg = blend.redHigh, fg = c.fg_light           },
        LvimUiTabInactive    = {                      fg = c.red                },
        LvimUiTabIconActive  = {                      fg = c.yellow             },
        LvimUiTabIconInactive= {                      fg = c.yellow_dark        },
        LvimUiTabTextActive  = {                      fg = c.red,   bold = true },
        LvimUiTabTextInactive= {                      fg = c.red_dark           },

        -- Action bar buttons
        LvimUiButtonActive       = { bg = c.bg_light,    fg = c.fg             },
        LvimUiButtonInactive     = { bg = c.bg_soft_dark, fg = c.fg_dark       },
        LvimUiButtonIconActive   = {                      fg = c.orange         },
        LvimUiButtonIconInactive = {                      fg = c.fg_dark        },
        LvimUiButtonTextActive   = {                      fg = c.fg,  bold = true },
        LvimUiButtonTextInactive = {                      fg = c.fg_dark        },

        -- Cursor / selection
        LvimUiCursorLine = { bg = c.bg },

        -- Typed-row (tabs) icon / text
        LvimUiRowIconActive   = { fg = c.yellow            },
        LvimUiRowIconInactive = { fg = c.yellow_dark       },
        LvimUiRowTextActive   = { fg = c.yellow, bold = true },
        LvimUiRowTextInactive = { fg = c.fg                },

        -- Select / multiselect items
        LvimUiItemIconActive   = { fg = c.teal             },
        LvimUiItemIconInactive = { fg = c.fg_dark          },
        LvimUiItemTextActive   = { fg = c.fg               },
        LvimUiItemTextInactive = { fg = c.fg_soft_dark     },

        -- Multiselect checkboxes
        LvimUiCheckboxSelected = { fg = c.green            },
        LvimUiCheckboxEmpty    = { fg = c.fg_dark          },

        -- Input field
        LvimUiInput = { bg = c.bg_soft_dark, fg = c.fg    },

        -- Footer hint bar
        LvimUiFooter      = { fg = c.blue,   bold = true   },
        LvimUiFooterKey   = { fg = c.blue                  },
        LvimUiFooterLabel = { fg = c.yellow                },

        -- Spacer / divider rows
        LvimUiSpacer = { fg = c.fg_dark                    },

        -- Notify toast panel
        LvimNotifyNormal     = { bg = c.bg_dark, fg = c.fg         },
        LvimNotifyTitle      = { fg = c.fg_light, bold = true       },
        LvimNotifyInfo       = { fg = c.teal                        },
        LvimNotifyWarn       = { fg = c.orange                      },
        LvimNotifyError      = { fg = c.red                         },
        LvimNotifyDebug      = { fg = c.purple                      },

        LvimNotifyTitleInfo  = { fg = c.teal,   bold = true         },
        LvimNotifyTitleWarn  = { fg = c.orange, bold = true         },
        LvimNotifyTitleError = { fg = c.red,    bold = true         },
        LvimNotifyTitleDebug = { fg = c.purple, bold = true         },

        LvimNotifyHeaderInfo  = { bg = blend.hintHigh,    fg = c.fg_light, bold = true },
        LvimNotifyHeaderWarn  = { bg = blend.warningHigh, fg = c.fg_light, bold = true },
        LvimNotifyHeaderError = { bg = blend.errorHigh,   fg = c.fg_light, bold = true },
        LvimNotifyHeaderDebug = { bg = blend.purpleHigh,  fg = c.fg_light, bold = true },

        LvimNotifySepInfo  = { bg = c.bg_dark, fg = blend.hintHigh    },
        LvimNotifySepWarn  = { bg = c.bg_dark, fg = blend.warningHigh },
        LvimNotifySepError = { bg = c.bg_dark, fg = blend.errorHigh   },
        LvimNotifySepDebug = { bg = c.bg_dark, fg = blend.purpleHigh  },
    }

    -- Inject into lvim-utils highlight registry (force=true) so our groups
    -- survive the ColorScheme autocmd that lvim-utils fires after each theme change.
    local ok, hl = pcall(require, "lvim-utils.highlight")
    if ok then
        hl.register(groups, true)
    end

    return groups
end

return M
