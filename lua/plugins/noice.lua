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
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
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
        cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {}, -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
                -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
                -- view: (default is cmdline view)
                -- opts: any options passed to the view
                -- icon_hl_group: optional hl_group for the icon
                -- title: set to anything or empty string to hide
                cmdline = { pattern = "^:", icon = "", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                input = {}, -- Used by input()
                -- lua = false, -- to disable a format, set to `false`
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c",                 desc = "Redirect Cmdline" },
        { "<leader>snl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
        { "<leader>snh", function() require("noice").cmd("history") end,                desc = "Noice History" },
        { "<leader>sna", function() require("noice").cmd("all") end,                    desc = "Noice All" },
        --{ "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,   silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
        --{ "<c-b>",       function() if not require("noice.lsp").scroll( -4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
}
