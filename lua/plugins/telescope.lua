-- /lua/plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- **** ADD THIS DEPENDENCY ****
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "> ",
				sorting_strategy = "ascending",
				layout_strategy = "flex",
			},
		})

		local map = vim.keymap.set
		map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
		map("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to Definition" })
		map("n", "<leader>gr", "<cmd>TDelescope lsp_references<cr>", { desc = "Go to References" })
		map("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to Implementation" })
		map("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
		map("n", "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
	end,
}
