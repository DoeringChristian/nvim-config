local ok, dap = pcall(require, "dap")
if not ok then
    return
end

local function configure()
    local ok, dap_install = pcall(require, "dap-install")
    if not ok then
        return
    end
    dap_install.setup {
        installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
    }

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

    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb',
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

    dap.configurations.rust = dap.configurations.cpp

end

local function configure_exts()

end

local function configure_debuggers()
    --require("user.dap.rust").setup()
end

configure()
configure_exts()
configure_debuggers()
require("user.dap.keymaps").setup()
