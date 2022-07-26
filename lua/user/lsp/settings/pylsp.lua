return {
    settings = {
        pylsp = {
            configurationSources = { "pylint" },
            plugins = {
                jedi_completion = { fuzzy = false },
                pylint = { enabled = false, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                pyls_isort = { enabled = false },
                pylsp_mypy = { enabled = false },
                pyls_flake8 = { enabled = false },
                yapf = { enabled = true },
                autopep8 = { enabled = false }
            },
        },
    },
}
