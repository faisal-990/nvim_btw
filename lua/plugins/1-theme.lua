-- /lua/plugins/1-theme.lua
-- We prefix with '1-' to ensure it loads first
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000, -- Make sure it loads first
  config = function()
    require('gruvbox').setup({
      contrast = 'high',
    })
    vim.cmd('colorscheme gruvbox')
  end,
}
