return {
  'ThePrimeagen/harpoon',
  config = function()
    vim.keymap.set('n', '<leader>ha', function() require("harpoon.mark").add_file() end)
    vim.keymap.set('n', '<leader>ht', function() require("harpoon.ui").toggle_quick_menu() end)
  end
}
