local config

vim = vim or { g = {}, o = {} }

local function opt(key, default)
	key = "lvim_" .. key
	if vim.g[key] == nil then
		return default
	end
	if vim.g[key] == 0 then
		return false
	end
	return vim.g[key]
end

config = {
	commentStyle = opt("italic_comments", true) and "italic" or "NONE",
	keywordStyle = opt("italic_keywords", false) and "italic" or "NONE",
	functionStyle = opt("italic_functions", false) and "italic" or "NONE",
	variableStyle = opt("italic_variables", false) and "italic" or "NONE",
	terminalColors = opt("terminal_colors", true),
	sidebars = opt("sidebars", {}),
	colors = opt("colors", {}),
	dev = opt("dev", false),
	darkFloat = opt("dark_float", true),
	darkSidebar = opt("dark_sidebar", true),
}

return config
