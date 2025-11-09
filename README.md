# My Neovim Configuration

This is my personal Neovim setup, built to be a fast and modern IDE for Go, C++, and easy to expand as per your needs.
It is built on `lazy.nvim` and is designed to be stable, easy to understand, and expandable.


## Prerequisites

Before you install this, you will need a few things on your system:

* **Neovim:** Version `0.10.0` or higher.
* **Git:** `lazy.nvim` uses this to manage plugins.
* **A Nerd Font:** This is **required** for icons in plugins like `nvim-tree.lua` and `lualine.nvim`. I recommend [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads).
* **Build Tools:** `gcc`, `make`, and `g++` are needed for `nvim-treesitter` to parse code and for `Mason` to install some tools.

## 🚀 Installation

1.  **Back up your old config (important!)**:
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    ```

2.  **Clone this repository:**
    ```bash
    git clone https://github.com/faisal-990/nvim_btw.git ~/.config/nvim
    ```
    

## First-Time Setup (Critical!)

After installing, you must follow these steps:

1.  **Launch Neovim:**
    ```bash
    nvim
    ```

2.  **Install Plugins:** `lazy.nvim` will automatically open. Press **`I`** to install all the plugins.

3.  **Restart Neovim:** Quit (`:q`) and re-open `nvim`.

4.  **Install Tools:** `Mason` (our tool manager) will automatically start installing all your LSPs, formatters, and debuggers (like `gopls`, `prettier`, `delve`).

You can check the progress by running the command `:Mason`. If anything is missing, you can install it manually from that menu.

## ✨ Core Features

This config turns Neovim into a full IDE, including:

* **Plugin Management:** `lazy.nvim`
* **LSP:** `nvim-lspconfig` for code intelligence.
* **Auto-completion:** `nvim-cmp` for pop-up suggestions.
* **Fuzzy Finding:** `telescope.nvim` for finding files, text, and LSP definitions.
* **Auto-Formatting:** `conform.nvim` formats your code on save.
* **Debugging:** `nvim-dap` provides a full visual debugger for Go and C++.
* **Git:** `gitsigns.nvim` shows changes in the gutter.
* **UI:** `nvim-tree.lua` (file explorer), `lualine.nvim` (status bar), and `gruvbox.nvim` (theme).

## 📖 Configuration Guide

### 0. ⌨️ Keymaps Cheat Sheet

Your Leader key is Space.

    General & UI

        Space + e - Toggle file explorer (NvimTree)

        gcc - Toggle comment on the current line


    Fuzzy Finder (Telescope)

        Space + ff - Find files

        Space + gd - Go to Definition

        Space + gr - Go to References

        Space + gi - Go to Implementation

        Space + ds - Document Symbols

        Space + ws - Workspace Symbols

    LSP (Code Smarts)

        K - Show documentation for word under cursor

        gD - Go to Declaration

    Debugger (DAP)

        Space + b - Toggle Breakpoint

        F5 - Start or Continue debugging

        F10 - Step Over

        F11 - Step Into

        F12 - Step Out



### 1. 📂 Overall Structure

Your config is split into `lua/core` for personal settings and `lua/plugins` for plugins.

* `~/.config/nvim/`
    * `init.lua` (Main entry point, sets up `lazy.nvim`)
    * `lazy-lock.json` (Auto-generated, locks plugin versions)
    * `lua/`
        * `core/`
            * `options.lua` (Global editor settings: tabs, numbers, etc.)
        * `plugins/` (All your plugins live here, edit and add as you like)
            * `1-theme.lua`
            * `autopairs.lua`
            * `comment.lua`
            * `dap.lua` (Debugger - DAP)
            * `formatter.lua`
            * `gitsigns.lua`
            * `indent-blankline.lua`
            * `lsp.lua` (Main LSP + Mason config)
            * `lsp-cmp.lua` (Auto-completion UI)
            * `lualine.lua`
            * `nvim-tree.lua`
            * `telescope.lua`
            * `treesitter.lua`
            * `which-key.lua`

### 2. 🚀 The Flow of Work (How it Boots)

This config fixes load-order errors using dependencies.

1.  **Start:** You run `nvim`.
2.  **`init.lua`:** Neovim loads `init.lua`.
3.  **Core Settings:** `init.lua` loads `core/options.lua` (tabs, line numbers, etc.).
4.  **`lazy.nvim`:** `init.lua` loads the plugin manager.
5.  **Scanning:** `lazy.nvim` scans the `lua/plugins/` directory.
6.  **Building the Graph:** `lazy.nvim` builds a "dependency graph" to find the correct load order. This is the critical path.

**Your Critical Dependency Path:**

* `lsp.lua` (with `mason.nvim`) is the base of your language features.
* `lsp-cmp.lua` (auto-completion) **depends on** `neovim/nvim-lspconfig` (from `lsp.lua`).
* `telescope.lua` (fuzzy finding) also **depends on** `neovim/nvim-lspconfig`.

**Result:** `lazy.nvim` guarantees that your Language Servers are fully loaded *before* your completion or fuzzy finder tries to use them, preventing errors.

### 3. 🗺️ What Part Handles What? (Component Guide)

| Feature | File(s) in `lua/plugins/` | What it Does |
| :--- | :--- | :--- |
| **Plugin Manager** | `init.lua` | Loads `lazy.nvim` and tells it to read the `lua/plugins/` folder. |
| **Global Settings** | `lua/core/options.lua` | Sets all `vim.opt` settings (tabs, numbers, mouse, virtual text for errors). |
| **Language Smarts (LSP)**| `lsp.lua` | **The most important file.** 1. Installs all LSPs/tools. 2. Bridges Mason and lspconfig. 3. Configures and attaches all LSPs. |
| **Auto-completion** | `lsp-cmp.lua` | Configures `nvim-cmp` to give you the pop-up suggestion menu. |
| **Fuzzy Finding** | `telescope.lua` | Configures `Telescope` and its keymaps (`<leader>ff`, `<leader>gd`). |
| **Auto-Formatting** | `formatter.lua` | Configures `conform.nvim` to auto-format your code on save. |
| **Syntax Highlighting**| `treesitter.lua` | Manages `nvim-treesitter` for fast, accurate code highlighting. |
| **Theme & UI** | `1-theme.lua` | Sets your `gruvbox` theme. It's numbered to load first. |
| **Status Bar** | `lualine.lua` | Configures the fancy status bar at the bottom. |
| **File Explorer** | `nvim-tree.lua` | Configures the file tree that opens with `<leader>e`. |
| **Indentation Guides** | `indent-blankline.lua` | Shows the vertical lines for indentation. |
| **Auto Brackets** | `autopairs.lua` | Automatically closes `(`, `[`, `{`, and `"`. |
| **Git Gutters** | `gitsigns.lua` | Shows `+` and `~` signs next to lines you've changed. |
| **Keymap Helper** | `which-key.lua` | Shows the pop-up menu when you press `Space`. |
| **Commenting** | `comment.lua` | Provides the `gcc` (comment line) command. |

### 4. 🛠️ Onboarding: How to Add a New Plugin

Here is your step-by-step guide to safely adding any new feature.

1.  **Find the Plugin:** Find its name on GitHub (e.g., `some-user/some-plugin.nvim`).
2.  **Create a New File:** Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-new-feature.lua`).
3.  **Write the Spec:** Paste this boilerplate into your new file:

    ```lua
    return {
      'github-user/plugin-name',
      
      -- OPTIONAL: Add dependencies if it needs another plugin
      -- dependencies = {
      --   'nvim-lua/plenary.nvim',
      -- },
      
      -- OPTIONAL: Set a lazy-loading event
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

4.  **Restart Neovim:** Save the file and restart `nvim`.
5.  **Install:** `lazy.nvim` will automatically pop up. Press `I` to install the new plugin.
6.  **Done:** Restart Neovim one more time.

### 5. 💡 Example: Adding a 'git blame' Plugin

1.  **Find:** The name is `f-person/git-blame.nvim`.
2.  **Create File:** `~/.config/nvim/lua/plugins/git-blame.lua`
3.  **Write Spec:** Paste this into the new file.

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
4.  **Restart & Install:** Save, restart `nvim`, and press `I`.
5.  **Test:** Restart. Open a file in a git repo. Press `<leader>gb` (`Space` + `g` + `b`).

### 🗺️ Where to Add New Features: A Quick Guide

#### 📦 A New Plugin
* **Where:** Create a **new file** in `~/.config/nvim/lua/plugins/`.
* **Example:** For `cool-thing.nvim`, create `lua/plugins/cool-thing.lua`.
* **Why:** Keeps features modular. `lazy.nvim` finds it automatically.

#### ⌨️ A New Keymap
* **Where:**
    1.  **For a plugin:** Inside that plugin's `config` function (e.g., in `lua/plugins/telescope.lua`).
    2.  **For you:** Create a new file like `lua/plugins/my-keymaps.lua`.
* **Why:** Ensures the plugin is loaded *before* the keymap is created.

#### 🔧 An Editor Setting
* **Where:** `~/.config/nvim/lua/core/options.lua`
* **Why:** This file is for all global `vim.opt` settings (like tabs, cursor, spell check). It's loaded first.

#### 🧠 A New Language (LSP)
* **Where:** Edit `lua/plugins/lsp.lua`
* **How (2 steps):**
    1.  Add the server's name to the `ensure_installed` list in the `mason.nvim` config.
    2.  Add the server's `lspconfig` name to the `handlers` list so it gets set up.

#### ✨ A New Formatter
* **Where:** Edit two files.
* **How (2 steps):**
    1.  In `lua/plugins/lsp.lua`, add the formatter's name to Mason's `ensure_installed` list.
    2.  In `lua/plugins/formatter.lua`, add the formatter to the `formatters_by_ft` table.

## Plugin Deep-Dives

### 🐞 Debugger (nvim-dap)

This is your visual debugger, fully integrated into Neovim, designed to replace print statements.

It allows you to:
* Set breakpoints.
* Step through your code line by line.
* Inspect the values of variables.
* See the call stack.

**Components in Your Config:**
* **`mfussenegger/nvim-dap`**: The "core" plugin.
* **`rcarriga/nvim-dap-ui`**: Provides the visual pop-up windows.
* **`leoluz/nvim-dap-go`**: A helper plugin for debugging Go.
* **`delve` (via Mason)**: The *actual* debugger program for Go.
* **`cpptools` (via Mason)**: The *actual* debugger program for C/C++.
* **`nvim-neotest/nvim-nio`**: A required dependency for `nvim-dap-ui`.


