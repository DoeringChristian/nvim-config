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
        sign_priority = 1,
        _on_attach_pre = function(_, callback)
            require "gitsigns-yadm".yadm_signs(callback)
        end,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- Navigation
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Prev Hunk")

            -- Actions
            map('n', '<leader>hs', gs.stage_hunk, "[H]unk [S]tage")
            map('n', '<leader>hr', gs.reset_hunk, "[H]unk [R]eset")
            map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                "[H]unk [S]tage")
            map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                "[H]unk [R]eset")
            map('n', '<leader>hS', gs.stage_buffer, "Stage Buffer")
            map('n', '<leader>hu', gs.undo_stage_hunk, "[H]unk Stage [U]ndo")
            map('n', '<leader>hR', gs.reset_buffer, "[R]eset Buffer")
            map('n', '<leader>hp', gs.preview_hunk, "[P]review Hunk")
            map('n', '<leader>hb', function() gs.blame_line { full = true } end, "[B]lame Line")
            map('n', '<leader>tb', gs.toggle_current_line_blame, "[T]oggle [B]lame")
            map('n', '<leader>hd', gs.diffthis, "[D]iffthis")
            map('n', '<leader>hD', function() gs.diffthis('~') end, "[D]iffthis ~")
            map('n', '<leader>td', gs.toggle_deleted, "[T]oggle [D]eleted")

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', "Select [H]unk")
        end
    }
}
