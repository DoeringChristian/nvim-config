return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async"
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
                    default = {},
                    -- rust = { "function_item", },
                    -- python = { "function_definition" },
                    -- cpp = { "function_definition" },
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
    }
}
