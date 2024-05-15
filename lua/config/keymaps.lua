--Remap space as leader key
-- map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = require("util").map
local xmap = require("util").xmap
local vmap = require("util").vmap
local nmap = require("util").nmap
local imap = require("util").imap

-- Resize with arrows
nmap("<C-Up>", ":resize +2<CR>", "Increase vertical size of current Buffer")
nmap("<C-Down>", ":resize -2<CR>", "Decrease vertical size of current Buffer")
nmap("<C-Right>", ":vertical resize +2<CR>", "Increase horizontal size of current Buffer")
nmap("<C-Left>", ":vertical resize -2<CR>", "Decrease horizontal size of current Buffer")

-- Navigate buffers
nmap("<S-l>", ":bnext<CR>", "Go one Buffer left")
nmap("<S-h>", ":bprevious<CR>", "Go one Buffer right")
nmap("<leader>bc", "<cmd>BufferLinePickClose<CR>", "[B]uffer [C]lose")
nmap("<leader>sb", "<cmd>BufferLinePick<CR>", "[S]elect [B]uffer")

-- Visual --
-- Stay in indent mode
vmap("<", "<gv")
vmap(">", ">gv")

-- Move text up and down
vmap("<A-j>", ":m .+1<CR>", "Move Line Down")
vmap("<A-k>", ":m .-2<CR>", "Move Line Up")
--vmap("p", '"_dP')

-- Visual Block --
-- Move text up and down
map("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move Line Down")
map("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move Line Up")

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
vim.cmd([[
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
]])

-- LuaSnippet --
nmap("<leader>lse", "<cmd>LuaSnipEdit<CR>", "[L]ua [S]nip [E]dit")

-- Leap search for operator pending mode (remove if causes issues)
map("o", "s", "<Plug>(leap-forward)")
map("o", "S", "<Plug>(leap-backward)")
-- map("n", "<leader>ms", function()
--     require "leap".leap {
--         target_windows = { vim.fn.win_getid() },
--         action = paranormal,
--         multiselect = true,
--     }
-- end, "Leap [M]ulti [S]elect")

-- SnipRun mappings
-- nmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Current Line")
-- nmap("<leader>rp", "vip<cmd>SnipRun<cr><esc>", "[R]un [P]aragraph")
-- vmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Selection")
-- map("o", "<leader>rr", "<Plug>SnipRunOperator", "[R]un for")
nmap("<space>rs", "<cmd>IronRepl<cr>")
nmap("<space>rr", "<cmd>IronRestart<cr>")
nmap("<space>rf", "<cmd>IronFocus<cr>")
nmap("<space>rh", "<cmd>IronHide<cr>")

-- Gitsigns mappings
nmap("]c", "<cmd>Gitsigns next_hunk<cr>", "Next [G]it Hunk")
nmap("[c", "<cmd>Gitsigns prev_hunk<cr>", "Previous [G]it Hunk")
nmap("<leader>gc", "<cmd>Telescope git_commits<cr>", "[G]oto [C]ommits")

-- Tab-page mapping
nmap("]t", "<cmd>:tabnext", "Next [T]ab Page")
nmap("[t", "<cmd>:-tabnext", "Next [T]ab Page")
