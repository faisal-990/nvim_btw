This configuration is designed to be stable, fast, and easy to expand. It is built around lazy.nvim, a modern plugin manager that handles loading plugins in the correct order to prevent errors.

1. 📂 Overall Structure

Your config is split into two main areas: lua/core for your personal settings and lua/plugins for all your plugins. This separation makes it easy to find and change things.

~/.config/nvim/
├── init.lua          <-- Main entry point, sets up lazy.nvim
├── lua/
│   ├── core/
│   │   └── options.lua   <-- Global editor settings (tabs, numbers, etc.)
│   │
│   └── plugins/        <-- All your plugins live here
│       ├── 1-theme.lua
│       ├── autopairs.lua
│       ├── comment.lua
│       ├── dap.lua         <-- Debugger (DAP)
│       ├── database.lua
│       ├── formatter.lua
│       ├── gitsigns.lua
│       ├── indent-blankline.lua
│       ├── lsp.lua         <-- Main LSP + Mason config
│       ├── lsp-cmp.lua     <-- Auto-completion UI
│       ├── lualine.lua
│       ├── nvim-tree.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       └── which-key.lua
│
└── lazy-lock.json      <-- Auto-generated, locks plugin versions

2. 🚀 The Flow of Work (How it Boots)

This is the most important part to understand. The errors you were seeing were all caused by plugins loading in the wrong order. This config fixes that using dependencies.

Here is the step-by-step boot sequence:

    Start: You run nvim.

    init.lua: Neovim loads init.lua.

    Core Settings: init.lua immediately loads core/options.lua to set up your tabs, line numbers, and diagnostic settings.

    lazy.nvim: init.lua loads lazy.nvim (your plugin manager).

    Scanning: lazy.nvim scans your entire lua/plugins/ directory. It reads all the files but does not load them yet.

    Building the Graph: lazy.nvim builds a "dependency graph" to find the correct load order. This is the critical path we designed.

    Your Critical Dependency Path:

        lsp.lua (which contains mason.nvim and mason-lspconfig.nvim) is set up as the "base" of your language features.

        lsp-cmp.lua (auto-completion) is told it depends on neovim/nvim-lspconfig (which is in lsp.lua).

        telescope.lua (fuzzy finding) is also told it depends on neovim/nvim-lspconfig.

    Result: lazy.nvim guarantees that your Language Servers are fully loaded and running before your completion engine or fuzzy finder tries to use them. This is what finally killed the attempt to call field 'setup' (a nil value) error.

3. 🗺️ What Part Handles What? (Component Guide)

Here is a breakdown of what each file in your config is responsible for.



Feature,File(s) in lua/plugins/,What it Does
Plugin Manager,init.lua,Loads lazy.nvim and tells it to read the lua/plugins/ folder.
Global Settings,lua/core/options.lua,"Sets all vim.opt settings (tabs, numbers, mouse, virtual text for errors)."
Language Smarts (LSP),lsp.lua,"The most important file. It does 3 things:  1. Installs all your LSPs/tools (like gopls, prettier).  2. Bridges Mason and lspconfig.  3. Configures and attaches all LSPs to your code."
Auto-completion,lsp-cmp.lua,Configures nvim-cmp to give you the pop-up suggestion menu as you type.
Fuzzy Finding,telescope.lua,"Configures Telescope and all its keymaps (<leader>ff, <leader>gd)."
Auto-Formatting,formatter.lua,Configures conform.nvim to auto-format your code with prettier on save.
Syntax Highlighting,treesitter.lua,"Manages nvim-treesitter for fast, accurate code highlighting."
Theme & UI,1-theme.lua,Sets your gruvbox theme. It's numbered to load first.
Status Bar,lualine.lua,Configures the fancy status bar at the bottom.
File Explorer,nvim-tree.lua,Configures the file tree that opens with <leader>e.
Indentation Guides,indent-blankline.lua,Shows the little vertical lines for indentation.
Auto Brackets,autopairs.lua,"Automatically closes (, [, {, and ""."
Git Gutters,gitsigns.lua,Shows + and ~ signs next to lines you've changed.
Keymap Helper,which-key.lua,Shows the pop-up menu when you press Space.
Commenting,comment.lua,Provides the gcc (comment line) command.




4. 🛠️ Onboarding: How to Add a New Plugin

Here is your step-by-step guide to safely adding any new feature.

    Find the Plugin: Find its name on GitHub (e.g., some-user/some-plugin.nvim).

    Create a New File: Create a new file in your lua/plugins/ directory. Give it a descriptive name (e.g., lua/plugins/my-new-feature.lua).

    Write the Spec: Paste the following boilerplate into your new file:


```lua
return {
  'github-user/plugin-name',

  -- OPTIONAL: Add dependencies if it needs another plugin
  -- dependencies = {
  --   'nvim-lua/plenary.nvim',
  -- },

  -- OPTIONAL: Set a lazy-loading event
  -- This makes it load only when you need it.
  -- 'InsertEnter' -> when you press 'i'
  -- 'BufRead' -> when you open any file
  -- 'VeryLazy' -> after startup is finished
  event = 'VeryLazy',

  -- OPTIONAL: Add configuration
  config = function()
    -- Put your setup code here
    require('plugin-name').setup({
      -- ... config options ...
    })
  end,
}
```

Restart Neovim: Save the file and restart nvim.

Install: lazy.nvim will automatically pop up. Press I to install the new plugin.

Done: Restart Neovim one more time. Your new plugin is now loaded and configured.

5. 💡 Example: Adding a 'git blame' Plugin

Let's add f-person/git-blame.nvim, which shows you the git blame for the current line.

    Find: The name is f-person/git-blame.nvim.

    Create File: /home/faisal/.config/nvim/lua/plugins/git-blame.lua

    Write Spec: We'll paste this into the new file. We'll load it on BufRead (when a file opens) and add a keymap.


```lua
return {
  'f-person/git-blame.nvim',
  event = 'BufRead', -- Don't load it until we open a file
  config = function()
    -- The plugin docs say to enable it like this
    vim.g.gitblame_enabled = 1

    -- Let's add a keymap for it, too
    vim.keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>', { desc = 'Toggle Git Blame' })
  end,
}
```

Restart & Install: Save the file, restart nvim, and press I in the lazy.nvim menu.

    Test: Restart again. Open any file in a git repo. Press <leader>gb (Space + g + b). The git blame should appear.

You're all set! Your config is now stable and, most importantly, understandable.


Where to Add New Features: A Quick Guide

Use this as a map to decide which file to edit for any new feature you want to add.

📦 A New Plugin

This is for any new functionality from a GitHub repo (e.g., a new Git tool, a mini-game, a different file explorer).

    Where to Add: Create a new file in /home/faisal/.config/nvim/lua/plugins/.

    Example: You want to add a plugin called cool-thing.nvim. You create a new file named lua/plugins/cool-thing.lua and put the plugin's setup code there.

    Why: This keeps your features modular and clean. lazy.nvim will find it automatically.

⌨️ A New Keymap

This is for any new keyboard shortcut.

    Where to Add:

        If the keymap is for a plugin: Put it inside that plugin's config function. For example, a new Telescope keymap goes in lua/plugins/telescope.lua.

        If it's a personal/global keymap: Create a new file like lua/plugins/my-keymaps.lua and add your vim.keymap.set(...) commands there.

    Why: This ensures the plugin is fully loaded before Neovim tries to create a keymap for it, preventing errors.

🔧 An Editor Setting

This is for changing Neovim's built-in behavior (e.g., changing tab size from 4 to 2, enabling spell check, changing the cursor).

    Where to Add: /home/faisal/.config/nvim/lua/core/options.lua

    Why: This file is for all your global vim.opt settings. It's loaded first and doesn't depend on any plugins.

🧠 A New Language (LSP)

This is for adding "smart" features for a new language (e.g., adding rust_analyzer for Rust).

    Where to Add: You'll edit one file: lua/plugins/lsp.lua

    How (2 steps):

        Step 1: Add the server's name to the ensure_installed list inside the mason.nvim config.

        Step 2: Add the server's lspconfig name to the handlers list so it gets set up with your on_attach and capabilities.

✨ A New Formatter

This is for adding a new tool to auto-format a language on save (e.g., adding black for Python).

    Where to Add: You'll edit two files.

    How (2 steps):

        Step 1: In lua/plugins/lsp.lua, add the formatter's name to Mason's ensure_installed list so it gets downloaded.

        Step 2: In lua/plugins/formatter.lua, add the formatter to the formatters_by_ft table to tell conform.nvim to use it for that file type.


**More features added

Here is a documentation write-up for the nvim-dap (Debug Adapter Protocol) setup we just built. This is tailored to your specific configuration.

🐞 Debugger (nvim-dap)

This is your visual debugger, fully integrated into Neovim. It's designed to replace print statements or the need to switch to another editor (like VS Code) just to debug.

It allows you to:

    Set breakpoints.

    Step through your code line by line.

    Inspect the values of variables.

    See the call stack.

Components in Your Config

This feature is a collection of several plugins working together:

    mfussenegger/nvim-dap: The main "core" plugin that understands the Debug Adapter Protocol.

    rcarriga/nvim-dap-ui: Provides the visual "pop-up" windows for the debugger (scopes, breakpoints, etc.).

    leoluz/nvim-dap-go: A helper plugin that makes debugging Go (which uses delve) much easier.

    delve (via Mason): The actual debugger program for Go.

    cpptools (via Mason): The actual debugger program for C/C++.

    nvim-neotest/nvim-nio: A required dependency for nvim-dap-ui to work.

⌨️ Your Debugger Keymaps (Cheat Sheet)

You use these commands in Normal Mode when you are in a file you want to debug.
