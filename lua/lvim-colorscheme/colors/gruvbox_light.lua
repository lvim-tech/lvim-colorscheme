---@param opts lvim-colorscheme.Config
return function(opts)
    return require("lvim-colorscheme.colors.lvim_light")(
        vim.tbl_extend("force", opts, { light_style = "gruvbox" })
    )
end
