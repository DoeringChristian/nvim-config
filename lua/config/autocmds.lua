-- Use filetype hlsl in *.hlsl files
vim.cmd [[
au BufRead,BufNewFile *.hlsl set filetype=hlsl
]]

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        M.hl = {}
    end,
})
