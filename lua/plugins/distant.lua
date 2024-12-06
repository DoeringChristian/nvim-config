return {
    -- Use to install:
    -- ssh example.com 'curl -L https://sh.distant.dev | sh -s -- --on-conflict overwrite'
    "chipsenkbeil/distant.nvim",
    -- WARN: Disabled, since it overwrites `vim.diagnostic.config`
    enabled = false,
    branch = "v0.3",
    config = function()
        require("distant"):setup()
    end,
}
