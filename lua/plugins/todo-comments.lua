local icons = require "user.icons"
return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    TODO = { icon = icons.todo.todo },
    HACK = { icon = icons.todo.hack },
    WARN = { icon = icons.todo.warn },
    PERF = { icon = icons.todo.perf },
    NOTE = { icon = icons.todo.note },
    TEST = { icon = icons.todo.test },
    keys = {
        { "gt",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "gT",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>gt", "<cmd>TodoTelescope<cr>",                            desc = "[G]oto [T]odo" },
    },
}
