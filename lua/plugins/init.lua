return{
    {
        "klen/nvim-config-local",
        config = function()
            require("config-local").setup({})
        end,
    },
    {
        "windwp/nvim-spectre",
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "[S]earch [R]eplace",
            },
        },
    },
}
