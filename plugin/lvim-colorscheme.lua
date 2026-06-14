-- :LvimColorscheme            → open the theme picker
-- :LvimColorscheme config     → open the runtime settings panel
-- :LvimColorscheme extras     → regenerate every extras/ theme file
-- :LvimColorscheme extras <t> → regenerate just one tool (e.g. kitty, wezterm)
vim.api.nvim_create_user_command("LvimColorscheme", function(cmd)
    local sub, arg = cmd.fargs[1], cmd.fargs[2]
    if sub == "extras" then
        require("lvim-colorscheme.extra").generate_themes(arg)
    elseif sub == "config" then
        require("lvim-colorscheme.config_ui").open()
    else
        require("lvim-colorscheme.picker").open()
    end
end, {
    nargs = "*",
    complete = function(_, line)
        local words = vim.split(vim.trim(line), "%s+")
        if #words >= 2 and words[2] == "extras" then
            local tools = vim.tbl_keys(require("lvim-colorscheme.extra").extras)
            table.sort(tools)
            return tools
        end
        return { "config", "extras" }
    end,
    desc = "lvim-colorscheme: theme picker / config panel / regenerate extras",
})
