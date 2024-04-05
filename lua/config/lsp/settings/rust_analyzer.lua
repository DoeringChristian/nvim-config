return {
    settings = {
        ["rust-analyzer"] = {
            inlayHints = { locationLinks = false },
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
                sysrootQueryMetadata = true,
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
