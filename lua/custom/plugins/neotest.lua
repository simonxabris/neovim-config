return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest",
				}),
			},
		})
	end,
  -- stylua: ignore
	keys = {
		{"<leader>rt", function() require("neotest").run.run() end,desc = "[R]un [T]est" },
		{"<leader>rat", function() require("neotest").run.run(vim.fn.expand("%")) end,desc = "[R]un [A]ll [T]est" },
		{ "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "[T]oggle [O]utput" }
	}
,
}
