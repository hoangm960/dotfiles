return {
    "3rd/image.nvim",
    opts = {
        backend = "kitty",
        kitty_method = "normal",
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
        tmux_show_only_in_active_window = true,
        window_overlap_clear_enabled = true,
        integrations = {
            markdown = {
                enabled = true,
                inlay_hints = { enabled = true },
            },
        },
        image_provider = function(path)
            if path:match("%.svg$") then
                local png_path = "/tmp/rsvg_" .. vim.fn.fnamemodify(path, ":t") .. ".png"
                vim.fn.system("rsvg-convert -o " .. png_path .. " " .. path)
                return png_path
            end
            return nil
        end,
    },
}
