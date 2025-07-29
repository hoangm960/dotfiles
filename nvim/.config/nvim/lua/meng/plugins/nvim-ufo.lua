return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup({
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 0,
			})

			vim.o.foldenable = true
			vim.o.foldcolumn = "0"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99

			vim.keymap.set("n", "zO", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "Close all folds" })
		end,
	},
}
