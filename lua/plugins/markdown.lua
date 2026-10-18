return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'rmd', 'quarto' },
    init = function()
      vim.treesitter.language.register('markdown', 'quarto')
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    opts = {
      latex = { enabled = false },
      heading = { sign = false },
      code = { sign = false },
    },
  },
}
