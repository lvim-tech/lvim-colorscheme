vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup()
require("lvim-colorscheme.extra").setup()
