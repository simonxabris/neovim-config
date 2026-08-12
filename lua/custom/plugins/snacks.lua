return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = { enabled = true },
	},
  -- stylua: ignore
	keys = {
		{ "<leader>fr", function() require('snacks').picker.recent() end, desc = "Recent" },
		{ "<leader>gf", function() require('snacks').picker.git_files() end, desc = "[G]it [F]iles" },
		{ "<leader>sd", function() require('snacks').picker.diagnostics_buffer() end, desc = "[S]earch [D]iagnostics" },
		{ "<leader>sg", function() require('snacks').picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() require('snacks').picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ "<leader>ds", function() require('snacks').picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "gr", function() require('snacks').picker.lsp_references() end, nowait = true, desc = "References" },
	},
}
