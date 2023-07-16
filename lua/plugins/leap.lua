return {
    "ggandor/leap.nvim",
    enabled = true,
    dependencies = {
        "ggandor/flit.nvim",
        "ggandor/leap-spooky.nvim",
    },
    config = function()
        local leap = require "leap"

        leap.set_default_keymaps()
        leap.setup {
            max_phase_one_targets = nil,
            highlight_unlabeled_phase_one_targets = false,
            max_highlighted_traversal_targets = 10,
            case_sensitive = false,
            equivalence_classes = { ' \t\r\n', },
            substitute_chars = {},
            labels = { "s", "f", "n", "u", "t", "r",
                "j", "k", "l", "o", "d", "w", "e", "h", "m", "v", "g",
                "c", ".", "z" },
            safe_labels = { "s", "f", "n", "u", "t", "r" },
            --"F", "L", "N", "H", "G", "M", "U", "T", "Z" },
            special_keys = {
                repeat_search = '<enter>',
                next_phase_one_target = '<enter>',
                next_target = { '<enter>', ';' },
                prev_target = { '<tab>', ',' },
                next_group = '<space>',
                prev_group = '<tab>',
                multi_accept = '<enter>',
                multi_revert = '<backspace>',
            },
        }
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })

        function LEAP_ALL_WINDOWS()
            require('leap').leap { target_windows = vim.tbl_filter(
                function(win) return vim.api.nvim_win_get_config(win).focusable end,
                vim.api.nvim_tabpage_list_wins(0)
            ) }
        end

        function LEAP_BIDIRECTIONAL()
            require('leap').leap { target_windows = { vim.fn.win_getid() } }
        end

        -- The following example showcases a custom action, using `multiselect`. We're
        -- executing a `normal!` command at each selected position (this could be even
        -- more useful if we'd pass in custom targets too).

        function paranormal(targets)
            -- Get the :normal sequence to be executed.
            local input = vim.fn.input("normal! ")
            if #input < 1 then return end

            local ns = vim.api.nvim_create_namespace("")

            -- Set an extmark as an anchor for each target, so that we can also execute
            -- commands that modify the positions of other targets (insert/change/delete).
            for _, target in ipairs(targets) do
                local line, col = unpack(target.pos)
                id = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
                target.extmark_id = id
            end

            -- Jump to each extmark (anchored to the "moving" targets), and execute the
            -- command sequence.
            for _, target in ipairs(targets) do
                local id = target.extmark_id
                local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
                vim.fn.cursor(pos[1] + 1, pos[2] + 1)
                vim.cmd("normal! " .. input)
            end

            -- Clean up the extmarks.
            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
        end

        flit = require "flit"

        flit.setup {
            keys = { f = 'f', F = 'F', t = 't', T = 'T' },
            -- A string like "nv", "nvo", "o", etc.
            labeled_modes = "v",
            multiline = true,
            -- Like `leap`s similar argument (call-specific overrides).
            -- E.g.: opts = { equivalence_classes = {} }
            opts = {}
        }

        spooky = require "leap-spooky"

        spooky.setup {
            affixes = {
                -- These will generate mappings for all native text objects, like:
                -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
                -- Special line objects will also be added, by repeating the affixes.
                -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
                -- window.
                -- You can also use 'rest' & 'move' as mnemonics.
                remote   = { window = 'r', cross_window = 'R' },
                magnetic = { window = 'm', cross_window = 'M' },
            },
            -- If this option is set to true, the yanked text will automatically be pasted
            -- at the cursor position if the unnamed register is in use.
            paste_on_remote_yank = false,
        }
    end
}
