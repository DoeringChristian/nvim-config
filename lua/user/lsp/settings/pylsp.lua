return {
    settings = {
        pylsp = {
            configurationSources = { "pylint" },
            plugins = {
                jedi_completion = { fuzzy = false },
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = true },
                pycodestyle = { enabled = true },
                pyls_isort = { enabled = false },
                pylsp_mypy = { enabled = false },
                pyls_flake8 = { enabled = false },
                yapf = { enabled = false },
                autopep8 = { enabled = false }
            },
        },
    },
}
