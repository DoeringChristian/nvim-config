return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "none",
        },
    },
    config = function(_, opts)
        require("lsp_signature").setup(opts)
    end,
}
