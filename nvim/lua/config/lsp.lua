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

local function setup_servers()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		if langs.servers[server] == nil then
			require("lspconfig")[server].setup(langs.common)
		else
			require("lspconfig")[server].setup(langs.servers[server])
		end
	end
end

setup_servers()

require("lspinstall").post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end

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
