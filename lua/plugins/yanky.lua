return {
    "gbprod/yanky.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local yanky = require "yanky"

        local mapping = require("yanky.telescope.mapping")

        yanky.setup({
            ring = {
                history_length = 10,
                storage = "shada",
                sync_with_numbered_registers = true,
            },
            system_clipboard = {
                sync_with_ring = true,
            },
            preserver_cursor_position = {
                enabled = false,
            },
            picker = {
                select = {
                    action = nil,
                },
                telescope = {
                    mappings = {
                        default = mapping.put("p"),
                        i = {
                            ["<c-p>"] = mapping.put("p"),
                            ["<c-P>"] = mapping.put("P"),
                            ["<c-x>"] = mapping.delete(),
                        },
                        n = {
                            p = mapping.put("p"),
                            P = mapping.put("P"),
                            d = mapping.delete(),
                        },
                    }
                },
            },
        })

        local picker = require("yanky.picker")
        picker.actions.put("p")
        picker.actions.put("P")
        picker.actions.put("gp")
        picker.actions.put("gP")
        picker.actions.delete()
    end
}
