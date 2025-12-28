return {
  {
    'nvim-mini/mini.icons',
    lazy = false,
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    'echasnovski/mini.align',
    version = false,
    keys = {
      { 'ga', desc = 'Align', mode = { 'n', 'x' } },
      { 'gA', desc = 'Align with Preview', mode = { 'n', 'x' } },
    },
    config = function()
      require('mini.align').setup {}
    end,
  },
  {
    'echasnovski/mini.pairs',
    enabled = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
    version = false,
    enabled = true,
    config = function()
      local gen_spec = require('mini.ai').gen_spec
      require('mini.ai').setup {
        n_lines = 1000,
        custom_textobjects = {
          F = gen_spec.treesitter {
            a = { '@function.outer' },
            i = { '@function.inner' },
          },
          -- o = gen_spec.treesitter {
          --     a = { "@function.outer", "@class.outer", "@loop.outer", "@conditional.outer", "@comment.outer" },
          --     i = { "@function.inner", "@class.inner", "@loop.inner", "@conditional.inner", "@comment.inner" }
          -- },
        },
      }
    end,
  },
  {
    'echasnovski/mini.files',
    enabled = true,
    version = false,
    lazy = false,
    dependencies = { 'nvim-mini/mini.icons' },
    keys = {
      {
        '-',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0))
        end,
        desc = 'Open mini.files in parrent directory',
      },
    },
    config = function()
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, 'gs', 'belowright horizontal')
          map_split(buf_id, 'gv', 'belowright vertical')
          vim.keymap.set({ 'n' }, 'go', function()
            vim.cmd 'tabnew'
            require('oil').open()
          end)
        end,
      })
      require('mini.files').setup {
        windows = {
          preview = true,
        },
        options = {
          permanent_delete = false,
        },
      }
    end,
  },
  { 'echasnovski/mini.trailspace', version = false, opts = {} },
}
