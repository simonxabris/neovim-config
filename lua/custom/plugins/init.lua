return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        with_markers = true,
        indent = {
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
        },
        icon = {
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon"
        }
      },
      window = {
        position = "right",
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
        }
      }
    })


    vim.keymap.set('n', '<leader>tt', function() require("neo-tree").show("filesystem", true) end)
    vim.keymap.set('n', '<leader>tf', function() require("neo-tree").focus("filesystem", true, false) end)
    vim.keymap.set('n', '<leader>tr', function() require("neo-tree").reveal_current_file("filesystem", false, false) end)
  end
}
