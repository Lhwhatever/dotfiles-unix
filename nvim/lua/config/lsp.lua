require("icons")
local langs = require("lang")
local keymaps = require("keymaps")

local M = {}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = "■ ",
		source = "if_many",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
})

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    if langs.servers[server.name] == nil then
        server:setup(langs.common)
    else
        server:setup(langs.servers[server.name])
    end
end)


function M.jump_to_preview()
	if vim.tbl_contains(vim.api.nvim_list_wins(), M.floating_win) then
		vim.cmd([[normal! m`]])
		vim.fn.setpos(".", { M.dest.buf, M.dest.line + 1, M.dest.character + 1 })
		vim.cmd([[doautocmd CursorMoved]])
	else
		vim.cmd([[normal! <CR>]])
	end
end

keymaps.map({
	{ "n", "<CR>", [[<cmd>lua require 'lsp'.jump_to_preview()<CR>]] },
}, { noremap = true, silent = true })

return M
