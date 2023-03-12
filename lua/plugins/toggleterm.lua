return {
    "akinsho/toggleterm.nvim",
    keys = {
        { "<leader>tt", "<cmd>lua _TERM_TOGGLE()<cr>",    desc = "[T]oggle [T]erminal" },
        { "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "[T]erminal [L]azyGit" },
        { "<leader>tp", "<cmd>lua _IPYTHON_TOGGLE()<cr>", desc = "[T]erminal [P]ython" },
    },
    cmd = {
        "ToggleTerm",
        "TermExec",
        "ToggleTermToggleAll",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines",
        "ToggleTermSendVisualSelection",
    },
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


        local Terminal = require "toggleterm.terminal".Terminal

        function _G.set_terminal_keymaps()
            local function map(mode, keys, func, desc)
                if desc then
                    desc = desc
                end
                vim.api.nvim_buf_set_keymap(0, mode, keys, func, { noremap = true, silent = true, desc = desc })
            end

            -- Terminal Mode
            map('t', '<Esc>', [[<C-\><C-n>]], "Exit Insert Mode") -- go to normal mode with escape
            map('t', '<C-n>', [[<C-\><C-n>]], "Exit Insert Mode") -- go to normal mode with escape
            -- Normal Mode
            map('n', '<esc>', "<cmd>close<cr>", "Exit Terminal")  -- close terminal on escape

            -- Navigating out of Terminal:
            map("t", "<C-h>", "<C-\\><C-N><C-w>h", "Move out of Terminal")
            map("t", "<C-j>", "<C-\\><C-N><C-w>j", "Move out of Terminal")
            map("t", "<C-k>", "<C-\\><C-N><C-w>k", "Move out of Terminal")
            map("t", "<C-l>", "<C-\\><C-N><C-w>l", "Move out of Terminal")
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

        ----------------------------------
        -- Set Custom terminals.
        ----------------------------------
        local test = Terminal:new {
            hidden = true,
            on_open = function(term)
            end
        }
        function _TERM_TOGGLE()
            test:toggle()
        end

        local lazygit = Terminal:new {
            cmd = "lazygit",
            hidden = true,
            on_open = function(term)
                -- remove escape for lazygit
                vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
            end
        }
        function _LAZYGIT_TOGGLE()
            lazygit:toggle()
        end

        -- TODO: ipython
        local ipython = Terminal:new {
            cmd = "python -m IPython",
            hidden = true,
            direction = "horizontal",
        }
        _IPYTHON = ipython
        function _IPYTHON_TOGGLE()
            ipython:toggle()
        end

        function _IPYTHON_SEND_CURRENT_LINE()
            if not ipython:is_open() then
                ipython:toggle()
            end
            vim.cmd("ToggleTermSendCurrentLine " .. ipython.id .. " open=0")
        end
    end
}
