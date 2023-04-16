vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

vim.keymap.set('n', '<leader>p', function()
  vim.cmd(':Prettier')
end)
