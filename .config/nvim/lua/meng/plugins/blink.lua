return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	opts = {
		keymap = {
			preset = "default",

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
			["<C-l>"] = { "select_and_accept" },
		},

		appearance = {
			nerd_font_variant = "normal",
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
