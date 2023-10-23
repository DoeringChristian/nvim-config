local virt_enabled = false
function DisableNabla()
    virt_enabled = false
    require "nabla".disable_virt()
end

function EnableNabla()
    virt_enabled = true
    require "nabla".enable_virt({
        autogen = true, -- auto-regenerate ASCII art when exiting insert mode
        silent = false, -- silents error messages
    })
end

return {
    "jbyuki/nabla.nvim",
    enabled = false,
    ft = { "markdown" },
    config = function()
        vim.api.nvim_create_autocmd({ "Filetype" }, {
            pattern = { "markdown" },
            callback = function()
                local function map(mode, keys, func, desc)
                    if desc then
                        desc = 'Nabla: ' .. desc
                    end
                    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                -- Enable nabla for markdown
                if virt_enabled then
                    require "nabla".enable_virt({
                        autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                        silent = false, -- silents error messages
                    })
                else
                    require "nabla".disable_virt()
                end
                map("n", "<leader>p", function()
                    return require "nabla".popup()
                end, "[P]opup")
                map("n", "<leader>nt", function()
                    return require "nabla".toggle_virt()
                end, "[N]abla [T]oggle")
            end
        })
    end
}
