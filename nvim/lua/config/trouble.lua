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
    {'n', '<leader>x', '<cmd>Trouble<CR>'},
}, { noremap = true, silent = true })
