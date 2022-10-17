return {
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "%f" },
                executable = "tectonic",
                forwardSearchAfter = false,
                onSave = true
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                args = {}
            },
            --latexFormatter = "latexindent",
            latexFormatter = "texlab",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    },
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }
}
