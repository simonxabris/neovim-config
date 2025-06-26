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
	},
}
