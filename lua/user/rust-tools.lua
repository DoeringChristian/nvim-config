local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status_ok then
  return
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

rust_tools.setup({
  
})
