-- /lua/plugins/autopairs.lua
-- This replaces your custom 'pairing.lua' file
-- It's more robust and managed as a proper plugin
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter', -- Load when entering insert mode
  config = function()
    require('nvim-autopairs').setup({
      -- You can add custom rules here if you like
    })
  end,
}
