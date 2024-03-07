return {
    "mrcjkb/rustaceanvim",
    enabled = true,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- lsp completions
    },
    config = function()
        -- local rust_tools = require("rusta")
        --local extension_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
        local mason_path = vim.fn.stdpath("data") .. "/mason/"
        local extension_path = mason_path .. "packages/codelldb/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"


        local cfg = require("rustaceanvim.config")

        local adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
        -- print(vim.inspect(adapter))

        local dap = require "dap"

        vim.g.rustaceanvim = {
            tools = {
                hover_actions = {
                    border = { "", "", "", "", "", "", "", "" },
                }
            },
            server = require("plugins.lsp.handlers").config("rust_analyzer"),
            dap = {
                adapter = adapter,
            },
        }
    end,
}
