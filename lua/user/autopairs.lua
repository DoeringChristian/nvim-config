local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
    return
end
local ok, Rule = pcall(require, "nvim-autopairs.rule")
if not ok then
    return
end
local ok, cond = pcall(require, "nvim-autopairs.conds")
if not ok then
    return
end
npairs.setup {
    check_ts = true,
    -- Ignore these chars: w, %, ', [, (, ., -, +, *, /
    ignored_next_char = [=[[%w%%%'%[%(%"%.%-%+%/%*]]=],
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<C-e>",
        chars = { "{", "[", "(", '"', "'" }, -- IMPORTANT: must match the characters in cmp.lua check_bracket
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%=] ]], "%s+", ""),
        --pattern = [=[[%'%"%)%>%]%)%}%,%=]]=],
        offset = 0, -- Offset from pattern match
        end_key = "\t",
        keys = "wertzuiopghyxcvbnmalskdjf",
        check_comma = true,
        highlight = "DiagnosticError",
        --highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

npairs.add_rules({
    Rule("$", "$", { "tex", "latex", "markdown" })
        -- don't add a pair if the next character is %
        :with_pair(cond.not_after_regex("%%"))
        -- don't move right when repeat character
        :with_move(cond.none())
        -- disable adding a newline when you press <cr>
        :with_cr(cond.none())
})

-- $|$ (<Space>)-> $ | $ in tex, latex, markdown
-- $ | $ ($)-> $  $|
npairs.add_rules({
    Rule(" ", " ", { "tex", "latex", "markdown" })
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '$$' }, pair)
        end),
    Rule('$ ', ' $')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%$') ~= nil
        end)
        :use_key('$'),
})
npairs.add_rules({
    Rule("$$", "$$", "tex")
        :with_pair(function(opts)
            print(vim.inspect(opts))
            if opts.line == "aa $$" then
                -- don't add pair on that line
                return false
            end
        end)
})

-- {|} -> { | }
npairs.add_rules {
    Rule(' ', ' ')
        :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
        end)
        :use_key(')'),
    Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
    Rule('=', '')
        :with_pair(cond.not_inside_quote())
        :with_pair(cond.not_filetypes({ "sh", "make", "desktop", "zsh", "conf" }))
        :with_pair(function(opts)
            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
            if last_char:match('[%w%=%s]') then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == ' ' and '' or ' '
            if prev_2char:match('%w$') then
                return '<bs> =' .. next_char
            end
            if prev_2char:match('%=$') then
                return next_char
            end
            if prev_2char:match('=') then
                return '<bs><bs>=' .. next_char
            end
            return ''
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none())
}



local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
