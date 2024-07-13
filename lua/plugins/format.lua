return {
    {
        "lukas-reineke/lsp-format.nvim",
        enabled = false,
        opts = {}
    },
    {
        -- TODO: find out why I wouldn't use this
        "stevearc/conform.nvim",
        enabled = true,
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "DiffFormat", "FormatEnable", "FormatDisable", "Format" },
        config = function()
            -- Load disable_autoformat from env var
            vim.g.disable_autoformat = vim.env.DISABLE_AUTOFORMAT

            local diff_format = function()
                local ignore_filetypes = { "lua" }
                if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                    vim.notify("range formatting for " .. vim.bo.filetype .. " not working properly.")
                    return
                end

                local hunks = require("gitsigns").get_hunks()
                if hunks == nil then
                    return
                end

                local format = require("conform").format

                local function format_range()
                    if next(hunks) == nil then
                        vim.notify("done formatting git hunks", "info", { title = "formatting" })
                        return
                    end
                    local hunk = nil
                    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
                        hunk = table.remove(hunks)
                    end

                    if hunk ~= nil and hunk.type ~= "delete" then
                        local start = hunk.added.start
                        local last = start + hunk.added.count
                        -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
                        local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
                        local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
                        format({ range = range, async = true, lsp_fallback = true }, function()
                            vim.defer_fn(function()
                                format_range()
                            end, 1)
                        end)
                    end
                end

                format_range()
            end

            -- local diff_format = function()
            --     local hunks = require("gitsigns").get_hunks()
            --     local format = require("conform").format
            --     for i = #hunks, 1, -1 do
            --         local hunk = hunks[i]
            --         if hunk ~= nil and hunk.type ~= "delete" then
            --             local start = hunk.added.start
            --             local last = start + hunk.added.count
            --             -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
            --             local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
            --             local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
            --             format({ async = true, lsp_fallback = true, range = range })
            --         end
            --     end
            -- end

            -- DiffFormat
            vim.api.nvim_create_user_command('DiffFormat', diff_format, { desc = 'Format changed lines' })


            -- FormatEnable/FormatDisable
            vim.api.nvim_create_user_command("FormatDisable", function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })
            vim.api.nvim_create_user_command("FormatEnable", function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = "Re-enable autoformat-on-save",
            })


            -- Format
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format({ async = true, lsp_fallback = true, range = range })
            end, { range = true })

            require "conform".setup {
                -- Use LSP and format after save (async)
                formatters_by_ft = {
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    fish = { "fish_indent" },
                    sh = { "shfmt" },
                    python = { "black" },
                },
                format_after_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    -- ...additional logic...
                    return { lsp_fallback = true }
                end,
            }
        end
    }
}
