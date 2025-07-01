return {
    "barreiroleo/ltex_extra.nvim",
    enabled = false,
    ft = { "markdown", "tex", "rst" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        local opts = require "plugins.lsp.server".config("ltex")
        require "ltex_extra".setup {
            load_langs = { "en-US", "de-DE" },
            path = ".ltex",
            init_check = true,
            server_opts = opts,
        }

        local addToDictionary = vim.lsp.commands["_ltex.addToDictionary"]
        vim.lsp.commands["_ltex.addToDictionary"] = function(command)
            addToDictionary(command)
        end
    end
}
