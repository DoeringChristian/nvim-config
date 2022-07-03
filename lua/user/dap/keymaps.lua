local M = {}

local whichkey_ok, whichkey = pcall(require, "which-key")
if not whichkey_ok then
    return
end

function M.setup()
    local keymap = {
        d = {
            name = "Debug",
            ["<F5>"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
            ["<F9>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
            ["<F10>"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
            ["<F11>"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" }
        },
    }

    whichkey.register(keymap, {
        mode = "n",
        prefix = "",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })

    local keymap_v = {
        name = "Debug",
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    }
    whichkey.register(keymap_v, {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })
end

return M
