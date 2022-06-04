local M = {}

function M.setup(_)
    local dap_install = require "dap-install"
    local dap = require "dap"
    dap_install.config("codelldb", {})
end

return M
