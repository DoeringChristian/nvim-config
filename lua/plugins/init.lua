return {
  { 'tpope/vim-sleuth', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  {
    'numToStr/Comment.nvim',
    opts = function()
      return {
        mappings = {
          extra = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = { enable_autocmd = false },
      },
    },
  },
  -- { "ray-x/lsp_signature.nvim", opts = { noice = false } },
  -- { "SvanT/lsp_signature.nvim", opts = { noice = false } },
  {
    'klen/nvim-config-local',
    config = function()
      require('config-local').setup {}
    end,
  },
  {
    'windwp/nvim-spectre',
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').open()
        end,
        desc = '[S]earch [R]eplace',
      },
    },
  },
}
