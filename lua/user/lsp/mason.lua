local ok, mason = pcall(require, "mason")
if not ok then
    return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
    return
end

mason.setup {}
mason_lspconfig.setup {}

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]       ,
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- Use Inc-Rename --
    --vim.keymap.set("n", "<leader>rn", function()
    --return ":IncRename " .. vim.fn.expand("<cword>")
    --end, { expr = true, buffer = bufnr })

    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    --vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>CodeActionMenu<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
    --vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rl", "<cmd>LspRestart<CR>", opts)

    -- F for format
    vim.api.nvim_buf_set_keymap(bufnr, "n", "F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- :Format command
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    -- Auto format on safe (version dependent)
    -- vim.cmd [[autocmd BufWritePre * lua if not vim.fn.has('nvim-0.8') then vim.lsp.buf.format() else vim.lsp.buf.formatting_sync() end]]
    vim.cmd [[
    autocmd BufWritePre * lua pcall(vim.lsp.buf.format, {async=true} )
    ]]
end

local function on_attach(client, bufnr)
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end
    if client.name == "rust_analyzer" then
        local opts = { noremap = true, silent = true }
        -- Rust Tools --
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>m", ":lua require'rust-tools.expand_macro'.expand_macro() <CR>"
            , opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ra",
            ":lua require'rust-tools.hover_actions'.hover_actions() <CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ri",
            ":lua require'rust-tools.inlay_hints'.toggle_inlay_hints() <CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rod",
            ":lua require'rust-tools.external_docs'.open_external_docs() <CR>", opts)
        -- TODO: Figure out why this won't work.
        require("rust-tools.inlay_hints").set_inlay_hints()
        require("rust-tools.inlay_hints").set_inlay_hints()
    end
    if client.name == "clangd" then
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)

end

local function default_handler(server_name)
    print(server_name)
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    local setup = {
        capabilities = capabilities,
        on_attach = on_attach,
    }

    local ok, config = pcall(require, "user.lsp.settings." .. server_name)
    if ok then
        setup = vim.tbl_deep_extend("force", setup, config)
    end

    lspconfig[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach
    }
end

mason_lspconfig.setup_handlers {
    default_handler
}
