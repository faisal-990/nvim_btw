-- /lua/plugins/dap.lua
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- 1. The visual UI for DAP
		"rcarriga/nvim-dap-ui",

		-- 2. Go adapter setup
		"leoluz/nvim-dap-go",

		-- 3. ***** ADD THIS LINE *****
		"nvim-neotest/nvim-nio", -- Required by dapui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		--
		-- ADAPTER SETUP
		--

		-- C/C++ (cpptools)
		dap.adapters.cpptools = {
			type = "executable",
			command = "OpenDebugAD7", -- This is the command cpptools provides
			args = {},
		}

		-- Go
		require("dap-go").setup()

		--
		-- DAP UI SETUP
		--
		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 20,
					position = "bottom",
				},
			},
		})

		--
		-- KEYMAPS
		--
		local map = vim.keymap.set
		map("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
		map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
		map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

		-- Toggle the UI on start
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
