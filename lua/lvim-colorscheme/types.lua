---@class lvim-colorscheme.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias lvim-colorscheme.Highlights table<string,lvim-colorscheme.Highlight|string>

---@alias lvim-colorscheme.HighlightsFn fun(colors: ColorScheme, opts:lvim-colorscheme.Config):lvim-colorscheme.Highlights

---@class lvim-colorscheme.Cache
---@field groups lvim-colorscheme.Highlights
---@field inputs table
