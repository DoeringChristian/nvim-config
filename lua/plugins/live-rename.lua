return {
  'saecki/live-rename.nvim',
  keys = {
    {
      '<leader>rn',
      function()
        require('live-rename').rename { insert = true, cursorpos = -1 }
      end,
      desc = '[R]e[n]ame',
    },
  },
  opts = {
    prepare_rename = true,
    show_other_ocurrences = true,
    use_patterns = true,
    keys = {
      submit = {
        { 'n', '<cr>' },
        { 'v', '<cr>' },
        { 'i', '<cr>' },
      },
      cancel = {
        { 'n', '<esc>' },
        { 'n', 'q' },
      },
    },
  },
}
