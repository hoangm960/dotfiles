return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = true,
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"emmet_language_server",
				"eslint",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"mypy",
				"black",
				"ruff",
				"python-lsp-server",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
							},
						},
					})
				end,

				["ts_ls"] = function()
					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						root_dir = function(fname)
							local util = lspconfig.util
							return not util.root_pattern("deno.json", "deno.jsonc")(fname)
								and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
						end,
						single_file_support = false,
						init_options = {
							preferences = {
								includeCompletionsWithSnippetText = true,
								includeCompletionsForImportStatements = true,
							},
						},
					})
				end,
			},
		})
	end,
}
