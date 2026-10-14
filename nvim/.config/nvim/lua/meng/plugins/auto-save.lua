return {
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    event = { "InsertLeave", "TextChanged" },
    keys = {
        { "<leader>as", "<cmd>ASToggle<CR>", desc = "Toggle [A]uto-[S]ave" },
    },
    opts = {
        debounce_delay = 5000, -- 5 seconds
        condition = function(buf)
            if vim.fn.getbufvar(buf, "&buftype") ~= "" then
                return false
            end
            local excluded = { "gitcommit", "gitrebase", "NvimTree", "oil", "TelescopePrompt", "prompt", "toggleterm" }
            if vim.tbl_contains(excluded, vim.fn.getbufvar(buf, "&filetype")) then
                return false
            end
            return vim.api.nvim_buf_get_name(buf) ~= ""
        end,
    },
}
