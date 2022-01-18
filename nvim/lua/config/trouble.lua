require 'trouble'.setup {
    action_keys = {
        jump = {},
        jump_close = {'<CR>'},
        previous = {'[q', '<S-Tab>', 'k'},
        ['next'] = {']q', '<Tab>', 'j'},
    }
}
local keymaps = require 'keymaps'

keymaps.map({
    {'n', '<leader>xx', '<cmd>TroubleToggle<CR>'},
    {'n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>'},
    {'n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>'},
    {'n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>'},
    {'n', '<leader>xl', '<cmd>TroubleToggle loclist<CR>'},
}, { noremap = true, silent = true })
