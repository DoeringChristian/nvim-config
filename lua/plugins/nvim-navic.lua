local util = require "util"

return {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
        vim.g.navic_silence = true
        util.on_attach(function(client, buffer)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, buffer)
                vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            end
        end)
    end,
    opts = function()
        return {
            separator = " ",
            -- highlight = true,
            depth_limit = 5,
            icons = require "user.icons".kinds,
        }
    end,
}
