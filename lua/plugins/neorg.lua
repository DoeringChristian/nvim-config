return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},  -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/share/notes/neorg",
                        },
                        default_workspace = "notes"
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            -- Want to move one keybind into the other? `remap_key` moves the data of the
                            -- first keybind to the second keybind, then unbinds the first keybind.
                            keybinds.remap_key("norg", "n", "<C-Space>", ",")
                        end,
                    }
                },
            },
            config = {
                ["core.completion"] = {
                    engine = "nvim-cmp",
                    name = "[Neorg]",
                }
            }
        }
    end,
}
