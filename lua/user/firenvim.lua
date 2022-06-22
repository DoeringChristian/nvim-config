--local ok, firenvim = pcall(require, "firenvim")
--if not ok then
--return
--end

vim.cmd [[
if exists('g:started_by_firenvim')
  set laststatus=0
  let &guifont = substitute(&guifont, ':h\zs\d\+', '8', '')
endif
]]
