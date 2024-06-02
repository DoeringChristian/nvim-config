return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    ft = "markdown",
    keys = {
        { "<leader>ob",  "<CMD>ObsidianBacklinks<CR>",   desc = "[O]bsidian [B]acklinks" },
        { "<leader>oS",  "<CMD>ObsidianSearch<CR>",      desc = "[O]bsidian [S]earch" },
        { "<leader>ot",  "<CMD>ObsidianToday<CR>",       desc = "[O]bsidian [T]oday" },
        { "<leader>oy",  "<CMD>ObsidianYesterday<CR>",   desc = "[O]bsidian [Y]esterday" },
        { "<leader>oo",  "<CMD>ObsidianOpen<CR>",        desc = "[O]bsidian [O]pen" },
        { "<leader>on",  "<CMD>ObsidianNew<CR>",         desc = "[O]bsidian [N]ew" },
        { "<leader>os",  "<CMD>ObsidianSearch<CR>",      desc = "[O]bsidian [S]earch" },
        { "<leader>oll", "<CMD>ObsidianLink<CR>",        desc = "[O]bsidian [L]ink" },
        { "<leader>os",  "<CMD>ObsidianQuickSwitch<CR>", desc = "[O]bsidian [S]witch" },
        { "<leader>oln", "<CMD>ObsidianLinkNew<CR>",     desc = "[O]bsidian [L]ink [N]ew" },
        { "<leader>ofl", "<CMD>ObsidianFollowLink<CR>",  desc = "[O]bsidian [F]ollow [L]ink" },
        -- { "<leader>ot",  "<CMD>ObsidianTemplate<CR>",    desc = "[O]bsidian [T]emplate" },
    },
    -- event = {
    --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --     "BufReadPre " .. vim.fn.expand "~" .. "/share/notes/obsidian/**.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- Optional, for completion.
        "hrsh7th/nvim-cmp",

        -- Optional, for search and quick-switch functionality.
        "nvim-telescope/telescope.nvim",

        -- Optional, an alternative to telescope for search and quick-switch functionality.
        -- "ibhagwan/fzf-lua"

        -- Optional, another alternative to telescope for search and quick-switch functionality.
        -- "junegunn/fzf",
        -- "junegunn/fzf.vim"

        -- Optional, alternative to nvim-treesitter for syntax highlighting.
        -- "godlygeek/tabular",
        -- "preservim/vim-markdown",
    },
    opts = {
        workspaces = {
            {
                name = "main",
                path = "~/share/notes/obsidian/main"
            }
        },

        notes_subdir = "notes",

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "notes/dailies",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil
        },

        completion = {
            nvim_cmp = true,
        },

        mappings = {
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ["gd"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ["gr"] = {
                action = function()
                    return [[<cmd>ObsidianBacklinks<CR>]]
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },

        },
        new_notes_location = "current_dir",

        -- Optional, for templates (see below).
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
        },

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local prefix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                prefix = title:gsub("[^A-Za-z0-9-]", "")
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    prefix = prefix .. string.char(math.random(65, 90))
                end
            end
            return prefix .. "-" .. tostring(os.time())
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix(".md")
        end,

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,

        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            name = "telescope.nvim",
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            mappings = {
                -- Create a new note from your query.
                new = "<C-x>",
                -- Insert a link to the selected note.
                insert_link = "<C-l>",
            },
        },
    },
}
