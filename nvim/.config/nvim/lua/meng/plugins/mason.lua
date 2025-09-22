return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"artemave/workspace-diagnostics.nvim",
	},
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "require", "Snacks" },
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
						telemetry = {
							enable = false,
						},
					},
				},
			},
			ts_ls = {
				on_attach = function(client, bufnr)
					require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
				end,
				init_options = {
					preferences = {
						includeCompletionsWithSnippetText = true,
						includeCompletionsForImportStatements = true,
					},
				},
			},
		},
	},

	config = function(_, opts)
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

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
		})

		for server, config in pairs(opts.servers) do
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local keyopts = { buffer = ev.buf, silent = true }

				keyopts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", vim.lsp.buf.references, keyopts)

				keyopts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keyopts)

				keyopts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, keyopts)

				keyopts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keyopts)

				keyopts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, keyopts)

				keyopts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, keyopts)

				keyopts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keyopts)

				keyopts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, keyopts)

				keyopts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, keyopts)

				keyopts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", keyopts)

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, keyopts)
			end,
		})

		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})
	end,
}
