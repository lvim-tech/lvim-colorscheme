-- Internal state shared across modules without circular dependencies.
local M = {}

---@type ColorScheme|nil
M.colors = nil

---@type lvim-colorscheme.Config|nil
M.opts = nil

---@type fun(colors: ColorScheme, opts: lvim-colorscheme.Config)[]
M.listeners = {}

return M
