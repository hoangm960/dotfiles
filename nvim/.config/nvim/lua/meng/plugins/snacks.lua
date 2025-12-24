local header = [[
███╗   ███╗███████╗███╗   ██╗ ██████╗
████╗ ████║██╔════╝████╗  ██║██╔════╝
██╔████╔██║█████╗  ██╔██╗ ██║██║  ███╗
██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║
██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝
╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝]]

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dashboard = {
            width = 70,
            row = 10,
            preset = {
                keys = {
                    {
                        icon = " ",
                        key = "f",
                        desc = "Find File",
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = " ", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
                    {
                        icon = "󰒲 ",
                        key = "L",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                header = header,
            },
            sections = {
                { section = "header" },
                { section = "keys",  gap = 1, padding = 3 },
            },
        },
        dim = {
            enabled = true,
        },
        indent = {
            only_scope = true,
            only_current = true,
        },
        lazygit = {
            enabled = true,
        },
        notifier = {
            style = "compact",
        },
        quickfile = {
            enabled = true,
        },
        picker = {
            enabled = true,
            sources = {
                files = {
                    hidden = true,
                    ignored = true,
                },
            },
        },
    },
    keys = function()
        return {
            {
                "<leader>lg",
                function()
                    Snacks.lazygit()
                end,
                desc = "[L]azy[G]it",
            },
            {
                "<leader>rf",
                function()
                    Snacks.rename.rename_file()
                end,
                desc = "[R]ename current [F]ile",
            },
            {
                "<leader>nh",
                function()
                    Snacks.notifier.show_history()
                end,
                desc = "Show [N]otification [H]istory",
            },
            {
                "<leader>td",
                function()
                    local dim = Snacks.dim
                    if dim.enabled then
                        dim.disable()
                    else
                        dim.enable()
                    end
                end,
                desc = "[T]oggle [D]im",
            },

            {
                "<leader>ff",
                function()
                    Snacks.picker.files()
                end,
                desc = "[F]ind [F]iles",
            },
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "[F]ind [P]rojects",
            },
            {
                "<leader>fc",
                function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "[F]ind [C]onfig files",
            },
            {
                "<leader>fg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "[F]ind with [G]rep",
            },
            {
                "<leader>fk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "[F]ind [K]eymaps",
            },
            {
                "<leader>fh",
                function()
                    Snacks.picker.help()
                end,
                desc = "[F]ind [H]elp",
            },
            {
                "<leader>uh",
                function()
                    Snacks.picker.undo()
                end,
                desc = "[U]ndo [H]istory",
            },
        }
    end,
}
