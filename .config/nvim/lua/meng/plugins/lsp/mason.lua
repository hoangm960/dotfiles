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
				-- "ts_ls", currently using a ts plugin
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"emmet_language_server",
				-- "eslint",
				"marksman",
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

				["emmet_ls"] = function()
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,

				["emmet_language_server"] = function()
					lspconfig.emmet_language_server.setup({
						filetypes = {
							"css",
							"eruby",
							"html",
							"javascript",
							"javascriptreact",
							"less",
							"sass",
							"scss",
							"pug",
							"typescriptreact",
						},
						init_options = {
							includeLanguages = {},
							excludeLanguages = {},
							extensionsPath = {},
							preferences = {},
							showAbbreviationSuggestions = true,
							showExpandedAbbreviation = "always",
							showSuggestionsAsSnippets = false,
							syntaxProfiles = {},
							variables = {},
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
