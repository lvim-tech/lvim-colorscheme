local M = {}

M.url = "https://github.com/nomad/nomad"

---@type lvim-colorscheme.HighlightsFn
function M.get(c)
    local blend = c.blend
    -- stylua: ignore
    return {
        NomadCollabPeerCursor1      = { fg = c.green, bg = blend.greenHigh },
        NomadCollabPeerHandle1      = { fg = c.green, bg = blend.greenHigh },
        NomadCollabPeerSelection1   = { fg = c.blue, bg = blend.greenHigh },
        NomadCollabPeerCursor2      = { fg = c.red, bg = blend.redHigh },
        NomadCollabPeerHandle2      = { fg = c.red, bg = blend.redHigh },
        NomadCollabPeerSelection2   = { fg = c.red, bg = blend.redHigh },
        NomadCollabPeerCursor3      = { fg = c.yellow, bg = blend.yellowHigh },
        NomadCollabPeerHandle3      = { fg = c.yellow, bg = blend.yellowHigh },
        NomadCollabPeerSelection3   = { fg = c.yellow, bg = blend.yellowHigh },
    }
end

return M
