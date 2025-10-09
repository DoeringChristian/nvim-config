return {
  'NeogitOrg/neogit',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  event = 'VeryLazy',
  keys = {
    {
      '<leader>gg',
      function()
        local neogit = require 'neogit'
        local file_dir = vim.fn.expand '%:h'
        local exec_result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true, cwd = file_dir }):wait()
        local root = vim.fn.trim(exec_result.stdout)
        neogit.open { kind = 'replace', cwd = root }
      end,
      desc = '[G]oto [G]it',
    },
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
  config = function(_, opts)
    local function hi(name, opts)
      vim.api.nvim_set_hl(0, name, opts)
    end

    require('neogit').setup(opts)

    hi('NeogitCommitViewHeader', { link = 'Special' })
    hi('NeogitDiffAddHighlight', { link = 'DiffAdd' })
    hi('NeogitDiffAdd', { link = 'DiffAdd' })
    hi('NeogitDiffDeleteHighlight', { link = 'DiffDelete' })
    hi('NeogitDiffDelete', { link = 'DiffDelete' })
    hi('NeogitFold', { link = 'FoldColumn' })
    hi('NeogitHunkHeader', { link = 'StatusLine' })
    hi('NeogitHunkHeader', { link = 'StatusLine' })
    hi('NeogitHunkHeaderHighlight', { link = 'WildMenu' })
    -- hi('NeogitHunkHeader', { fg = p.base0D, bg = nil, attr = nil, sp = nil })
    -- hi('NeogitHunkHeaderHighlight', { fg = p.base0D, bg = nil, attr = 'bold', sp = nil })
    hi('NeogitNotificationError', { link = 'DiagnosticError' })
    hi('NeogitNotificationInfo', { link = 'DiagnosticInfo' })
    hi('NeogitNotificationWarning', { link = 'DiagnosticWarn' })
  end,
}
