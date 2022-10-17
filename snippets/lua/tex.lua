local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local d = ls.dynamic_node
local f = ls.function_node
local p = require("luasnip.extras").partial
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local isn = ls.indent_snippet_node
local events = require "luasnip.util.events"
local types = require "luasnip.util.types"
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local conds = require "luasnip.extras.expand_conditions"

local rec_ls
rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    });
end

local tex = {}
tex.in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

local table_node = function(args)
    local tabs = {}
    local count
    table = args[1][1]:gsub("%s", ""):gsub("|", "")
    count = table:len()
    for j = 1, count do
        local iNode
        iNode = i(j)
        tabs[2 * j - 1] = iNode
        if j ~= count then
            tabs[2 * j] = t " & "
        end
    end
    return sn(nil, tabs)
end

local rec_table = function()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t { "\\\\", "" }, d(1, table_node, { ai[1] }), d(2, rec_table, { ai[1] }) })
        }),
    });
end

local rec_cols = function()
    return sn(nil, {

    })
end

local snippets = {
    s("ls", {
        t({ "\\begin{itemize}",
            "\t\\item " }), i(1), d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }), i(0)
    }),
    s("\\item ", {
        t("\\item "),
        d(1, rec_ls, {}),
    }),

    s("dm", {
        t({ "\\[", "\t" }),
        i(1),
        t({ "", "\\]" }),
    }, { condition = tex.in_text }),

    s("ctable", {
        t "\\begin{tabular}{",
        i(1, "0"),
        t { "}", "" },
        d(2, table_node, { 1 }, {}),
        d(3, rec_table, { 1 }),
        t { "", "\\end{tabular}" }
    }),
}
s("columns", {
    t { "\\begin{columns}",
        "\t" },
    t("\t\\column{"),
    i(1),
    t("\\textwidth}"),
    t {
        "",
        "\\end{columns}"
    }
})

return snippets
