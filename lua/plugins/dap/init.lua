return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        "jayp0521/mason-nvim-dap.nvim",
    },
    keys = {
        {
            "<F5>",
            function()
                -- require 'hydra'.spawn('dap-hydra')
                require 'dapui'.open()
                require 'dap'.continue()
            end,
            desc = "Debug Start"
        },
        {
            "<leader>db",
            function()
                require 'dapui'.open()
                require 'dap'.continue()
            end,
            desc = "Debug Start"
        },
        {
            "<leader>dt",
            function()
                require "dap".toggle_breakpoint()
            end
        },
        {
            "<F6>",
            function()
                require "dapui".toggle()
            end,
            desc = "Toggle Debug Interface"
        },
        {
            "<leader>di",
            function()
                require "dapui".toggle()
            end,
            desc = "Toggle Debug Interface"
        },
        {
            "<F9>",
            function()
                require "dap".toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint"
        },
    },
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        local mason_dir = vim.fn.stdpath("data") .. "/mason"
        local extension_path = mason_dir .. "/packages/codelldb/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local lldb_path = extension_path .. "lldb/bin/lldb"

        local function configure()
            local dap_breakpoint = {
                error = {
                    text = "🟥",
                    texthl = "LspDiagnosticsSignError",
                    linehl = "",
                    numhl = "",
                },
                rejected = {
                    text = "",
                    texthl = "LspDiagnosticsSignHint",
                    linehl = "",
                    numhl = "",
                },
                stopped = {
                    text = "⭐️",
                    texthl = "LspDiagnosticsSignInformation",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "LspDiagnosticsSignInformation",
                },
            }

            vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
            vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
            vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
        end

        local function configure_exts()
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                -- Expand lines larger than the window
                -- Requires >= 0.7
                expand_lines = vim.fn.has("nvim-0.7"),
                -- Layouts define sections of the screen to place windows.
                -- The position can be "left", "right", "top" or "bottom".
                -- The size specifies the height/width depending on position. It can be an Int
                -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
                -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
                -- Elements are the elements shown in the layout (in order).
                -- Layouts are opened in order so that earlier layouts take priority in window sizing.
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil,  -- These can be integers or a float between 0 and 1.
                    max_width = nil,   -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                }
            })
            dap.listeners.after.event_initialized["dapui_config"] = function()
                _dap_hydra:activate()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                require "nvim-tree".toggle { focus = false } -- Refresh Nvim-Tree
                require "nvim-tree".toggle { focus = false }
                _dap_hydra:exit()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                require "nvim-tree".toggle { focus = false } -- Refresh Nvim-Tree
                require "nvim-tree".toggle { focus = false }
                _dap_hydra:exit()
                dapui.close()
            end
        end

        local function configure_debuggers()
            dap.adapters.lldb = {
                type = "executable",
                command = codelldb_path,
                name = "lldb"
            }

            dap.configurations.cpp = {
                {
                    name = 'Launch',
                    type = 'lldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                }
            }
        end

        configure()
        configure_exts()
        configure_debuggers()
        --require("user.dap.keymaps").setup()
    end
}
