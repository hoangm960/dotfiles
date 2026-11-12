return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    opts = {
        keymap = {
            preset = "default",

            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-leader>"] = { "show" },
            ["<C-l>"] = { "select_and_accept" },
        },

        appearance = {
            nerd_font_variant = "normal",
        },
        signature = { enabled = true },
        completion = {
            ghost_text = { enabled = true },
            documentation = { auto_show = true },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = {
                    fallbacks = {},
                },
                path = {
                    fallbacks = {},
                },
                buffer = {
                    score_offset = 0,
                    opts = {
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == "" and vim.bo[bufnr].buflisted
                            end, vim.api.nvim_list_bufs())
                        end,
                    },
                },
                snippets = {
                    opts = {
                        extended_filetypes = {
                            ruby = { "rails", "rspec", "rdoc" },
                            eruby = { "html", "rails" },
                        },
                    },
                },
            },
        },
    },
    opts_extend = { "sources.default" },
}
