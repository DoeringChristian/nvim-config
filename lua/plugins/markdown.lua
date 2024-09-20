return {
    {
        "OXY2DEV/markview.nvim",
        enabled = false,
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            -- You will not need this if you installed the
            -- parsers manually
            -- Or if the parsers are in your $RUNTIMEPATH
            "nvim-treesitter/nvim-treesitter",

            "nvim-tree/nvim-web-devicons"
        },

        opts = {
            tables = {
                enable = false,
            }
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        enabled = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        opts = {
            anti_conceal = { enabled = true },
            -- render_modes = { "i", "n", "c" },
            render_modes = { "n", "c" },
            -- NOTE: require pylatexenc
            -- latex = {
            --     enabled = true,
            -- },
            heading = {
                border = true,
                sign = false,
            },
            code = {
                sign = false,
            },
            bullet = {
                enabled = true,
                icons = { '•', '•', '•', '•' },
                right_pad = 1,
            },
            pipe_table = {
                enabled = false,
            },
            link = {
                enabled = false,
            },
            checkbox = {
                enabled = true,
                unchecked = {
                    icon = "󰄱",
                    highlight = "RenderMarkdownTodo",
                },
                checked = {
                    icon = "",
                },
                custom = {
                    follow_up = { raw = '[>]', rendered = '', highlight = "RenderMarkdownTodo" },
                    cancled = { raw = '[~]', rendered = '󰰱', highlight = "RenderMarkdownWarn" },
                    important = { raw = '[!]', rendered = '', highlight = "RenderMarkdownError" },

                }
            }
        },
    },
    {
        "jakewvincent/mkdnflow.nvim",
        enabled = false,
        config = function()
            require "mkdnflow".setup {
                modules = {
                    bib = true,
                    buffers = true,
                    conceal = true,
                    cursor = true,
                    folds = true,
                    links = true,
                    lists = true,
                    maps = true,
                    paths = true,
                    tables = true,
                    yaml = true,
                },
                filetypes = { md = true, rmd = true, markdown = true },
                create_dirs = true,
                perspective = {
                    priority = 'first',
                    fallback = 'current',
                    root_tell = false,
                    nvim_wd_heel = false,
                    update = false
                },
                wrap = false,
                bib = {
                    default_path = nil,
                    find_in_root = true
                },
                silent = false,
                links = {
                    style = 'wiki',
                    name_is_source = false,
                    conceal = true,
                    context = 0,
                    implicit_extension = nil,
                    transform_implicit = function(input)
                        -- Find obsidian note if in obsidian dir
                        local obsidian_dir = require "util".obsidian_dir
                        if vim.fn.getcwd():find("^" .. obsidian_dir) then
                            require "util".fin_obsidian_note(input)
                        else
                            return input
                        end
                    end,
                    transform_explicit = function(text)
                        text = text:gsub(" ", "-")
                        text = text:lower()
                        text = os.date('%Y-%m-%d_') .. text
                        return (text)
                    end
                },
                new_file_template = {
                    use_template = false,
                    template = [[
# {{ title }}
Date: {{ date }}
Filename: {{ filename }}
]],
                    placeholders = {
                        before = {
                            date = function()
                                return os.date("%A, %B %d, %Y") -- Wednesday, March 1, 2023
                            end
                        },
                        after = {
                            filename = function()
                                return vim.api.nvim_buf_get_name(0)
                            end
                        }
                    }
                },
                to_do = {
                    symbols = { ' ', '-', 'X' },
                    update_parents = true,
                    not_started = ' ',
                    in_progress = '-',
                    complete = 'X'
                },
                tables = {
                    trim_whitespace = true,
                    format_on_move = true,
                    auto_extend_rows = false,
                    auto_extend_cols = false
                },
                yaml = {
                    bib = { override = false }
                },
                mappings = {
                    -- MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' },
                    MkdnEnter = false,
                    MkdnTab = false,
                    MkdnSTab = false,
                    MkdnNextLink = false,
                    MkdnPrevLink = false,
                    MkdnNextHeading = { 'n', ']]' },
                    MkdnPrevHeading = { 'n', '[[' },
                    MkdnGoBack = { 'n', '<BS>' },
                    MkdnGoForward = { 'n', '<Del>' },
                    MkdnCreateLink = false,                                      -- see MkdnEnter
                    MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>p' }, -- see MkdnEnter
                    MkdnFollowLink = false,                                      -- see MkdnEnter
                    MkdnDestroyLink = { 'n', '<leader><BS>' },
                    MkdnTagSpan = { 'v', '<M-CR>' },
                    MkdnMoveSource = { 'n', '<leader>mv' },
                    MkdnYankAnchorLink = { 'n', 'yaa' },
                    MkdnYankFileAnchorLink = { 'n', 'yfa' },
                    MkdnIncreaseHeading = { 'n', '-' },
                    MkdnDecreaseHeading = { 'n', '=' },
                    MkdnToggleToDo = { { 'n', 'v' }, ',' },
                    MkdnNewListItem = false,
                    MkdnNewListItemBelowInsert = { 'n', 'o' },
                    MkdnNewListItemAboveInsert = { 'n', 'O' },
                    MkdnExtendList = false,
                    MkdnUpdateNumbering = { 'n', '<leader>nn' },
                    MkdnTableNextCell = { 'i', '<Tab>' },
                    MkdnTablePrevCell = { 'i', '<S-Tab>' },
                    MkdnTableNextRow = false,
                    MkdnTablePrevRow = { 'i', '<M-CR>' },
                    MkdnTableNewRowBelow = { 'n', '<leader>ir' },
                    MkdnTableNewRowAbove = { 'n', '<leader>iR' },
                    MkdnTableNewColAfter = { 'n', '<leader>ic' },
                    MkdnTableNewColBefore = { 'n', '<leader>iC' },
                    MkdnFoldSection = false,
                    MkdnUnfoldSection = false,
                }
            }
        end
    }
}
