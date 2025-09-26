return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", desc = "[T]oggle [T]rouble" },
		{ "<leader>tc", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "[T]rouble [C]urrent" },
	},
}
