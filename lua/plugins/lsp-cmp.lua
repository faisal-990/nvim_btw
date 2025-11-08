-- /lua/plugins/lsp-cmp.lua
-- This file NOW ONLY configures nvim-cmp.
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Completion sources
		"hrsh7th/cmp-nvim-lsp", -- <-- TYPO FIX 1: 'hrsh7t' -> 'hrsh7th'
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		-- Snippet engine
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",

		-- It now depends on our main lsp config file
		"neovim/nvim-lspconfig",
	},
	config = function()
		local cmp = require("cmp")

		-- This file NO LONGER sets up LSP.
		-- It ONLY sets up nvim-cmp.
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
				max_items = 10,
			},
			sources = {
				{ name = "nvim_lsp" }, -- This will now find the LSPs
				{ name = "luasnip" },
				{ name = "buffer" },
				-- { name =Type = "STRING"}, -- <-- TYPO FIX 2: Removed this invalid line
				{ name = "path" },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-e>"] = cmp.mapping.confirm({ select = false }),
			}),
		})

		-- Snippets
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
