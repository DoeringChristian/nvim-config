local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 32
local MAX_MENU_WIDTH = 32

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
        local kind_icons = require "config.icons".kinds
        -- find more here: https://www.nerdfonts.com/cheat-sheet

        cmp.setup {
            performance = {
                debounce = 100,
                -- Controlls the time cmp waits at most before displaying results
                -- has impact on priority.
                fetching_timeout = 50,
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
                format = function(etnry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

                    -- vim_item.menu_hl_group = "LspInlayHint"
                    -- Truncate menu
                    if vim_item.menu ~= nil then
                        local truncated_menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH)
                        if truncated_menu ~= vim_item.menu then
                            vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
                        end
                    end
                    -- Truncate label
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                    end

                    return vim_item
                end
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
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
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
