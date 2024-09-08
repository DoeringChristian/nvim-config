local function open_in_tab()
    vim.cmd("tabnew")
    require "oil".open()
end
return {
    "stevearc/oil.nvim",
    enabled = true,
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

    keys = {
        -- { "-", open_in_tab, desc = "Open oil in parrent directory" },
        {
            "-",
            function()
                require "oil".open()
            end,
            desc = "Open oil in parrent directory"
        },
    },
    cmd = { "Oil" },
    config = function()
        -- vim.keymap.set("n", "-", function() require "oil".open_float() end, { desc = "Open parent directory" })
        -- vim.keymap.set("n", "-", function() require "oil".open() end, { desc = "Open parent directory" })
        -- vim.keymap.set("n", "-", open_in_tab, { desc = "Open parent directory" })

        require "oil".setup {
            use_default_keymaps = false,
            default_file_explorer = true, -- Beware might break `gx` mapping
            delete_to_trash = true,
            keymaps = {
                -- ["q"] = "<CMD>q!<CR>",
                ["q"] = "actions.close",
                -- [".."] = "actions.parent",
                ["<C-p>"] = "<Plug>(YankyCycleForward)",

                -- More like mini.files
                ["h"] = "actions.parent",
                ["l"] = "actions.select",
                ["r"] = "actions.refresh",
                -- Default
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<C-c>"] = "actions.close",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        }
    end
}
