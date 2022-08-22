local hsluv = require("lvim-colorscheme.hsluv")

local util = {}

util.colorsUsed = {}
util.colorCache = {}

util.bg = "#000000"
util.fg = "#ffffff"
util.day_brightness = 0.3

local function hexToRgb(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local r, g, b = string.match(hex_str, pat)
	return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

function util.blend(fg, bg, alpha)
	bg = hexToRgb(bg)
	fg = hexToRgb(fg)
	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end
	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
	return util.blend(hex, bg or util.bg, math.abs(amount))
end

function util.lighten(hex, amount, fg)
	return util.blend(hex, fg or util.fg, math.abs(amount))
end

function util.brighten(color, percentage)
	local hsl = hsluv.hex_to_hsluv(color)
	local larpSpace = 100 - hsl[3]
	if percentage < 0 then
		larpSpace = hsl[3]
	end
	hsl[3] = hsl[3] + larpSpace * percentage
	return hsluv.hsluv_to_hex(hsl)
end

function util.invertColor(color)
	if color ~= "NONE" then
		local hsl = hsluv.hex_to_hsluv(color)
		hsl[3] = 100 - hsl[3]
		if hsl[3] < 40 then
			hsl[3] = hsl[3] + (100 - hsl[3]) * util.day_brightness
		end
		return hsluv.hsluv_to_hex(hsl)
	end
	return color
end

function util.getColor(color)
	if vim.o.background == "dark" then
		return color
	end
	if not util.colorCache[color] then
		util.colorCache[color] = util.invertColor(color)
	end
	return util.colorCache[color]
end

function util.highlight(group, color)
	if color.fg then
		util.colorsUsed[color.fg] = true
	end
	if color.bg then
		util.colorsUsed[color.bg] = true
	end
	if color.sp then
		util.colorsUsed[color.sp] = true
	end
	local style = color.style and "gui=" .. color.style or "gui=NONE"
	local fg = color.fg and "guifg=" .. util.getColor(color.fg) or "guifg=NONE"
	local bg = color.bg and "guibg=" .. util.getColor(color.bg) or "guibg=NONE"
	local sp = color.sp and "guisp=" .. util.getColor(color.sp) or ""
	local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
	if color.link then
		vim.cmd("highlight! link " .. group .. " " .. color.link)
	else
		vim.cmd(hl)
	end
end

function util.debug(colors)
	colors = colors or require("lvim-colorscheme.colors")
	for name, color in pairs(colors) do
		if type(color) == "table" then
			util.debug(color)
		else
			if util.colorsUsed[color] == nil then
				print("not used: " .. name .. " : " .. color)
			end
		end
	end
end

function util.onColorScheme()
	if vim.g.colors_name ~= "lvim" then
		vim.cmd([[autocmd! LvimColorscheme]])
		vim.cmd([[augroup! LvimColorscheme]])
	end
end

function util.autocmds(config)
	vim.cmd([[augroup LvimColorscheme]])
	vim.cmd([[  autocmd!]])
	vim.cmd([[  autocmd ColorScheme * lua require("lvim-colorscheme.util").onColorScheme()]])
	if config.dev then
		vim.cmd([[  autocmd BufWritePost */lua/lvim-colorscheme/** nested colorscheme lvim]])
	end
	for _, sidebar in ipairs(config.sidebars) do
		if sidebar == "terminal" then
			vim.cmd([[  autocmd TermOpen * setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]])
		else
			vim.cmd(
				[[  autocmd FileType ]] .. sidebar .. [[ setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]]
			)
		end
	end
	vim.cmd([[augroup end]])
end

function util.template(str, table)
	return (str:gsub("($%b{})", function(w)
		return table[w:sub(3, -2)] or w
	end))
end

function util.syntax(syntax)
	for group, colors in pairs(syntax) do
		util.highlight(group, colors)
	end
end

function util.terminal(colors)
	vim.g.terminal_color_0 = colors.color_03
	vim.g.terminal_color_8 = colors.color_23
	vim.g.terminal_color_7 = colors.color_16
	vim.g.terminal_color_15 = colors.color_21
	vim.g.terminal_color_1 = colors.color_25
	vim.g.terminal_color_9 = colors.color_25
	vim.g.terminal_color_2 = colors.color_18
	vim.g.terminal_color_10 = colors.color_18
	vim.g.terminal_color_3 = colors.color_07
	vim.g.terminal_color_11 = colors.color_08
	vim.g.terminal_color_4 = colors.color_13
	vim.g.terminal_color_12 = colors.color_13
	vim.g.terminal_color_5 = colors.color_24
	vim.g.terminal_color_13 = colors.color_24
	vim.g.terminal_color_6 = colors.color_23
	vim.g.terminal_color_14 = colors.color_23
end

function util.light_colors(colors)
	if type(colors) == "string" then
		return util.getColor(colors)
	end
	local ret = {}
	for key, value in pairs(colors) do
		ret[key] = util.light_colors(value)
	end
	return ret
end

function util.load(theme)
	if vim.g.colors_name then
		vim.cmd("hi clear")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "lvim"
	util.syntax(theme.base)
	util.syntax(theme.plugins)
	util.terminal(theme.colors)
	util.autocmds(theme.config)
	vim.defer_fn(function()
		util.syntax(theme.defer)
	end, 100)
end

function util.color_overrides(colors, config)
	if type(config.colors) == "table" then
		for key, value in pairs(config.colors) do
			if not colors[key] then
				error("Color " .. key .. " does not exist")
			end
			if type(colors[key]) == "table" then
				util.color_overrides(colors[key], { colors = value })
			else
				if value:lower() == "none" then
					colors[key] = "NONE"
				elseif string.sub(value, 1, 1) == "#" then
					colors[key] = value
				else
					if not colors[value] then
						error("Color " .. value .. " does not exist")
					end
					colors[key] = colors[value]
				end
			end
		end
	end
end

function util.light(brightness)
	for hl_name, hl in pairs(vim.api.nvim__get_hl_defs(0)) do
		local def = {}
		for key, def_key in pairs({ foreground = "fg", background = "bg", special = "sp" }) do
			if type(hl[key]) == "number" then
				local hex = string.format("#%06x", hl[key])
				local color = util.invertColor(hex)
				if brightness then
					color = util.brighten(hex, brightness)
				end
				table.insert(def, "gui" .. def_key .. "=" .. color)
			end
		end
		if hl_name ~= "" and #def > 0 then
			for _, style in pairs({ "bold", "italic", "underline", "undercurl", "reverse" }) do
				if hl[style] then
					table.insert(def, "gui=" .. style)
				end
			end
			vim.cmd("highlight! " .. hl_name .. " " .. table.concat(def, " "))
		end
	end
end

return util
