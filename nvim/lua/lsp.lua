require 'icons'
local langs = require 'lang'
local windows = require 'windows'
local keymaps = require 'keymaps'

local M = {}

local function setup_servers()
    require 'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        if langs.servers[server] == nil then
            require 'lspconfig'[server].setup {}
        else
            require 'lspconfig'[server].setup(langs.servers[server])
        end
    end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
    local config = { -- your config
        underline = true,
        virtual_text = {
            prefix = "■ ",
            spacing = 4,
        },
        signs = true,
        update_in_insert = false,
    }
    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
        diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded'})

setup_servers()

require 'lspinstall'.post_install_hook = function()
    setup_servers()
    vim.cmd('bufdo e')
end

function M.preview_location(location, context, before_context)
    context = context or 15
    before_context = before_context or 0
    local uri = location.targetUri or location.uri
    if uri == nil then
        return
    end
    local bufnr = vim.uri_to_bufnr(uri)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end

    local range = location.targetRange or location.range
    local contents = vim.api.nvim_buf_get_lines(
        bufnr,
        range.start.line - before_context,
        range["end"].line + 1 + context,
        false
    )

    M.dest = range.start
    M.dest.buf = bufnr

    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    return vim.lsp.util.open_floating_preview(contents, filetype, { border = windows.border })
end

function M.preview_location_callback(_, method, result)
    local context = 15
    if result == nil or vim.tbl_isempty(result) then
        print("No location found: " .. method)
        return nil
    end
    if vim.tbl_islist(result) then
        M.floating_buf, M.floating_win = M.preview_location(result[1], context)
    else
        M.floating_buf, M.floating_win = M.preview_location(result, context)
    end
    vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', 'doautocmd CursorMoved', { silent = true, noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-c>', 'doautocmd CursorMoved', { silent = true, noremap = true })
end

function M.Peek(request)
    if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
        vim.api.nvim_set_current_win(M.floating_win)
    else
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, request, params, M.preview_location_callback)
    end
end

function M.jump_to_preview()
    if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
        vim.cmd [[normal! m`]]
        vim.fn.setpos('.', {M.dest.buf, M.dest.line + 1, M.dest.character + 1})
        vim.cmd [[doautocmd CursorMoved]]
    else
        vim.cmd [[normal! <CR>]]
    end
end

keymaps.map({
    { 'n', '<CR>', [[<cmd>lua require 'lsp'.jump_to_preview()<CR>]] },
}, { noremap = true, silent = true })


return M
