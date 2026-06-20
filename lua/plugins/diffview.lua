return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'Gdiff', 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    opts = {},
    config = function(_, opts)
      require('diffview').setup(opts)
      -- `:Gdiff` opens diffview (passes through any args, e.g. `:Gdiff main`)
      -- with the same revision/file completion as `:DiffviewOpen`.
      vim.api.nvim_create_user_command('Gdiff', function(o)
        vim.cmd('DiffviewOpen ' .. o.args)
      end, {
        nargs = '*',
        complete = function(arg_lead, cmd_line, cur_pos)
          -- Rewrite the leading `Gdiff` to `DiffviewOpen` so diffview's
          -- completer matches on the command name.
          local rewritten = cmd_line:gsub('^(%s*)Gdiff', '%1DiffviewOpen', 1)
          local offset = #rewritten - #cmd_line
          return require('diffview').completion(arg_lead, rewritten, cur_pos + offset)
        end,
      })
    end,
  },
}
