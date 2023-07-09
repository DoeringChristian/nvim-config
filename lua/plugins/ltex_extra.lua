return {
    "barreiroleo/ltex_extra.nvim",
    -- ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        local opts = require "user.lsp.handlers".config("ltex")
        require "ltex_extra".setup {
            log_level = "trace",
            load_langs = { "en-US", "de-DE" },
            path = ".ltex",
            init_check = true,
            server_opts = opts,
        }

        local addToDictionary = vim.lsp.commands["_ltex.addToDictionary"]
        vim.lsp.commands["_ltex.addToDictionary"] = function(command)
            print("test")
            addToDictionary(command)
        end
    end
}
