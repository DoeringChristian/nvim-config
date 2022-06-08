local ok, pandoc_cmp = pcall(require, "cmp_pandoc")
if not ok then
    return
end

pandoc_cmp.setup({
    filetypes = {
        "pandoc",
        "markdown",
        "rmd",
    },
    bibliography = {
        documentation = true,
        fields = {
            "type",
            "title",
            "author",
            "year",
        },
    },
    crossref = {
        documentation = true,
        enable_nabla = true,
    }
})

local ok, pandoc = pcall(require, "pandoc")
if not ok then
    return
end

function _PANDOC_MAKE()
    -- Make your pandoc command
    local input = vim.api.nvim_get_buf_name(0)
    pandoc.render.build {
        input = input,
        args = {
            { '--standalone' },
            { '--toc' },
            { '--filter', 'pandoc-crossref' },
            { '--pdf-engine', 'xelatex' }
        },
        output = 'pandoc.pdf'
    }
end

function _NABLA_SHOW()
    pandoc.equation.show()
end

function _PANDOC_RENDER()
    pandoc.render.init()
end

pandoc.setup({
    equation = {
        border = "rounded",
    }
})
