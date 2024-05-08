return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { "junegunn/fzf", build = "./install --bin" },
    },
    keys = {
        { "<leader><Tab>", function() require "fzf-lua".live_grep() end, "Fuzzy Live Grep" }
    },
    config = function()
        local actions = require "fzf-lua.actions"
        -- calling `setup` is optional for customization
        require "fzf-lua".setup {
            "telescope",
            winopts = {
                border = false,
                on_create = function()
                    -- called once upon creation of the fzf main window
                    -- can be used to add custom fzf-lua mappings, e.g:
                    vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
                    vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
                end,
            },
            fzf_colors = {
                -- ["gutter"] = "-1"
                ["gutter"] = { "bg", "CursorLine" },
                ["bg+"]    = { "bg", "CursorLine" },
            },
            keymap = {

            }
        }
    end
}
