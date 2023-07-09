return {
    "jbyuki/nabla.nvim",
    config = function()
        vim.api.nvim_create_autocmd({ "Filetype" }, {
            pattern = { "markdown", "tex" },
            callback = function()
                -- Enable nabla for markdown
                require "nabla".enable_virt({
                    autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                    silent = true,  -- silents error messages
                })
            end
        })
    end
}
