return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local ls = require "luasnip"

        local types = require("luasnip.util.types")

        local snipdir = vim.fn.stdpath('config') .. '/snippets'

        require 'luasnip.loaders.from_vscode'.lazy_load()
        require 'luasnip.loaders.from_snipmate'.lazy_load {
            paths = snipdir .. '/snipmate'
        }
        require 'luasnip.loaders.from_lua'.lazy_load {
            paths = snipdir .. '/lua'
        }


        -- Same function as used by luasnip but limits sources to snipmate
        local function format_snipmate(path, source_name)
            if source_name ~= "snipmate" then
                return nil
            end
            path = path:gsub(
                    vim.pesc(vim.fn.stdpath("data") .. "/site/pack/packer/start"),
                    "$PLUGINS"
                )
            if vim.env.HOME then
                path = path:gsub(vim.pesc(vim.env.HOME .. "/.config/nvim"), "$CONFIG")
            end
            return path
        end

        vim.api.nvim_create_user_command("LuaSnipEdit", function()
            require 'luasnip.loaders'.edit_snippet_files {
                format = format_snipmate,
                edit = function(file)
                    vim.notify("test")
                    vim.cmd("vsplit " .. file)
                end
            }
        end, {})

        --vim.cmd [[command! LuaSnipEdit :lua require('luasnip.loaders.from_snipmate').edit_snippet_files()]]
        --vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

        ls.config.setup {
            -- This one is cool cause if you have dynamic snippets, it updates as you type!
            updateevents = "TextChanged,TextChangedI",

            -- Autosnippets:
            enable_autosnippets = true,

            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "●", "Boolean" } }
                    }
                },
                [types.insertNode] = {
                    active = {
                        virt_text = { { "●", "StorageClass" } }
                    }
                }
            },
        }
    end
}
