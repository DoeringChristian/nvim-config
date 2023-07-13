return {
    "jakewvincent/mkdnflow.nvim",
    config = function()
        require "mkdnflow".setup {
            modules = {
                bib = true,
                buffers = true,
                conceal = true,
                cursor = true,
                folds = true,
                links = false,
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
                transform_implicit = false,
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
                MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' },
                MkdnTab = false,
                MkdnSTab = false,
                MkdnNextLink = { 'n', '<Tab>' },
                MkdnPrevLink = { 'n', '<S-Tab>' },
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
                MkdnToggleToDo = { { 'n', 'v' }, '<leader>tc' },
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
