-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Keep multiple buffers open
vim.opt.hidden = true

-- Split to right/below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indentation
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Search
vim.opt.smartcase = true

-- Fold count
vim.opt.foldlevel = 3

-- Line numbers
vim.opt.number = true
vim.cmd [[
    augroup relativenumber
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * setl relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * setl norelativenumber
    augroup END
]]

-- No backups
vim.g.backup = false
vim.g.writebackup = false

-- Update time
vim.opt.updatetime = 100
vim.opt.timeoutlen = 600

-- Python settings
if vim.env.NVIM_PYTHON ~= nil then
    vim.g.python3_host_prog = vim.env.NVIM_PYTHON
end
