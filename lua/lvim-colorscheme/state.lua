-- lvim-colorscheme.state: runtime-only state shared across modules without circular deps.
-- Holds the palette + opts of the last-applied theme and the on-load listener list. This is
-- NOT configuration (see config.lua for the live config) — only ephemeral load-time values.
--
---@module "lvim-colorscheme.state"

local M = {}

---@type ColorScheme|nil
M.colors = nil

---@type lvim-colorscheme.Config|nil
M.opts = nil

---@type fun(colors: ColorScheme, opts: lvim-colorscheme.Config)[]
M.listeners = {}

return M
