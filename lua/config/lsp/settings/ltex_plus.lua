return {
    filetypes = { "tex", "markdown", "md" },
    flags = { debounce_text_changes = 500 },
    settings = {
        ltex = {
            enabled = { "bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext",
                "rsweave" },
            completionEnabled = true,
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
