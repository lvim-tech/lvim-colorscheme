---@param opts lvim-colorscheme.Config
return function(opts)
    return require("lvim-colorscheme.colors.base_light")(
        vim.tbl_extend("force", opts, { light_style = "tokyonight_dark" })
    )
end
