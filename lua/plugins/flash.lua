local mode = function(str)
    local keywords = vim.o.iskeyword
    local keywords = "0-9a-z" -- Any characters allowed to match (keep case insensitive)
    local patern = "\\(^\\|[^" .. keywords .. "]\\zs\\)" .. str
    return patern
end
return {
    "folke/flash.nvim",
    enabled = false,
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        labels = "sfnutrjklodwehmvgc",
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
                        forward = true,
                        wrap = false,
                        multi_window = false,
                        mode = mode,
                    },
                }
            end,
            desc = "Flash"
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump {
                    search = {
                        forward = false,
                        wrap = false,
                        multi_window = false,
                        mode = mode,
                    },
                }
            end,
            desc = "Flash"
        },
        -- {
        --     "S",
        --     mode = { "n", "o", "x" },
        --     function() require("flash").treesitter() end,
        --     desc =
        --     "Flash Treesitter"
        -- },
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
