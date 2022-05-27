require 'telescope'.setup {
    defaults = {
        promt_prefix = '➤ '
    }
}

local opts = {
    silent = true,
}

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>', opts)

vim.keymap.set('n', '<M-f>', '<cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<M-b>', '<cmd>Telescope buffers<CR>', opts)

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

vim.keymap.set('n', '<leader>fo', '<cmd>Telescope old_files<CR>', opts)
vim.keymap.set('n', '<leader>fy', '<cmd>Telescope registers<CR>', opts)
vim.keymap.set('n', '<leader>fm', '<cmd>Telescope marks<CR>', opts)
vim.keymap.set('n', '<leader>f/', '<cmd>Telescope search_history<CR>', opts)
vim.keymap.set('n', '<leader>fq', '<cmd>Telescope command_history<CR>', opts)
vim.keymap.set('n', '<leader>fz', '<cmd>Telescope spell_suggest<CR>', opts)

require "telescope".load_extension "file_browser"

vim.keymap.set('n', '<M-p>', '<cmd>Telescope file_browser<CR>', opts)
