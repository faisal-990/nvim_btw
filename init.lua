-- Set leader key
-- This MUST be set before lazy.nvim is loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core settings
require('core.options')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specifications from lua/plugins/
-- and configure lazy.nvim
require('lazy').setup('plugins', {
  -- Your lazy.nvim config options can go here
  ui = {
    border = 'rounded',
  },
})
