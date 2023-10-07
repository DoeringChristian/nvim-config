return {
    "jdhao/better-escape.vim",
    event = "InsertEnter",
    config = function()
        vim.g.better_escape_shortcut = { "jk", "jK", "JK", "Jk" }
        vim.g.better_escape_interval = 1000
    end
}