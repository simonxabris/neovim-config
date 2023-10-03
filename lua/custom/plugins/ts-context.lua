return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    vim.keymap.set('n', '<leader>p', function() vim.cmd(":Prettier") end)
  end
}
