return {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = {
        selected_interpreters = { 'Python3_fifo' },
        repl_enable = { 'Python3_fifo' },
        interpreter_options = {
            Python3_fifo = {
                venv = { ".venv", "../.venv" },
            }
        }
    }
}
