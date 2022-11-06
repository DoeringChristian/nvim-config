return {
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            completion = {
                postfix = {
                    enable = false,
                },
                snippets = {
                    custom = {
                    }
                }
            }
        },
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
