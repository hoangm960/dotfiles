return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
				},
				indent = { enable = true },

				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"python",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"gitignore",
					"vimdoc",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>b",
						node_incremental = "<leader>b",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = false,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
					["typescriptreact"] = {
						enable_close = true,
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		opts = { mode = "cursor", max_lines = 5 },
	},
}
