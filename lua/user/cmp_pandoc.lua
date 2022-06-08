local ok, pandoc = pcall(require, "cmp_pandoc")
if not ok then
    return
end

pandoc.setup({
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
