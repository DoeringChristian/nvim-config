return {
    "akinsho/toggleterm.nvim",
    config = function()
        local toggleterm = require "toggleterm"

        toggleterm.setup {
            open_mapping = [[<C-t>]],
            terminal_mappings = true,
            direction = "float",
            float_opts = {
                border = "curved",
            },
        }

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, 't', '<C-a>', [[<C-t>]], opts)
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')




        local ok, terminal = pcall(require, 'toggleterm.terminal')
        if not ok then
            return
        end

        local Terminal = terminal.Terminal

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            -- Terminal Mode
            vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts) -- go to normal mode with escape
            vim.api.nvim_buf_set_keymap(0, 't', '<C-n>', [[<C-\><C-n>]], opts) -- go to normal mode with escape
            --vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n>k]], opts)
            --vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n>j]], opts)
            -- Normal Mode
            vim.api.nvim_buf_set_keymap(0, 'n', '<esc>', "<cmd>ToggleTerm<CR>", opts) -- close terminal on escape
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

        ----------------------------------
        -- Set Custom terminals.
        ----------------------------------
        local gitui = Terminal:new({
            cmd = "gitui",
            hidden = false,
        })
        function _GITUI_TOGGLE()
            gitui:toggle()
        end

        local bottom = Terminal:new({
            cmd = "btm",
            hidden = false,
            on_open = function(term)
                vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
            end
        })
        function _BOTTOM_TOGGLE()
            bottom:toggle()
        end

        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = false,
            on_open = function(term)
                -- remove escape for lazygit
                vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
            end
        })
        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end

        local dust = Terminal:new({
            cmd = "dust",
            hidden = false,
            close_on_exit = false,
        })
        function _DUST_TOGGLE()
            dust:toggle()
        end

        local htop = Terminal:new({
            cmd = "htop",
            hidden = false,
        })
        function _HTOP_TOGGLE()
            htop:toggle()
        end

        local cargo_run_trace = Terminal:new({
            cmd = "clear && export RUST_BACKTRACE=1 && export RUST_LOG=trace && cargo run",
            hidden = false,
            close_on_exit = false,
            on_open = function(term)
                -- remove escape for lazygit
                --vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "iq")
            end
        })
        function _CARGO_RUN_TRACE_TOGGLE()
            cargo_run_trace:toggle()
        end
    end
}
