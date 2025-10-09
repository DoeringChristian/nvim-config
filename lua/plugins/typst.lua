return {
  'kaarmu/typst.vim',
  enabled = true,
  ft = 'typst',
  lazy = false,
  config = function()
    vim.g.typst_pdf_viewer = 'zathura'
  end,
}
