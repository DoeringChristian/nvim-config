local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local ok, luasnip = pcall(require, "luasnip")
if not ok then
    return
end

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

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    -- :h nvim-cmp
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
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
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
        },
        ["<C-Space>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "c" }),
        --[[
        ["<CR>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                else
                    fallback()
                end
            end,
        },
        --]]
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_bracket() ~= nil then
                require('nvim-autopairs.fastwrap').show()
            elseif check_backspace() then
                fallback()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
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
                rg = "[RipGrep]",
                latex_symbols = "[LaTeX-Symbols]"
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources(
        {
            { name = "nvim_lsp" },
            { name = 'nvim_lsp_signature_help' },
            { name = "luasnip" },
        },
        {
            { name = "path" },
            { name = "buffer", keyword_length = 5 },
            { name = "spell" },
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
        ghost_text = true,
        native_menu = false,
    },
    --sorting_ = {
    --    comparators = {
    --        cmp.config.compare.score,
    --        cmp.config.compare.offset,
    --    }
    --},
    sorting = {
        -- From https://github.com/tjdevries/config_manager/blob/40e9f32cff4f1a8f38fef3d3ea0d992417d6ef07/xdg_config/nvim/after/plugin/completion.lua
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
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
