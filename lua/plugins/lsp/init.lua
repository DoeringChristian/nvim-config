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
    vim.cmd([[
    augroup Format
    autocmd BufWritePre <buffer=]] .. bufnr .. [[> lua pcall(vim.lsp.buf.format, {async=false} )
    augroup END
    ]])
    vim.notify("Formatting enabled, buffer: " .. bufnr)
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "jose-elias-alvarez/null-ls.nvim", -- null-ls handles formatters etc.
        "nvim-telescope/telescope.nvim",
        "j-hui/fidget.nvim",
        "ray-x/lsp_signature.nvim", -- function signature completions
    },
    config = function()
        -- NOTE: lsp settings are loaded by mason (rust-analyzer is handled by rust-tools)

        -- Functions for enabling/disabling auto formatting

        vim.cmd [[command! Fm execute 'lua enable_formatting()']]
        vim.cmd [[command! NFm execute 'lua disable_formatting()']]
        vim.cmd [[command! NoFm execute 'lua disable_formatting()']]

        vim.cmd [[au BufNewFile,BufRead *.wgsl set filetype=wgsl]] --wgsl fix

        --require "user.lsp.lsp-installer"
        require "plugins.lsp.handlers".setup()

        require "fidget".setup {}
    end
}
