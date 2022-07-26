return {
    settings = {
        pylsp = {
            plugins = {
                pylint = { enabled = false, executable = "pylint" },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                jedi_completion = { fuzzy = true },
                pyls_isort = { enabled = false },
                pylsp_mypy = { enabled = true },
            },
        },
    },
}
