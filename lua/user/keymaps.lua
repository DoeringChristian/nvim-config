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

-- Normal --
-- window navigation
nmap("<C-h>", "<C-w>h", "Move to Buffer to the left")
nmap("<C-j>", "<C-w>j", "Move to Buffer to the bottom")
nmap("<C-k>", "<C-w>k", "Move to Buffer to the top")
nmap("<C-l>", "<C-w>l", "Move to Buffer to the right")

-- Resize with arrows
nmap('<C-Up>', ':resize +2<CR>', "Increase vertical size of current Buffer")
nmap('<C-Down>', ':resize -2<CR>', "Decrease vertical size of current Buffer")
nmap('<C-Right>', ':vertical resize +2<CR>', "Increase horizontal size of current Buffer")
nmap('<C-Left>', ':vertical resize -2<CR>', "Decrease horizontal size of current Buffer")

-- Navigate buffers
nmap('<S-l>', ":bnext<CR>", "Go one Buffer left")
nmap('<S-h>', ":bprevious<CR>", "Go one Buffer right")

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

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", "Move out of Terminal")
map("t", "<C-j>", "<C-\\><C-N><C-w>j", "Move out of Terminal")
map("t", "<C-k>", "<C-\\><C-N><C-w>k", "Move out of Terminal")
map("t", "<C-l>", "<C-\\><C-N><C-w>l", "Move out of Terminal")

-- Telescope --
nmap("<leader><Tab>", "<cmd>Telescope live_grep<cr>", "Live Grep")

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
nmap("<c-n>", "<Plug>(YankyCycleBackward)", "Next Paste Element")
nmap("<c-p>", "<Plug>(YankyCycleForward)", "Previous Paste Element")

-- NvimTree --
nmap("<C-f>", "<cmd>NvimTreeToggle<CR>", "Toggle file manager")

-- Hop --
map({ "n", "v" }, "<leader>w", "<cmd>HopWord<CR>", "Jump to [W]ord")

-- Terminal --
nmap('<leader>tt', '<cmd>ToggleTerm<CR>', "[T]oggle [T]erminal")
nmap('<leader>tg', '<cmd>lua _GITUI_TOGGLE()<CR>', "[T]erminal [G]it UI")
nmap('<leader>tb', '<cmd>lua _BOTTOM_TOGGLE()<CR>', "[T]erminal [B]ottom (Taks Manager)")
nmap('<leader>tl', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', "[T]erminal [L]azyGit")
nmap('<leader>td', '<cmd>lua _DUST_TOGGLE()<CR>', "[T]erminal [D]ust")
nmap('<leader>th', '<cmd>lua _HTOP_TOGGLE()<CR>', "[T]erminal [H]TOP (Taks Manager)")
nmap('<leader>tct', '<cmd>lua _CARGO_RUN_TRACE_TOGGLE()<CR>', "[T]erminal [C]argo Run with [T]race")

-- Nabla --
-- Pandoc --
nmap('<leader>pr', '<cmd>lua _PANDOC_RENDER()<CR>', "[P]andoc [R]ender")
nmap('<leader>pm', '<cmd>lua _PANDOC_MAKE()<CR>', "[P]andoc [M]ake Document")
nmap('<leader>pe', '<cmd>lua _NABLA_SHOW()<CR>', "[P]andoc Show [E]quations")
nmap('<leader>pv', '<cmd>lua require"nabla".disable_virt() <CR> <cmd>lua require"nabla".enable_virt()<CR>',
    "[P]andoc Reenable [V]irtual Equations")

-- Align --
map("x", "ga", "<Plug>(EasyAlign)", "Easy [A]lign")
map("n", "ga", "<Plug>(EasyAlign)", "Easy [A]lign")

-- Leap --
nmap("<leader>s", LEAP_ALL_WINDOWS, "Leap [S]earch all Buffers")

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
nmap('<F5>', function()
        require 'hydra'.spawn('dap-hydra')
        require 'dapui'.open()
        require 'dap'.continue()
end, "Debug Start")
--nmap('<F5>', "<cmd>lua require'dap'.continue()<cr> <cmd>lua require'dapui'.open()<cr>")
nmap('<F6>', require 'dapui'.toggle)
nmap('<F9>', require 'dap'.toggle_breakpoint)
nmap('<F10>', "<cmd>lua require'dap'.step_over()<cr>")
nmap('<F11>', "<cmd>lua require'dap'.step_into()<cr>")

-- LuaSnippet --
nmap('<leader>lse', '<cmd>LuaSnipEdit<CR>', "[L]ua [S]nip [E]dit")

-- Syntax Tree Surfer --
local ok, sts = pcall(require, "syntax-tree-surfer")
if ok then
        -- Syntax Tree Surfer V2 Mappings
        -- Targeted Jump with virtual_text
        nmap("gv", function() -- only jump to variable_declarations
                sts.targeted_jump({ "variable_declaration" })
        end, "[G]oto [V]ariable Declaration")
        nmap("gfn", function() -- only jump to functions
                sts.targeted_jump({ "function", "arrrow_function", "function_definition" })
                --> In this example, the Lua language schema uses "function",
                --  when the Python language uses "function_definition"
                --  we include both, so this keymap will work on both languages
        end, "[G]oto [F]unction")
        nmap("gif", function() -- only jump to if_statements
                sts.targeted_jump({ "if_statement" })
        end, "[G]oto [If] Statement")
        nmap("gfo", function() -- only jump to for_statements
                sts.targeted_jump({ "for_statement" })
        end, "[G]oto [Fo]r statement")
        nmap("gj", function() -- jump to all that you specify
                sts.targeted_jump({
                    "function",
                    "if_statement",
                    "else_clause",
                    "else_statement",
                    "elseif_statement",
                    "for_statement",
                    "while_statement",
                    "switch_statement",
                })
        end, "[G]oto target")

        -- Visual Selection from Normal Mode
        nmap("vx", '<cmd>STSSelectMasterNode<cr>', "[V]isual Select Master Node")
        nmap("vn", '<cmd>STSSelectCurrentNode<cr>', "[V]isual Select Current Node")

        -- Select Nodes in Visual Mode
        map("x", "H", '<cmd>STSSelectParentNode<cr>', "Parent Node")
        map("x", "J", '<cmd>STSSelectNextSiblingNode<cr>', "Next Sibling Node")
        map("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>', "Previous Sibling Node")
        map("x", "L", '<cmd>STSSelectChildNode<cr>', "Child Node")

        -- Swapping Nodes in Visual Mode
        map("x", "<A-j>", '<cmd>STSSwapNextVisual<cr>', "Swap with Next Node")
        map("x", "<A-k>", '<cmd>STSSwapPrevVisual<cr>', "Swap with Previous Node")
end


-- Leap search for operator pending mode (remove if causes issues)
map("o", "s", "<Plug>(leap-forward)")
map("o", "S", "<Plug>(leap-backward)")

-- SnipRun mappings
nmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Current Line")
nmap("<leader>rp", "vip<cmd>SnipRun<cr><esc>", "[R]un [P]aragraph")
vmap("<leader>rr", "<cmd>SnipRun<cr>", "[R]un Selection")
