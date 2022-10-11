return {
    settings = {
        pylsp = {
            configurationSources = { "pylint" },
            plugins = {
                jedi_completion = { fuzzy = false },
                pylint = { enabled = true, executable = "pylint" },
                pyflakes = { enabled = true },
                pycodestyle = { enabled = true },
                pyls_isort = { enabled = true },
                pylsp_mypy = { enabled = true },
                pyls_flake8 = { enabled = true },
                yapf = { enabled = true },
                autopep8 = { enabled = true }
            },
        },
    },
}
