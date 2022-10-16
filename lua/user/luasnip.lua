local ok, ls = pcall(require, "luasnip")
if not ok then
    return
end
local types = require("luasnip.util.types")

local snipdir = vim.fn.stdpath('config') .. '/snippets'

require 'luasnip.loaders.from_vscode'.lazy_load()
require 'luasnip.loaders.from_snipmate'.lazy_load {
    paths = snipdir .. '/snipmate'
}
require 'luasnip.loaders.from_lua'.lazy_load {
    paths = snipdir .. '/lua'
}

--vim.cmd [[command! LuaSnipEdit :lua require('luasnip.folders.from_snipmate').edit_snippet_files()]]
vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

ls.config.setup {
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "Bool" } }
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "String" } }
            }
        }
    },
}
