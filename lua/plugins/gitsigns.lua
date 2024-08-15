return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "seanbreckenridge/gitsigns-yadm.nvim",
            opts = {
                shell_timeout_ms = 1000,
            },
        },
    },
    opts = {
        -- signs_staged_enable = false,
        numhl = true,
        signcolumn = true,
        -- sign_priority = 1,
        current_line_blame = true,
        current_line_blame_formatter = "<author>, <author_time:%R> - <abbrev_sha> <summary>",
        _on_attach_pre = function(_, callback)
            require "gitsigns-yadm".yadm_signs(callback)
        end,
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
            map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
            map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "[H]unk [S]tage" })
            map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "[H]unk [R]eset" })
            map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage Buffer" })
            map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "[H]unk Stage [U]ndo" })
            map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "[H]unk [R]eset Buffer" })
            map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
            map('n', '<leader>hb', function()
                gitsigns.blame_line { full = true }
            end, { desc = "Blame Line" })
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "[T]oggle [B]lame Line" })
            map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff This" })
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff this ~" })
            map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted" })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
}
