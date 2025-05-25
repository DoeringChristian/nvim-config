return {
    settings = {
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = "off",
                diagnosticSeverityOverrides = {
                    reportGeneralTypeIssues = "information",
                },
            }
        },
    },
    capabilities = {
        document_formatting = false
    }
}
