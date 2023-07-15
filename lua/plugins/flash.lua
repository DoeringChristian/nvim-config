return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        label = {
            uppercase = false,
            reuse = "all",
            rainbow = {
                enabled = false,
                -- number between 1 and 9
                shade = 5,
            },
        },
        remote_op = {
            -- restore = true,
        }
    },
    -- stylua: ignore
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump {
                    search = {
                        -- mode = function(str)
                        --     return "\\<" .. str
                        -- end,
                        mode = function(str)
                            local keywords = vim.o.iskeyword
                            local keywords = "@0-9192-255-" -- Keywords except Underscore
                            local patern = "\\(^\\|[^" .. keywords .. "]\\zs\\)" .. str
                            return patern
                        end
                    },
                }
            end,
            desc = "Flash"
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function() require("flash").treesitter() end,
            desc =
            "Flash Treesitter"
        },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        {
            "R",
            mode = { "o", "x" },
            function() require("flash").treesitter_search() end,
            desc =
            "Treesitter Search"
        },
        {
            "<c-s>",
            mode = { "c" },
            function() require("flash").toggle() end,
            desc =
            "Toggle Flash Search"
        },
    },
}
