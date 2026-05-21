return {
  'stevearc/dressing.nvim',
  lazy = true,
  opts = {
    select = {
      enabled = true,
      -- backend = "builtin", -- Telescope is brocken atm.
      telescope = {
        initial_mode = 'normal',
      },
    },
  },
  init = function()
    -- Persistent wrapper that sanitizes bad vim.ui.select calls
    -- (e.g. from lazy.nvim checker passing non-list tables or nil on_choice)
    local function safe_select(items, opts, on_choice, ...)
      if type(items) == 'table' and not vim.islist(items) then
        items = vim.tbl_values(items)
      end
      -- Handle callers passing (items, callback) without opts
      if type(opts) == 'function' and on_choice == nil then
        on_choice = opts
        opts = {}
      end
      if type(on_choice) ~= 'function' then
        on_choice = function() end
      end
      return vim._real_ui_select(items, opts, on_choice, ...)
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(items, opts, on_choice, ...)
      require('lazy').load { plugins = { 'dressing.nvim' } }
      -- After loading, dressing replaced vim.ui.select — capture it
      vim._real_ui_select = vim.ui.select
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = safe_select
      return safe_select(items, opts, on_choice, ...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require('lazy').load { plugins = { 'dressing.nvim' } }
      return vim.ui.input(...)
    end
  end,
}
