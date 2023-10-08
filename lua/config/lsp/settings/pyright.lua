return {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                disableOrganizeImports = true,
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "information",
                }
            }
        },
    },
    capabilities = {
        document_formatting = false
    }
}
