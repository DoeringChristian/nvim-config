local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

local icons = require 'config.icons'

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
      opts = {},
      config = function(_, opts)
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Spawn dapui in new tab see https://github.com/rcarriga/nvim-dap-ui/issues/122#issuecomment-1206389311
        local debug_win = nil
        local debug_tab = nil
        local debug_tabnr = nil

        local function open_in_tab()
          if debug_win and vim.api.nvim_win_is_valid(debug_win) then
            vim.api.nvim_set_current_win(debug_win)
            return
          end

          vim.cmd 'tabedit %'
          debug_win = vim.fn.win_getid()
          debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
          debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

          dapui.open()
        end

        local function close_tab()
          dapui.close()

          if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
            vim.api.nvim_exec('tabclose ' .. debug_tabnr, false)
          end

          debug_win = nil
          debug_tab = nil
          debug_tabnr = nil
        end

        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          open_in_tab()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          close_tab()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          close_tab()
        end
      end,
    },
    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
    -- which key integration
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<leader>d'] = { name = '+debug' },
        },
      },
    },
    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        -- handlers = {},
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
          codelldb = function(config) end,
        },

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },
    -- stylua: ignore
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
  config = function()
    vim.fn.sign_define('DapBreakpoint', {
      text = icons.dbg.breakpoint,
      texthl = 'DiagnosticError',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapStopped', {
      text = icons.dbg.rejected,
      texthl = 'DiagnosticSignHint',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = icons.dbg.stopped,
      texthl = 'DiagnosticWarn',
      linehl = 'DiagnosticUnderlineInfo',
      numhl = 'LspDiagnosticsSignInformation',
    })

    local mason_path = vim.fn.stdpath 'data' .. '/mason/'
    local extension_path = mason_path .. 'packages/codelldb/extension/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
  end,
}
