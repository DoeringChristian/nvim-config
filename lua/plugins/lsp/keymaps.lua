return function(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Declare functions for mapping in current buffer
    local function map(mode, keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    local function nmap(keys, func, desc)
        map("n", keys, func, desc)
    end

    local function vmap(keys, func, desc)
        map("v", keys, func, desc)
    end

    -- NOTE: handled by keymaps.lua
    -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- LSP Goto functions prefixed with 'g'
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gd", function() require "telescope.builtin".lsp_definitions() end, "[G]oto [D]efinition")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    -- nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    -- TODO: figure out why overwriting the handler doesn't work
    nmap("gr", function() require "telescope.builtin".lsp_references() end, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.incoming_calls, "[G]oto [I]ncoming Calls")
    nmap("gO", vim.lsp.buf.outgoing_calls, "[G]oto [O]utgoing Calls")
    nmap("<leader>fs", vim.lsp.buf.document_symbol, "[G]oto Document [S]ymbol")
    nmap("gS", vim.lsp.buf.workspace_symbol, "[G]oto [W]orkspace [S]ymbol")

    -- LSP <leader> prefixed commands

    nmap("<leader>fe", function()
        require("telescope.builtin").diagnostics({ severity = "error" })
    end, "[G]oto [E]rror")
    nmap("<leader>fw", function()
        require("telescope.builtin").diagnostics({ severity = "warn" })
    end, "[G]oto [W]arning")

    nmap("]d", "<cmd>lua vim.diagnostic.goto_next({})<CR>", "Next [D]iagnostic")
    nmap("[d", "<cmd>lua vim.diagnostic.goto_prev({})<CR>", "Previous [D]iagnostic")
    -- nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

    nmap("]e", '<cmd>lua vim.diagnostic.goto_next({ severity = "error" })<CR>', "Next [E]rror")
    nmap("[e", '<cmd>lua vim.diagnostic.goto_prev({ severity = "error" })<CR>', "Previous [E]rror")
    nmap("]w", '<cmd>lua vim.diagnostic.goto_next({ severity = "warn" })<CR>', "Next [W]arning")
    nmap("[w", '<cmd>lua vim.diagnostic.goto_prev({ severity = "warn" })<CR>', "Previous [W]arning")

    -- Lsp keymaps
    nmap("<leader>lr", "<cmd>LspRestart<CR>", "[L]SP [R]estart")

    -- Client specific maps
    if client.name == "rust-analyzer" then
        nmap("<leader>m", function() vim.cmd.RustLsp("expandMacro") end, "Expand [M]acro")
        nmap("<leader>rod", function() vim.cmd.RustLsp("externalDocs") end, "[R]ust [O]pen External [D]ocs")
        nmap("<leader>e", function() vim.cmd.RustLsp("explainError") end, "Explain [E]rror")
    end
    if client.name == "texlab" then
        nmap("<leader>tb", "<CMD>TexlabBuild<CR>", "[T]ex [B]uild")
        nmap("<leader>tf", "<CMD>TexlabForward<CR>", "[T]exlab [F]orward")
    end
end
