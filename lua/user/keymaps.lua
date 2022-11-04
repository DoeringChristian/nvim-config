local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap
local vmap = function(from, to)
    vim.cmd("xnoremap <expr> " .. from .. ' mode() ==# "v" ? "' .. to .. '" : "' .. from .. '"')
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Kak maps
keymap("n", 'w', 'vw', opts)
keymap("n", 'b', 'vb', opts)
keymap("n", 'e', 've', opts)

vmap("w", "<esc>vw")
vmap("b", "<esc>vb")
vmap("e", "<esc>ve")

vmap('h', '<esc>h')
vmap('j', '<esc>j')
vmap('k', '<esc>k')
vmap('l', '<esc>l')
vmap('i', '<esc>i')
vmap('a', '<esc>a')
vmap(':', '<esc>:')
vmap('<cmd>', '<esc><cmd>')


keymap("v", '<leader>m', '<esc><leader>m', opts)


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- window navigation
keymap("n", '<C-h>', '<C-w>h', opts)
keymap("n", '<C-j>', '<C-w>j', opts)
keymap("n", '<C-k>', '<C-w>k', opts)
keymap("n", '<C-l>', '<C-w>l', opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", '<C-Up>', ':resize +2<CR>', opts)
keymap("n", '<C-Down>', ':resize -2<CR>', opts)
keymap("n", '<C-Left>', ':vertical resize -2<CR>', opts)
keymap("n", '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap("n", '<S-l>', ":bnext<CR>", opts)
keymap("n", '<S-h>', ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", '<A-j>', ':m .+1<CR>==', opts)
keymap("v", '<A-k>', ':m .-2<CR>==', opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
--keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope --
--keymap("n", "<C-f>", "<cmd>Telescope
keymap("n", "<leader><Tab>", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<C-f>", "<cmd>Telescope file_browser<cr>", opts)

-- Yank History (Yanky)--
--keymap("n", "<leader>p", "<cmd>Telescope yank_history initial_mode=normal<cr>", opts)

-- vim-bookmarks
keymap("n", "ml", "<cmd>Telescope vim_bookmarks all<CR>", opts)
keymap("n", "mf", "<cmd>Telescope vim_bookmarks current_file initial_mode=normal<CR>", opts)

-- Yanky --
-- paste
vim.keymap.set("n", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("n", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("x", "p", "<Plug>(YankyPutAfter)", {})
vim.keymap.set("x", "P", "<Plug>(YankyPutBefore)", {})
vim.keymap.set("n", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("n", "gP", "<Plug>(YankyGPutBefore)", {})
vim.keymap.set("x", "gp", "<Plug>(YankyGPutAfter)", {})
vim.keymap.set("x", "gP", "<Plug>(YankyGPutBefore)", {})

-- cycle navigation
vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleBackward)", {})
vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleForward)", {})

-- keep cursor position
--vim.keymap.set("n", "y", "<Plug>(YankyYank)", {})
--vim.keymap.set("x", "y", "<Plug>(YankyYank)", {})

-- NvimTree --
keymap("n", "<C-f>", "<cmd>NvimTreeToggle<CR>", opts)

-- Hop --
vim.keymap.set({ "n", "v" }, "<leader>f", "<cmd>HopChar1MW<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>w", "<cmd>HopWord<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>b", "<cmd>HopWordBC<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>j", "<cmd>HopLineAC<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>k", "<cmd>HopLineBC<CR>", opts)

-- MiniYank --
--vim.keymap.set({"n", "v"}, "p", "<Plug>(miniyank-autoput)", opts)
--vim.keymap.set({"n", "v"}, "P", "<Plug>(miniyank-autoPut)", opts)
--vim.keymap.set({"n", "v"}, "<C-p>", "<Plug>(miniyank-cycle)", opts)

-- Terminal --
keymap('n', '<leader>tt', '<cmd>ToggleTerm<CR>', opts)
keymap('n', '<leader>tg', '<cmd>lua _GITUI_TOGGLE()<CR>', opts)
keymap('n', '<leader>tb', '<cmd>lua _BOTTOM_TOGGLE()<CR>', opts)
keymap('n', '<leader>tl', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', opts)
keymap('n', '<leader>td', '<cmd>lua _DUST_TOGGLE()<CR>', opts)
keymap('n', '<leader>th', '<cmd>lua _HTOP_TOGGLE()<CR>', opts)
keymap('n', '<leader>tct', '<cmd>lua _CARGO_RUN_TRACE_TOGGLE()<CR>', opts)

-- Nabla --
--keymap("n", "<leader>p", '<cmd>lua require("nabla").popup()<CR>', opts)
-- Pandoc --
keymap('n', '<leader>pr', '<cmd>lua _PANDOC_RENDER()<CR>', opts)
keymap('n', '<leader>pm', '<cmd>lua _PANDOC_MAKE()<CR>', opts)
keymap('n', '<leader>pe', '<cmd>lua _NABLA_SHOW()<CR>', opts)
keymap('n', '<leader>pv', '<cmd>lua require"nabla".disable_virt() <CR> <cmd>lua require"nabla".enable_virt()<CR>', opts)

-- Align --
keymap("x", "ga", "<Plug>(EasyAlign)", opts)
keymap("n", "ga", "<Plug>(EasyAlign)", opts)

-- Leap --
vim.keymap.set("n", "<leader>f", LEAP_ALL_WINDOWS, opts)
vim.keymap.set("n", "f", LEAP_BIDIRECTIONAL, opts)

-- GUI font size --
vim.cmd [[
nnoremap <C-+> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C--> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>
]]

-- Dap --
keymap("n", '<F5>', "<cmd>lua require'dap'.continue()<cr> <cmd>lua require'dapui'.open()<cr>", opts)
keymap("n", '<F6>', "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", '<F9>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", '<F10>', "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", '<F11>', "<cmd>lua require'dap'.step_into()<cr>", opts)

-- LuaSnippet --
keymap("n", '<leader>lse', '<cmd>LuaSnipEdit<CR>', opts)
