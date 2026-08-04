-- lvim-colorscheme.types: shared LuaDoc type definitions (no runtime code).
-- The Highlight / Highlights / HighlightsFn / Cache / Palette / ColorScheme classes and
-- aliases used across the engine (groups, colors, theme, util) live here so the annotations
-- stay in one place. Required for its side-effect of registering the types with the LSP.
--
---@module "lvim-colorscheme.types"

--- A group definition is everything `nvim_set_hl` accepts, plus the engine-only `style`
--- key (a `styles.*` config value — `"italic"`, `{ italic = true }`, `false`). `util.highlight`
--- expands `style` into the real boolean attributes and strips it before the value reaches
--- the API, so the extra field never leaves the engine.
---@class lvim-colorscheme.Highlight : vim.api.keyset.highlight
---@field style? string|table

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
