-- Utility functions from here: https://github.com/alpha2phi/modern-neovim/blob/6f81337311b24e4d5af4c056c03b7e265cb268dd/lua/pde/jupyter.lua#L107
local function get_commenter()
    local commenter = { python = "# ", lua = "-- ", julia = "# ", fennel = ";; ", scala = "// ", r = "# " }
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if ft == nil or ft == "" then
        return commenter["python"]
    elseif commenter[ft] == nil then
        return commenter["python"]
    end

    return commenter[ft]
end

local CELL_MARKER = get_commenter() .. "%%"

local function select_cell()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_row = vim.api.nvim_win_get_cursor(0)[1]
    local current_col = vim.api.nvim_win_get_cursor(0)[2]

    local start_line = nil
    local end_line = nil

    for line = current_row, 1, -1 do
        local line_content = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
        if line_content:find("^" .. CELL_MARKER) then
            start_line = line
            break
        end
    end
    local line_count = vim.api.nvim_buf_line_count(bufnr)
    for line = current_row + 1, line_count do
        local line_content = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
        if line_content:find("^" .. CELL_MARKER) then
            end_line = line - 1
            break
        end
    end

    if not start_line then
        start_line = 1
    end
    if not end_line then
        end_line = line_count
    end

    -- Get length of last line
    local line_content = vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, false)[1]
    local end_col = #line_content

    return current_row, current_col, start_line, end_line, end_col
end

local function execute_cell()
    local current_row, current_col, start_line, end_line, end_col = select_cell()
    if start_line and end_line then
        vim.fn.setpos("'<", { 0, start_line + 1, 0, 0 })
        vim.fn.setpos("'>", { 0, end_line, end_col, 0 })
        require("iron.core").visual_send()
        vim.api.nvim_win_set_cursor(0, { current_row, current_col })
    end
end

local function navigate_cell(up)
    local is_up = up or false
    local _, _, start_line, end_line, _ = select_cell()
    if is_up and start_line ~= 1 then
        vim.api.nvim_win_set_cursor(0, { start_line - 1, 0 })
        _, _, start_line, end_line = select_cell()
        vim.api.nvim_win_set_cursor(0, { start_line, 0 })
    elseif end_line then
        local bufnr = vim.api.nvim_get_current_buf()
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        if end_line ~= line_count then
            vim.api.nvim_win_set_cursor(0, { end_line + 1, 0 })
            _, _, start_line, end_line = select_cell()
            vim.api.nvim_win_set_cursor(0, { start_line, 0 })
        end
    end
end

return {
    {
        "Vigemus/iron.nvim",
        enabled = true,
        lazy = false,
        keys = {
            { "<leader>rc",    desc = "[R]epl Execute" },
            { "<leader>rc",    desc = "[R]epl Execute" },
            { "<leader>rf",    desc = "[R]epl send [F]ile" },
            { "<leader>rl",    desc = "[R]epl send Line" },
            { "<leader>rp",    desc = "[R]epl send [P]aragraph" },
            { "<leader>ru",    desc = "[R]epl send [U]ntil Cursor" },
            { "<leader>rm",    desc = "[R]epl send [M]ark" },
            { "<leader>r<cr>", desc = "[R]epl [<CR>]" },
            { "<leader>rq",    desc = "[R]epl [Q]uit" },
            { "<leader>rd",    desc = "[R]epl [D]elete/Clear" },
            {
                "<leader>ro",
                mode = { "n" },
                function()
                    vim.cmd('normal V')
                    require("leap.treesitter").select()
                    require("iron.core").visual_send()
                    vim.cmd("norm! j")
                end,
                desc = "[R]epl operator",
            },
            -- {
            --     "<leader>rr",
            --     mode = { "n" },
            --     function()
            --         execute_cell()
            --         navigate_cell(false)
            --     end,
            --     desc = "[R]epl [R]un"
            -- },
        },
        config = function()
            local view = require "iron.view"
            require "iron.core".setup {
                config = {
                    repl_definition = {
                        python = {
                            command = { "ipython", "--no-autoindent" },
                            format = require "iron.fts.common".bracketed_paste_python
                        }
                    },
                    repl_open_cmd = view.split.vertical("40%"),
                },
                keymaps = {
                    send_motion = "<leader>rc",
                    visual_send = "<leader>rc",
                    send_file = "<leader>rf",
                    send_line = "<leader>rl",
                    send_paragraph = "<leader>rp",
                    send_until_cursor = "<leader>ru",
                    send_mark = "<leader>rm",
                    cr = "<leader>r<cr>",
                    exit = "<leader>rq",
                    clear = "<leader>rd",
                }
            }
        end
    },
    {
        "GCBallesteros/NotebookNavigator.nvim",
        event = "VeryLazy",
        keys = {
            { "]r",         function() require("notebook-navigator").move_cell "d" end },
            { "[r",         function() require("notebook-navigator").move_cell "u" end },
            { "<leader>rr", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
            -- { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
        },
        config = function()
            local nn = require "notebook-navigator"
            nn.setup {}
        end
    },
    {
        "pappasam/nvim-repl",
        enabled = false,
        init = function()
            vim.g["repl_filetype_commands"] = {
                javascript = "node",
                python = "ipython --no-autoindent"
            }
        end,
        keys = {
            { "<leader>rt", "<cmd>ReplToggle<cr>",  desc = "[R]epl [T]oggle" },
            { "<leader>rr", "<cmd>ReplRunCell<cr>", desc = "[R]epl run" },
        },
    },
}
