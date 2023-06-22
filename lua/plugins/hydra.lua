return {
    "anuvyklack/hydra.nvim",
    config = function()
        local Hydra = require "hydra"

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
                { 'H',     '<C-v>h:VBox<CR>' },
                { 'J',     '<C-v>j:VBox<CR>' },
                { 'K',     '<C-v>k:VBox<CR>' },
                { 'L',     '<C-v>l:VBox<CR>' },
                { 'f',     ':VBox<CR>',      { mode = 'v' } },
                { 'q',     nil,              { exit = true } },
                { '<Esc>', nil,              { exit = true } },
            }
        })

        function interp(str, vars)
            -- Allow replace_vars{str, vars} syntax as well as replace_vars(str, {vars})
            if not vars then
                vars = str
                str = vars[1]
            end
            return (str:gsub("({([^}]+)})",
                function(whole, i)
                    return vars[i] or whole
                end))
        end

        local icons = require "user.icons"
        local hint =
            "  _H_: " .. icons.dbg.step_out .. "\n" ..
            "  _J_: " .. icons.dbg.step_over .. "\n" ..
            "  _L_: " .. icons.dbg.step_into .. "\n" ..
            "  _r_: " .. icons.dbg.play .. "\n" ..
            "  _c_: " .. icons.dbg.play .. "ⵊ" .. "\n" ..
            "  _p_: " .. icons.dbg["pause"] .. "\n" ..
            "  _B_: " .. icons.dbg.breakpoint .. "\n" ..
            "  _K_: " .. icons.dbg.eval .. "\n" ..
            "  _d_: " .. icons.dbg.disconnect .. "\n" ..
            "  _x_: " .. icons.dbg.terminate .. "\n" ..
            "  _q_: "

        local dap = require 'dap'

        _dap_hydra = Hydra({
            hint = hint,
            config = {
                color = 'pink',
                invoke_on_body = true,
                hint = {
                    -- type = "cmdline",
                    type = "window",
                    position = "top-right",
                    -- border = 'rounded'
                },
                desc = 'Hydra: Debugger',
            },
            name = 'dap',
            mode = { 'n', 'x' },
            body = '<leader>dh',
            heads = {
                { 'J', dap.step_over,         { silent = true } },
                { 'L', dap.step_into,         { silent = true } },
                { 'H', dap.step_out,          { silent = true } },
                { 'c', dap.run_to_cursor,     { silent = true } },
                { 'r', dap.continue,          { silent = true } },
                { 'p', dap.pause,             { silent = true } },
                { 'B', dap.toggle_breakpoint, { silent = true } },
                { 'd', function()
                    dap.disconnect({ terminateDebuggee = false })
                    dap.close()
                    require 'dapui'.toggle() -- Close causes problems with NvimTree
                    require 'dapui'.close()
                end, { exit = true, silent = true } },
                { 'x', function()
                    -- dap.disconnect({ terminateDebuggee = false })
                    dap.terminate()
                    dap.close()
                    require 'dapui'.toggle() -- Close causes problems with NvimTree
                    require 'dapui'.close()
                end, { exit = true, silent = true } },
                { 'K', ":lua require('dap.ui.widgets').hover()<CR>", { exit = true, silent = true } },
                { 'q', nil,                                          { exit = true, nowait = true } },
            }
        })
        Hydra.spawn = function(head)
            if head == 'dap-hydra' then
                _dap_hydra:activate()
            end
        end

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
                { 'z',
                    function()
                        return require 'telescope.builtin'.grep_string { shorten_path = true, word_match =
                        "-w", only_sort_text = true, search = '' }
                    end },
                { 'o', cmd 'Telescope oldfiles', {
                    desc =
                    'recently opened files'
                } },
                { 'h', cmd 'Telescope help_tags', {
                    desc =
                    'vim help'
                } },
                { 'm', cmd 'Telescope marks', {
                    desc =
                    'marks'
                } },
                { 'k', cmd 'Telescope keymaps' },
                { 'O', cmd 'Telescope vim_options' },
                { 'r', cmd 'Telescope resume' },
                { 'p', cmd 'Telescope projects', {
                    desc =
                    'projects'
                } },
                { '/', cmd 'Telescope current_buffer_fuzzy_find', {
                    desc =
                    'search in file'
                } },
                { '?', cmd 'Telescope search_history', {
                    desc =
                    'search history'
                } },
                { ';', cmd 'Telescope command_history', {
                    desc =
                    'command-line history'
                } },
                { 'c', cmd 'Telescope commands', {
                    desc =
                    'execute command'
                } },
                { 'u', cmd 'silent! %foldopen! | UndotreeToggle', {
                    desc =
                    'undotree'
                } },
                { '<Enter>', cmd 'Telescope', {
                    exit = true,
                    desc = 'list all pickers'
                } },
                { '<Esc>', nil, {
                    exit = true,
                    nowait = true
                } },
            }
        })
    end
}
