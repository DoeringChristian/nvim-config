return {
    filetypes = { "markdown", "md", "tex", "python", "rust" },
    flags = { debounce_text_changes = 500 },
    settings = {
        ltex = {
            enabled = { "bibtex", "context", "context.tex", "html", "latex", "markdown", "org", "restructuredtext",
                "rsweave", "python", "rust" },
            completionEnabled = true,
            markdown = {
                nodes = {
                    FencedCodeBlock = "ignore",
                    CodeBlock = "ignore",
                }
            }
        }
    }
}
