return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>fb",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "[F]ormat [B]uffer",
		},
	},
	opts = {
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 3000,
		},
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			python = { "ruff" },
			java = { "google-java-format" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--tab-width", "4" },
			},
			["google-java-format"] = {
				append_args = { "--aosp" },
			},
		},
	},
}
