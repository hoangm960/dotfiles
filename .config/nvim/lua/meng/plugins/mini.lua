return {
	{ "echasnovski/mini.nvim", version = false },

	{
		"echasnovski/mini.comment",
		version = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				},
			})
		end,
	},

	{
		"echasnovski/mini.files",
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				mappings = {
					synchronize = "s",
				},
			})
			vim.keymap.set("n", "<leader>oe", "<cmd>lua MiniFiles.open()<CR>", { desc = "[O]pen [E]xplorer" })
			vim.keymap.set("n", "<leader>ef", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "[E]xplorer current [F]ile" })
		end,
	},

	{
		"echasnovski/mini.surround",
		opts = {},
	},

	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local miniTrailspace = require("mini.trailspace")

			miniTrailspace.setup({
				only_in_normal_buffers = true,
			})

			vim.keymap.set("n", "<leader>ew", function()
				miniTrailspace.trim()
			end, { desc = "[E]rase [W]hitespace" })

			vim.api.nvim_create_autocmd("CursorMoved", {
				pattern = "*",
				callback = function()
					miniTrailspace.unhighlight()
				end,
			})
		end,
	},

	{
		"echasnovski/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")

			miniSplitJoin.setup({
				mappings = { toggle = "" },
			})

			vim.keymap.set({ "n", "x" }, "<leader>aj", function()
				miniSplitJoin.join()
			end, { desc = "[A]rguments [J]oin" })
			vim.keymap.set({ "n", "x" }, "<leader>as", function()
				miniSplitJoin.split()
			end, { desc = "[A]rguments [S]plit" })
		end,
	},

	{
		"echasnovski/mini.move",
		opts = {},
	},
}
