local keymaps = require 'keymaps'

vim.g.dashboard_default_executive = 'telescope'

keymaps.map({
    {'n', '<leader>ss', '<cmd>SessionSave<CR>'},
    {'n', '<leader>sl', '<cmd>SessionLoad<CR>'},
}, { silent = true, noremap = true })

vim.cmd [[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]
