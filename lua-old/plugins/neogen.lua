return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
        {
            "<leader>ng", function() require "neogen".generate() end, desc = "[N]eogen [G]enerate"
        },
    },
    config = function()
        require "neogen".setup { snippet_engine = "luasnip" }
    end

}
