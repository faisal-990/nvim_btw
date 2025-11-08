-- /lua/plugins/formatter.lua
--
-- 'none-ls.nvim' is deprecated. This is the new, recommended way.
-- We use 'conform.nvim' for formatting.
--
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre', -- Format on save
  config = function()
    require('conform').setup({
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        -- You had prettier for these
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        -- You can add more
        lua = { 'stylua' },
      },
    })
  end,
}
