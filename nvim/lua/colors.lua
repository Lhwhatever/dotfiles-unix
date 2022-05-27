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

local augroup_id = vim.api.nvim_create_augroup('OnColorscheme', {})
vim.api.nvim_create_autocmd('ColorScheme', {
    group = augroup_id,
    pattern = 'NormalFloat',
    command = 'highlight NormalFloat guibg=NONE',
})
vim.api.nvim_create_autocmd('ColorScheme', {
    group = augroup_id,
    callback = function () require 'lightspeed'.init_highlight() end
})

local configuration = vim.fn['sonokai#get_configuration']()
local palette = vim.fn["sonokai#get_palette"](vim.g.sonokai_style, configuration.colors_override)

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
