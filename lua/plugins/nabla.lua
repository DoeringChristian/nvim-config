return {
    "jbyuki/nabla.nvim",
    config = function()
        vim.api.nvim_create_autocmd({ "Filetype" }, {
            pattern = { "markdown", "tex" },
            callback = function()
                local function map(mode, keys, func, desc)
                    if desc then
                        desc = 'Nabla: ' .. desc
                    end
                    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                -- Enable nabla for markdown
                require "nabla".enable_virt({
                    autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                    silent = false, -- silents error messages
                })
                map("n", "<leader>p", function()
                    return require "nabla".popup()
                end, "[P]opup")
                map("n", "<leader>nv", function()
                    return require "nabla".toggle_virt()
                end, "[N]abla [V]irt")
            end
        })
    end
}
