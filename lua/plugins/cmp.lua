local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 32

return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-buffer",       -- buffer completions
        "hrsh7th/cmp-path",         -- path completions
        "hrsh7th/cmp-cmdline",      -- cmdline completions
        "saadparwaiz1/cmp_luasnip", -- snippet completions
        "hrsh7th/cmp-nvim-lsp",     -- lsp completions
        --"ray-x/lsp_signature.nvim", -- function signature completions
        -- "SvanT/lsp_signature.nvim",
    },
    opts = function()
        local cmp = require "cmp"
        local luasnip = require "luasnip"

        local check_backspace = function()
            local col = vim.fn.col "." - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
        end

        local check_bracket = function()
            local col = vim.fn.col '.' - 1
            print(vim.fn.getline('.'):sub(1, col))
            local before = vim.fn.getline('.'):sub(1, col)
            local after = vim.fn.getline('.'):sub(col + 1, -1)
            return vim.fn.getline('.'):sub(1, col):match "[%(%[%{\"']$" -- IMPORTANT: must match characters in autopairs.fast_wrap.chars
        end
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        --   פּ ﯟ   some other good icons
        local kind_icons = require "user.icons".kinds
        -- find more here: https://www.nerdfonts.com/cheat-sheet

        cmp.setup {
            performance = {
                debounce = 100,
                fetching_timeout = 200,
            },
            -- :h nvim-cmp
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = {
                -- ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ["<C-e>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                },
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                ["<CR>"] = cmp.mapping.confirm { select = false },
                ["<C-j>"] = cmp.mapping {
                    i = function(fallback)
                        if luasnip.choice_active() then
                            luasnip.change_choice(1)
                        else
                            fallback()
                        end
                    end,
                },
                ["<C-l>"] = cmp.mapping {
                    i = function(fallback)
                        if luasnip.jumpable() then
                            luasnip.jump(1) -- Need to jump forward
                        elseif luasnip.expandable() then
                            luasnip.expand()
                        else
                            fallback()
                        end
                    end,
                },
                ["<C-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "c" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- this way you will only jump inside the snippet region
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                    -- if cmp.visible() then
                    --     cmp.select_next_item()
                    -- elseif check_bracket() ~= nil then
                    --     require('nvim-autopairs.fastwrap').show()
                    -- elseif check_backspace() then
                    --     fallback()
                    -- elseif luasnip.expandable() then
                    --     luasnip.expand()
                    -- elseif luasnip.expand_or_jumpable() then
                    --     luasnip.expand_or_jump()
                    -- else
                    --     fallback()
                    -- end
                end, {
                    "i",
                    "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[NVIM_LUA]",
                        luasnip = "[Snippet]",
                        spell = "[Spell]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                        cmp_pandoc = "[Pandoc]",
                        cmp_clippy = "[AI]",
                        rg = "[RipGrep]",
                        latex_symbols = "[LaTeX-Symbols]"
                    })[entry.source.name]


                    -- Truncate label
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                    end
                    return vim_item
                end,
            },
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp_signature_help" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                {
                    { name = "path" },
                    { name = "buffer", keyword_length = 5 },
                    --{ name = "spell" },
                }
            ),
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                documentation = cmp.config.window.bordered()
            },
            experimental = {
                -- ghost_text = true,
                native_menu = false,
            },
            -- sorting = {
            --     comparators = {
            --         cmp.config.compare.score,
            --         cmp.config.compare.offset,
            --
            --         function(entry1, entry2)
            --             local _, entry1_under = entry1.completion_item.label:find "^_+"
            --             local _, entry2_under = entry2.completion_item.label:find "^_+"
            --             entry1_under = entry1_under or 0
            --             entry2_under = entry2_under or 0
            --             if entry1_under > entry2_under then
            --                 return false
            --             elseif entry1_under < entry2_under then
            --                 return true
            --             end
            --         end,
            --     }
            -- },
            --sorting = {
            --    -- From https://github.com/tjdevries/config_manager/blob/40e9f32cff4f1a8f38fef3d3ea0d992417d6ef07/xdg_config/nvim/after/plugin/completion.lua
            --    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
            --    comparators = {
            --        cmp.config.compare.offset,
            --        cmp.config.compare.exact,
            --        cmp.config.compare.score,

            --        -- copied from cmp-under, but I don't think I need the plugin for this.
            --        -- I might add some more of my own.
            --        function(entry1, entry2)
            --            local _, entry1_under = entry1.completion_item.label:find "^_+"
            --            local _, entry2_under = entry2.completion_item.label:find "^_+"
            --            entry1_under = entry1_under or 0
            --            entry2_under = entry2_under or 0
            --            if entry1_under > entry2_under then
            --                return false
            --            elseif entry1_under < entry2_under then
            --                return true
            --            end
            --        end,

            --        cmp.config.compare.kind,
            --        cmp.config.compare.sort_text,
            --        cmp.config.compare.length,
            --        cmp.config.compare.order,
            --    },
            --},
            matching = {
                disallow_fuzzy_matching = false,
            },
        }


        cmp.setup.cmdline('/', {
            sources = cmp.config.sources({
                { name = 'nvim_lsp_document_symbol' }
            }, {
                { name = 'buffer' }
            }),
            mapping = cmp.mapping.preset.cmdline(),
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end
}
