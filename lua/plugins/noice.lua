return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                view = "mini",
            },
            -- {
            --     filter = {
            --         event = "msg_show",
            --         kind = "search_count",
            --     },
            --     opts = { skip = true },
            -- },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
            hover = {
            },
            signature = {
                enabled = false,
            },
            documentation = {
                opts = {
                    border = { style = 'rounded' },
                    relative = 'cursor',
                    position = {
                        row = 2,
                    },
                    zindex = 200,
                    win_options = {
                        concealcursor = 'n',
                        conceallevel = 3,
                        winhighlight = {
                            Normal = 'LspFloat',
                            FloatBorder = 'LspFloatBorder',
                        },
                    },
                },
            }
        },
        format = {
            spinner = {
                name = "pipe",
            },
        },
        presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = true,
        },
        messages = {
            enabled = true,
        },
        cmdline = {
            enabled = true, -- enables the Noice cmdline UI
        },
        -- views = {
        --     mini = {
        --         position = {
        --             row = -2,
        --             col = "100%",
        --             -- col = 0,
        --         },
        --     }
        -- },
    },
    -- stylua: ignore
    keys = {
        {
            "<S-Enter>",
            function() require("noice").redirect(vim.fn.getcmdline()) end,
            mode = "c",
            desc =
            "Redirect Cmdline"
        },
        { "<leader>snl", function() require("noice").cmd("last") end,    desc = "Noice Last Message" },
        { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
        { "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
        --{ "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,   silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
        --{ "<c-b>",       function() if not require("noice.lsp").scroll( -4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
}