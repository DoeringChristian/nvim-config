return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    cmd = {
        "Neotest"
    },
    keys = {
        { "<leader>nr", function() require "neotest".run.run() end,                    desc = "[N]eotest [R]un" },
        { "<leader>ns", function() require "neotest".summary.toggle() end,             desc = "[N]eotest [S]ummary" },
        { "<leader>no", function() require "neotest".output.open { enter = true } end, desc = "[N]eoutest [O]utput" },
    },
    config = function()
        require "neotest".setup {
            adapters = {
                require "rustaceanvim.neotest"
            },
            summary = {
                mappings = {
                    attach = "a",
                    clear_marked = "M",
                    clear_target = "T",
                    debug = "d",
                    debug_marked = "D",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    expand_all = "e",
                    jumpto = "i",
                    mark = "m",
                    next_failed = "J",
                    output = "o",
                    prev_failed = "K",
                    run = "r",
                    run_marked = "R",
                    short = "O",
                    stop = "u",
                    target = "t",
                    watch = "w"
                }
            }
        }
    end
}
