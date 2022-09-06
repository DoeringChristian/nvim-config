local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- LSPs excluded from Auto Formatting
AUTO_FORMAT_EXCLUDED = {}

-- Functions for enabling/disabling auto formatting

function disable_formatting(bufnr)
    if not (type(bufnr) == "int") then
        bufnr = vim.fn.bufnr('%')
    end
    
    vim.cmd([[
    au! Format BufWritePre <buffer=]].. bufnr ..[[>
    ]])
    vim.notify("Formatting disabled, buffer: ".. bufnr)
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
    vim.notify("Formatting enabled, buffer: ".. bufnr)
end

vim.cmd[[command! Fm execute 'lua enable_formatting()']]
vim.cmd[[command! NFm execute 'lua disable_formatting()']]

--require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.fidget"
