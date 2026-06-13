---@class lvim-colorscheme.Highlight
---@field fg? string
---@field bg? string
---@field style? string|table
---@field sp? string

--- A highlight is either a definition table or a string linking to another group.
---@alias lvim-colorscheme.Highlights table<string, lvim-colorscheme.Highlight|string>

---@alias lvim-colorscheme.HighlightsFn fun(colors: ColorScheme, opts: lvim-colorscheme.Config): lvim-colorscheme.Highlights

---@class lvim-colorscheme.Cache
---@field groups lvim-colorscheme.Highlights
---@field inputs table

---@class Palette
---@field [string] string

---@class ColorScheme
---@field colors Palette
---@field highlights lvim-colorscheme.Highlights
