local M = {}

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=bg]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=White guibg=bg]]

M.border = {
    {'╭', 'TelescopeBorder'},
    {'─', 'TelescopeBorder'},
    {'╮', 'TelescopeBorder'},
    {'│', 'TelescopeBorder'},
    {'╯', 'TelescopeBorder'},
    {'─', 'TelescopeBorder'},
    {'╰', 'TelescopeBorder'},
    {'│', 'TelescopeBorder'},
}

return M
