return {
    filetypes = { "markdown", "md", "tex" },
    flags = { debounce_text_changes = 500 },
    settings = {
        ltex = {
            enabled = { "bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext",
                "rsweave" },
            -- completionEnabled = true,
            markdown = {
                nodes = {
                    FencedCodeBlock = "ignore",
                    CodeBlock = "ignore",
                }
            },
            checkFrequency = "save",

        }
    }
}
