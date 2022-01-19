local base = require 'env'

if base.has('termguicolors') then
    vim.opt.termguicolors = true
end

vim.g.sonokai_style = 'atlantis'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_diagnostic_text_highlight = 1
vim.g.sonokai_diagnostic_virtual_text = 'colored'
vim.g.sonokai_better_performance = 1

vim.cmd [[augroup OnColorscheme]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd ColorScheme NormalFloat guibg=NONE]]
vim.cmd [[  autocmd ColorScheme * lua require 'lightspeed'.init_highlight()]]
vim.cmd [[augroup end]]

local palette = vim.fn["sonokai#get_palette"](vim.g.sonokai_style)

local function get_palette(key)
	return palette[key][1]
end

local _M = {}

_M.colors = {
	red = get_palette("bg_red"),
	green = get_palette("bg_green"),
	blue = get_palette("bg_blue"),
	purple = get_palette("purple"),
	orange = get_palette("orange"),
	yellow = get_palette("yellow"),
	dcharc = get_palette("bg1"),
	charc = get_palette("bg2"),
	dgrey = get_palette("bg3"),
	grey = get_palette("bg4"),
	lgrey = get_palette("grey"),
	xgrey = get_palette("grey_dim"),
}

return _M
