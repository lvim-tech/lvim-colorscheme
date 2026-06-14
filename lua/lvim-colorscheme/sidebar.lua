-- lvim-colorscheme.sidebar: mark configured filetypes as sidebars.
--
-- Side panels that don't theme themselves (help, quickfix, outlines, …) otherwise render
-- with the editor `Normal` background. This applies a `Normal:NormalSB` winhighlight to the
-- windows of the `sidebar_filetypes`, so they take the sidebar background — which follows
-- `styles.sidebars` (dark / transparent / normal). Plugins that ship their own groups
-- (neo-tree, …) already get the sidebar bg and set their own winhighlight, so leave them out.
--
---@module "lvim-colorscheme.sidebar"

local api = vim.api

local M = {}

-- Remap the window's structural groups onto the *SB sidebar variants.
local WINHL = "Normal:NormalSB,NormalNC:NormalSB,SignColumn:SignColumnSB"

---Install (or refresh) the FileType autocmd that marks `filetypes` as sidebars.
---@param filetypes string[]|nil
function M.setup(filetypes)
    local grp = api.nvim_create_augroup("LvimColorschemeSidebar", { clear = true })
    if not filetypes or vim.tbl_isempty(filetypes) then
        return
    end
    api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = filetypes,
        callback = function(ev)
            -- Schedule so the window exists and is settled before we touch its winhighlight.
            vim.schedule(function()
                local win = vim.fn.bufwinid(ev.buf)
                if win == -1 or not api.nvim_win_is_valid(win) then
                    return
                end
                local cur = vim.wo[win].winhighlight or ""
                if cur == "" then
                    vim.wo[win].winhighlight = WINHL
                elseif not cur:find("NormalSB", 1, true) then
                    -- Prepend ours; first match wins, but keep the window's existing entries.
                    vim.wo[win].winhighlight = WINHL .. "," .. cur
                end
            end)
        end,
    })
end

return M
