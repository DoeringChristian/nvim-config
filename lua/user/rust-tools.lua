local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status_ok then
    return
end

rust_tools.setup({

})
