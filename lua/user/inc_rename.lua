if not vim.fn.has("nvim-0.8") then
    return
end
local ok, inc_rename = pcall(require, "inc_rename")
if not ok then
    return
end

inc_rename.setup()
