local keymaps = require 'keymaps'

local dap = require 'dap'
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = 'lldb'
}

dap.configurations.cpp = {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require 'dapui'.setup()

keymaps.map({
    {'n', '<F5>', [[<cmd>lua require 'dap'.continue()<CR>]]},
    {'n', '<F10>', [[<cmd>lua require 'dap'.step_over()<CR>]]},
    {'n', '<F11>', [[<cmd>lua require 'dap'.step_into()<CR>]]},
    {'n', '<F12>', [[<cmd>lua require 'dap'.step_out()<CR>]]},
    {'n', '<leader>dd', [[<cmd>lua require 'dap'.toggle_breakpoint()<CR>]]},
    {'n', '<leader>dc', [[<cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]},
    {'n', '<leader>dl', [[<cmd>lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]]},
    {'n', '<leader>dr', [[<cmd>lua require 'dap'.repl.open()<CR>]]},
    {'n', '<leader>dL', [[<cmd>lua require 'dap'.run_last()<CR>]]},
    {'n', '<leader>D', [[<cmd>lua require 'dapui'.toggle()<CR>]]},
    {'n', '<leader>dk', [[<cmd>lua require 'dapui'.float_element()<CR>]]},
    {'v', '<M-k>', [[<cmd>lua require 'dapui'.eval()<CR>]]},
}, { noremap = true, silent = true })
