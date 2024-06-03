local function setup_slang()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local util = require("lspconfig/util")

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = {
            "*.slang",
            "*.slangh",
            "*.hlsl",
            "*.usf",
            "*.ush",
        },
        callback = function()
            vim.cmd([[set filetype=slang]])
        end,
    })

    configs.slang = {
        default_config = {
            cmd = { "slangd" },
            filetypes = { "slang" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {
                enableCommitCharactersInAutoCompletion = false,
            },
        },
        docs = {
            description = [[Language Server Protocoll for Slang]],
        },
    }

    -- vim.notify(vim.inspect(configs))
    lspconfig.slang.setup(require("plugins.lsp.handlers").config("slang"))
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "ray-x/lsp_signature.nvim",        -- function signature completions
        "nvimtools/none-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        {
            "lukas-reineke/lsp-format.nvim",
            enabled = false,
            opts = {}
        },
        {
            -- TODO: find out why I wouldn't use this
            "stevearc/conform.nvim",
            enabled = true,
            event = { "BufWritePre" },
            cmd = { "ConformInfo", "DiffFormat", "FormatEnable", "FormatDisable", "Format" },
            config = function()
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*",
                    callback = function(args)
                        require("conform").format({ bufnr = args.buf })
                    end,
                })
                -- Format Diff command
                vim.api.nvim_create_user_command('DiffFormat', function()
                    local lines = vim.fn.system('git diff --unified=0'):gmatch('[^\n\r]+')
                    local ranges = {}
                    for line in lines do
                        if line:find('^@@') then
                            local line_nums = line:match('%+.- ')
                            if line_nums:find(',') then
                                local _, _, first, second = line_nums:find('(%d+),(%d+)')
                                table.insert(ranges, {
                                    start = { tonumber(first), 0 },
                                    ['end'] = { tonumber(first) + tonumber(second), 0 },
                                })
                            else
                                local first = tonumber(line_nums:match('%d+'))
                                table.insert(ranges, {
                                    start = { first, 0 },
                                    ['end'] = { first + 1, 0 },
                                })
                            end
                        end
                    end
                    local format = require('conform').format
                    for _, range in pairs(ranges) do
                        vim.notify(vim.inspect(range))
                        format {
                            range = range,
                        }
                    end
                end, { desc = 'Format changed lines' })
                vim.api.nvim_create_user_command("FormatDisable", function(args)
                    if args.bang then
                        -- FormatDisable! will disable formatting just for this buffer
                        vim.b.disable_autoformat = true
                    else
                        vim.g.disable_autoformat = true
                    end
                end, {
                    desc = "Disable autoformat-on-save",
                    bang = true,
                })
                vim.api.nvim_create_user_command("FormatEnable", function()
                    vim.b.disable_autoformat = false
                    vim.g.disable_autoformat = false
                end, {
                    desc = "Re-enable autoformat-on-save",
                })
                vim.api.nvim_create_user_command("Format", function(args)
                    local range = nil
                    if args.count ~= -1 then
                        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                        range = {
                            start = { args.line1, 0 },
                            ["end"] = { args.line2, end_line:len() },
                        }
                    end
                    require("conform").format({ async = true, lsp_fallback = true, range = range })
                end, { range = true })

                require "conform".setup {
                    -- Use LSP and format on after save (async)
                    formatters_by_ft = {
                    },
                    format_after_save = function(bufnr)
                        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                            return
                        end
                        -- ...additional logic...
                        return { lsp_fallback = true }
                    end,
                }
            end
        }
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        -- Functions for enabling/disabling auto formatting

        vim.cmd([[au BufNewFile,BufRead *.wgsl set filetype=wgsl]]) --wgsl fix
        vim.cmd([[au BufNewFile,BufRead *.pest set filetype=pest]]) --pest fix

        setup_slang()
        require 'lspconfig'.glslls.setup {}

        require "plugins.lsp.handlers".setup()
    end,
}
