local rust_tools_status_ok, rust_tools = pcall(require, 'rust-tools')
if not rust_tools_status_ok then
    return
end

local extension_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

rust_tools.setup({
    tools = {
        hover_with_actions = true,
        autoSetHints = true,
        inlay_hints = {
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "⯇ ",
            other_hints_prefix = "🠊 ",
            --highlight = "Conceal",
        },
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
    },
})
