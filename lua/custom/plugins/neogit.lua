return {
  'NeogitOrg/neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local neogit = require('neogit')

    neogit.setup {}
    vim.keymap.set('n', '<leader>gs', function() neogit.open() end)
  end
}
