local M = {}

-- Declare functions for mapping
M.map = function(mode, keys, func, desc)
  if desc then
    desc = desc
  end
  vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

M.nmap = function(keys, func, desc)
  M.map('n', keys, func, desc)
end

M.vmap = function(keys, func, desc)
  M.map('v', keys, func, desc)
end

M.xmap = function(keys, func, desc)
  M.map('x', keys, func, desc)
end

M.imap = function(keys, func, desc)
  M.map('i', keys, func, desc)
end

return M
