local border = require "user.border"
return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        handler_opts = {
            border = border.style
        }
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
}
