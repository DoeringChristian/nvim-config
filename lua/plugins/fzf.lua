return {
    "ibhagwan/fzf-lua",
    build = "./install --bin",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup {
            -- border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            border = {},
        }
    end
}
