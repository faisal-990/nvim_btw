-- /lua/plugins/lsp.lua
-- This ONE file configures Mason, lspconfig, and the bridge.
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- 1. The Installer: mason.nvim
		{
			"williamboman/mason.nvim",
			-- This is the config for mason.nvim
			config = function()
				require("mason").setup({
					ui = { border = "rounded" },
					ensure_installed = {
						-- Your LSPs
						"pyright",
						"typescript-language-server",
						"clangd",
						"gopls",
						"tailwindcss",
						-- Your Formatters
						"prettier",
						"stylua",
						"delve",
						"cpptools",
					},
				})
			end,
		},

		-- 2. The Bridge: mason-lspconfig.nvim
		{
			"williamboman/mason-lspconfig.nvim",
			-- This is the config for the bridge
			-- It runs AFTER mason.nvim and nvim-lspconfig are loaded
			config = function()
				-- This is the key. We define our reusable functions
				-- to pass to the setup handler.

				-- This is what runs *after* an LSP attaches
				-- Base on_attach function
				local on_attach = function(client, bufnr)
					-- Your keymaps
					local map = vim.keymap.set
					map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
					map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP Declaration" })
				end -- These are the "capabilities" that nvim-cmp needs
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				-- This setup function call is the *entire fix*.
				-- It tells mason-lspconfig:
				-- "For every server in 'ensure_installed',
				-- automatically run lspconfig.setup{} for me,
				-- and pass it my on_attach and capabilities."
				require("mason-lspconfig").setup({
					ensure_installed = {
						"pyright",
						"ts_ls",
						"clangd",
						"gopls",
						"tailwindcss",
					},
					handlers = {
						-- This default handler uses your on_attach and capabilities
						function(server_name)
							require("lspconfig")[server_name].setup({
								on_attach = on_attach,
								capabilities = capabilities,
							})
						end,

						-- Custom setup for Go (your special settings)
						["gopls"] = function()
							require("lspconfig").gopls.setup({
								on_attach = function(client, bufnr)
									on_attach(client, bufnr) -- Run base on_attach
									if client.supports_method("textDocument/formatting") then
										vim.api.nvim_create_autocmd("BufWritePre", {
											buffer = bufnr,
											callback = function()
												vim.lsp.buf.format({ async = false, bufnr = bufnr })
											end,
										})
									end
								end,
								capabilities = capabilities,
								settings = { gopls = { gofumpt = true } },
							})
						end,
					},
				})
			end,
		},

		-- 3. Dependency for capabilities
		"hrsh7th/cmp-nvim-lsp",
	},
}
