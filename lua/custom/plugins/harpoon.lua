return {
	"ThePrimeagen/harpoon",
	config = function() -- This is the function that runs, AFTER loading
		vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = "[H]arpoon [A]dd" })
		vim.keymap.set("n", "<leader>qn", require("harpoon.ui").toggle_quick_menu, { desc = "[Q]uick [N]av" })
	end,
}
