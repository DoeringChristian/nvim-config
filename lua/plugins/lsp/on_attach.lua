-- local function enable_formatting(client, bufnr)
--     if not (type(bufnr) == "int") then
--         bufnr = vim.fn.bufnr('%')
--     end
--     local ag = vim.api.nvim_create_augroup("Format", {
--         clear = false
--     })
--
--     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--         group = ag,
--         buffer = bufnr,
--         callback = function(ev)
--             require "plugins.lsp.formatting".callback(client, bufnr)
--         end
--     })
--     vim.notify("Formatting enabled, buffer: " .. bufnr .. " client: " .. client.name)
-- end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
    end
end

local function lsp_keymaps(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Declare functions for mapping in current buffer
    local function map(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    local function nmap(keys, func, desc)
        map('n', keys, func, desc)
    end

    local function vmap(keys, func, desc)
        map('v', keys, func, desc)
    end

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- LSP Goto functions prefixed with 'g'
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.incoming_calls, "[G]oto [I]ncoming Calls")
    nmap("gO", vim.lsp.buf.outgoing_calls, "[G]oto [O]utgoing Calls")
    nmap("gs", vim.lsp.buf.document_symbol, "[G]oto Document [S]ymbol")
    nmap("gS", vim.lsp.buf.workspace_symbol, "[G]oto [W]orkspace [S]ymbol")

    -- LSP <leader> prefixed commands
    nmap("<leader>rn", require 'renamer'.rename, "[R]e[n]ame")

    nmap("<leader>a", "<cmd>CodeActionMenu<CR>", "Code [A]ction")

    nmap("<leader>gd", require 'telescope.builtin'.diagnostics, "[G]oto [D]iagnostics")
    nmap("<leader>ge", function()
        require 'telescope.builtin'.diagnostics { severity = "error" }
    end, "[G]oto [E]rror")
    nmap("<leader>gw", function()
        require 'telescope.builtin'.diagnostics { severity = "warn" }
    end, "[G]oto [W]arning")

    nmap("]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Next [D]iagnostic")
    nmap("[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Previous [D]iagnostic")
    nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

    nmap("]e", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = "error" })<CR>',
        "Next [E]rror")
    nmap("[e", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = "error" })<CR>',
        "Previous [E]rror")
    nmap("]w", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded", severity = "warn" })<CR>',
        "Next [W]arning")
    nmap("[w", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded", severity = "warn" })<CR>',
        "Previous [W]arning")


    -- Lsp keymaps
    nmap("<leader>lr", "<cmd>LspRestart<CR>", "[L]SP [R]estart")

    -- Client specific maps
    if client.name == "rust_analyzer" then
        nmap("K", "<cmd>RustHoverActions<CR>", "Hover Documentation")
        nmap('<F5>', function()
            require 'hydra'.spawn('dap-hydra')
            vim.cmd [[RustDebuggables]]
        end, "Debug Start")
        nmap("<leader>m", require 'rust-tools.expand_macro'.expand_macro, "Expand [M]acro")
        nmap("<leader>ra", require 'rust-tools.hover_actions'.hover_actions, "[R]ust Hover [A]ctions")
        nmap("<leader>rod", require 'rust-tools.external_docs'.open_external_docs, "[R]ust [O]pen External [D]ocs")
    end
    if client.name == "texlab" then
        nmap("<leader>tb", "<CMD>TexlabBuild<CR>", "[T]ex [B]uild")
    end
end

return function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)

    -- Auto format on safe (version dependent)
    -- if client.server_capabilities.documentFormattingProvider and AUTO_FORMAT_EXCLUDED[client.name] == nil and
    --     AUTO_FORMAT_EXCLUDED[vim.bo[bufnr].filetype] == nil then
    -- end
    require "lsp-format".on_attach(client)
    vim.notify("LSP Client: " .. client.name)
end
