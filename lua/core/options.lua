-- /lua/core/options.lua
-- These are basic editor settings

local opt = vim.opt -- for conciseness

-- Appearance
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true -- Enable 24-bit RGB color
opt.background = "dark" -- Use dark background

-- Behavior
opt.wrap = false -- Don't wrap lines
opt.mouse = "a" -- Enable mouse
opt.scrolloff = 8 -- Keep cursor 8 lines from top/bottom
opt.sidescrolloff = 8 -- Keep cursor 8 columns from left/right
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.completeopt = "menu,menuone,noselect" -- Autocomplete options

-- Tab / Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Indentation level
opt.tabstop = 4 -- Tab width
opt.autoindent = true -- Copy indent from current line when starting new line

-- Search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override 'ignorecase' if search pattern contains uppercase

vim.diagnostic.config({
	underline = true,
	virtual_text = true, -- Show error messages at the end of the line
	float = true, -- Show messages in a float window on hover
})
