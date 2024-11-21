return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async"
        },
        lazy = false,
        keys = {
            { "zR", function() require "ufo".openAllFolds() end,  desc = "[R]eveal all Folds" },
            { "zM", function() require "ufo".closeAllFolds() end, desc = "Close all Folds" },
        },
        config = function()
            -- local group = vim.api.nvim_create_augroup("ufo_hover", {})
            -- vim.api.nvim_create_autocmd("CursorHold", {
            --     callback = function(args)
            --         local winid = require "ufo".peekFoldedLinesUnderCursor()
            --         --     if not winid then
            --         --         vim.lsp.buf.hover()
            --         --     end
            --     end,
            --     group = group,
            -- })

            require "ufo".setup {
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
                close_fold_kinds_for_ft = {
                    -- default = { "comment" },
                    -- rust = { "function_item", },
                    -- python = { "function_definition" },
                    -- cpp = {
                    --     "comment",
                    --     "region",
                    --     "function_definition",
                    --     "struct_specifier",
                    --     "union_specifier",
                    --     "class_specifier",
                    --     "enum_specifier",
                    -- },
                },
                preview = {
                    win_config = {
                        border = { '', '─', '', '', '', '─', '', '' },
                        winhighlight = 'Normal:Folded',
                        winblend = 0
                    },
                    mappings = {
                        scrollU = '<C-u>',
                        scrollD = '<C-d>',
                        jumpTop = '[',
                        jumpBot = ']'
                    }
                },
            }
        end
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {}, -- needed even when using default config
    },
}
