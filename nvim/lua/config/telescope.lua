require 'telescope'.setup {
    defaults = {
        promt_prefix = '➤ '
    }
}

local opts = {
    noremap = true,
    silent = true,
}

vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<CR>', opts)

vim.api.nvim_set_keymap('n', '<M-f>', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<M-b>', '<cmd>Telescope buffers<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>Telescope old_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fy', '<cmd>Telescope registers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope marks<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f/', '<cmd>Telescope search_history<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fq', '<cmd>Telescope command_history<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fz', '<cmd>Telescope spell_suggest<CR>', opts)
