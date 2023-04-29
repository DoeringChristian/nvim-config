local icons = require "user.icons"
return {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        keywords = {
            TODO = { icon = icons.todo.todo },
            HACK = { icon = icons.todo.hack },
            WARN = { icon = icons.todo.warn },
            PERF = { icon = icons.todo.perf },
            NOTE = { icon = icons.todo.note },
            TEST = { icon = icons.todo.test },
        }
    },
    keys = {
        {
            "gt",
            function() require("todo-comments").jump_next() end,
            desc =
            "Next Special comment"
        },
        {
            "]t",
            function() require("todo-comments").jump_next { keywords = { "TODO" } } end,
            desc =
            "Next TODO comment"
        },
        {
            "gT",
            function() require("todo-comments").jump_prev() end,
            desc =
            "Previous special comment"
        },
        {
            "[t",
            function() require("todo-comments").jump_prev { keywords = { "TODO" } } end,
            desc =
            "Previous TODO comment"
        },
        { "<leader>gt", "<cmd>TodoTelescope<cr>", desc = "[G]oto [T]odo" },
    },
}
