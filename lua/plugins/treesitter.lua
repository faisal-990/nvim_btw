-- /lua/plugins/treesitter.lua
return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'lua', 'python', 'javascript', 'html', 'css', 'cpp', 'go', 'typescript' },
      highlight = {
        enable = true,
      },
    }
  end,
}
