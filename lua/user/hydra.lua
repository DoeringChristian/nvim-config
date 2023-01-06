local ok, Hydra = pcall(require, "hydra")
if not ok then
    return
end

local hint = [[
 Arrow^^^^^^   Select region with <C-v> 
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _<Esc>_
]]

Hydra({
    name = 'Draw Diagram',
    hint = hint,
    config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
            border = 'rounded'
        },
        on_enter = function()
            vim.o.virtualedit = 'all'
        end,
        desc = 'Hydra: [D]ia[g]ram',
    },
    mode = 'n',
    body = '<leader>dg',
    heads = {
        { 'H', '<C-v>h:VBox<CR>' },
        { 'J', '<C-v>j:VBox<CR>' },
        { 'K', '<C-v>k:VBox<CR>' },
        { 'L', '<C-v>l:VBox<CR>' },
        { 'f', ':VBox<CR>', { mode = 'v' } },
        { 'q', nil, { exit = true } },
        { '<Esc>', nil, { exit = true } },
    }
})

local hint = [[
 _J_: step over   _r_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _L_: step into   _x_: Quit             ^ ^                 ^ ^
 _H_: step out    _X_: Stop             ^ ^
 _c_: to cursor   _C_: Close UI
 ^
 ^ ^              _q_: exit
]]

local dap = require 'dap'

local dap_hydra = Hydra({
    hint = hint,
    config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
            position = 'bottom',
            border = 'rounded'
        },
        desc = 'Hydra: Debugger',
    },
    name = 'dap',
    mode = { 'n', 'x' },
    body = '<leader>dh',
    heads = {
        { 'J', dap.step_over, { silent = true } },
        { 'L', dap.step_into, { silent = true } },
        { 'H', dap.step_out, { silent = true } },
        { 'c', dap.run_to_cursor, { silent = true } },
        { 'r', dap.continue, { silent = true } },
        { 'x', ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
        { 'X', dap.close, { silent = true } },
        { 'C', ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
        { 'b', dap.toggle_breakpoint, { silent = true } },
        { 'K', ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
        { 'q', nil, { exit = true, nowait = true } },
    }
})
Hydra.spawn = function(head)
    if head == 'dap-hydra' then
        vim.notify("test")
        dap_hydra:activate()
    end
end

local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐   _z_: fzf
  ██🬿      🭊██   
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _r_: resume      _u_: undotree
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _h_: vim help    _c_: execute command
                 _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
 
                 _<Enter>_: Telescope           _<Esc>_
]]

Hydra({
    name = 'Telescope',
    hint = hint,
    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
        desc = 'Hydra: [F]ind using Telescope'
    },
    mode = 'n',
    body = '<leader>f',
    heads = {
        { 'f', cmd 'Telescope find_files' },
        { 'g', cmd 'Telescope live_grep' },
        { 'z', cmd 'Telescope fzf' },
        { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
        { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
        { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
        { 'k', cmd 'Telescope keymaps' },
        { 'O', cmd 'Telescope vim_options' },
        { 'r', cmd 'Telescope resume' },
        { 'p', cmd 'Telescope projects', { desc = 'projects' } },
        { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
        { '?', cmd 'Telescope search_history', { desc = 'search history' } },
        { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
        { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
        { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' } },
        { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    }
})
