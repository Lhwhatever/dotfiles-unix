local base = require 'env'

local M = {}

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
vim.cmd [[  autocmd ColorScheme * lua require 'lightspeed'.init_highlight()]]
vim.cmd [[augroup end]]
