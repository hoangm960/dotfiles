return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
        },
    },
    config = function(_, opts)
        require("harpoon"):setup(opts)
    end,
    keys = function()
        local function toggle_harpoon_picker(harpoon_files)
            local finder = function()
                local paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(paths, {
                        text = item.value,
                        file = item.value,
                    })
                end
                return paths
            end

            Snacks.picker.pick({
                title = "Harpoon",
                finder = finder,
                prompt = " ",
                format = "file",
                win = {
                    input = {
                        keys = {
                            ["<C-x>"] = { "harpoon_delete", mode = { "n", "i" } },
                            ["dd"] = { "harpoon_delete", mode = { "n" } },
                        },
                    },
                },
                actions = {
                    harpoon_delete = function(picker, item)
                        local to_remove = item or picker:selected()
                        if to_remove then
                            table.remove(harpoon_files.items, to_remove.idx)
                            harpoon_files._length = #harpoon_files.items
                            require("harpoon"):sync()
                            picker:find({
                                refresh = true,
                            })
                        end
                    end,
                },
            })
        end

        local keys = {
            {
                "<leader>ha",
                function()
                    require("harpoon"):list():add()
                end,
                desc = "[H]arpoon [A]dd file",
            },
            {
                "<leader>hh",
                function()
                    toggle_harpoon_picker(require("harpoon"):list())
                end,
                desc = "[H]arpoon [H]istory",
            },
            {
                "[h",
                function()
                    require("harpoon"):list():prev()
                end,
                desc = "Prev harpoon",
            },
            {
                "]h",
                function()
                    require("harpoon"):list():next()
                end,
                desc = "Next harpoon",
            },
        }

        for i = 1, 4 do
            table.insert(keys, {
                "<leader>" .. i,
                function()
                    require("harpoon"):list():select(i)
                end,
                desc = "Harpoon to file [" .. i .. "]",
            })
        end

        return keys
    end,
}
