-- LSPs excluded from Auto Formatting
AUTO_FORMAT_EXCLUDED = {}

function disable_formatting(bufnr)
    if not (type(bufnr) == "int") then
        bufnr = vim.fn.bufnr('%')
    end

    vim.cmd([[
    au! Format BufWritePre <buffer=]] .. bufnr .. [[>
    ]])
    vim.notify("Formatting disabled, buffer: " .. bufnr)
end

function enable_formatting(bufnr)
    if not (type(bufnr) == "int") then
        bufnr = vim.fn.bufnr('%')
    end
    local ag = vim.api.nvim_create_augroup("Format", {
        clear = false
    })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = ag,
        buffer = bufnr,
        callback = function(ev)
            require "util".format(bufnr)
        end
    })
    vim.notify("Formatting enabled, buffer: " .. bufnr)
end

local function setup_slang()
    local lspconfig = require "lspconfig"
    local configs = require 'lspconfig.configs'
    local util = require "lspconfig/util"

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = {
            "*.slang",
            "*.slangh",
            "*.hlsl",
            "*.usf",
            "*.ush"
        },
        callback = function()
            vim.cmd [[set filetype=slang]]
        end
    })

    configs.slang = {
        default_config = {
            cmd = { "shader-slang" },
            filetypes = { "slang" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {
            },
        },
        docs = {
            description = [[Language Server Protocoll for Slang]],
        }
    }

    -- vim.notify(vim.inspect(configs))
    lspconfig.slang.setup(require "user.lsp.handlers".config("slang"))
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "ray-x/lsp_signature.nvim",        -- function signature completions
        "jose-elias-alvarez/null-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        "j-hui/fidget.nvim",
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        -- Functions for enabling/disabling auto formatting

        vim.cmd [[command! Fm execute 'lua enable_formatting()']]
        vim.cmd [[command! NFm execute 'lua disable_formatting()']]
        vim.cmd [[command! NoFm execute 'lua disable_formatting()']]

        vim.cmd [[au BufNewFile,BufRead *.wgsl set filetype=wgsl]] --wgsl fix

        setup_slang()

        --require "user.lsp.lsp-installer"
        require "user.lsp.handlers".setup()

        require "fidget".setup {
            text = {
                spinner = "pipe"
            }
        }
    end
}
