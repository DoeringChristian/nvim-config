return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<leader>nr", function() require "neotest".run.run() end,                    desc = "[N]eotest [R]un" },
        -- { "<leader>na", function() require "neotest".run.run { enter = true } end,     desc = "[N]eoutest Run [A]ll" },
        { "<leader>ns", function() require "neotest".summary.toggle() end,             desc = "[N]eotest [S]ummary" },
        { "<leader>no", function() require "neotest".output.open { enter = true } end, desc = "[N]eoutest [O]utput" },
    },
    config = function()
        require "neotest".setup {
            adapters = {
                require "rustaceanvim.neotest",
                require "neotest-python" {
                    args = { "--log-level", "DEBUG", "--verbose", "-s" },
                },
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
