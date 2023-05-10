-- Declare functions for mapping
local function map(mode, keys, func, desc)
    if desc then
        desc = desc
    end
    vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
end

local function nmap(keys, func, desc)
    map('n', keys, func, desc)
end

local function vmap(keys, func, desc)
    map('v', keys, func, desc)
end

local function xmap(keys, func, desc)
    map('x', keys, func, desc)
end

local function imap(keys, func, desc)
    map('i', keys, func, desc)
end

--Remap space as leader key
-- map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Resize with arrows
nmap('<C-Up>', ':resize +2<CR>', "Increase vertical size of current Buffer")
nmap('<C-Down>', ':resize -2<CR>', "Decrease vertical size of current Buffer")
nmap('<C-Right>', ':vertical resize +2<CR>', "Increase horizontal size of current Buffer")
nmap('<C-Left>', ':vertical resize -2<CR>', "Decrease horizontal size of current Buffer")

-- Navigate buffers
nmap('<S-l>', ":bnext<CR>", "Go one Buffer left")
nmap('<S-h>', ":bprevious<CR>", "Go one Buffer right")
nmap('<leader>bc', "<cmd>BufferLinePickClose<CR>", "[B]uffer [C]lose")
nmap('<leader>sb', "<cmd>BufferLinePick<CR>", "[S]elect [B]uffer")

-- Visual --
-- Stay in indent mode
vmap("<", "<gv")
vmap(">", ">gv")

-- Move text up and down
vmap('<A-j>', ':m .+1<CR>', "Move Line Down")
vmap('<A-k>', ':m .-2<CR>', "Move Line Up")
--vmap("p", '"_dP')

-- Visual Block --
-- Move text up and down
map("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move Line Down")
map("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move Line Up")

-- Telescope --
nmap("<leader><Tab>", "<cmd>Telescope live_grep<cr>", "Live Grep")

-- Surround --
-- Need to remap surround.vim mappings to not conflict with leap.nvmi
vim.g.surround_no_mappings = 1

nmap("ds", "<Plug>Dsurround", "[D]elete [S]urround")
nmap("cs", "<Plug>Csurround", "[C]hange [S]urround")
nmap("cS", "<Plug>CSurround", "[C]hange [S]urround with Newline")
nmap("ys", "<Plug>Ysurround", "Insert  Surround")
nmap("yS", "<Plug>YSurround", "Insert Surround wiht Newline")
nmap("yss", "<Plug>Yssurround", "Insert Surround Line")
nmap("ySs", "<Plug>YSsurround", "Insert Surround Line wiht Newline")
nmap("ySS", "<Plug>YSsurround", "Insert Surround Line with Newline and Indent")

xmap("gs", "<Plug>VSurround", "Surround Visual")
xmap("gS", "<Plug>VgSurround", "Surround Visual with Newline")

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
-- nmap('<F5>', function()
--     require 'hydra'.spawn('dap-hydra')
--     require 'dapui'.open()
--     require 'dap'.continue()
-- end, "Debug Start")
-- --nmap('<F5>', "<cmd>lua require'dap'.continue()<cr> <cmd>lua require'dapui'.open()<cr>")
-- nmap('<F6>', require 'dapui'.toggle)
-- nmap('<F9>', require 'dap'.toggle_breakpoint)
-- nmap('<F10>', "<cmd>lua require'dap'.step_over()<cr>")
-- nmap('<F11>', "<cmd>lua require'dap'.step_into()<cr>")

-- LuaSnippet --
nmap('<leader>lse', '<cmd>LuaSnipEdit<CR>', "[L]ua [S]nip [E]dit")

-- Leap search for operator pending mode (remove if causes issues)
map("o", "s", "<Plug>(leap-forward)")
map("o", "S", "<Plug>(leap-backward)")

-- SnipRun mappings
-- nmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Current Line")
-- nmap("<leader>rp", "vip<cmd>SnipRun<cr><esc>", "[R]un [P]aragraph")
-- vmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Selection")
-- map("o", "<leader>rr", "<Plug>SnipRunOperator", "[R]un for")
namep('<space>rs', '<cmd>IronRepl<cr>')
namep('<space>rr', '<cmd>IronRestart<cr>')
namep('<space>rf', '<cmd>IronFocus<cr>')
namep('<space>rh', '<cmd>IronHide<cr>')
