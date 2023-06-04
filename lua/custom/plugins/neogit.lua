return {
  'TimUntersberger/neogit',
  config = function()
    local neogit = require('neogit')

    neogit.setup {}
    vim.keymap.set('n', '<leader>gs', function() neogit.open() end)
  end
}
