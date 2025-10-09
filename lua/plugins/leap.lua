return {
  {
    'ggandor/leap.nvim',
    enabled = true,
    lazy = false,
    dependencies = {
      -- "ggandor/flit.nvim",
      -- "ggandor/leap-spooky.nvim",
    },
    config = function()
      local leap = require 'leap'

      leap.set_default_keymaps()
      vim.keymap.set({ 'x', 'o' }, 'o', function()
        require('leap.treesitter').select()
      end, { desc = '[O]mni select' })

      leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

      -- We have to increase the anti-conceal level of render-markdown when jumping
      -- vim.api.nvim_create_autocmd('User', {
      --     pattern = 'LeapEnter',
      --     callback = function()
      --         local api = require "render-markdown.api"
      --         print("enable")
      --         for i = 1, 100, 1 do
      --             api.expand()
      --             api.disable()
      --         end
      --     end,
      -- }
      -- )
      -- vim.api.nvim_create_autocmd('User', {
      --     pattern = 'LeapLeave',
      --     callback = function()
      --         local api = require "render-markdown.api"
      --         print("disable")
      --         for i = 1, 100, 1 do
      --             api.contract()
      --             api.enable()
      --         end
      --     end,
      -- }
      -- )

      leap.setup {
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = false,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        equivalence_classes = { ' \t\r\n' },
        substitute_chars = {},
        relative_directions = true,
        labels = {
          's',
          'f',
          'n',
          'u',
          't',
          'r',
          'j',
          'k',
          'l',
          'o',
          'd',
          'w',
          'e',
          'h',
          'm',
          'v',
          'g',
          'c',
          '.',
          'z',
        },
        safe_labels = { 's', 'f', 'n', 'u', 't', 'r' },
        --"F", "L", "N", "H", "G", "M", "U", "T", "Z" },
        special_keys = {
          repeat_search = '<enter>',
          next_phase_one_target = '<enter>',
          next_target = { '<enter>', ';' },
          prev_target = { '<tab>', ',' },
          next_group = '<space>',
          prev_group = '<tab>',
          multi_accept = '<enter>',
          multi_revert = '<backspace>',
        },
      }

      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    end,
  },
  {
    'ggandor/leap-spooky.nvim',
    enabled = true,
    lazy = false,
    dependencies = {
      'ggandor/leap.nvim',
    },
    config = function()
      require('leap-spooky').setup {
        -- Additional text objects, to be merged with the default ones.
        -- E.g.: {'iq', 'aq'}
        extra_text_objects = nil,
        -- Mappings will be generated corresponding to all native text objects,
        -- like: (ir|ar|iR|aR|im|am|iM|aM){obj}.
        -- Special line objects will also be added, by repeating the affixes.
        -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
        -- window.
        affixes = {
          -- The cursor moves to the targeted object, and stays there.
          magnetic = { window = 'm', cross_window = 'M' },
          -- The operation is executed seemingly remotely (the cursor boomerangs
          -- back afterwards).
          remote = { window = 'r', cross_window = 'R' },
        },
        -- Defines text objects like `riw`, `raw`, etc., instead of
        -- targets.vim-style `irw`, `arw`. (Note: prefix is forced if a custom
        -- text object does not start with "a" or "i".)
        prefix = false,
        -- The yanked text will automatically be pasted at the cursor position
        -- if the unnamed register is in use.
        paste_on_remote_yank = false,
      }
    end,
  },
}
