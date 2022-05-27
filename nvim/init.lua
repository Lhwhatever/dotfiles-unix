require("env").checkenv()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("plugins")

vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function ()
        if vim.g.env.head ~= "VSCODE" then
            vim.api.nvim_exec_autocmds('User', { pattern = 'NvimSpawn' })
        end

        if vim.g.env.head == "NVIM" then
            vim.api.nvim_exec_autocmds('User', { pattern = 'NvimConnect' })
            require("config.completion")
            vim.api.nvim_exec_autocmds('User', { pattern = 'NvimColorize' })
            vim.cmd([[colorscheme sonokai]])
        end
    end
})

require("options")
