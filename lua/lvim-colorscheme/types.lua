---@class lvim-colorscheme.Highlight
---@field fg? string
---@field bg? string
---@field style? string
---@field sp? string

---@alias lvim-colorscheme.Highlights table<string, lvim-colorscheme.Highlight>

---@alias lvim-colorscheme.HighlightsFn fun(colors: ColorScheme, opts: lvim-colorscheme.Config): lvim-colorscheme.Highlights

---@class lvim-colorscheme.Cache
---@field groups lvim-colorscheme.Highlights
---@field inputs table

---@class Palette
---@field [string] string

---@class ColorScheme
---@field colors Palette
---@field highlights lvim-colorscheme.Highlights
