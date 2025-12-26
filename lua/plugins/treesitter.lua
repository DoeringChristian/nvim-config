return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    commit = 'v0.10.0',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
    config = function()
      local treesitter = require 'nvim-treesitter.configs'
      treesitter.setup {
        ensure_installed = {
          'bash',
          'bibtex',
          'c',
          'cmake',
          'cpp',
          'cuda',
          'diff',
          'dockerfile',
          'eex',
          'gdscript',
          'glsl',
          'java',
          'latex',
          'llvm',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'ninja',
          'nix',
          'norg',
          'ocaml',
          'ocamllex',
          'python',
          'regex',
          'rst',
          'rust',
          'vim',
          'wgsl',
          'yaml',
          'toml',
        },

        sync_install = false,

        highlight = { enable = true },
        indent = { enable = true },

        textobjects = {
          lsp_interop = {
            enable = false,
            border = 'none',
            floating_preview_opts = {},
          },
          select = {
            enable = false,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = { query = '@function.outer', desc = 'Select [A]rround [F]unction' },
              ['if'] = { query = '@function.inner', desc = 'Select [I]nside [F]unction' },
              ['ac'] = { query = '@class.outer', desc = 'Select [A]rround [C]lass' },
              ['ic'] = { query = '@class.inner', desc = 'Select [I]nside [C]lass' },
              ['ag'] = { query = '@comment.outer', desc = 'Select [A]rround Comment' },
              ['ig'] = { query = '@comment.inner', desc = 'Select [I]nside Comment' },
              ['al'] = { query = '@loop.outer', desc = 'Select [A]rround [L]oop' },
              ['il'] = { query = '@loop.inner', desc = 'Select [I]nside [L]oop' },
              -- ["ab"] = { query = "@block.outer", desc = "Select [A]rround [B]lock" },
              -- ["ib"] = { query = "@bloc.inner", desc = "Select [I]nside [B]lock" },
            },
          },
        },
      }
    end,
  },
  -- TODO: treesitter textobjects
}
