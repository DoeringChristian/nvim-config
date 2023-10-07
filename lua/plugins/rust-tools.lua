local border = require "user.border"
return {
    "simrat39/rust-tools.nvim",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
        local rust_tools = require "rust-tools"
        --local extension_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
        local mason_dir = vim.fn.stdpath("data") .. "/mason"
        local extension_path = mason_dir .. "/packages/codelldb/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

        rust_tools.setup({
            tools = {
                --executor = require("rust-tools/executors").toggleterm,
                -- hover_with_actions = true,
                inlay_hints = {
                    auto = true,
                    only_current_line = false,
                    show_parameter_hints = true,
                    parameter_hints_prefix = "⯇ ",
                    other_hints_prefix = "🠊 ",
                    highlight = "Conceal",
                },
                on_initialized = function()
                    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                        pattern = { "*.rs" },
                        callback = function()
                            vim.lsp.codelens.refresh()
                        end,
                    })
                end,
            },
            hover_actions = {
                -- the border that is used for the hover window
                -- see vim.api.nvim_open_win()
                border = border.style,

                -- whether the hover action window gets automatically focused
                -- default: false
                auto_focus = false,
            },
            dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(
                    codelldb_path, liblldb_path)
            },
            server = require "user.lsp.handlers".config("rust_analyzer"),
        })
    end
}
