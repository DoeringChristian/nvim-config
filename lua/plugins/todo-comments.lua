local icons = require 'config.icons'
return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    keywords = {
      TODO = { icon = icons.todo.todo },
      HACK = { icon = icons.todo.hack },
      WARN = { icon = icons.todo.warn },
      PERF = { icon = icons.todo.perf },
      NOTE = { icon = icons.todo.note },
      TEST = { icon = icons.todo.test },
    },
  },
  keys = {
    {
      'gt',
      '<CMD>TodoTelescope<CR>',
      desc = '[G]oto [T]odo comments',
    },
    -- {
    --     "]t",
    --     function() require "todo-comments".jump_next { keywords = { "TODO" } } end,
    --     desc =
    --     "Next TODO comment"
    -- },
    -- {
    --     "[t",
    --     function() require "todo-comments".jump_prev { keywords = { "TODO" } } end,
    --     desc =
    --     "Previous TODO comment"
    -- },
    { '<leader>gt', '<cmd>TodoTelescope<cr>', desc = '[G]oto [T]odo' },
  },
}
