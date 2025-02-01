local util = require("lvim-colorscheme.util")

local M = {}

M.url = "https://github.com/folke/snacks.nvim"

---@type lvim-colorscheme.HighlightsFn
function M.get(c, opts)
  -- stylua: ignore
  local ret = {
    SnacksNotifierDebug       = { fg = c.fg, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierBorderDebug = { fg = util.blend_bg(c.comment, 0.4), bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierIconDebug   = { fg = c.comment, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTitleDebug  = { fg = c.comment, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierError       = { fg = c.fg, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierBorderError = { fg = util.blend_bg(c.error, 0.4), bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierIconError   = { fg = c.error, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTitleError  = { fg = c.error, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierInfo        = { fg = c.fg, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierBorderInfo  = { fg = util.blend_bg(c.info, 0.4), bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierIconInfo    = { fg = c.info, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTitleInfo   = { fg = c.info, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTrace       = { fg = c.fg, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierBorderTrace = { fg = util.blend_bg(c.purple, 0.4), bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierIconTrace   = { fg = c.purple, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTitleTrace  = { fg = c.purple, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierWarn        = { fg = c.fg, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierBorderWarn  = { fg = util.blend_bg(c.warning, 0.4), bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierIconWarn    = { fg = c.warning, bg = opts.transparent and c.none or c.bg_dark },
    SnacksNotifierTitleWarn   = { fg = c.warning, bg = opts.transparent and c.none or c.bg_dark },
    -- Dashboard
    SnacksDashboardDesc       = { fg = c.cyan },
    SnacksDashboardFooter     = { fg = c.red_dark },
    SnacksDashboardHeader     = { fg = c.green_dark },
    SnacksDashboardIcon       = { fg = c.red_dark },
    SnacksDashboardKey        = { fg = c.orange },
    SnacksDashboardSpecial    = { fg = c.purple },
    SnacksDashboardDir        = { fg = c.comment },
    -- Profiler
    SnacksProfilerIconInfo    = { bg = util.blend_bg(c.red_dark, 0.3), fg = c.red_dark },
    SnacksProfilerBadgeInfo   = { bg = util.blend_bg(c.red_dark, 0.1), fg = c.red_dark },
    SnacksScratchKey          = "SnacksProfilerIconInfo",
    SnacksScratchDesc         = "SnacksProfilerBadgeInfo",
    SnacksProfilerIconTrace   = { bg = util.blend_bg(c.purple_dark, 0.3), fg = c.bg_soft_light },
    SnacksProfilerBadgeTrace  = { bg = util.blend_bg(c.purple_dark, 0.1), fg = c.bg_soft_light },
    SnacksIndent              = { fg = c.fg_dark, nocombine = true },
    SnacksIndentScope         = { fg = c.red_dark, nocombine = true },
    SnacksZenIcon             = { fg = c.purple },
    SnacksInputIcon           = { fg = c.red_dark },
    SnacksInputBorder         = { fg = c.yellow },
    SnacksInputTitle          = { fg = c.yellow },
    -- Picker
    SnacksPickerInputBorder   = { fg = c.orange, bg = c.bg_float },
    SnacksPickerInputTitle         = { fg = c.orange, bg = c.bg_float },
    SnacksPickerBoxTitle         = { fg = c.orange, bg = c.bg_float },
    SnacksPickerSelected    = { fg = c.magenta_dark},
    SnacksPickerFlag         = "SnacksProfilerBadgeInfo",
  }
    for i, color in ipairs(c.rainbow) do
        ret["SnacksIndent" .. i] = { fg = color, nocombine = true }
    end
    return ret
end

return M
