-- /lua/plugins/nvim-tree.lua
return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup()

    -- Your keymap for NvimTree
    local map = vim.keymap.set
    map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
  end,
}
