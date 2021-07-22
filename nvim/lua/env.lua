local base = {}

function base.has(key)
    return vim.fn.has(key) == 1
end

function base.checkenv()
    local env = {}
    if (base.has('win64') or base.has('win32') or base.has('win16')) then
        env.os = 'Windows'
    elseif base.has('unix') then
        env.os = 'Linux'
    elseif base.has('mac') then
        env.os = 'macOS'
    else
        env.os = 'other'
    end

    if base.has('g:vscode') then
        env.head = 'VSCODE'
    elseif vim.fn.len(vim.api.nvim_list_uis()) < 1 then
        env.head = 'HEADLESS'
    else
        env.head = 'NVIM'
    end

    vim.g.env = env
end

return base
