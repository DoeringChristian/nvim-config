return {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

    config = function()
        vim.keymap.set("n", "-", function() require "oil".open_float() end, { desc = "Open parent directory" })
        require "oil".setup {
            keymaps = {
                ["q"] = "<CMD>q!<CR>",
                -- [".."] = "actions.parent",
                ["<C-p>"] = "<Plug>(YankyCycleForward)",
            },
            delete_to_trash = true,
        }
    end
}
