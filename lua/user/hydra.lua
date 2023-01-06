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
    },
    mode = 'n',
    body = '<leader>g',
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
