local vaults_dir = "~/share/notes/obsidian"
return {
    "epwalsh/obsidian.nvim",
    version = "*",
    -- lazy = true,
    -- event = "VeryLazy",
    event = {
        "BufReadPre " .. vim.fn.resolve(vim.fn.expand(vaults_dir)) .. "/*",
        "BufNewFile " .. vim.fn.resolve(vim.fn.expand(vaults_dir)) .. "/*",
    },
    -- ft = "markdown",
    keys = {
        { "<leader>ob",  "<CMD>ObsidianBacklinks<CR>",     desc = "[O]bsidian [B]acklinks" },
        { "<leader>oS",  "<CMD>ObsidianSearch<CR>",        desc = "[O]bsidian [S]earch" },
        { "<leader>os",  "<CMD>ObsidianQuickSwitch<CR>",   desc = "[O]bsidian [S]witch" },
        { "<leader>ot",  "<CMD>ObsidianToday<CR>",         desc = "[O]bsidian [T]oday" },
        { "<leader>o2w", "<CMD>ObsidianDailies -14 1<CR>", desc = "[O]bsidian [F]ollow [L]ink" },
        { "<leader>ow",  "<CMD>ObsidianDailies -7 1<CR>",  desc = "[O]bsidian [F]ollow [L]ink" },
        { "<leader>oy",  "<CMD>ObsidianYesterday<CR>",     desc = "[O]bsidian [Y]esterday" },
        { "<leader>oo",  "<CMD>ObsidianOpen<CR>",          desc = "[O]bsidian [O]pen" },
        { "<leader>on",  "<CMD>ObsidianNew<CR>",           desc = "[O]bsidian [N]ew" },
        { "<leader>oll", "<CMD>ObsidianLink<CR>",          desc = "[O]bsidian [L]ink" },
        { "<leader>oln", "<CMD>ObsidianLinkNew<CR>",       desc = "[O]bsidian [L]ink [N]ew" },
        { "<leader>ofl", "<CMD>ObsidianFollowLink<CR>",    desc = "[O]bsidian [F]ollow [L]ink" },
        { "<leader>oT",  "<CMD>ObsidianTemplate<CR>",      desc = "[O]bsidian [T]emplate" },
    },
    cmd = {
        "ObsidianToday",
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
            },
            -- {
            --     name = "no-vault",
            --     path = function()
            --         -- alternatively use the CWD:
            --         -- return assert(vim.fn.getcwd())
            --         return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
            --     end,
            --     overrides = {
            --         notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
            --         new_notes_location = "current_dir",
            --         templates = {
            --             folder = vim.NIL,
            --         },
            --         disable_frontmatter = true,
            --     },
            -- },
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
            ["<leader>rn"] = {
                action = function()
                    return [[<cmd>ObsidianRename<CR>]]
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
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
            -- NOTE:
            -- Unfortunately, due to obsidian the pure id based system does not work

            -- Append Zettelkasten is to title if given
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                local id = title:gsub("[^A-Za-z0-9- ]", "")
                -- id = id:sub(1, 20)
                id = id -- .. " " .. os.date("%y%m%d-%H%M%S")
                return id
            end

            -- If title is nil, just add 4 random uppercase letters to the suffix.
            local id = "" .. os.date("%y%m%d-%H%M%S")
            return id
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            path = path:with_suffix(".md")
            return path
        end,

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        image_name_func = function()
            -- Prefix image names with timestamp.
            return string.format("%s-", os.time())
        end,

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            if note:get_field("date") == nil then
                note:add_field("date", os.date("%Y-%m-%d %H:%m"))
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
        ui = {
            -- Handled by render-markdown.nvim
            enable = true,
        },
    },
}
