return {
    settings = {
        pylsp = {
            configurationSources = { "pylint" },
            plugins = {
                jedi_completion = { fuzzy = false },
                pylint = { enabled = false, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = true },
                pyls_isort = { enabled = false },
                pylsp_mypy = { enabled = false },
                pyls_flake8 = { enabled = false },
                yapf = { enabled = false },
                autopep8 = { enabled = false }
            },
        },
    },
    capabilities = {
        document_formatting = false
    }
}
