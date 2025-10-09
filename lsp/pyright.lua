return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = 'information',
        },
        typeCheckingMode = 'off',
      },
    },
  },
  capabilities = {
    document_formatting = false,
  },
}
