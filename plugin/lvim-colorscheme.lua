vim.api.nvim_create_user_command("LvimColorscheme", function()
    require("lvim-colorscheme.picker").open()
end, { desc = "Open lvim-colorscheme theme picker" })
