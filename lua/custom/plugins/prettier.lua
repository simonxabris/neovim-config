return {
  'prettier/vim-prettier',
  config = function()
    vim.keymap.set('n', '<leader>p', function() vim.cmd(":Prettier") end)
  end
}
